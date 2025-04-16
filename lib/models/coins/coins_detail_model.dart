import 'package:coins_flutter_test/models/coins/coin_base_model.dart';

class CoinDetailModel extends CoinBaseModel {
  final String? hashingAlgorithm;
  final int? blockTimeInMinutes;
  final List<String>? categories;
  final String? description;
  final String? image;
  final double? currentPriceUsd;
  final double? marketCapUsd;
  final double? totalVolumeUsd;
  final double? priceChangePercentage24h;
  final double? priceChangePercentage7d;
  final double? priceChangePercentage30d;
  final double? priceChangePercentage1y;
  final List<double>? sparklineIn7d;

  CoinDetailModel({
    required super.id,
    required super.symbol,
    required super.name,
    this.hashingAlgorithm,
    this.blockTimeInMinutes,
    this.categories,
    this.description,
    this.image,
    this.currentPriceUsd,
    this.marketCapUsd,
    this.totalVolumeUsd,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
    this.sparklineIn7d,
  });

  factory CoinDetailModel.fromJson(Map<String, dynamic> json) {
    return CoinDetailModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      hashingAlgorithm: json['hashing_algorithm'],
      blockTimeInMinutes: json['block_time_in_minutes'],
      categories:
          (json['categories'] as List?)?.map((e) => e.toString()).toList(),
      description: json['description']?['en'],
      image: json['image']?['large'],
      currentPriceUsd:
          json['market_data']?['current_price']?['usd']?.toDouble(),
      marketCapUsd: json['market_data']?['market_cap']?['usd']?.toDouble(),
      totalVolumeUsd: json['market_data']?['total_volume']?['usd']?.toDouble(),
      priceChangePercentage24h:
          json['market_data']?['price_change_percentage_24h']?.toDouble(),
      priceChangePercentage7d:
          json['market_data']?['price_change_percentage_7d']?.toDouble(),
      priceChangePercentage30d:
          json['market_data']?['price_change_percentage_30d']?.toDouble(),
      priceChangePercentage1y:
          json['market_data']?['price_change_percentage_1y']?.toDouble(),
      sparklineIn7d:
          (json['market_data']?['sparkline_7d']?['price'] as List?)
              ?.map((e) => e is num ? e.toDouble() : null)
              .nonNulls
              .toList(),
    );
  }
}
