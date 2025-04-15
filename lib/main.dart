// lib/main.dart
import 'package:coins_flutter_test/stores/theme/theme_store.dart';
import 'package:coins_flutter_test/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/app_bindings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: AppBindings(), 
      theme: AppTheme.lightTheme,   
      darkTheme: AppTheme.darkTheme, 
      themeMode: Get.find<ThemeStore>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
      
    );
  }
}