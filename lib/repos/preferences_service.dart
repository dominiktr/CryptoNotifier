import 'package:cryptonotifier/models/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future save(List<Alarm> alarms) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(alarms[0].crypto_symbol, alarms.map((e) => e.price_target.toString()).toList());
    await preferences.setStringList("${alarms[0].crypto_symbol}_high", alarms.map((e) => e.high.toString()).toList());
    await preferences.setStringList("${alarms[0].crypto_symbol}_active", alarms.map((e) => e.active.toString()).toList());
  }

  Future<List<Alarm>> getAlarm(String crypto_symbol) async {
    final preferences = await SharedPreferences.getInstance();
    final List<String>? targetPriceList = preferences.getStringList(crypto_symbol);
    final List<String>? highList = preferences.getStringList("${crypto_symbol}_high");
    final List<String>? activeList = preferences.getStringList("${crypto_symbol}_active");
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
