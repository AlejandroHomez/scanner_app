import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _optionSelected = 0;

  int get optionSelected {
    return this._optionSelected;
  }

  set optionSelected(int i) {
    this._optionSelected = i;
    notifyListeners();
  }
}
