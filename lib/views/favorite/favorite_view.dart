import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:coins_flutter_test/views/detail/coin_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Get.find<FavoriteStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('Moedas Favoritas')),
      body: Observer(
        builder: (_) {
          if (favoriteStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final favoriteCoins = favoriteStore.favoriteCoins;

          if (favoriteCoins.isEmpty) {
            return const Center(child: Text('Nenhuma moeda favoritada'));
          }

          return ListView.builder(
            itemCount: favoriteCoins.length,
            itemBuilder: (context, index) {
              final crypto = favoriteCoins[index];
              return ListTile(
                onTap: () {
                  Get.to(() => CoinDetailView(coinId: crypto.id));
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: _buildLeading(crypto),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    _buildPriceRow(crypto),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSparklineChart(crypto.sparklineIn7d),
                    _buildMarketData(crypto),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => favoriteStore.toggleFavorite(crypto),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLeading(CoinModelHive crypto) {
    return crypto.image != null && crypto.image!.isNotEmpty
        ? ClipOval(
          child: Image.network(
            crypto.image!,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Text(crypto.symbol.toUpperCase()),
              );
            },
          ),
        )
        : CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(crypto.symbol.toUpperCase()),
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
    if (sparkline.isEmpty) {
      return SizedBox(
        height: 40,
        child: Center(child: Text('Sem dados disponíveis')),
      );
    }

    final minY = sparkline.reduce((a, b) => a < b ? a : b);
    final maxY = sparkline.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 40,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: sparkline.length.toDouble() - 1,
          minY: minY,
          maxY: maxY,
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
}
