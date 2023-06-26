import 'package:flutter/material.dart';

class LoanDetailsProvider extends ChangeNotifier{
  Map<String, dynamic> _loandetails = {};

  Map<String, dynamic> get loandetails => _loandetails;

  updateLoanDetails(Map<String, dynamic> newdetails){
    _loandetails = newdetails;
    notifyListeners();
  }
}