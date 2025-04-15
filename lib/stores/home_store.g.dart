// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<List<CryptoModel>>? _$filteredCryptoListComputed;

  @override
  List<CryptoModel> get filteredCryptoList => (_$filteredCryptoListComputed ??=
          Computed<List<CryptoModel>>(() => super.filteredCryptoList,
              name: '_HomeStoreBase.filteredCryptoList'))
      .value;

  late final _$cryptoListAtom =
      Atom(name: '_HomeStoreBase.cryptoList', context: context);

  @override
  List<CryptoModel> get cryptoList {
    _$cryptoListAtom.reportRead();
    return super.cryptoList;
  }

  @override
  set cryptoList(List<CryptoModel> value) {
    _$cryptoListAtom.reportWrite(value, super.cryptoList, () {
      super.cryptoList = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_HomeStoreBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cryptoList: ${cryptoList},
searchQuery: ${searchQuery},
filteredCryptoList: ${filteredCryptoList}
    ''';
  }
}
