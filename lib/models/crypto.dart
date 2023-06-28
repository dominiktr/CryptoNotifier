import 'package:cryptonotifier/models/alarm.dart';

class Crypto {
  final String symbol;
  final String price;
  final String img;
  List<Alarm> alarms;

  Crypto({required this.symbol, required this.price, required this.img, required this.alarms});

  factory Crypto.fromJson(Map<String, dynamic> json){
    return Crypto(symbol: json['symbol'], price: json['price'], img: json['img'], alarms: []);
  }
}