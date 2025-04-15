import 'package:coins_flutter_test/views/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
  ];
}