import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/app/app.dart';
import 'package:gym_training_app/telegram/telegram_web_app.dart';

void main() {
  testWidgets('shows the training overview', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    expect(find.text('До тренировки — 2 дня'), findsOneWidget);
    expect(find.text('Следующая тренировка'), findsOneWidget);
    expect(find.text('Спина + бицепс'), findsOneWidget);
    expect(find.text('Начать тренировку'), findsOneWidget);
  });

  testWidgets('keeps shell navigation between main sections', (tester) async {
    await tester.pumpWidget(
      GymTrainingApp(telegram: const TelegramLaunchData.browser()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Расписание'));
    await tester.pumpAndSettle();
    expect(find.text('Расписание'), findsWidgets);
    expect(find.text('Грудь + трицепс'), findsOneWidget);

    await tester.tap(find.byTooltip('История'));
    await tester.pumpAndSettle();
    expect(find.text('История пока пуста'), findsOneWidget);
  });

  testWidgets('shows Telegram identity in profile', (tester) async {
    const telegram = TelegramLaunchData(
      isTelegram: true,
      platform: 'tdesktop',
      version: '10.1',
      isDarkMode: true,
      userName: 'Dima (@dima)',
    );
    await tester.pumpWidget(GymTrainingApp(telegram: telegram));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Профиль'));
    await tester.pumpAndSettle();

    expect(find.text('Dima (@dima)'), findsOneWidget);
    expect(find.text('Telegram подключён'), findsOneWidget);
    expect(find.text('tdesktop'), findsOneWidget);
  });
}
