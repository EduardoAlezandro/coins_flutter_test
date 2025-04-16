import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'dart:convert';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  @observable
  ObservableList<CoinModelHive> favoriteCoins = ObservableList();

  @observable
  ObservableSet<String> favoriteIds = ObservableSet();

  @observable
  bool isLoading = false;

  _FavoriteStoreBase() {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    await loadFavorites();
  }

  bool isFavorite(CoinModelHive coin) {
    return favoriteIds.contains(coin.id);
  }

  @action
  Future<void> toggleFavorite(CoinModelHive coin) async {
    final prefs = await SharedPreferences.getInstance();

    runInAction(() {
      if (isFavorite(coin)) {
        favoriteCoins.removeWhere((c) => c.id == coin.id);
        favoriteIds.remove(coin.id);
      } else {
        favoriteCoins.add(coin);
        favoriteIds.add(coin.id);
      }
    });

    try {
      final favoriteJson = jsonEncode(
        favoriteCoins.map((coin) => coin.toJson()).toList(),
      );
      await prefs.setString('favorites', favoriteJson);
    } catch (e) {
      print('Erro ao salvar os favoritos: $e');
      runInAction(() {
        if (isFavorite(coin)) {
          favoriteCoins.removeWhere((c) => c.id == coin.id);
          favoriteIds.remove(coin.id);
        } else {
          favoriteCoins.add(coin);
          favoriteIds.add(coin.id);
        }
      });
    }

    final favoriteJson = favoriteCoins.map((coin) => coin.toJson()).toList();
    await prefs.setString('favorites', jsonEncode(favoriteJson));
  }

  @action
  Future<void> loadFavorites() async {
    isLoading = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('favorites');
      if (favoritesJson != null) {
        final List<dynamic> decodedJson = jsonDecode(favoritesJson);
        final List<CoinModelHive> coins =
            decodedJson.map((json) => CoinModelHive.fromJson(json)).toList();

        runInAction(() {
          favoriteCoins = ObservableList.of(coins);
          favoriteIds = ObservableSet.of(coins.map((coin) => coin.id));
        });
      }
    } finally {
      isLoading = false;
    }
  }
}
