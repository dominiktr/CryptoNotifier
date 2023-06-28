import 'package:cryptonotifier/bloc/crypto_event.dart';
import 'package:cryptonotifier/bloc/crypto_state.dart';
import 'package:cryptonotifier/repos/crypto_repo.dart';
import 'package:cryptonotifier/repos/preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/crypto.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final cryptoRepo = CryptoRepository();
  final prefService = PreferencesService();

  CryptoBloc() : super(CryptosLoadingState()) {
    on<LoadCryptoEvent>((event, emit) async {
      try {
        emit(CryptosLoadingState());
        List<Crypto> cryptos = (await cryptoRepo.getCryptos()).cast<Crypto>();
        for (var i = 0; i < cryptos.length; i++) {
          final alarms = await prefService.getAlarm(cryptos[i].symbol);
          cryptos[i].alarms = alarms;
        }
        emit(CryptosLoadedState(cryptos: cryptos));
      } catch (e) {
        emit(CryptoLoadingError(error: e.toString()));
      }
    });
  }
}
