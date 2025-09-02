import 'package:hive_flutter/hive_flutter.dart';

Future<void> dependencyInjection() async {
  await Hive.initFlutter();

  // Открываем боксы
  await Hive.openBox('characters');
  await Hive.openBox('favorites');
  await Hive.openBox('settings');
}
