class CryptoModel {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double percentChange;
  final double marketCap;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentChange,
    required this.marketCap,
  });
}