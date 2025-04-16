import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:coins_flutter_test/views/detail/coin_detail.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../../stores/searchCoins/search_coins_store.dart';

class SearchCoins extends GetView<SearchCoinsStore> {
  const SearchCoins({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Get.find<FavoriteStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptomoedas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.toNamed('/favorites'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquisar criptomoedas',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => controller.setSearchQuery(query),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.shouldShowEmptyState) {
                  return const Center(
                    child: Text('Nenhuma criptomoeda encontrada'),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.sortedDisplayedCoins.length,
                        itemBuilder: (context, index) {
                          final crypto = controller.sortedDisplayedCoins[index];
                          return Observer(
                            builder:
                                (_) => ListTile(
                                  onTap: () {
                                    Get.to(
                                      () => CoinDetailScreen(coinId: crypto.id),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    child: Text(crypto.symbol.toUpperCase()),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        crypto.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      _buildPriceRow(crypto),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildSparklineChart(
                                        crypto.sparklineIn7d,
                                      ),
                                      _buildMarketData(crypto),
                                    ],
                                  ),
                                  trailing: _buildFavoriteButton(
                                    favoriteStore,
                                    crypto,
                                    context,
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
                    _PaginationControls(controller: controller),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(CoinModelHive crypto) {
    final isPositive = crypto.priceChangePercentage24h >= 0;
    return Row(
      children: [
        Text(
          '\$${crypto.currentPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${crypto.priceChangePercentage24h.toStringAsFixed(1)}%',
            style: TextStyle(
              color: isPositive ? Colors.green[800] : Colors.red[800],
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSparklineChart(List<double> sparkline) {
    return SizedBox(
      height: 40,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: sparkline.length.toDouble() - 1,
          minY: sparkline.reduce((a, b) => a < b ? a : b),
          maxY: sparkline.reduce((a, b) => a > b ? a : b),
          lineBarsData: [
            LineChartBarData(
              spots:
                  sparkline
                      .asMap()
                      .entries
                      .map((e) => FlSpot(e.key.toDouble(), e.value))
                      .toList(),
              isCurved: true,
              color:
                  sparkline.last >= sparkline.first ? Colors.green : Colors.red,
              barWidth: 1.5,
              belowBarData: BarAreaData(show: false),
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketData(CoinModelHive crypto) {
    final format = NumberFormat.compact(locale: 'en_US');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMarketDataItem('CAP', '\$${format.format(crypto.marketCap)}'),
        _buildMarketDataItem(
          'VOL 24H',
          '\$${format.format(crypto.totalVolume)}',
        ),
      ],
    );
  }

  Widget _buildMarketDataItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
        Text(value, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildFavoriteButton(
    FavoriteStore favoriteStore,
    CoinModelHive crypto,
    context,
  ) {
    return IconButton(
      icon: Icon(
        favoriteStore.isFavorite(crypto)
            ? Icons.favorite
            : Icons.favorite_border,
        color: favoriteStore.isFavorite(crypto) ? Colors.red : Colors.grey[400],
      ),
      onPressed: () {
        favoriteStore.toggleFavorite(crypto);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              favoriteStore.isFavorite(crypto)
                  ? 'Adicionado aos favoritos'
                  : 'Removido dos favoritos',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}

class _PaginationControls extends StatelessWidget {
  final SearchCoinsStore controller;

  const _PaginationControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed:
                      controller.hasPreviousPage
                          ? () => controller.previousPage()
                          : null,
                ),
                Text(
                  'Página ${controller.currentPage} de ${controller.totalPages}',
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed:
                      controller.hasNextPage
                          ? () async =>
                              await controller
                                  .nextPage() // Modificado
                          : null,
                ),
              ],
            ),
          ),
    );
  }
}
