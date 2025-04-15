import 'package:coins_flutter_test/services/api_service.dart';
import 'package:coins_flutter_test/stores/theme/theme_store.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(ThemeStore());
  }
}