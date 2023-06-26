import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_workshop/components/icon_text_button.dart';
import 'package:flutter_workshop/model/exrate_model.dart';
import 'package:flutter_workshop/pages/loan/loan_details.dart';
import 'package:flutter_workshop/providers/appdata_provider.dart';
import 'package:flutter_workshop/providers/loandetails_provider.dart';
import 'package:flutter_workshop/providers/tabindex_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Map<String, String>> loanList = [
  {
    'title': "Marriage Loan",
    'img':
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'details': "Marriage Loan is for love couple blah blah...."
  },
  {
    'title': "Business Loan",
    'img':
        'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'details': "Business Loan is serious business..."
  },
  {
    'title': "Easy Loan",
    'img':
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'details': "Easy Loan is sabaiy sabaiy..."
  },
  {
    'title': "Personal Loan",
    'img':
        'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'details': "Personal Loan is blah blah"
  },
  {
    'title': "Consumer Loan",
    'img':
        'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'details': "Consumer Loan is blas blah..."
  },
  {
    'title': "Overdraft Loan",
    'img':
        'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
    'details': "Overdraft Loan is blah blah.."
  },
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final numFormat = NumberFormat('###,##0.00');
  // Obtain shared preferences.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // doInqExrt();
    doInqExrtService();
  }

  doInqExrt() async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);

    // do something here?
    final response = await http.get(
      Uri.parse('https://www.bcel.com.la/appservice/news/itrslt'),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> respbody = jsonDecode(response.body);

      if (respbody['exrtList'] != null) {
        List<dynamic> exrtData = respbody['exrtList'];
        appDataProvider.updateByKey({"exrtList": exrtData});
      }
    } else {
      // then throw an exception.
      throw Exception('Failed to doInqExrt');
    }
  }

  doInqExrtService() async {
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // try to read from
    String destCcy = "LAK";
    List<String> currencies = [
      "USD",
      "THB",
      "EUR",
      "CNY",
      "AUD",
      "CAD",
      "JPY",
      "SGD",
      "SEK",
      "NOK",
      "HKD",
      "GBP",
      "DKK",
      "CHF",
      "VND"
    ];
    List<ExchangeRateModel> exrateList = [];

    // try to get exchange rates from local storage first - if exists then set before fetching new ones
    String? existingExrtList = prefs.getString('exrtList');
    if (existingExrtList != null) {
      // exrateList = jsonDecode(existingExrtList);
      var list =
          jsonDecode("{\"list\": ${jsonDecode(existingExrtList)} }")['list']
              as List;
      exrateList = list.map((news) => ExchangeRateModel.fromMap(news)).toList();

      appDataProvider.updateByKey({"exrtList": exrateList});
    }

    double buyRate;
    double sellRate;
    String dateRate;
    exrateList = []; // reset

    for (var ccy in currencies) {
      buyRate = 0;
      sellRate = 0;
      dateRate = "";

      //  buy rate
      var response = await http.get(
        Uri.parse(
            'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${ccy.toLowerCase()}/${destCcy.toLowerCase()}.json'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> respbody = jsonDecode(response.body);
        buyRate = respbody[destCcy.toLowerCase()] ?? 0.0;
        dateRate = respbody["date"] ?? "";
      }

      // sell rate
      var response2 = await http.get(
        Uri.parse(
            'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${destCcy.toLowerCase()}/${ccy.toLowerCase()}.json'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
      );

      if (response2.statusCode == 201 || response2.statusCode == 200) {
        Map<String, dynamic> respbody = jsonDecode(response2.body);
        double srate = respbody[ccy.toLowerCase()] ?? 0.0; // 1 LAK = srate CCY
        // needs to full conversion to 1 srate CCY -> x LAK
        sellRate = 1 / srate;
      }

      exrateList.add(ExchangeRateModel(
          sourceCurrency: ccy,
          destCurrency: destCcy,
          icon: '$ccy.png',
          dateRate: dateRate,
          etf: buyRate,
          sell: sellRate,
          buydisp: numFormat.format(buyRate),
          selldisp: numFormat.format(sellRate)));
    }

    // update latest to provider and to local storage
    appDataProvider.updateByKey({"exrtList": exrateList});
    prefs.setString("exrtList", jsonEncode(exrateList));

    // // do something here?
    // final response = await http.get(
    //   Uri.parse('https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$srcCcy/$destCcy.json'),
    //   headers: <String, String>{
    //     HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    //   },
    // );

    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //   Map<String, dynamic> respbody = jsonDecode(response.body);

    //   if (respbody['exrtList'] != null) {
    //     List<dynamic> exrtData = respbody['exrtList'];
    //     appDataProvider.updateByKey({"exrtList": exrtData});
    //   }
    // } else {
    //   // then throw an exception.
    //   throw Exception('Failed to doInqExrt');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider =
        Provider.of<TabIndexProvider>(context, listen: false);
    final loanDetailsProvider =
        Provider.of<LoanDetailsProvider>(context, listen: false);
    // final List<Widget> imageSliders = imgList
    //     .map((item) => GestureDetector(
    //           onTap: () {
    //             // map data?
    //             Map<String, dynamic> loandetails = {};
    //             loandetails['title'] = "";
    //             loandetails['img'] = item;
    //             loandetails['details'] = "";

    //             Provider.of<LoanDetailsProvider>(context).updateLoanDetails(loandetails);
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const LoanDetailsPage(),
    //                 ));
    //           },
    //           child: Container(
    //             margin: const EdgeInsets.all(5.0),
    //             child: ClipRRect(
    //                 borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    //                 child: Stack(
    //                   children: <Widget>[
    //                     Image.network(item, fit: BoxFit.cover, width: 1000.0),
    //                     Positioned(
    //                       bottom: 0.0,
    //                       left: 0.0,
    //                       right: 0.0,
    //                       child: Container(
    //                         decoration: const BoxDecoration(
    //                           gradient: LinearGradient(
    //                             colors: [
    //                               Color.fromARGB(200, 0, 0, 0),
    //                               Color.fromARGB(0, 0, 0, 0)
    //                             ],
    //                             begin: Alignment.bottomCenter,
    //                             end: Alignment.topCenter,
    //                           ),
    //                         ),
    //                         padding: const EdgeInsets.symmetric(
    //                             vertical: 10.0, horizontal: 20.0),
    //                         child: Text(
    //                           'No. ${imgList.indexOf(item)} image',
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 20.0,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 )),
    //           ),
    //         ))
    //     .toList();

    final List<Widget> imageSliders = loanList
        .map((item) => GestureDetector(
              onTap: () {
                loanDetailsProvider.updateLoanDetails(item);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoanDetailsPage(),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item['img'].toString(),
                            fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item['title'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        Row(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: IconTextButton(
                          icon: Icons.attach_money,
                          text: 'Exchange Rate',
                          onPressed: () {
                            // Handle button press here
                            tabIndexProvider.updateIndex(1);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconTextButton(
                          icon: Icons.percent,
                          text: 'Interest Rates',
                          onPressed: () {
                            // Handle button press here
                            tabIndexProvider.updateIndex(2);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconTextButton(
                          icon: Icons.currency_exchange,
                          text: 'Exchange Calculator',
                          onPressed: () {
                            // Handle button press here
                            tabIndexProvider.updateIndex(3);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<AppDataProvider>(builder: (context, appDataProvider, child) {
          var exrateList = appDataProvider.data['exrtList'];
          if (exrateList != null) {
            return listExchangeRateTable(exrateList as List<ExchangeRateModel>);
          } else {
            return const SizedBox();
          }

          // var datastr = appDataProvider.data['exrtList'];
          // List<ExchangeRateModel> data = [];

          // print("datastr = $datastr");

          // if (datastr != null) {
          //   var list = jsonDecode("{\"list\": ${jsonEncode(datastr)} }")['list']
          //       as List;
          //   data = list.map((news) => ExchangeRateModel.fromMap(news)).toList();
          // }

          // return listExchangeRateTable(data);
        }),
      ]),
    );
  }

  Widget listExchangeRateTable(List<ExchangeRateModel> list) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Exchange Rates',
                  // style: TextStyle(fontStyle: FontStyle.italic),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  '',
                  // style: TextStyle(fontStyle: FontStyle.italic),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  '',
                  // style: TextStyle(fontStyle: FontStyle.italic),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
        // rows: listExchangeRates(list),
        rows: listExchangeRatesNew(list),
      ),
    );
  }

  List<DataRow> listExchangeRates(List<ExchangeRateModel> list) {
    List<DataRow> result = [];
    ExchangeRateModel m;
    for (var i = 0; i < (list.length > 5 ? 5 : list.length); i++) {
      m = list[i];

      result.add(DataRow(
        cells: <DataCell>[
          DataCell(Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/flags/${m.icon!.toLowerCase()}"),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(m.destCurrency.toString())
            ],
          )),
          DataCell(Text(
            m.buydisp.toString(),
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            m.selldisp.toString(),
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          )),
        ],
      ));
    }

    return result;
  }

  List<DataRow> listExchangeRatesNew(List<ExchangeRateModel> list) {
    List<DataRow> result = [];
    ExchangeRateModel m;
    for (var i = 0; i < (list.length > 5 ? 5 : list.length); i++) {
      m = list[i];

      result.add(DataRow(
        cells: <DataCell>[
          DataCell(Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/flags/${m.icon!.toLowerCase()}"),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(m.sourceCurrency.toString())
              ],
            ),
          )),
          DataCell(Container(
            alignment: Alignment.centerLeft,
            child: Text(
              m.buydisp.toString(),
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          )),
          DataCell(Container(
            alignment: Alignment.centerLeft,
            child: Text(
              m.selldisp.toString(),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )),
        ],
      ));
    }

    return result;
  }
}
