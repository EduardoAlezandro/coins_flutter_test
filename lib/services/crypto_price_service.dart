import 'package:get/get.dart';
import '../services/api_service.dart';

class CryptoPriceService {
  final ApiService _apiService = Get.find();

  Future<Map<String, dynamic>> getCryptoPrices({
    required List<String> ids,
    required List<String> vsCurrencies,
    bool includeMarketCap = false,
    bool include24hrVol = false,
    bool include24hrChange = false,
    bool includeLastUpdatedAt = false,
    String precision = 'full',
  }) async {
    try {
      final queryParams = {
        'ids': ids.join(','),
        'vs_currencies': vsCurrencies.join(','),
        'include_market_cap': includeMarketCap.toString(),
        'include_24hr_vol': include24hrVol.toString(),
        'include_24hr_change': include24hrChange.toString(),
        'include_last_updated_at': includeLastUpdatedAt.toString(),
        'precision': precision,
      };

      return await _apiService.get(
        'simple/price',
        queryParameters: queryParams,
      );
    } catch (e) {
      throw Exception('Error fetching crypto prices: $e');
    }
  }
}
