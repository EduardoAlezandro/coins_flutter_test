// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinDetailStore on _CoinDetailStore, Store {
  Computed<double>? _$maxYValueComputed;

  @override
  double get maxYValue =>
      (_$maxYValueComputed ??= Computed<double>(() => super.maxYValue,
              name: '_CoinDetailStore.maxYValue'))
          .value;
  Computed<double>? _$minYValueComputed;

  @override
  double get minYValue =>
      (_$minYValueComputed ??= Computed<double>(() => super.minYValue,
              name: '_CoinDetailStore.minYValue'))
          .value;

  late final _$coinAtom = Atom(name: '_CoinDetailStore.coin', context: context);

  @override
  CoinDetailModel? get coin {
    _$coinAtom.reportRead();
    return super.coin;
  }

  @override
  set coin(CoinDetailModel? value) {
    _$coinAtom.reportWrite(value, super.coin, () {
      super.coin = value;
    });
  }

  late final _$chartDataAtom =
      Atom(name: '_CoinDetailStore.chartData', context: context);

  @override
  ObservableList<FlSpot> get chartData {
    _$chartDataAtom.reportRead();
    return super.chartData;
  }

  @override
  set chartData(ObservableList<FlSpot> value) {
    _$chartDataAtom.reportWrite(value, super.chartData, () {
      super.chartData = value;
    });
  }

  late final _$selectedPeriodAtom =
      Atom(name: '_CoinDetailStore.selectedPeriod', context: context);

  @override
  String get selectedPeriod {
    _$selectedPeriodAtom.reportRead();
    return super.selectedPeriod;
  }

  @override
  set selectedPeriod(String value) {
    _$selectedPeriodAtom.reportWrite(value, super.selectedPeriod, () {
      super.selectedPeriod = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CoinDetailStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_CoinDetailStore.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$fetchCoinDetailsAsyncAction =
      AsyncAction('_CoinDetailStore.fetchCoinDetails', context: context);

  @override
  Future<void> fetchCoinDetails(String coinId) {
    return _$fetchCoinDetailsAsyncAction
        .run(() => super.fetchCoinDetails(coinId));
  }

  late final _$loadChartDataAsyncAction =
      AsyncAction('_CoinDetailStore.loadChartData', context: context);

  @override
  Future<void> loadChartData() {
    return _$loadChartDataAsyncAction.run(() => super.loadChartData());
  }

  late final _$_CoinDetailStoreActionController =
      ActionController(name: '_CoinDetailStore', context: context);

  @override
  void changePeriod(String period) {
    final _$actionInfo = _$_CoinDetailStoreActionController.startAction(
        name: '_CoinDetailStore.changePeriod');
    try {
      return super.changePeriod(period);
    } finally {
      _$_CoinDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
coin: ${coin},
chartData: ${chartData},
selectedPeriod: ${selectedPeriod},
isLoading: ${isLoading},
error: ${error},
maxYValue: ${maxYValue},
minYValue: ${minYValue}
    ''';
  }
}
