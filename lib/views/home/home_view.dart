import 'package:coins_flutter_test/views/advanceSearch/advance_search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:coins_flutter_test/stores/home/home_store.dart';

class HomeView extends GetView<HomeStore> {
  final DateFormat _dateFormat = DateFormat('dd/MM');
  final DateFormat _hourFormat = DateFormat('HH:mm');
  final NumberFormat _priceFormat = NumberFormat.currency(symbol: '\$');

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise de Preços'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed('/search'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder:
              (_) => Column(
                children: [
                  _buildCoinSelector(),
                  const SizedBox(height: 20),
                  _buildPeriodSelector(),
                  const SizedBox(height: 20),
                  _buildChart(),
                  const SizedBox(height: 40),
                  _buildPriceInfo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const AdvancedSearchView());
                      },
                      child: const Text('Busca Avançada'),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildCoinSelector() {
    return Observer(
      builder: (_) {
        if (controller.availableCoins.isEmpty) {
          return const Text('Nenhuma moeda disponível');
        }

        final validValue =
            controller.availableCoins.contains(controller.currentCoinId)
                ? controller.currentCoinId
                : controller.availableCoins.first;

        return DropdownButtonFormField<String>(
          value: validValue,
          decoration: InputDecoration(
            labelText: 'Selecione a Moeda',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items:
              controller.availableCoins.map((coinId) {
                return DropdownMenuItem<String>(
                  value: coinId,
                  child: Text(coinId.toUpperCase()),
                );
              }).toList(),
          onChanged: (newCoinId) {
            if (newCoinId != null) {
              controller.changeCoin(newCoinId);
            }
          },
        );
      },
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
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.hasError) {
            return Center(child: Text(controller.errorMessage));
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
                _priceFormat.format(value),
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
            final date =
                controller.selectedPeriod == '1D'
                    ? DateTime.now().subtract(Duration(hours: 24 - index))
                    : DateTime.now().subtract(
                      Duration(days: historyLength - index - 1),
                    );

            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                controller.selectedPeriod == '1D'
                    ? _hourFormat.format(date)
                    : _dateFormat.format(date),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Observer(
      builder:
          (_) => SizedBox(
            width: 300,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'PREÇO ATUAL',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.chartData.isNotEmpty
                          ? _priceFormat.format(controller.chartData.last.y)
                          : '--',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.currentCoinId.toUpperCase(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
