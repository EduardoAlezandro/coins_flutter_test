import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/services/crypto_coins_service.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:mobx/mobx.dart';
import 'package:get/get.dart';

part 'search_coins_store.g.dart';

class SearchCoinsStore = _SearchCoinsStore with _$SearchCoinsStore;

abstract class _SearchCoinsStore with Store {
  final CryptoCoinsService _cryptoCoinsService = Get.find();
  final FavoriteStore _favoriteStore = Get.find();

  @observable
  ObservableList<CoinModelHive> allCoins = ObservableList<CoinModelHive>();

  @observable
  ObservableList<CoinModelHive> displayedCoins =
      ObservableList<CoinModelHive>();

  @observable
  String searchQuery = '';

  @observable
  bool isLoading = true;

  @observable
  int currentPage = 1;

  @observable
  int itemsPerPage = 50;

  @observable
  bool isLoadingMore = false;

  @observable
  bool hasMore = true;

  @computed
  bool get hasNextPage => currentPage < totalPages || hasMore;

  _SearchCoinsStore() {
    loadInitialCoins();
  }

  @action
  Future<void> loadInitialCoins() async {
    try {
      isLoading = true;
      final coins = await _cryptoCoinsService.getInitialCoins();
      allCoins = ObservableList.of(coins);
      hasMore = coins.length >= 250;
      _updateDisplayedCoins();
    } catch (e) {
      print('Error loading initial coins: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadMoreCoins() async {
    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true;
    try {
      final newCoins = await _cryptoCoinsService.getMoreCoins(allCoins.length);
      if (newCoins.isEmpty) {
        hasMore = false;
      } else {
        allCoins.addAll(newCoins);
        hasMore = newCoins.length >= 50;
        _updateDisplayedCoins(); // Adicionado
      }
    } catch (e) {
      print('Error loading more coins: $e');
    } finally {
      isLoadingMore = false;
    }
  }

  @action
  void _updateDisplayedCoins() {
    try {
      final filtered =
          searchQuery.isEmpty
              ? allCoins
              : allCoins.where(
                (c) =>
                    c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                    c.symbol.toLowerCase().contains(searchQuery.toLowerCase()),
              );

      final filteredList = filtered.toList();
      final totalItems = filteredList.length;

      final maxPage = (totalItems / itemsPerPage).ceil();
      currentPage = currentPage.clamp(1, maxPage);

      final startIndex = (currentPage - 1) * itemsPerPage;
      final safeStart = startIndex.clamp(0, totalItems);
      final safeEnd = (safeStart + itemsPerPage).clamp(safeStart, totalItems);

      displayedCoins =
          totalItems > 0
              ? ObservableList.of(filteredList.sublist(safeStart, safeEnd))
              : ObservableList<CoinModelHive>.of([]);
    } catch (e) {
      displayedCoins.clear();
    }
  }

  @computed
  List<CoinModelHive> get sortedDisplayedCoins {
    final favorites =
        displayedCoins
            .where(_favoriteStore.isFavorite)
            .toList()
            .reversed
            .toList();
    final nonFavorites =
        displayedCoins.where((c) => !_favoriteStore.isFavorite(c)).toList();
    return [...favorites, ...nonFavorites];
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
    currentPage = 1;
    _updateDisplayedCoins();
  }

  @action
  Future<void> nextPage() async {
    // Modificado para async
    if (currentPage < totalPages) {
      currentPage++;
      _updateDisplayedCoins();
    } else if (hasMore) {
      await loadMoreCoins();
      if (currentPage < totalPages) {
        currentPage++;
        _updateDisplayedCoins();
      }
    }
  }

  @action
  void previousPage() {
    if (hasPreviousPage) {
      currentPage--;
      _updateDisplayedCoins();
    }
  }

  @computed
  bool get hasPreviousPage => currentPage > 1;

  @computed
  int get totalPages {
    final totalFiltered =
        searchQuery.isEmpty
            ? allCoins.length
            : allCoins
                .where(
                  (c) =>
                      c.name.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ) ||
                      c.symbol.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                )
                .length;

    return (totalFiltered / itemsPerPage).ceil();
  }

  @computed
  bool get shouldShowEmptyState => displayedCoins.isEmpty && !isLoading;
}
