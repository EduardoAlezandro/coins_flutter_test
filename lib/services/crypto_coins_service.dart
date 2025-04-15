import 'package:coins_flutter_test/models/coins/coin_history_model.dart';
import 'package:coins_flutter_test/models/coins/coin_model.dart';
import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class CryptoCoinsService {
  final ApiService _apiService = Get.find();

  Future<List<CoinModel>> getCoinList({bool includePlatform = false}) async {
    try {
      final queryParams = {'include_platform': includePlatform.toString()};

      final response = await _apiService.get(
        'coins/list',
        queryParameters: queryParams,
      );

      return (response as List)
          .map((coinJson) => CoinModel.fromJson(coinJson))
          .toList();
    } catch (e) {
      throw Exception('Error fetching coin list: $e');
    }
  }

  Future<List<CoinModel>> getCoinMarkets({
    required String vsCurrency,
    List<String>? ids,
    List<String>? names,
    List<String>? symbols,
    String? category,
    String? order = 'market_cap_desc',
    int perPage = 100,
    int page = 1,
    bool sparkline = false,
    List<String>? priceChangePercentage,
    String locale = 'en',
    String precision = 'full',
  }) async {
    try {
      final rawParams = {
        'vs_currency': vsCurrency,
        'ids': ids?.join(','),
        'names': names?.join(','),
        'symbols': symbols?.join(','),
        'category': category,
        'order': order,
        'per_page': perPage.toString(),
        'page': page.toString(),
        'sparkline': sparkline.toString(),
        'price_change_percentage': priceChangePercentage?.join(','),
        'locale': locale,
        'precision': precision,
      };

      final queryParams = <String, String>{
        for (var entry in rawParams.entries)
          if (entry.value != null) entry.key: entry.value!,
      };

      final response = await _apiService.get(
        'coins/markets',
        queryParameters: queryParams,
      );

      return (response as List)
          .map((marketJson) => CoinModel.fromJson(marketJson))
          .toList();
    } catch (e) {
      throw Exception('Error fetching coin markets: $e');
    }
  }

  Future<CoinDetailModel> getCoinDetails({
    required String id,
    bool localization = true,
    bool tickers = true,
    bool marketData = true,
    bool communityData = true,
    bool developerData = true,
    bool sparkline = false,
  }) async {
    try {
      final queryParams = <String, String>{
        'localization': localization.toString(),
        'tickers': tickers.toString(),
        'market_data': marketData.toString(),
        'community_data': communityData.toString(),
        'developer_data': developerData.toString(),
        'sparkline': sparkline.toString(),
      };

      final response = await _apiService.get(
        'coins/$id',
        queryParameters: queryParams,
      );

      return CoinDetailModel.fromJson(response);
    } catch (e) {
      throw Exception('Error fetching coin details: $e');
    }
  }

  Future<CoinHistoryModel> getCoinHistory({
    required String id,
    required String date,
    bool localization = false,
  }) async {
    final response = await _apiService.get(
      '/coins/$id/history',
      queryParameters: {'date': date, 'localization': localization.toString()},
    );

    return CoinHistoryModel.fromJson(response);
  }
}
