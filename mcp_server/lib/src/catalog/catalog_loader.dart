/// Builds a [DesignSystemCatalog] by parsing the design_system package's
/// public API with `package:analyzer`.
///
/// Only syntactic parsing is used (no semantic resolution): it's fast,
/// has no build-graph setup cost, and is robust across analyzer versions.
/// Components/tokens/enums are classified purely by their folder — the
/// same convention documented in `design_system/README.md`.
library;

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;

import 'models.dart';

/// The full catalog extracted from a design_system package.
class DesignSystemCatalog {
  DesignSystemCatalog(
      {required this.components,
      required this.enums,
      required this.tokenClasses});

  /// Every public `Ds*` widget, across all three Atomic Design layers.
  final List<ComponentInfo> components;

  /// Every public variant/size enum.
  final List<EnumInfo> enums;

  /// Every public design token class (colors, spacing, typography, theme).
  final List<TokenClassInfo> tokenClasses;
}

/// Parses `design_system.dart` and everything it exports, under
/// `<packageRoot>/lib`, into a [DesignSystemCatalog].
DesignSystemCatalog loadDesignSystemCatalog({required String packageRoot}) {
  final libDir = p.join(packageRoot, 'lib');
  final barrelPath = p.join(libDir, 'design_system.dart');
  final barrelUnit = _parse(barrelPath).unit;

  final exportedFiles = <String>[
    for (final directive in barrelUnit.directives)
      if (directive is ExportDirective)
        if (directive.uri.stringValue case final uri?)
          p.normalize(p.join(libDir, uri)),
  ];

  final components = <ComponentInfo>[];
  final enums = <EnumInfo>[];
  final tokenClasses = <TokenClassInfo>[];

  for (final filePath in exportedFiles) {
    final relativePath = p.relative(filePath, from: libDir);
    final unit = _parse(filePath).unit;

    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration) {
        final name = declaration.namePart.typeName.lexeme;
        if (name.startsWith('_')) continue;
        if (_isUnder(relativePath, 'components')) {
          components.add(_componentFrom(declaration, name, relativePath));
        } else if (_isUnder(relativePath, 'tokens') ||
            _isUnder(relativePath, 'theme')) {
          tokenClasses.add(
            TokenClassInfo(
              name: name,
              doc: _docFor(declaration.documentationComment),
              members: _tokenMembersOf(declaration),
            ),
          );
        }
      } else if (declaration is EnumDeclaration) {
        final name = declaration.namePart.typeName.lexeme;
        if (name.startsWith('_')) continue;
        enums.add(
          EnumInfo(
            name: name,
            doc: _docFor(declaration.documentationComment),
            values: [
              for (final constant in declaration.body.constants)
                EnumValueInfo(
                  name: constant.name.lexeme,
                  doc: _docFor(constant.documentationComment),
                ),
            ],
          ),
        );
      }
    }
  }

  return DesignSystemCatalog(
      components: components, enums: enums, tokenClasses: tokenClasses);
}

ParseStringResult _parse(String path) => parseFile(
    path: path,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false);

bool _isUnder(String relativePath, String folder) =>
    relativePath.contains('${p.separator}$folder${p.separator}');

ComponentCategory _categoryFrom(String relativePath) {
  if (_isUnder(relativePath, 'atoms')) return ComponentCategory.atom;
  if (_isUnder(relativePath, 'molecules')) return ComponentCategory.molecule;
  return ComponentCategory.organism;
}

ComponentInfo _componentFrom(
    ClassDeclaration declaration, String name, String relativePath) {
  final constructors =
      declaration.body.members.whereType<ConstructorDeclaration>();
  ConstructorDeclaration? constructor;
  for (final candidate in constructors) {
    if (candidate.name == null) {
      constructor = candidate;
      break;
    }
  }
  constructor ??= constructors.isEmpty ? null : constructors.first;

  final params = <ParamInfo>[
    if (constructor != null)
      for (final param in constructor.parameters.parameters)
        if (_describeParam(param, declaration) case final info?) info,
  ];

  return ComponentInfo(
    name: name,
    category: _categoryFrom(relativePath),
    filePath: relativePath,
    doc: _docFor(declaration.documentationComment),
    params: params,
  );
}

ParamInfo? _describeParam(FormalParameter param, ClassDeclaration declaration) {
  final name = param.name?.lexeme;
  // `super.key` is boilerplate on every widget and not useful in a catalog
  // meant to help an agent call the constructor correctly.
  if (name == null || name == 'key') return null;

  final fieldDeclaration = _fieldDeclarationFor(declaration, name);
  final typeText =
      param.type?.toSource() ?? fieldDeclaration?.fields.type?.toSource();

  return ParamInfo(
    name: name,
    type: typeText ?? 'dynamic',
    required: param.isRequired,
    defaultValue: param.defaultClause?.value.toSource(),
    doc: _docFor(fieldDeclaration?.documentationComment),
  );
}

FieldDeclaration? _fieldDeclarationFor(
    ClassDeclaration declaration, String name) {
  for (final member in declaration.body.members) {
    if (member is FieldDeclaration) {
      for (final variable in member.fields.variables) {
        if (variable.name.lexeme == name) return member;
      }
    }
  }
  return null;
}

List<TokenMemberInfo> _tokenMembersOf(ClassDeclaration declaration) {
  final members = <TokenMemberInfo>[];
  for (final member in declaration.body.members) {
    if (member is FieldDeclaration && member.isStatic) {
      final doc = _docFor(member.documentationComment);
      for (final variable in member.fields.variables) {
        if (variable.name.lexeme.startsWith('_')) continue;
        members.add(
          TokenMemberInfo(
            name: variable.name.lexeme,
            type: member.fields.type?.toSource() ?? 'dynamic',
            value: variable.initializer?.toSource(),
            doc: doc,
          ),
        );
      }
    } else if (member is MethodDeclaration &&
        member.isStatic &&
        member.isGetter &&
        !member.name.lexeme.startsWith('_')) {
      members.add(
        TokenMemberInfo(
          name: member.name.lexeme,
          type: member.returnType?.toSource() ?? 'dynamic',
          // Computed (e.g. `DsTheme.light`), not a literal constant.
          value: null,
          doc: _docFor(member.documentationComment),
        ),
      );
    }
  }
  return members;
}

String? _docFor(Comment? comment) {
  if (comment == null) return null;
  final lines = comment.tokens.map((token) {
    var text = token.lexeme;
    if (text.startsWith('/// ')) {
      text = text.substring(4);
    } else if (text.startsWith('///')) {
      text = text.substring(3);
    }
    return text;
  });
  final joined = lines.join('\n').trim();
  return joined.isEmpty ? null : joined;
}
