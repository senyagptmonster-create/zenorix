import 'package:flutter_test/flutter_test.dart';
import 'package:zenorix/zenorix_app.dart';

void main() {
  testWidgets('ZenorixApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ZenorixApp());
    expect(find.text('ZENORIX FOCUS SPHERE'), findsOneWidget);
    expect(find.text('EXPAND SPHERE'), findsOneWidget);
  });
}
