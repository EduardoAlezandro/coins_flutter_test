import 'package:coins_flutter_test/views/favorite/favorite_page.dart';
import 'package:coins_flutter_test/views/searchCoins/search_coins_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';

  static final routes = [
    GetPage(name: home, page: () => SearchCoins()),
    GetPage(name: '/favorites', page: () => FavoritesPage()),
  ];
}
