// lib/views/favorites_page.dart
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:coins_flutter_test/stores/searchCoins/search_coins_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Get.find<FavoriteStore>();
    final homeStore = Get.find<SearchCoinsStore>();

    return Scaffold(
      appBar: AppBar(title: Text('Moedas Favoritas')),
      body: Observer(
        builder: (_) {
          if (favoriteStore.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final favoriteCoins =
              homeStore.allCoins
                  .where((coin) => favoriteStore.favoriteIds.contains(coin.id))
                  .toList();

          if (favoriteCoins.isEmpty) {
            return Center(child: Text('Nenhuma moeda favoritada'));
          }

          return ListView.builder(
            itemCount: favoriteCoins.length,
            itemBuilder: (context, index) {
              final crypto = favoriteCoins[index];
              return Observer(
                builder:
                    (_) => ListTile(
                      title: Text(crypto.name),
                      subtitle: Text(crypto.symbol),
                      trailing: IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () => favoriteStore.toggleFavorite(crypto),
                      ),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
