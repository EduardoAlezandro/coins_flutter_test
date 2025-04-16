// coin_history_data.dart
class CoinHistoryData {
  final DateTime timestamp;
  final double price;
  final double marketCap;
  final double volume;

  CoinHistoryData({
    required this.timestamp,
    required this.price,
    required this.marketCap,
    required this.volume,
  });

  factory CoinHistoryData.fromJson(List<dynamic> json) {
    return CoinHistoryData(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0] as int),
      price: (json[1] as num).toDouble(),
      marketCap: (json[2] as num).toDouble(),
      volume: (json[3] as num).toDouble(),
    );
  }
}