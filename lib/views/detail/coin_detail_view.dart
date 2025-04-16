import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../stores/detail/coin_detail_store.dart';
import '../../stores/favorite/favorite_store.dart';

class CoinDetailView extends GetView<CoinDetailStore> {
  final String coinId;

  const CoinDetailView({super.key, required this.coinId});

  @override
  Widget build(BuildContext context) {
    Get.put(CoinDetailStore()).fetchCoinDetails(coinId);

    final favoriteStore = Get.find<FavoriteStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Moeda'),
        actions: [
          Observer(
            builder: (_) {
              final isFavorite =
                  controller.coin != null &&
                  favoriteStore.isFavorite(
                    CoinModelHive(
                      id: controller.coin!.id,
                      symbol: controller.coin!.symbol,
                      name: controller.coin!.name,
                      platforms: {},
                      currentPrice: controller.coin!.currentPriceUsd ?? 0,
                      priceChangePercentage24h:
                          controller.coin!.priceChangePercentage24h ?? 0,
                      marketCap: controller.coin!.marketCapUsd ?? 0,
                      totalVolume: controller.coin!.totalVolumeUsd ?? 0,
                      sparklineIn7d: controller.coin?.sparklineIn7d ?? [],
                      image: controller.coin?.image,
                    ),
                  );
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  if (controller.coin != null) {
                    favoriteStore.toggleFavorite(
                      CoinModelHive(
                        id: controller.coin!.id,
                        symbol: controller.coin!.symbol,
                        name: controller.coin!.name,
                        platforms: {},
                        currentPrice: controller.coin!.currentPriceUsd ?? 0,
                        priceChangePercentage24h:
                            controller.coin!.priceChangePercentage24h ?? 0,
                        marketCap: controller.coin!.marketCapUsd ?? 0,
                        totalVolume: controller.coin!.totalVolumeUsd ?? 0,
                        sparklineIn7d: controller.coin?.sparklineIn7d ?? [],
                        image: controller.coin?.image,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error.isNotEmpty) {
            return Center(child: Text(controller.error));
          }
          if (controller.coin == null) {
            return const Center(child: Text('Moeda não encontrada'));
          }

          final coin = controller.coin!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(coin),
                  const SizedBox(height: 16),
                  _buildPriceInfo(coin),
                  const SizedBox(height: 16),
                  _buildMarketData(coin),
                  const SizedBox(height: 16),
                  _buildPeriodSelector(),
                  const SizedBox(height: 16),
                  _buildChart(),
                  const SizedBox(height: 16),
                  _buildDescription(coin),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(CoinDetailModel coin) {
    return Row(
      children: [
        coin.image != null && coin.image!.isNotEmpty
            ? ClipOval(
              child: Image.network(
                coin.image!,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Text(coin.symbol.toUpperCase()),
                  );
                },
              ),
            )
            : CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Text(coin.symbol.toUpperCase()),
            ),
        const SizedBox(width: 8),
        Text(
          coin.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPriceInfo(CoinDetailModel coin) {
    final isPositive = (coin.priceChangePercentage24h ?? 0) >= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${coin.currentPriceUsd?.toStringAsFixed(2) ?? 'N/A'}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isPositive ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${coin.priceChangePercentage24h?.toStringAsFixed(1) ?? 'N/A'}%',
            style: TextStyle(
              color: isPositive ? Colors.green[800] : Colors.red[800],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketData(CoinDetailModel coin) {
    final format = NumberFormat.compact(locale: 'en_US');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capitalização de Mercado',
          style: TextStyle(color: Colors.grey[600]),
        ),
        Text('\$${format.format(coin.marketCapUsd)}'),
        const SizedBox(height: 8),
        Text('Volume (24h)', style: TextStyle(color: Colors.grey[600])),
        Text('\$${format.format(coin.totalVolumeUsd)}'),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Observer(
      builder:
          (_) => SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: '1D', label: Text('24H')),
              ButtonSegment(value: '15D', label: Text('15 Dias')),
              ButtonSegment(value: '30D', label: Text('30 Dias')),
            ],
            selected: {controller.selectedPeriod},
            onSelectionChanged:
                (periods) => controller.changePeriod(periods.first),
          ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 300,
      child: Observer(
        builder: (_) {
          if (controller.chartData.isEmpty) {
            return const Center(child: Text('Dados de gráfico indisponíveis'));
          }
          return LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: _buildTitlesData(),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: controller.chartData.length.toDouble() - 1,
              minY: controller.minYValue,
              maxY: controller.maxYValue,
              lineBarsData: [
                LineChartBarData(
                  spots: controller.chartData,
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget:
              (value, _) => Text(
                '\$${value.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            final index = value.toInt();
            if (index % 5 != 0) return const SizedBox();

            final historyLength = controller.chartData.length;
            final date = DateTime.now().subtract(
              Duration(days: historyLength - index - 1),
            );

            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                DateFormat('dd/MM').format(date),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescription(CoinDetailModel coin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descrição', style: TextStyle(color: Colors.grey[600])),
        const SizedBox(height: 8),
        Text(
          coin.description ?? 'Sem descrição disponível.',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
