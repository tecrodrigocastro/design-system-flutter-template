import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_gallery/main.dart';

void main() {
  testWidgets('renders the Widgetbook shell without throwing', (tester) async {
    await tester.pumpWidget(const WidgetbookGalleryApp());
    await tester.pumpAndSettle();

    expect(find.byType(WidgetbookGalleryApp), findsOneWidget);
  });
}
