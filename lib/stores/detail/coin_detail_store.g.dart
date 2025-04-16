// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinDetailStore on _CoinDetailStore, Store {
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

  @override
  String toString() {
    return '''
coin: ${coin},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
