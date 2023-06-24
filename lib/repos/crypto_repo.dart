import 'dart:convert';
import 'package:cryptonotifier/models/crypto.dart';
import 'package:http/http.dart';

class CryptoRepository {
  String coincap = "https://api.coincap.io/v2/assets/";

  Future<List<Crypto>> getCryptos() async {
    Response response = await get(Uri.parse(coincap));
    if(response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      result.forEach((element) async {
        String img = "https://assets.coincap.io/assets/icons/${element['symbol'].toLowerCase()}@2x.png";
        element['img'] = img;
        double price = double.parse(element['priceUsd']);
        element['price'] = '${price >=1 ? price.toStringAsFixed(2) : price >= 0.01 ? price.toStringAsFixed(5) : price.toStringAsFixed(10)}\$';
        });
        return result.map((e) => Crypto.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}