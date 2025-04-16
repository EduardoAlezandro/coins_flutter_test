// coin_model.dart
import 'package:hive/hive.dart';

part 'coin_model_hive.g.dart';

@HiveType(typeId: 0)
class CoinModelHive extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String symbol;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final Map<String, dynamic>? platforms;

  // Novos campos adicionados
  @HiveField(4)
  final double currentPrice;

  @HiveField(5)
  final double priceChangePercentage24h;

  @HiveField(6)
  final double marketCap;

  @HiveField(7)
  final double totalVolume;

  @HiveField(8)
  final List<double> sparklineIn7d;

  CoinModelHive({
    required this.id,
    required this.symbol,
    required this.name,
    required this.platforms,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.marketCap,
    required this.totalVolume,
    required this.sparklineIn7d,
  });

  factory CoinModelHive.fromJson(Map<String, dynamic> json) {
    return CoinModelHive(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      platforms: json['platforms'] != null
          ? Map<String, dynamic>.from(json['platforms'])
          : null,
      // Novos campos mapeados
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      priceChangePercentage24h: json['price_change_percentage_24h']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      totalVolume: json['total_volume']?.toDouble() ?? 0.0,
      sparklineIn7d: json['sparkline_in_7d']?['price'] != null
          ? List<double>.from(json['sparkline_in_7d']['price'].map((x) => x.toDouble()))
          : [],
    );
  }
}