import 'package:mcp_server/src/search/doc_search_index.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  // `dart test` always runs with the package root as the working
  // directory, so this fixture path is stable regardless of which shell
  // invoked it.
  final fixturePath = p.join('test', 'fixtures', 'sample_index.json');

  test('loads and decodes entries, including nested kinds', () {
    final index = DocSearchIndex.load(fixturePath);

    final results = index.search('DsBanner');
    final class_ = results.firstWhere((e) => e.kind == 'class');
    expect(class_.name, 'DsBanner');

    final constructor = results.firstWhere((e) => e.kind == 'constructor');
    expect(constructor.enclosedBy, 'DsBanner');
  });

  test('matches by name or description, ranking name matches first', () {
    final index = DocSearchIndex.load(fixturePath);

    final results = index.search('spinner');

    expect(results, hasLength(1));
    expect(results.single.name, 'isLoading');
  });

  test('search is case-insensitive', () {
    final index = DocSearchIndex.load(fixturePath);

    expect(index.search('dsbutton').map((e) => e.name),
        contains('DsButtonVariant'));
  });

  test('throws a helpful error when the index file is missing', () {
    expect(
        () => DocSearchIndex.load('/nonexistent/index.json'), throwsStateError);
  });
}
