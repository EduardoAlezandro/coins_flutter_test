import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
  ];
}