import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CacheRepository {
  static final CacheRepository _instance = CacheRepository._internal();
  static Box<List<CoinModelHive>>? _coinsBox;
  static Box? _metaBox;

  static const _coinsBoxName = 'coinsCache';
  static const _metaBoxName = 'coinsMetaCache';
  static const _lastUpdateKey = 'lastUpdate';

  CacheRepository._internal();
  factory CacheRepository() => _instance;

  Future<void> init() async {
    if (_coinsBox == null || !_coinsBox!.isOpen) {
      _coinsBox = Hive.isBoxOpen(_coinsBoxName)
          ? Hive.box<List<CoinModelHive>>(_coinsBoxName)
          : await Hive.openBox<List<CoinModelHive>>(_coinsBoxName);
    }

    if (_metaBox == null || !_metaBox!.isOpen) {
      _metaBox = Hive.isBoxOpen(_metaBoxName)
          ? Hive.box(_metaBoxName)
          : await Hive.openBox(_metaBoxName);
    }
  }

  Future<void> close() async {
    if (_coinsBox?.isOpen == true) await _coinsBox!.close();
    if (_metaBox?.isOpen == true) await _metaBox!.close();
  }

  Future<void> saveCoins(List<CoinModelHive> coins) async {
    try {
      await init();
       await _coinsBox!.add(coins);
      await _metaBox!.put(
        _lastUpdateKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving to cache: $e');
      }
    }
  }

  Future<List<CoinModelHive>> getCachedCoins() async {
    try {
      await init();
      return _coinsBox!.get('coins')?.cast<CoinModelHive>() ?? [];
    } catch (e) {
      if (kDebugMode) {
        print('Error accessing cache: $e');
      }
      return [];
    }
  }

  DateTime? getLastUpdate() {
    if (_metaBox == null || !_metaBox!.isOpen) return null;
    final lastUpdate = _metaBox!.get(_lastUpdateKey) as int?;
    return lastUpdate != null
        ? DateTime.fromMillisecondsSinceEpoch(lastUpdate)
        : null;
  }

  bool shouldRefresh() {
    final lastUpdate = getLastUpdate();
    if (lastUpdate == null) return true;
    return DateTime.now().difference(lastUpdate).inDays >= 2;
  }
}
