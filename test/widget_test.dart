import 'package:flutter_test/flutter_test.dart';
import 'package:zenorix/zenorix_app.dart';

void main() {
  testWidgets('ZenorixApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ZenorixApp());
    await tester.pump();
    expect(find.text('Focus Sphere'), findsWidgets);
  });
}
