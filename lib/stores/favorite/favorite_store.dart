import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  @observable
  ObservableSet<String> favoriteIds = ObservableSet();

  @observable
  bool isLoading = false;

  bool isFavorite(CoinModelHive coin) => favoriteIds.contains(coin.id);

  _FavoriteStoreBase() {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    await loadFavorites();
  }

  @action
  Future<void> toggleFavorite(CoinModelHive coin) async {
    final prefs = await SharedPreferences.getInstance();

    runInAction(() {
      if (favoriteIds.contains(coin.id)) {
        favoriteIds.remove(coin.id);
      } else {
        favoriteIds.add(coin.id);
      }
    });

    await prefs.setStringList('favorites', favoriteIds.toList());
  }

  @action
  Future<void> loadFavorites() async {
    isLoading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites') ?? [];
      favoriteIds = ObservableSet.of(favorites.toSet());
    } finally {
      isLoading = false;
    }
  }
}
