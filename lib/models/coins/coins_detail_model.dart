import 'coin_base_model.dart';

class CoinDetailModel extends CoinBaseModel {
  final String? hashingAlgorithm;
  final int? blockTimeInMinutes;
  final List<String>? categories;
  final String? description;
  final String? image;
  final double? currentPriceUsd;
  final double? marketCapUsd;
  final double? totalVolumeUsd;

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
  });

  factory CoinDetailModel.fromJson(Map<String, dynamic> json) {
    return CoinDetailModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      hashingAlgorithm: json['hashing_algorithm'],
      blockTimeInMinutes: json['block_time_in_minutes'],
      categories: (json['categories'] as List?)?.map((e) => e.toString()).toList(),
      description: json['description']?['en'],
      image: json['image']?['large'],
      currentPriceUsd: json['market_data']?['current_price']?['usd']?.toDouble(),
      marketCapUsd: json['market_data']?['market_cap']?['usd']?.toDouble(),
      totalVolumeUsd: json['market_data']?['total_volume']?['usd']?.toDouble(),
    );
  }
}
