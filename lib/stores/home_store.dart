// lib/stores/home_store.dart
import 'package:coins_flutter_test/models/coins/coin_model.dart';
import 'package:coins_flutter_test/services/crypto_coins_service.dart';
import 'package:mobx/mobx.dart';
import 'package:get/get.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final CryptoCoinsService _cryptoCoinsService = Get.find();

  @observable
  ObservableList<CoinModel> cryptoList = ObservableList<CoinModel>();

  @observable
  String searchQuery = '';

  @observable
  bool isLoading = true;

  @action
  Future<void> fetchCryptoList() async {
    try {
      isLoading = true;
      final list = await _cryptoCoinsService.getCoinList();
      cryptoList = ObservableList.of(list);
    } catch (e) {
      print('Error fetching crypto list: $e');
      cryptoList.clear();
    } finally {
      isLoading = false;
    }
  }

  @computed
  List<CoinModel> get filteredCryptoList {
    if (searchQuery.isEmpty) {
      return cryptoList.toList();
    }
    return cryptoList
        .where((crypto) =>
            crypto.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            crypto.symbol.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }
}