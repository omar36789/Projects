import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_app_new/main.dart';

void main() {
  testWidgets('Home screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp()); // Remove 'const'

    expect(find.text('Pay Bills'), findsOneWidget);
    expect(find.text('Report Issues'), findsOneWidget);
    expect(find.text('Gov. Documents'), findsOneWidget);
    expect(find.text('Emergency Services'), findsOneWidget);
  });
}
