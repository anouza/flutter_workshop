import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier{
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  updateByKey(Map<String, dynamic> updatedlist){
    updatedlist.forEach((key, value) {
      _data[key] = value;
    });

    notifyListeners();
  }

  updateWholeData(Map<String, dynamic> updatedlist){
    _data = updatedlist;
    notifyListeners();
  }
}