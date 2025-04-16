import 'package:coins_flutter_test/repository/cache_repository.dart';
import 'package:coins_flutter_test/theme/app_theme.dart';
import 'package:coins_flutter_test/views/favorite/favorite_page.dart';
import 'package:coins_flutter_test/views/searchCoins/search_coins_page.dart';
import 'package:coins_flutter_test/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bindings/app_bindings.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  
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
      themeMode: ThemeMode.system,
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: AppBindings(),
        ),
        GetPage(name: '/favorites', page: () => FavoritesPage()),
        
        GetPage(
          name: '/search',
          page: () => SearchCoins(),
          binding: AppBindings(),
        ),
      ],
    );
  }
}
