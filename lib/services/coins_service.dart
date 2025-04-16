import 'package:coins_flutter_test/models/coins/coin_history_range_model.dart';
import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:coins_flutter_test/repository/cache_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class CoinsService {
  final ApiService _apiService = Get.find();
  final CacheRepository _cacheRepository = Get.find();

  static const _initialPageSize = 250;
  static const _paginationSize = 50;

  Future<List<CoinModelHive>> getInitialCoins() async {
    if (await _shouldUseCache()) {
      return _cacheRepository.getCachedCoins();
    }
    return _refreshCoins();
  }

  Future<List<CoinModelHive>> getMoreCoins(int currentCount) async {
    if (await _shouldUseCache() && currentCount < _initialPageSize) {
      return _getCachedPaginated(currentCount);
    }
    return _fetchNewBatch(currentCount);
  }

  Future<bool> _shouldUseCache() async {
    if (!_cacheRepository.shouldRefresh()) {
      final cachedCoins = await _cacheRepository.getCachedCoins();
      return cachedCoins.isNotEmpty;
    }
    return false;
  }

  Future<List<CoinModelHive>> _refreshCoins() async {
    try {
      final newCoins = await _getCoinBatch(page: 1, perPage: _initialPageSize);
      await _cacheRepository.saveCoins(newCoins);
      return newCoins;
    } catch (e) {
      return _cacheRepository.getCachedCoins();
    }
  }

  Future<List<CoinModelHive>> _fetchNewBatch(int currentCount) async {
    try {
      final newCoins = await _getCoinBatch(
        page: (currentCount ~/ _paginationSize) + 1,
        perPage: _paginationSize,
      );

      await _mergeWithCache(newCoins);
      return newCoins;
    } catch (e) {
      return _cacheRepository.getCachedCoins();
    }
  }

  Future<void> _mergeWithCache(List<CoinModelHive> newCoins) async {
    final cachedCoins = await _cacheRepository.getCachedCoins();
    final mergedCoins = _mergeCoinLists(cachedCoins, newCoins);
    await _cacheRepository.saveCoins(mergedCoins);
  }

  List<CoinModelHive> _mergeCoinLists(
    List<CoinModelHive> existing,
    List<CoinModelHive> newCoins,
  ) {
    final mergedMap = {for (var c in existing) c.id: c};
    mergedMap.addAll({for (var c in newCoins) c.id: c});
    return mergedMap.values.toList();
  }

  Future<List<CoinModelHive>> _getCachedPaginated(int currentCount) {
    return _cacheRepository.getCachedCoins().then((coins) {
      final startIndex = currentCount;
      final endIndex = startIndex + _paginationSize;
      return coins.sublist(
        startIndex.clamp(0, coins.length),
        endIndex.clamp(0, coins.length),
      );
    });
  }

  Future<List<CoinModelHive>> _getCoinBatch({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await _apiService.get(
        'coins/markets',
        queryParameters: _buildQueryParams(page, perPage),
      );

      return (response as List)
          .map<CoinModelHive>((json) => CoinModelHive.fromJson(json))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading batch: $e');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> searchCoins(String query) async {
    final response = await _apiService.get(
      'search?query=$query',
    );
    return response;
  }

  Map<String, String> _buildQueryParams(int page, int perPage) {
    return {
      'vs_currency': 'usd',
      'sparkline': 'true',
      'price_change_percentage': '24h',
      'order': 'market_cap_desc',
      'per_page': perPage.toString(),
      'page': page.toString(),
    };
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
      throw Exception('Erro ao buscar detalhes da moeda: $e');
    }
  }

  Future<List<CoinHistoryData>> getCoinHistoryRange({
    required String coinId,
    required DateTime startDate,
    required DateTime endDate,
    String vsCurrency = 'usd',
    String precision = '2',
  }) async {
    try {
      final response = await _apiService.get(
        'coins/$coinId/market_chart/range',
        queryParameters: {
          'vs_currency': vsCurrency,
          'from': (startDate.millisecondsSinceEpoch ~/ 1000).toString(),
          'to': (endDate.millisecondsSinceEpoch ~/ 1000).toString(),
          'precision': precision,
        },
      );

      final prices =
          (response['prices'] as List)
              .map(
                (price) => CoinHistoryData.fromJson([
                  price[0],
                  price[1],
                  (response['market_caps'] as List).firstWhere(
                    (mc) => mc[0] == price[0],
                  )[1],
                  (response['total_volumes'] as List).firstWhere(
                    (vol) => vol[0] == price[0],
                  )[1],
                ]),
              )
              .toList();

      return prices;
    } catch (e) {
      throw Exception('Failed to load historical data: $e');
    }
  }
}
