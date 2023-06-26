import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class LoanCalculatorPage extends StatefulWidget {
  const LoanCalculatorPage({super.key});

  @override
  State<LoanCalculatorPage> createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  /*
    what a loan calculator shall have:
    loan type (loan percentage), amount, ccy, loan period
    after calculation then show per repayment and loan schedule

    - logic
    1. calculate repayment amount for each month
    2. calculate end date (because loan period will contain months)
    3. display results in another page
    
  */
  final _formKey = GlobalKey<FormState>();
  final _loanAmount = TextEditingController();
  double _interestRate = 0;
  double _loanTerm = 0;
  double _monthlyPayment = 0;
  String _loanCcy = "LAK";
  final NumberFormat numFormat = NumberFormat('###,##0.00');
  String _formatNumber(String s) =>
      NumberFormat('#,###.##').format(double.parse(s));

  void _calculateMonthlyPayment() {
    setState(() {
      double monthlyInterestRate = (_interestRate / 100) / 12;
      double totalMonths = _loanTerm * 12;
      double temp = pow((1 + monthlyInterestRate), (totalMonths)) as double;

      _monthlyPayment =
          (double.tryParse(_loanAmount.text.replaceAll(",", "")) ?? 0) *
              monthlyInterestRate *
              temp /
              (temp - 1);
    });
  }

  List<Map<String, dynamic>> _generateRepaymentSchedule() {
    List<Map<String, dynamic>> schedule = [];
    double remainingBalance =
        double.tryParse(_loanAmount.text.replaceAll(",", "")) ?? 0;
    double monthlyInterestRate = (_interestRate / 100) / 12;
    double totalMonths = _loanTerm * 12;

    for (int i = 1; i <= totalMonths; i++) {
      double interestPayment = remainingBalance * monthlyInterestRate;
      double principalPayment = _monthlyPayment - interestPayment;
      remainingBalance -= principalPayment;

      schedule.add({
        'month': i,
        'principal': principalPayment,
        'interest': interestPayment,
        'balance': remainingBalance,
      });
    }

    return schedule;
  }

  Widget _buildRepaymentScheduleTable() {
    List<Map<String, dynamic>> schedule = _generateRepaymentSchedule();

    return DataTable(
      columnSpacing: 30,
      columns: const [
        DataColumn(label: Text('Month')),
        DataColumn(label: Text('Principal')),
        DataColumn(label: Text('Interest')),
        DataColumn(label: Text('Balance')),
      ],
      rows: schedule.map((row) {
        return DataRow(cells: [
          DataCell(Text(row['month'].toString())),
          DataCell(Text(numFormat.format(row['principal']))),
          DataCell(Text(numFormat.format(row['interest']))),
          DataCell(Text(numFormat.format(row['balance']))),
        ]);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xFF1e8bfa);

    return SizedBox(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _loanAmount,
              decoration: const InputDecoration(
                  labelText: 'Loan Amount', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              // onChanged: (value) {
              //   _loanAmount = value;
              // },
              onChanged: (string) {
                string = _formatNumber(string.replaceAll(',', ''));
                _loanAmount.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length),
                );
              },
            ),
            const SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              value: _loanCcy,
              onChanged: (value) {
                setState(() {
                  _loanCcy = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "LAK",
                  child: Text("Lao Kip - LAK"),
                ),
                DropdownMenuItem(
                  value: "USD",
                  child: Text("US Dollar - USD"),
                ),
                DropdownMenuItem(
                  value: "THB",
                  child: Text("Thai Baht - THB"),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Currency',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            DropdownButtonFormField<double>(
              value: _interestRate,
              onChanged: (value) {
                setState(() {
                  _interestRate = value ?? 0;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 0,
                  enabled: false,
                  child: Text("--- Please select ---"),
                ),
                DropdownMenuItem(
                  value: 6,
                  child: Text("Consumer Loan - 6% per year"),
                ),
                DropdownMenuItem(
                  value: 7,
                  child: Text("Home Loan - 7% per year"),
                ),
                DropdownMenuItem(
                  value: 15,
                  child: Text("Overdraft Loan - 15% per year"),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Interest Rate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            DropdownButtonFormField<double>(
              value: _loanTerm,
              onChanged: (value) {
                setState(() {
                  _loanTerm = value ?? 0.0;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 0,
                  enabled: false,
                  child: Text("--- Please select ---"),
                ),
                DropdownMenuItem(
                  value: 0.5,
                  child: Text("6 Months"),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text("1 Year"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("2 Years"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("3 Years"),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text("5 Years"),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text("10 Years"),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Loan Term',
                border: OutlineInputBorder(),
              ),
            ),
            // TextFormField(
            //   decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            //   keyboardType: TextInputType.number,
            //   onChanged: (value) {
            //     _interestRate = double.tryParse(value) ?? 0;
            //   },
            // ),
            // TextFormField(
            //   decoration: InputDecoration(labelText: 'Loan Term (Years)'),
            //   keyboardType: TextInputType.number,
            //   onChanged: (value) {
            //     _loanTerm = int.tryParse(value) ?? 0;
            //   },
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateMonthlyPayment,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'Calculate Monthly Payment',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 16),
            if (_monthlyPayment > 0)
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Monthly Payment:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '${numFormat.format(_monthlyPayment)} $_loanCcy',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ]),
              const SizedBox(height: 16),
            if (_monthlyPayment > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Repayment Schedule:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildRepaymentScheduleTable(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
