class Alarm {
  final String crypto_symbol;
  double price_target;
  bool high;
  bool active;

  Alarm({required this.crypto_symbol, required this.price_target, required this.high, required this.active});
}