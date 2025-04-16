import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/stores/advanceSearch/advanced_search_store.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:coins_flutter_test/views/detail/coin_detail_view.dart';
import 'package:coins_flutter_test/views/favorite/favorite_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AdvancedSearchView extends GetView<AdvancedSearchStore> {
  const AdvancedSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca Avançada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Get.to(() => const FavoritesView());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.setSearchQuery(value),
              decoration: InputDecoration(
                labelText: 'Digite sua busca',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => controller.performSearch(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Observer(
              builder: (_) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.error.isNotEmpty) {
                  return Center(child: Text(controller.error));
                }
                if (controller.searchResults.isEmpty) {
                  return const Center(
                    child: Text('Nenhum resultado disponível'),
                  );
                }

                final coins =
                    (controller.searchResults['coins'] as List?)
                        ?.cast<Map<String, dynamic>>() ??
                    [];
                final exchanges =
                    (controller.searchResults['exchanges'] as List?)
                        ?.cast<Map<String, dynamic>>() ??
                    [];
                final categories =
                    (controller.searchResults['categories'] as List?)
                        ?.cast<Map<String, dynamic>>() ??
                    [];

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (coins.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Moedas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: coins.length,
                            itemBuilder: (context, index) {
                              final coin = coins[index];
                              return Observer(
                                builder: (_) {
                                  return ListTile(
                                    onTap: () {
                                      Get.to(
                                        () =>
                                            CoinDetailView(coinId: coin['id']),
                                      );
                                    },
                                    leading: ClipOval(
                                      child: Image.network(
                                        coin['thumb'],
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            child: Text(
                                              coin['symbol']
                                                  .toString()
                                                  .toUpperCase(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    title: Text(coin['name']),
                                    subtitle: Text(coin['symbol']),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        if (exchanges.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Exchanges',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: exchanges.length,
                            itemBuilder: (context, index) {
                              final exchange = exchanges[index];
                              return ListTile(
                                leading: ClipOval(
                                  child: Image.network(
                                    exchange['thumb'],
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        child: Text(
                                          exchange['name']
                                              .toString()
                                              .substring(0, 2)
                                              .toUpperCase(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                title: Text(exchange['name']),
                                subtitle: Text(exchange['market_type']),
                              );
                            },
                          ),
                        ],
                        if (categories.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Categorias',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return ListTile(
                                title: Text(category['name']),
                                subtitle: Text(category['id']),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
