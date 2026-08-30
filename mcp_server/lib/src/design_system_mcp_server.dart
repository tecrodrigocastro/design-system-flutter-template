/// The MCP server itself: wires the [DesignSystemCatalog] and
/// [DocSearchIndex] up as MCP tools over stdio.
library;

import 'dart:async';
import 'dart:convert';

import 'package:dart_mcp/server.dart';
import 'package:path/path.dart' as p;

import 'catalog/catalog_loader.dart';
import 'search/doc_search_index.dart';

/// An MCP server exposing the design_system package's component catalog,
/// design tokens, and dartdoc search index.
base class DesignSystemMcpServer extends MCPServer with ToolsSupport {
  /// Creates the server, eagerly parsing the design_system package found
  /// at [designSystemRoot] (the directory containing its `pubspec.yaml`).
  DesignSystemMcpServer(super.channel, {required String designSystemRoot})
      : _catalog = loadDesignSystemCatalog(packageRoot: designSystemRoot),
        _docIndexPath = p.join(designSystemRoot, 'doc', 'api', 'index.json'),
        super.fromStreamChannel(
          implementation:
              Implementation(name: 'design_system_catalog', version: '0.1.0'),
          instructions:
              'Use these tools to look up design_system components, tokens, '
              'and enums instead of grepping source or guessing prop names. '
              'Start with list_components or search_docs, then call '
              'get_component for the full param schema before writing code '
              'that uses a Ds* widget.',
        ) {
    registerTool(listComponentsTool, _listComponents);
    registerTool(getComponentTool, _getComponent);
    registerTool(listTokensTool, _listTokens);
    registerTool(getTokenTool, _getToken);
    registerTool(listEnumsTool, _listEnums);
    registerTool(getEnumTool, _getEnum);
    registerTool(searchDocsTool, _searchDocs);
  }

  final DesignSystemCatalog _catalog;
  final String _docIndexPath;
  DocSearchIndex? _docIndex;

  // --- list_components ---------------------------------------------------

  /// Lists every component, optionally filtered by Atomic Design category.
  final listComponentsTool = Tool(
    name: 'list_components',
    description: 'List every public design_system widget (atoms, molecules, '
        'organisms), with a one-line summary of each.',
    inputSchema: Schema.object(
      properties: {
        'category': Schema.string(
          description:
              'Filter by "atom", "molecule", or "organism". Omit to list all.',
        ),
      },
    ),
  );

  FutureOr<CallToolResult> _listComponents(CallToolRequest request) {
    final categoryFilter = request.arguments?['category'] as String?;
    final components = _catalog.components
        .where(
            (c) => categoryFilter == null || c.category.name == categoryFilter)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return _jsonResult([
      for (final c in components)
        {
          'name': c.name,
          'category': c.category.name,
          'summary': _firstLine(c.doc)
        },
    ]);
  }

  // --- get_component -------------------------------------------------------

  /// Returns the full schema for a single component.
  final getComponentTool = Tool(
    name: 'get_component',
    description: 'Get the full schema for one design_system component: its doc '
        '(including a usage example), and every constructor parameter '
        'with type, required/default, and doc.',
    inputSchema: Schema.object(
      properties: {
        'name': Schema.string(
            description: 'The component class name, e.g. "DsButton"')
      },
      required: ['name'],
    ),
  );

  FutureOr<CallToolResult> _getComponent(CallToolRequest request) {
    final name = request.arguments!['name'] as String;
    final component = _findByName(_catalog.components, (c) => c.name, name);
    if (component == null) {
      return _notFound(
          name, 'component', _catalog.components.map((c) => c.name));
    }
    return _jsonResult(component.toJson());
  }

  // --- list_tokens / get_token ---------------------------------------------

  /// Lists every design token class.
  final listTokensTool = Tool(
    name: 'list_tokens',
    description: 'List every design token class (colors, spacing, typography, '
        'theme) with the names of the values/members it exposes.',
    inputSchema: Schema.object(properties: const {}),
  );

  FutureOr<CallToolResult> _listTokens(CallToolRequest request) {
    return _jsonResult([
      for (final t in _catalog.tokenClasses)
        {
          'name': t.name,
          'summary': _firstLine(t.doc),
          'members': [for (final m in t.members) m.name]
        },
    ]);
  }

  /// Returns the literal values for a single token class.
  final getTokenTool = Tool(
    name: 'get_token',
    description:
        'Get every member of a design token class, with its literal value '
        '(e.g. "Color(0xFF782DC8)") so you never have to hardcode one.',
    inputSchema: Schema.object(
      properties: {
        'name':
            Schema.string(description: 'The token class name, e.g. "DsPrimary"')
      },
      required: ['name'],
    ),
  );

  FutureOr<CallToolResult> _getToken(CallToolRequest request) {
    final name = request.arguments!['name'] as String;
    final tokenClass = _findByName(_catalog.tokenClasses, (t) => t.name, name);
    if (tokenClass == null) {
      return _notFound(
          name, 'token class', _catalog.tokenClasses.map((t) => t.name));
    }
    return _jsonResult(tokenClass.toJson());
  }

  // --- list_enums / get_enum -----------------------------------------------

  /// Lists every variant/size enum.
  final listEnumsTool = Tool(
    name: 'list_enums',
    description:
        'List every public enum used to configure component variants and sizes.',
    inputSchema: Schema.object(properties: const {}),
  );

  FutureOr<CallToolResult> _listEnums(CallToolRequest request) {
    return _jsonResult([
      for (final e in _catalog.enums)
        {
          'name': e.name,
          'summary': _firstLine(e.doc),
          'values': [for (final v in e.values) v.name]
        },
    ]);
  }

  /// Returns every value of a single enum, with its doc.
  final getEnumTool = Tool(
    name: 'get_enum',
    description:
        'Get every value of a design_system enum, each with its doc comment.',
    inputSchema: Schema.object(
      properties: {
        'name':
            Schema.string(description: 'The enum name, e.g. "DsButtonVariant"')
      },
      required: ['name'],
    ),
  );

  FutureOr<CallToolResult> _getEnum(CallToolRequest request) {
    final name = request.arguments!['name'] as String;
    final enumInfo = _findByName(_catalog.enums, (e) => e.name, name);
    if (enumInfo == null) {
      return _notFound(name, 'enum', _catalog.enums.map((e) => e.name));
    }
    return _jsonResult(enumInfo.toJson());
  }

  // --- search_docs -----------------------------------------------------------

  /// Searches the dartdoc-generated index for a free-text query.
  final searchDocsTool = Tool(
    name: 'search_docs',
    description:
        'Full-text search over the dartdoc index (doc/api/index.json) for a '
        'component, token, or member name. Use this when you don\'t know '
        'the exact symbol name. Requires `dart doc .` to have been run '
        'inside design_system/.',
    inputSchema: Schema.object(
      properties: {
        'query': Schema.string(
            description: 'Free-text search term, e.g. "banner" or "loading"'),
        'limit':
            Schema.int(description: 'Max results to return. Defaults to 20.'),
      },
      required: ['query'],
    ),
  );

  FutureOr<CallToolResult> _searchDocs(CallToolRequest request) {
    final query = request.arguments!['query'] as String;
    final limit = (request.arguments!['limit'] as int?) ?? 20;

    try {
      final index = _docIndex ??= DocSearchIndex.load(_docIndexPath);
      final results = index.search(query, limit: limit);
      return _jsonResult([for (final r in results) r.toJson()]);
    } on StateError catch (e) {
      return CallToolResult(
          content: [TextContent(text: e.message)], isError: true);
    }
  }

  // --- helpers ---------------------------------------------------------------

  CallToolResult _jsonResult(Object? data) =>
      CallToolResult(content: [TextContent(text: jsonEncode(data))]);

  CallToolResult _notFound(
      String name, String kind, Iterable<String> available) {
    final sorted = available.toList()..sort();
    return CallToolResult(
      content: [
        TextContent(
            text: 'No $kind named "$name". Available: ${sorted.join(', ')}'),
      ],
      isError: true,
    );
  }

  T? _findByName<T>(List<T> items, String Function(T) nameOf, String name) {
    for (final item in items) {
      if (nameOf(item) == name) return item;
    }
    return null;
  }

  String _firstLine(String? doc) => doc == null ? '' : doc.split('\n').first;
}
