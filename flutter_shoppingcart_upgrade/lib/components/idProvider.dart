import 'package:flutter/material.dart';

class idProvider with ChangeNotifier {
  int _colorId = 0;
  int _selectedId = 0;

  int get colorId => _colorId;
  int get selectedId => _selectedId;

  void colorIdChange(int id) {
    _colorId = id;

    notifyListeners();
  }

  void seletedIdChange(int id) {
    _selectedId = id;
    _colorId = 0;
    notifyListeners();
  }
}
