import 'package:mobx/mobx.dart';
import '../models/crypto_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  List<CryptoModel> cryptoList = [
    CryptoModel(
      id: 'bitcoin',
      name: 'Bitcoin',
      symbol: 'BTC',
      price: 27000,
      percentChange: 2.5,
      marketCap: 500000000000,
    ),
    CryptoModel(
      id: 'ethereum',
      name: 'Ethereum',
      symbol: 'ETH',
      price: 1800,
      percentChange: -1.2,
      marketCap: 200000000000,
    ),
    CryptoModel(
      id: 'cardano',
      name: 'Cardano',
      symbol: 'ADA',
      price: 0.45,
      percentChange: 0.8,
      marketCap: 15000000000,
    ),
  ];

  @observable
  String searchQuery = '';

  @computed
  List<CryptoModel> get filteredCryptoList {
    if (searchQuery.isEmpty) {
      return cryptoList;
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