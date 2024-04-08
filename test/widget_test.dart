import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reference_architecture/ui/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  testWidgets('Increments counter', (WidgetTester tester) async {
    await givenApiBackendIsRunning(() async {
      await whenAppIsRunning(tester);
      await thenShowsInitialCounterValue(tester);

      await whenTapOnIncrementCounterButton(tester);
      await thenShowsIncrementedCounterValue(tester);
    });
  });
}

givenApiBackendIsRunning(Future<void> Function() fn) {
  final client = MockClient((request) async {
    if (request.url.path.endsWith('/get-counter') && request.method == 'GET') {
      return Response(
          json.encode({'value': 15, 'updated_at': '2024-04-08T16:45:32+0000'}),
          200,
          headers: {'Content-Type': 'application/json'});
    }
    if (request.url.path.endsWith('/increment-counter') &&
        request.method == 'POST') {
      return Response(
          json.encode({'value': 16, 'updated_at': '2024-04-08T16:45:46+0000'}),
          200,
          headers: {'Content-Type': 'application/json'});
    }
    return Response('Method Not Allowed', 405, headers: {});
  });
  return runWithClient(fn, () => client);
}

whenAppIsRunning(WidgetTester tester) => tester.pumpWidget(const App());

whenTapOnIncrementCounterButton(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(find.byIcon(Icons.add));
}

thenShowsInitialCounterValue(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await expectLater(find.byType(App),
      matchesGoldenFile('snapshots/initial-counter-value.png'));
}

thenShowsIncrementedCounterValue(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await expectLater(find.byType(App),
      matchesGoldenFile('snapshots/incremented-counter-value.png'));
}
