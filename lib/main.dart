import 'package:flutter/material.dart';

import 'app/app.dart';
import 'telegram/telegram_web_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final telegram = TelegramWebApp.initialize();
  runApp(GymTrainingApp(telegram: telegram));
}
