import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void load() {
    final box = Hive.box('settings');
    _isDark = box.get('dark', defaultValue: false);
    notifyListeners();
  }

  Future<void> toggle() async {
    _isDark = !_isDark;
    await Hive.box('settings').put('dark', _isDark);
    notifyListeners();
  }
}
