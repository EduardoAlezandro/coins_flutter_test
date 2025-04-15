import 'coin_base_model.dart';

class CoinHistoryModel extends CoinBaseModel {
  final String? imageThumb;
  final String? imageSmall;
  final double? currentPriceUsd;
  final double? marketCapUsd;
  final double? totalVolumeUsd;

  CoinHistoryModel({
    required super.id,
    required super.symbol,
    required super.name,
    this.imageThumb,
    this.imageSmall,
    this.currentPriceUsd,
    this.marketCapUsd,
    this.totalVolumeUsd,
  });

  factory CoinHistoryModel.fromJson(Map<String, dynamic> json) {
    return CoinHistoryModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      imageThumb: json['image']?['thumb'],
      imageSmall: json['image']?['small'],
      currentPriceUsd: json['market_data']?['current_price']?['usd']?.toDouble(),
      marketCapUsd: json['market_data']?['market_cap']?['usd']?.toDouble(),
      totalVolumeUsd: json['market_data']?['total_volume']?['usd']?.toDouble(),
    );
  }
}
