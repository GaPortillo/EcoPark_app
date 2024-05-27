// lib/presentation/providers/current_screen_provider.dart

import 'package:flutter/material.dart';

class CurrentScreenProvider extends ChangeNotifier {
  int _currentScreenIndex;

  CurrentScreenProvider([this._currentScreenIndex = 0]);

  int get currentScreenIndex => _currentScreenIndex;

  void changeScreen(int newIndex) {
    if (_currentScreenIndex != newIndex) {
      _currentScreenIndex = newIndex;
      notifyListeners();
    }
  }
}