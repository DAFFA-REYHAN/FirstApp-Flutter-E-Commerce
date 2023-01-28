import 'package:flutter_application/route/app_route.dart';
import 'package:flutter_application/view/dashboard/dashboard_binding.dart';
import 'package:flutter_application/view/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';

class AppPage{
  static var list = [
    GetPage(
      name: AppRoute.dashbooard, 
      page: () => const DashboardScreen(),
      binding: DashboardBinding()
      )
  ];
}