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
    final List<String>? list = preferences.getStringList(crypto_symbol);
    if (list == null) return [];
    final returnList = list.map((e) => Alarm(crypto_symbol: crypto_symbol, price_target: int.parse(e))).toList();
    return returnList;
  }
}
