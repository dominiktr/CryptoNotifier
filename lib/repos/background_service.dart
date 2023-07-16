import 'package:cryptonotifier/models/alarm.dart';
import 'package:cryptonotifier/models/crypto.dart';
import 'package:workmanager/workmanager.dart';

import 'load_cryptos_service.dart';

final workmanager = Workmanager();

void showNotification(Alarm alarm) {
  //todo
}

void callbackDispatcher() {
  workmanager.executeTask((taskName, inputData) async {
    if(taskName == 'CheckCryptos'){
      List<Crypto> cryptos  = await LoadCryptosService().loadCryptos();
      for (var c in cryptos) {
        for (var a in c.alarms) {
          if(a.high){
            if(double.parse(c.price) > a.price_target){
              showNotification(a);
            }
          }else {
            if(double.parse(c.price) < a.price_target){
              showNotification(a);
            }
          }
        }
      }
    }
    return Future.value(true);
  });
}

void registerBackgroundTask() {
  workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  workmanager.registerPeriodicTask("CheckCryptos", "CheckCryptos",
      frequency: const Duration(minutes: 15));
}
