import 'package:cryptonotifier/repos/crypto_repo.dart';
import 'package:cryptonotifier/repos/preferences_service.dart';
import '../../models/crypto.dart';

class LoadCryptosService {
  final cryptoRepo = CryptoRepository();
  final prefService = PreferencesService();

  Future<List<Crypto>> loadCryptos() async {
    List<Crypto> cryptos = (await cryptoRepo.getCryptos()).cast<Crypto>();
        for (var i = 0; i < cryptos.length; i++) {
          final alarms = await prefService.getAlarm(cryptos[i].symbol);
          cryptos[i].alarms = alarms;
        }
    return cryptos;
  }
}