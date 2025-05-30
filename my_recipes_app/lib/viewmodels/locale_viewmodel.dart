import 'dart:ui';

import 'package:flutter/material.dart';

class LocaleViewmodel extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  void clearLocale() {
    _locale = const Locale('es'); // Restablecer al valor por defecto
    notifyListeners();
  }
}
