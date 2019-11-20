import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kopo/kopo.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  testWidgets('Create Kopo', (WidgetTester tester) async {
    await tester.pumpWidget(Kopo(title: 'title'));

    final titleFinder = find.text('title');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Load daum post url', (WidgetTester tester) async {
    final key = new GlobalKey<KopoState>();
    await tester.pumpWidget(Kopo(key: key));

    WebViewController controller = key.currentState.controller;

    expect(controller, isNotNull);
    expect(
      await controller.currentUrl(),
      'https://salondecode.github.io/kopo/assets/daum.html',
    );
  });

  testWidgets('evaluate Javascript', (WidgetTester tester) async {
    final key = new GlobalKey<KopoState>();
    await tester.pumpWidget(Kopo(key: key));

    WebViewController controller = key.currentState.controller;

    expect(
      await controller.evaluateJavascript("fake js string"),
      "fake js string",
      reason: 'should get the argument',
    );
    expect(
      () => controller.evaluateJavascript(null),
      throwsA(anything),
    );
  });
}
