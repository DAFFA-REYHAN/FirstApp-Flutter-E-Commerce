import 'package:flutter_application/controller/product_cotroller.dart';
import 'package:get/get.dart';
import 'package:flutter_application/controller/dashboard_controller.dart';
import 'package:flutter_application/controller/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
  }
}
