import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/ui/core/widgets/async_action_button.dart';

void main() {
  testWidgets('shows progress and prevents repeated taps while running', (
    tester,
  ) async {
    var calls = 0;
    final completion = Completer<void>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AsyncActionButton(
            label: 'Повторить',
            onPressed: () {
              calls += 1;
              return completion.future;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Повторить'));
    await tester.pump();
    await tester.tap(find.byType(AsyncActionButton));

    expect(calls, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    completion.complete();
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Повторить'), findsOneWidget);
  });
}
