import 'package:flutter/material.dart';

class TabIndexProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  String _pageTitle = 'Forex & Loan';

  int get selectedIndex => _selectedIndex;
  String get pageTitle => _pageTitle;

  updateIndex(int newIndex){
    _selectedIndex = newIndex;
    switch (newIndex) {
      case 0:
        _pageTitle = "Forex & Loan";
        break;
      case 1:
        _pageTitle = "Exchange Rates";
        break;
      case 2:
        _pageTitle = "Loan Calculator";
        break;
      case 3:
        _pageTitle = "Rate Conversion";
        break;
      default:
    }

    notifyListeners();
  }

  updateTitle(String newTitle){
    _pageTitle = newTitle;
    notifyListeners();
  }
}