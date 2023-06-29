import '../../models/crypto.dart';

abstract class CryptoState {}

class CryptosLoadingState extends CryptoState {}

class CryptosLoadedState extends CryptoState {
  List<Crypto> cryptos;
  
  CryptosLoadedState({required this.cryptos});
}

class CryptoLoadingError extends CryptoState {
  final String error;

  CryptoLoadingError({required this.error});
}