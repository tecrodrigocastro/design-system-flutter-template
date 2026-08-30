/// Data model for the design_system catalog, extracted from the package's
/// source via `package:analyzer`.
library;

/// The Atomic Design layer a [ComponentInfo] belongs to.
enum ComponentCategory { atom, molecule, organism }

/// A public design_system widget (atom, molecule, or organism).
class ComponentInfo {
  ComponentInfo({
    required this.name,
    required this.category,
    required this.filePath,
    required this.doc,
    required this.params,
  });

  /// The class name, e.g. `DsButton`.
  final String name;

  /// Which Atomic Design layer this component belongs to.
  final ComponentCategory category;

  /// Path to the declaring file, relative to `design_system/lib`.
  final String filePath;

  /// The class-level dartdoc comment, with `///` markers stripped.
  final String? doc;

  /// The constructor's parameters (`key` is omitted).
  final List<ParamInfo> params;

  Map<String, Object?> toJson() => {
        'name': name,
        'category': category.name,
        'filePath': filePath,
        'doc': doc,
        'params': [for (final p in params) p.toJson()],
      };
}

/// A single constructor parameter of a [ComponentInfo].
class ParamInfo {
  ParamInfo({
    required this.name,
    required this.type,
    required this.required,
    required this.defaultValue,
    required this.doc,
  });

  /// The parameter name, e.g. `variant`.
  final String name;

  /// The parameter's type as written in source, e.g. `DsButtonVariant`.
  final String type;

  /// Whether the caller must supply this parameter.
  final bool required;

  /// The default value's source text, e.g. `DsButtonVariant.primary`, or
  /// `null` if there is none.
  final String? defaultValue;

  /// Doc comment for the backing field, with `///` markers stripped.
  final String? doc;

  Map<String, Object?> toJson() => {
        'name': name,
        'type': type,
        'required': required,
        if (defaultValue != null) 'defaultValue': defaultValue,
        if (doc != null) 'doc': doc,
      };
}

/// A public enum used to configure component variants/sizes.
class EnumInfo {
  EnumInfo({required this.name, required this.doc, required this.values});

  /// The enum name, e.g. `DsButtonVariant`.
  final String name;

  /// The enum-level dartdoc comment.
  final String? doc;

  /// The declared enum values, in source order.
  final List<EnumValueInfo> values;

  Map<String, Object?> toJson() => {
        'name': name,
        'doc': doc,
        'values': [for (final v in values) v.toJson()],
      };
}

/// A single value of an [EnumInfo].
class EnumValueInfo {
  EnumValueInfo({required this.name, required this.doc});

  /// The value's name, e.g. `primary`.
  final String name;

  /// Doc comment for this specific value.
  final String? doc;

  Map<String, Object?> toJson() => {'name': name, if (doc != null) 'doc': doc};
}

/// A class of design tokens, e.g. `DsPrimary` or `DsSpacing`.
class TokenClassInfo {
  TokenClassInfo(
      {required this.name, required this.doc, required this.members});

  /// The class name, e.g. `DsPrimary`.
  final String name;

  /// The class-level dartdoc comment.
  final String? doc;

  /// The static members (constants or computed getters) it exposes.
  final List<TokenMemberInfo> members;

  Map<String, Object?> toJson() => {
        'name': name,
        'doc': doc,
        'members': [for (final m in members) m.toJson()],
      };
}

/// A single static member of a [TokenClassInfo].
class TokenMemberInfo {
  TokenMemberInfo(
      {required this.name,
      required this.type,
      required this.value,
      required this.doc});

  /// The member name, e.g. `base`.
  final String name;

  /// The declared or return type, e.g. `Color`.
  final String type;

  /// The literal initializer source (e.g. `Color(0xFF782DC8)`), or `null`
  /// when the member is a computed getter rather than a constant.
  final String? value;

  /// Doc comment for this member.
  final String? doc;

  Map<String, Object?> toJson() => {
        'name': name,
        'type': type,
        if (value != null) 'value': value,
        if (doc != null) 'doc': doc,
      };
}
