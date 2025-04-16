import 'package:coins_flutter_test/repository/cache_repository.dart';
import 'package:coins_flutter_test/services/api_service.dart';
import 'package:coins_flutter_test/services/coins_service.dart';
import 'package:coins_flutter_test/stores/advanceSearch/advanced_search_store.dart';
import 'package:coins_flutter_test/stores/favorite/favorite_store.dart';
import 'package:coins_flutter_test/stores/home/home_store.dart';
import 'package:coins_flutter_test/stores/searchCoins/search_coins_store.dart';
import 'package:coins_flutter_test/stores/theme/theme_store.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Serviços primeiro
    Get.put(CacheRepository(), permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.put(CoinsService(), permanent: true);

    // Stores com dependências
    Get.lazyPut(() => FavoriteStore());
    Get.lazyPut(() => ThemeStore());

    // HomeStore por último (depende dos serviços)
    Get.lazyPut(() => SearchCoinsStore());
    Get.lazyPut(() => HomeStore());
    Get.lazyPut(() => AdvancedSearchStore());
  }
}
