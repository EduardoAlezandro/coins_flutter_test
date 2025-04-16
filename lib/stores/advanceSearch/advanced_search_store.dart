import 'package:mobx/mobx.dart';
import 'package:get/get.dart';
import 'package:coins_flutter_test/services/coins_service.dart';

part 'advanced_search_store.g.dart';

class AdvancedSearchStore = _AdvancedSearchStoreBase with _$AdvancedSearchStore;

abstract class _AdvancedSearchStoreBase with Store {
  final CoinsService _coinsService = Get.find();

  @observable
  String searchQuery = '';

  @observable
  Map<String, dynamic> searchResults = {};

  @observable
  bool isLoading = false;

  @observable
  String error = '';

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  Future<void> performSearch() async {
    if (searchQuery.trim().isEmpty) {
      error = 'Por favor, insira um termo de pesquisa';
      return;
    }

    try {
      isLoading = true;
      error = '';
      searchResults = await _coinsService.searchCoins(searchQuery);
    } catch (e) {
      error = 'Erro ao buscar: $e';
    } finally {
      isLoading = false;
    }
  }
}