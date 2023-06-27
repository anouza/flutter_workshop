import 'package:flutter/material.dart';
import 'package:flutter_workshop/model/exrate_model.dart';
import 'package:flutter_workshop/providers/appdata_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExchangeCalculatorPage extends StatefulWidget {
  const ExchangeCalculatorPage({super.key});

  @override
  State<ExchangeCalculatorPage> createState() => _ExchangeCalculatorPageState();
}

class _ExchangeCalculatorPageState extends State<ExchangeCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();
  String _sourceCurrency = 'USD';
  String _destinationCurrency = 'LAK';
  double _convertedAmount = 0.0;
  Map<String, ExchangeRateModel> exchangeRates = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convertAmount() {
    setState(() {
      final double amount = double.tryParse(_amountController.text.replaceAll(",", "")) ?? 0.0;
      final double sourceRate = exchangeRates[_sourceCurrency]?.etf ?? 1.0;
      final double destinationRate =
          exchangeRates[_destinationCurrency]?.etf ?? 1.0;

      _convertedAmount = amount * sourceRate / destinationRate;
    });
  }

  void _swapCurrencies() {
    setState(() {
      final String temp = _sourceCurrency;
      _sourceCurrency = _destinationCurrency;
      _destinationCurrency = temp;

      _convertAmount();
    });
  }

  String _formatNumber(String s) =>
      NumberFormat('#,###.##').format(double.parse(s));

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xFF1e8bfa);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Consumer<AppDataProvider>(
                          builder: (context, appDataProvider, child) {
                        var datastr = appDataProvider.data['exrtList'];
                        List<DropdownMenuItem<String>> data = [];
      
                        if (datastr != null) {
                          List<ExchangeRateModel> list =
                              datastr as List<ExchangeRateModel>;
      
                          // LAK first
                          data.insert(
                              0,
                              const DropdownMenuItem<String>(
                                value: "LAK",
                                child: Text("LAK"),
                              ));
      
                          // then other currencies
                          for (ExchangeRateModel ccy in list) {
                            exchangeRates[ccy.sourceCurrency.toString()] = ccy;
                            data.add(DropdownMenuItem<String>(
                              value: ccy.sourceCurrency,
                              child: Text(ccy.sourceCurrency.toString()),
                            ));
                          }
      
                          // var list = jsonDecode(
                          //         "{\"list\": ${jsonEncode(datastr)} }")['list']
                          //     as List;
                          // data = list.map((news) {
                          //   ExchangeRateModel m = ExchangeRateModel.fromMap(news);
                          //   exchangeRates[
                          //       m.destCurrency.toString().substring(0, 3)] = m;
      
                          //   if (m.destCurrency == 'USD 1-20' ||
                          //       m.destCurrency == 'EUR 1-20') {
                          //     return const DropdownMenuItem<String>(
                          //       value: "",
                          //       child: Text(""),
                          //     );
                          //   } else {
                          //     return DropdownMenuItem<String>(
                          //       value: m.destCurrency?.substring(0, 3),
                          //       child: Text(
                          //           m.destCurrency.toString().substring(0, 3)),
                          //     );
                          //   }
                          // }).toList();
      
                          // // clear empty values
                          // data.removeWhere((element) => element.value == "");
      
                          // // LAK
                          // data.insert(0, const DropdownMenuItem<String>(
                          //       value: "LAK",
                          //       child: Text("LAK"),
                          //     ));
                        }
      
                        return Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _sourceCurrency,
                            onChanged: (value) {
                              setState(() {
                                _sourceCurrency = value!;
                              });
                            },
                            items: data,
                            decoration: const InputDecoration(
                              labelText: 'From',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      }),
                      IconButton(
                        onPressed: _swapCurrencies,
                        icon: const Icon(Icons.swap_horiz),
                      ),
                      Consumer<AppDataProvider>(
                          builder: (context, appDataProvider, child) {
                        var datastr = appDataProvider.data['exrtList'];
                        List<DropdownMenuItem<String>> data = [];
      
                        if (datastr != null) {
                          List<ExchangeRateModel> list =
                              datastr as List<ExchangeRateModel>;
      
                          // LAK first
                          data.insert(
                              0,
                              const DropdownMenuItem<String>(
                                value: "LAK",
                                child: Text("LAK"),
                              ));
      
                          // then other currencies
                          for (ExchangeRateModel ccy in list) {
                            data.add(DropdownMenuItem<String>(
                              value: ccy.sourceCurrency,
                              child: Text(ccy.sourceCurrency.toString()),
                            ));
                          }
      
                          // var list = jsonDecode(
                          //         "{\"list\": ${jsonEncode(datastr)} }")['list']
                          //     as List;
                          // data = list.map((news) {
                          //   ExchangeRateModel m = ExchangeRateModel.fromMap(news);
      
                          //   if (m.destCurrency == 'USD 1-20' ||
                          //       m.destCurrency == 'EUR 1-20') {
                          //     return const DropdownMenuItem<String>(
                          //       value: "",
                          //       child: Text(""),
                          //     );
                          //   } else {
                          //     return DropdownMenuItem<String>(
                          //       value: m.destCurrency?.substring(0, 3),
                          //       child: Text(
                          //           m.destCurrency.toString().substring(0, 3)),
                          //     );
                          //   }
                          // }).toList();
      
                          // // clear empty values
                          // data.removeWhere((element) => element.value == "");
      
                          // // LAK
                          // data.insert(0, const DropdownMenuItem<String>(
                          //       value: "LAK",
                          //       child: Text("LAK"),
                          //     ));
                        }
      
                        return Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _destinationCurrency,
                            onChanged: (value) {
                              setState(() {
                                _destinationCurrency = value!;
                              });
                            },
                            items: data,
                            decoration: const InputDecoration(
                              labelText: 'To',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      }),
                      // Expanded(
                      //   child: DropdownButtonFormField<String>(
                      //     value: _destinationCurrency,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         _destinationCurrency = value!;
                      //       });
                      //     },
                      //     items: exchangeRates.keys.map((currency) {
                      //       return DropdownMenuItem<String>(
                      //         value: currency,
                      //         child: Text(currency),
                      //       );
                      //     }).toList(),
                      //     decoration: InputDecoration(
                      //       labelText: 'To',
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _amountController.value = TextEditingValue(
                        text: string,
                        selection: TextSelection.collapsed(offset: string.length),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _convertAmount,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Convert',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  _convertedAmount != 0.0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Result",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: primaryColor),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 24.0),
                  _convertedAmount != 0.0
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/flags/${_sourceCurrency.toLowerCase()}.png"),
                          ),
                          title: const Text(
                            "Exchanged Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            NumberFormat.currency(
                                    locale: 'en-US',
                                    decimalDigits: 2,
                                    symbol: _sourceCurrency,
                                    customPattern: '#,##0.00 \u00a4')
                                .format(double.tryParse(_amountController.text.replaceAll(",", "")) ??
                                    1.0),
                            style:
                                const TextStyle(fontSize: 16, color: Colors.red),
                          ))
                      : const SizedBox(),
                  const SizedBox(
                    height: 8,
                  ),
                  _convertedAmount != 0.0
                      ? ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/flags/${_destinationCurrency.toLowerCase()}.png"),
                          ),
                          title: const Text(
                            "Received Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            NumberFormat.currency(
                                    locale: 'en-US',
                                    decimalDigits: 2,
                                    symbol: _destinationCurrency,
                                    customPattern: '#,##0.00 \u00a4')
                                .format(_convertedAmount),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                          ),
                        )
                      : const SizedBox(),
                  // _convertedAmount != 0.0
                  //     ? Text('Converted Amount: $_convertedAmount')
                  //     : SizedBox(),
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: exchangeRates.length,
            //     itemBuilder: (context, index) {
            //       final currencyCode = exchangeRates.keys.elementAt(index);
            //       final buyRate = exchangeRates[currencyCode];
      
            //       return ListTile(
            //         leading: Image.asset("assets/flags/usd.png"),
            //         title: Text(currencyCode),
            //         subtitle: Text('Buy Rate: ${buyRate?.etf}'),
            //         trailing: Text(
            //             'Sell Rate: ${buyRate?.etf ?? 1.0 + 0.02}'), // Example calculation, adjust as needed
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
