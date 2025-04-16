// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_coins_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchCoinsStore on _SearchCoinsStore, Store {
  Computed<bool>? _$hasNextPageComputed;

  @override
  bool get hasNextPage =>
      (_$hasNextPageComputed ??= Computed<bool>(() => super.hasNextPage,
              name: '_SearchCoinsStore.hasNextPage'))
          .value;
  Computed<List<CoinModelHive>>? _$sortedDisplayedCoinsComputed;

  @override
  List<CoinModelHive> get sortedDisplayedCoins =>
      (_$sortedDisplayedCoinsComputed ??= Computed<List<CoinModelHive>>(
              () => super.sortedDisplayedCoins,
              name: '_SearchCoinsStore.sortedDisplayedCoins'))
          .value;
  Computed<bool>? _$hasPreviousPageComputed;

  @override
  bool get hasPreviousPage =>
      (_$hasPreviousPageComputed ??= Computed<bool>(() => super.hasPreviousPage,
              name: '_SearchCoinsStore.hasPreviousPage'))
          .value;
  Computed<int>? _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: '_SearchCoinsStore.totalPages'))
          .value;
  Computed<bool>? _$shouldShowEmptyStateComputed;

  @override
  bool get shouldShowEmptyState => (_$shouldShowEmptyStateComputed ??=
          Computed<bool>(() => super.shouldShowEmptyState,
              name: '_SearchCoinsStore.shouldShowEmptyState'))
      .value;

  late final _$allCoinsAtom =
      Atom(name: '_SearchCoinsStore.allCoins', context: context);

  @override
  ObservableList<CoinModelHive> get allCoins {
    _$allCoinsAtom.reportRead();
    return super.allCoins;
  }

  @override
  set allCoins(ObservableList<CoinModelHive> value) {
    _$allCoinsAtom.reportWrite(value, super.allCoins, () {
      super.allCoins = value;
    });
  }

  late final _$displayedCoinsAtom =
      Atom(name: '_SearchCoinsStore.displayedCoins', context: context);

  @override
  ObservableList<CoinModelHive> get displayedCoins {
    _$displayedCoinsAtom.reportRead();
    return super.displayedCoins;
  }

  @override
  set displayedCoins(ObservableList<CoinModelHive> value) {
    _$displayedCoinsAtom.reportWrite(value, super.displayedCoins, () {
      super.displayedCoins = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_SearchCoinsStore.searchQuery', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_SearchCoinsStore.isLoading', context: context);

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

  late final _$currentPageAtom =
      Atom(name: '_SearchCoinsStore.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$itemsPerPageAtom =
      Atom(name: '_SearchCoinsStore.itemsPerPage', context: context);

  @override
  int get itemsPerPage {
    _$itemsPerPageAtom.reportRead();
    return super.itemsPerPage;
  }

  @override
  set itemsPerPage(int value) {
    _$itemsPerPageAtom.reportWrite(value, super.itemsPerPage, () {
      super.itemsPerPage = value;
    });
  }

  late final _$isLoadingMoreAtom =
      Atom(name: '_SearchCoinsStore.isLoadingMore', context: context);

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
    });
  }

  late final _$hasMoreAtom =
      Atom(name: '_SearchCoinsStore.hasMore', context: context);

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$loadInitialCoinsAsyncAction =
      AsyncAction('_SearchCoinsStore.loadInitialCoins', context: context);

  @override
  Future<void> loadInitialCoins() {
    return _$loadInitialCoinsAsyncAction.run(() => super.loadInitialCoins());
  }

  late final _$loadMoreCoinsAsyncAction =
      AsyncAction('_SearchCoinsStore.loadMoreCoins', context: context);

  @override
  Future<void> loadMoreCoins() {
    return _$loadMoreCoinsAsyncAction.run(() => super.loadMoreCoins());
  }

  late final _$nextPageAsyncAction =
      AsyncAction('_SearchCoinsStore.nextPage', context: context);

  @override
  Future<void> nextPage() {
    return _$nextPageAsyncAction.run(() => super.nextPage());
  }

  late final _$_SearchCoinsStoreActionController =
      ActionController(name: '_SearchCoinsStore', context: context);

  @override
  void _updateDisplayedCoins() {
    final _$actionInfo = _$_SearchCoinsStoreActionController.startAction(
        name: '_SearchCoinsStore._updateDisplayedCoins');
    try {
      return super._updateDisplayedCoins();
    } finally {
      _$_SearchCoinsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_SearchCoinsStoreActionController.startAction(
        name: '_SearchCoinsStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_SearchCoinsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousPage() {
    final _$actionInfo = _$_SearchCoinsStoreActionController.startAction(
        name: '_SearchCoinsStore.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_SearchCoinsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allCoins: ${allCoins},
displayedCoins: ${displayedCoins},
searchQuery: ${searchQuery},
isLoading: ${isLoading},
currentPage: ${currentPage},
itemsPerPage: ${itemsPerPage},
isLoadingMore: ${isLoadingMore},
hasMore: ${hasMore},
hasNextPage: ${hasNextPage},
sortedDisplayedCoins: ${sortedDisplayedCoins},
hasPreviousPage: ${hasPreviousPage},
totalPages: ${totalPages},
shouldShowEmptyState: ${shouldShowEmptyState}
    ''';
  }
}
