// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<List<String>>? _$availableCoinsComputed;

  @override
  List<String> get availableCoins => (_$availableCoinsComputed ??=
          Computed<List<String>>(() => super.availableCoins,
              name: '_HomeStoreBase.availableCoins'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_HomeStoreBase.hasError'))
      .value;
  Computed<bool>? _$hasDataComputed;

  @override
  bool get hasData => (_$hasDataComputed ??=
          Computed<bool>(() => super.hasData, name: '_HomeStoreBase.hasData'))
      .value;
  Computed<double>? _$maxYValueComputed;

  @override
  double get maxYValue =>
      (_$maxYValueComputed ??= Computed<double>(() => super.maxYValue,
              name: '_HomeStoreBase.maxYValue'))
          .value;
  Computed<double>? _$minYValueComputed;

  @override
  double get minYValue =>
      (_$minYValueComputed ??= Computed<double>(() => super.minYValue,
              name: '_HomeStoreBase.minYValue'))
          .value;

  late final _$chartDataAtom =
      Atom(name: '_HomeStoreBase.chartData', context: context);

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
      Atom(name: '_HomeStoreBase.selectedPeriod', context: context);

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

  late final _$currentCoinIdAtom =
      Atom(name: '_HomeStoreBase.currentCoinId', context: context);

  @override
  String get currentCoinId {
    _$currentCoinIdAtom.reportRead();
    return super.currentCoinId;
  }

  @override
  set currentCoinId(String value) {
    _$currentCoinIdAtom.reportWrite(value, super.currentCoinId, () {
      super.currentCoinId = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeStoreBase.isLoading', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_HomeStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_HomeStoreBase.initialize', context: context);

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$loadChartDataAsyncAction =
      AsyncAction('_HomeStoreBase.loadChartData', context: context);

  @override
  Future<void> loadChartData() {
    return _$loadChartDataAsyncAction.run(() => super.loadChartData());
  }

  late final _$_selectInitialCoinAsyncAction =
      AsyncAction('_HomeStoreBase._selectInitialCoin', context: context);

  @override
  Future<void> _selectInitialCoin() {
    return _$_selectInitialCoinAsyncAction
        .run(() => super._selectInitialCoin());
  }

  late final _$changeCoinAsyncAction =
      AsyncAction('_HomeStoreBase.changeCoin', context: context);

  @override
  Future<void> changeCoin(String newCoinId) {
    return _$changeCoinAsyncAction.run(() => super.changeCoin(newCoinId));
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void changePeriod(String period) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.changePeriod');
    try {
      return super.changePeriod(period);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chartData: ${chartData},
selectedPeriod: ${selectedPeriod},
currentCoinId: ${currentCoinId},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
availableCoins: ${availableCoins},
hasError: ${hasError},
hasData: ${hasData},
maxYValue: ${maxYValue},
minYValue: ${minYValue}
    ''';
  }
}
