import 'package:get/get.dart';
import '../services/api_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
  }
}