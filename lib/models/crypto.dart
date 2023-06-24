class Crypto {
  final String symbol;
  final String price;
  final String img;

  Crypto({required this.symbol, required this.price, required this.img});

  factory Crypto.fromJson(Map<String, dynamic> json){
    return Crypto(symbol: json['symbol'], price: json['price'], img: json['img']);
  }
}