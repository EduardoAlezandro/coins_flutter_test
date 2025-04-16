import 'dart:math';
import 'package:coins_flutter_test/models/coins/coins_detail_model.dart';
import 'package:mobx/mobx.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coins_flutter_test/services/coins_service.dart';

part 'coin_detail_store.g.dart';

class CoinDetailStore = _CoinDetailStore with _$CoinDetailStore;

abstract class _CoinDetailStore with Store {
  final CoinsService _cryptoCoinsService = Get.find();

  @observable
  CoinDetailModel? coin;

  @observable
  ObservableList<FlSpot> chartData = ObservableList<FlSpot>();

  @observable
  String selectedPeriod = '30D';

  @observable
  bool isLoading = true;

  @observable
  String error = '';

  @action
  Future<void> fetchCoinDetails(String coinId) async {
    try {
      isLoading = true;
      error = '';
      final details = await _cryptoCoinsService.getCoinDetails(id: coinId);
      coin = details;
      await loadChartData();
    } catch (e) {
      error = 'Erro ao carregar detalhes da moeda: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadChartData() async {
    try {
      isLoading = true;
      chartData.clear();

      if (coin == null) return;

      final endDate = DateTime.now();
      final startDate = _calculateStartDate(endDate);

      final history = await _cryptoCoinsService.getCoinHistoryRange(
        coinId: coin!.id,
        startDate: startDate,
        endDate: endDate,
      );

      chartData = ObservableList.of(
        history.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          return FlSpot(index.toDouble(), data.price);
        }).toList(),
      );
    } catch (e) {
      error = 'Erro ao carregar dados do gráfico: $e';
    } finally {
      isLoading = false;
    }
  }

  DateTime _calculateStartDate(DateTime endDate) {
    switch (selectedPeriod) {
      case '1D':
        return endDate.subtract(const Duration(days: 1));
      case '15D':
        return endDate.subtract(const Duration(days: 15));
      default:
        return endDate.subtract(const Duration(days: 30));
    }
  }

  @action
  void changePeriod(String period) {
    selectedPeriod = period;
    loadChartData();
  }

  @computed
  double get maxYValue =>
      chartData.isEmpty ? 0 : chartData.map((spot) => spot.y).reduce(max) * 1.1;

  @computed
  double get minYValue =>
      chartData.isEmpty ? 0 : chartData.map((spot) => spot.y).reduce(min) * 0.9;
}