// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdvancedSearchStore on _AdvancedSearchStoreBase, Store {
  late final _$searchQueryAtom =
      Atom(name: '_AdvancedSearchStoreBase.searchQuery', context: context);

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

  late final _$searchResultsAtom =
      Atom(name: '_AdvancedSearchStoreBase.searchResults', context: context);

  @override
  Map<String, dynamic> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(Map<String, dynamic> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AdvancedSearchStoreBase.isLoading', context: context);

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
      Atom(name: '_AdvancedSearchStoreBase.error', context: context);

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

  late final _$performSearchAsyncAction =
      AsyncAction('_AdvancedSearchStoreBase.performSearch', context: context);

  @override
  Future<void> performSearch() {
    return _$performSearchAsyncAction.run(() => super.performSearch());
  }

  late final _$_AdvancedSearchStoreBaseActionController =
      ActionController(name: '_AdvancedSearchStoreBase', context: context);

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_AdvancedSearchStoreBaseActionController.startAction(
        name: '_AdvancedSearchStoreBase.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_AdvancedSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
searchResults: ${searchResults},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
