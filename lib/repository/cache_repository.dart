// cache_repository.dart
import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:hive/hive.dart';

class CacheRepository {
  static Box<List<CoinModelHive>>? _box;
  static const _coinsBoxName = 'coinsCache';
  static const _lastUpdateKey = 'lastUpdate';

  Future<void> init() async {
    await Hive.openBox(_coinsBoxName);
  }

  Future<void> close() async {
    if (_box != null && _box!.isOpen) {
      await _box!.close();
    }
  }

  Future<Box<List<CoinModelHive>>> _getBox() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox<List<CoinModelHive>>('coinsCache');
    }
    return _box!;
  }

  Future<void> saveCoins(List<CoinModelHive> coins) async {
    try {
      final box = await _getBox();
      await box.put('coins', coins);
    } catch (e) {
      print('Error saving to cache: $e');
    }
  }

  Future<List<CoinModelHive>> getCachedCoins() async {
    try {
      final box = await _getBox();
      return box.get('coins')?.cast<CoinModelHive>() ?? [];
    } catch (e) {
      print('Error accessing cache: $e');
      return [];
    }
  }

  DateTime? getLastUpdate() {
    final box = Hive.box(_coinsBoxName);
    final lastUpdate = box.get(_lastUpdateKey) as int?;
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
