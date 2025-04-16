import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:coins_flutter_test/services/crypto_coins_service.dart';
import 'package:mobx/mobx.dart';
import 'package:get/get.dart';

part 'coin_detail_store.g.dart';

class CoinDetailStore = _CoinDetailStore with _$CoinDetailStore;

abstract class _CoinDetailStore with Store {
  final CryptoCoinsService _cryptoCoinsService = Get.find();

  @observable
  CoinDetailModel? coin;

  @observable
  bool isLoading = true;

  @observable
  String error = '';

  @action
  Future<void> fetchCoinDetails(String coinId) async {
    try {
      isLoading = true;
      error = '';
      final details = await _cryptoCoinsService.getCoinDetails(id: coinId);
      coin = details;
    } catch (e) {
      error = 'Erro ao carregar detalhes da moeda: $e';
    } finally {
      isLoading = false;
    }
  }
}