import 'package:coins_flutter_test/models/coins/hive/coin_model_hive.dart';
import 'package:coins_flutter_test/repository/cache_repository.dart';
import 'package:coins_flutter_test/theme/app_theme.dart';
import 'package:coins_flutter_test/views/detail/coin_detail_view.dart';
import 'package:coins_flutter_test/views/favorite/favorite_view.dart';
import 'package:coins_flutter_test/views/searchCoins/search_coins_view.dart';
import 'package:coins_flutter_test/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bindings/app_bindings.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(CoinModelHiveAdapter());
  }
  final cacheRepository = CacheRepository();
  await cacheRepository.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: AppBindings(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeView(), binding: AppBindings()),
        GetPage(name: '/favorites', page: () => FavoritesView()),
        GetPage(
          name: '/detail/:coinId',
          page: () => CoinDetailView(coinId: Get.parameters['coinId']!),
          binding: AppBindings(),
        ),
        GetPage(
          name: '/search',
          page: () => SearchCoinsView(),
          binding: AppBindings(),
        ),
      ],
    );
  }
}
