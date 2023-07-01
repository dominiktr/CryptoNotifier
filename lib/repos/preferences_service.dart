import 'package:cryptonotifier/models/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future save(Alarm alarm) async {
    final preferences = await SharedPreferences.getInstance();
    final current = preferences.getStringList(alarm.crypto_symbol);
    List<String> list = [alarm.price_target as String];
    if (current != null) list.addAll(current);
    await preferences.setStringList(alarm.crypto_symbol, list);
  }

  Future<List<Alarm>> getAlarm(String crypto_symbol) async {
    final preferences = await SharedPreferences.getInstance();
    final List<String>? targetPriceList = preferences.getStringList(crypto_symbol);
    final List<String>? highList = preferences.getStringList(crypto_symbol+"_high");
    final List<String>? activeList = preferences.getStringList(crypto_symbol+"_active");
    if (targetPriceList == null) return [];
    List<Alarm> returnList = [];
    
    for (var i = 0; i < targetPriceList.length; i++) {
      returnList.add(Alarm(crypto_symbol: crypto_symbol, price_target: double.parse(targetPriceList[i]), high: highList![i].toBoolean(), active: activeList![i].toBoolean()));
    }
    return returnList;
  }

  
}

extension on String {
  bool toBoolean() {
    print(this);
    return (this.toLowerCase() == "true" || this.toLowerCase() == "1")
        ? true
        : (this.toLowerCase() == "false" || this.toLowerCase() == "0"
            ? false
            : throw Exception("Parse error"));
  }
}
