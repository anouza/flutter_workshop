import 'package:flutter/material.dart';
import 'package:flutter_workshop/model/exrate_model.dart';
import 'package:flutter_workshop/providers/appdata_provider.dart';
import 'package:provider/provider.dart';

class ExchangeRateDashboardPage extends StatefulWidget {
  const ExchangeRateDashboardPage({super.key});

  @override
  State<ExchangeRateDashboardPage> createState() =>
      _ExchangeRateDashboardPageState();
}

class _ExchangeRateDashboardPageState extends State<ExchangeRateDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
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
                  'Currency',
                  // style: TextStyle(fontStyle: FontStyle.italic),
                  style: TextStyle(fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Buy',
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
                  'Sell',
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
    for (var i = 0; i < list.length; i++) {
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
          DataCell(Text(m.buydisp.toString())),
          DataCell(Text(m.selldisp.toString())),
        ],
      ));
    }

    return result;
  }

  List<DataRow> listExchangeRatesNew(List<ExchangeRateModel> list) {
    List<DataRow> result = [];
    ExchangeRateModel m;
    for (var i = 0; i < list.length; i++) {
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
              Text(m.sourceCurrency.toString())
            ],
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
