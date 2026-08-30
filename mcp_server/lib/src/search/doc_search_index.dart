/// Loads and searches the `index.json` search index that `dart doc`
/// generates alongside the HTML docs (`doc/api/index.json`).
///
/// This index is intentionally shallow (name, kind, one-line description,
/// href) — good for discovery ("does a banner component exist?"), not for
/// full prop schemas. For that, see `catalog_loader.dart`.
library;

import 'dart:convert';
import 'dart:io';

/// Best-effort labels for dartdoc's numeric `kind` codes, derived
/// empirically from a generated `index.json` (dartdoc does not publish a
/// stable enum for these).
const _kindLabels = <int, String>{
  1: 'constant',
  2: 'constructor',
  3: 'class',
  5: 'enum',
  9: 'library',
  10: 'method',
  16: 'property',
};

String _labelForKind(int kind) => _kindLabels[kind] ?? 'kind_$kind';

/// A single entry from dartdoc's `index.json`.
class DocSearchEntry {
  DocSearchEntry({
    required this.name,
    required this.qualifiedName,
    required this.kind,
    required this.href,
    required this.description,
    required this.enclosedBy,
  });

  factory DocSearchEntry.fromJson(Map<String, Object?> json) {
    final enclosedBy = json['enclosedBy'] as Map<String, Object?>?;
    return DocSearchEntry(
      name: json['name'] as String? ?? '',
      qualifiedName: json['qualifiedName'] as String? ?? '',
      kind: _labelForKind(json['kind'] as int? ?? -1),
      href: json['href'] as String? ?? '',
      description: json['desc'] as String?,
      enclosedBy: enclosedBy?['name'] as String?,
    );
  }

  final String name;
  final String qualifiedName;
  final String kind;
  final String href;
  final String? description;
  final String? enclosedBy;

  Map<String, Object?> toJson() => {
        'name': name,
        'qualifiedName': qualifiedName,
        'kind': kind,
        'href': href,
        if (description != null) 'description': description,
        if (enclosedBy != null) 'enclosedBy': enclosedBy,
      };
}

/// A searchable in-memory copy of dartdoc's `index.json`.
class DocSearchIndex {
  DocSearchIndex(this._entries);

  /// Reads and parses `index.json` from [indexJsonPath].
  ///
  /// Throws a [StateError] with a helpful message if the file doesn't
  /// exist yet (i.e. `dart doc` hasn't been run).
  factory DocSearchIndex.load(String indexJsonPath) {
    final file = File(indexJsonPath);
    if (!file.existsSync()) {
      throw StateError(
        'No dartdoc index found at "$indexJsonPath". '
        'Run `dart doc .` inside the design_system package first.',
      );
    }
    final raw = jsonDecode(file.readAsStringSync()) as List<Object?>;
    return DocSearchIndex([
      for (final entry in raw.cast<Map<String, Object?>>())
        DocSearchEntry.fromJson(entry),
    ]);
  }

  final List<DocSearchEntry> _entries;

  /// Returns entries whose name or description contains [query]
  /// (case-insensitive), name matches ranked first.
  List<DocSearchEntry> search(String query, {int limit = 20}) {
    final needle = query.toLowerCase();
    bool nameMatches(DocSearchEntry e) => e.name.toLowerCase().contains(needle);
    bool descMatches(DocSearchEntry e) =>
        e.description?.toLowerCase().contains(needle) ?? false;

    final matches =
        _entries.where((e) => nameMatches(e) || descMatches(e)).toList()
          ..sort((a, b) {
            final aNameMatch = nameMatches(a);
            final bNameMatch = nameMatches(b);
            if (aNameMatch != bNameMatch) return aNameMatch ? -1 : 1;
            return a.name.compareTo(b.name);
          });

    return matches.take(limit).toList();
  }
}
