import 'package:flutter_test/flutter_test.dart';
import 'package:gym_training_app/main.dart';
import 'package:gym_training_app/telegram/telegram_web_app.dart';

void main() {
  testWidgets('shows Telegram launch information', (tester) async {
    const telegram = TelegramLaunchData(
      isTelegram: true,
      platform: 'tdesktop',
      version: '10.1',
      isDarkMode: false,
      userName: 'Dima (@dima)',
    );

    await tester.pumpWidget(const GymTrainingApp(telegram: telegram));

    expect(find.text('Telegram Mini App подключён'), findsOneWidget);
    expect(find.text('tdesktop'), findsOneWidget);
    expect(find.text('10.1'), findsOneWidget);
    expect(find.text('Dima (@dima)'), findsOneWidget);
  });

  testWidgets('shows a browser preview fallback', (tester) async {
    await tester.pumpWidget(
      const GymTrainingApp(telegram: TelegramLaunchData.browser()),
    );

    expect(find.text('Предпросмотр в обычном браузере'), findsOneWidget);
    expect(find.text('browser'), findsOneWidget);
  });
}
