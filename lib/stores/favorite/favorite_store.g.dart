// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on _FavoriteStoreBase, Store {
  late final _$favoriteIdsAtom =
      Atom(name: '_FavoriteStoreBase.favoriteIds', context: context);

  @override
  ObservableSet<String> get favoriteIds {
    _$favoriteIdsAtom.reportRead();
    return super.favoriteIds;
  }

  @override
  set favoriteIds(ObservableSet<String> value) {
    _$favoriteIdsAtom.reportWrite(value, super.favoriteIds, () {
      super.favoriteIds = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_FavoriteStoreBase.isLoading', context: context);

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

  late final _$_initializeAsyncAction =
      AsyncAction('_FavoriteStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$toggleFavoriteAsyncAction =
      AsyncAction('_FavoriteStoreBase.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(CoinModelHive coin) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(coin));
  }

  late final _$loadFavoritesAsyncAction =
      AsyncAction('_FavoriteStoreBase.loadFavorites', context: context);

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  @override
  String toString() {
    return '''
favoriteIds: ${favoriteIds},
isLoading: ${isLoading}
    ''';
  }
}
