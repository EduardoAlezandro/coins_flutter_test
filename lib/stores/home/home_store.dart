// stores/home/home_store.dart
import 'dart:math';
import 'package:mobx/mobx.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coins_flutter_test/services/crypto_coins_service.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final CryptoCoinsService _cryptoService = Get.find();
  final List<String> popularCoins = [
    'bitcoin',
    'ethereum',
    'binancecoin',
    'cardano',
    'solana',
  ];

  @observable
  ObservableList<FlSpot> chartData = ObservableList<FlSpot>();

  @observable
  String selectedPeriod = '30D';

  @observable
  String currentCoinId = '';

  @observable
  bool isLoading = true;

  @observable
  String errorMessage = '';

  _HomeStoreBase() {
    initialize();
  }

  @action
  Future<void> initialize() async {
    try {
      isLoading = true;
      final favoriteStore = Get.find<FavoriteStore>();
      await favoriteStore.loadFavorites();
      await _selectInitialCoin();
      await loadChartData();
    } catch (e) {
      errorMessage = 'Erro na inicialização: ${e.toString()}';
    } finally {
      isLoading = false;
    }
  }

  @computed
  List<String> get availableCoins {
    final favoriteStore = Get.find<FavoriteStore>();
    final coins =
        favoriteStore.favoriteIds.isNotEmpty
            ? favoriteStore.favoriteIds.toList()
            : popularCoins;

    final uniqueCoins = coins.toSet().toList();
    return uniqueCoins.isNotEmpty ? uniqueCoins : ['bitcoin']; // Fallback
  }

  @action
  Future<void> loadChartData() async {
    try {
      isLoading = true;
      errorMessage = '';
      chartData = ObservableList<FlSpot>.of([]);

      if (currentCoinId.isEmpty) {
        await _selectInitialCoin();
      }

      final endDate = DateTime.now();
      final startDate = _calculateStartDate(endDate);

      final history = await _cryptoService.getCoinHistoryRange(
        coinId: currentCoinId,
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
      errorMessage = 'Erro ao carregar dados: ${e.toString()}';
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
  Future<void> _selectInitialCoin() async {
    final favoriteStore = Get.find<FavoriteStore>();

    // Hierarquia de seleção:
    // 1. Primeiro favorito
    if (favoriteStore.favoriteIds.isNotEmpty) {
      currentCoinId = favoriteStore.favoriteIds.first;
    }
    // 2. Moedas especiais/populares
    else if (popularCoins.isNotEmpty) {
      final random = Random();
      currentCoinId = popularCoins[random.nextInt(popularCoins.length)];
    }
    // 3. Fallback hardcoded
    else {
      currentCoinId = 'bitcoin';
    }
  }

  @action
  Future<void> changeCoin(String newCoinId) async {
    currentCoinId = newCoinId;
    await loadChartData();
  }

  @action
  void changePeriod(String period) {
    selectedPeriod = period;
    loadChartData();
  }

  @computed
  bool get hasError => errorMessage.isNotEmpty;

  @computed
  bool get hasData => chartData.isNotEmpty && !isLoading && !hasError;

  @computed
  double get maxYValue =>
      chartData.isEmpty ? 0 : chartData.map((spot) => spot.y).reduce(max) * 1.1;

  @computed
  double get minYValue =>
      chartData.isEmpty ? 0 : chartData.map((spot) => spot.y).reduce(min) * 0.9;

}
