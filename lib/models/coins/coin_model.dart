import 'coin_base_model.dart';

class CoinModel extends CoinBaseModel {
  final Map<String, dynamic>? platforms;

  CoinModel({
    required super.id,
    required super.symbol,
    required super.name,
    this.platforms,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      platforms: json['platforms'] != null
          ? Map<String, dynamic>.from(json['platforms'])
          : null,
    );
  }
}
