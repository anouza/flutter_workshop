// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExchangeRateModel {
  /*
  {
            "sourceCurrency": "Vietnamese Dong",
            "destCurrency": "VND",
            "dateRate": "23/06/2023",
            "etf": 0.8367,
            "sell": 0.8534,
            "icon": "VND.png",
            "buydisp": "-",
            "selldisp": "0.85"
        }
   */

  String? sourceCurrency;
  String? destCurrency;
  String? dateRate;
  String? icon;
  String? buydisp;
  String? selldisp;
  double? etf;
  double? sell;


  ExchangeRateModel({
     this.sourceCurrency,
     this.destCurrency,
     this.dateRate,
     this.icon,
     this.buydisp,
     this.selldisp,
     this.etf,
     this.sell,
    }
  );


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sourceCurrency': sourceCurrency,
      'destCurrency': destCurrency,
      'dateRate': dateRate,
      'icon': icon,
      'buydisp': buydisp,
      'selldisp': selldisp,
      'etf': etf,
      'sell': sell,
    };
  }

  factory ExchangeRateModel.fromMap(Map<String, dynamic> map) {
    return ExchangeRateModel(
      sourceCurrency: map['sourceCurrency'],
      destCurrency: map['destCurrency'],
      dateRate: map['dateRate'],
      icon: map['icon'],
      buydisp: map['buydisp'],
      selldisp: map['selldisp'],
      etf: map['etf'],
      sell: map['sell']
    );
  }

  String toJson() => json.encode(toMap());

  factory ExchangeRateModel.fromJson(String source) => ExchangeRateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
