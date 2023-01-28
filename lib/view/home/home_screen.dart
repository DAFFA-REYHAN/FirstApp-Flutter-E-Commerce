import 'package:flutter/material.dart';
import 'package:flutter_application/view/home/components/popular_category/popular_category_loading.dart';
import 'package:flutter_application/view/home/components/section_title.dart';
import 'package:get/get.dart';
import 'package:flutter_application/componnent/main_header.dart';
import 'package:flutter_application/controller/controllers.dart';
import 'package:flutter_application/view/home/components/carousel_slider/carousel_slider_view.dart';

import 'components/carousel_slider/carousel_loading.dart';
import 'components/popular_category/popular_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const MainHeader(),
        Obx(() {
          if (homeController.bannerList.isNotEmpty) {
            return CarouselSliderView(bannerList: homeController.bannerList);
          } else {
            return const CarouselLoading();
          }
        }),
        const SectionTitle(title: "Popular Category"),
        Obx(() {
          if (homeController.popularCategoryList.isNotEmpty) {
            return PopularCategory(
              categories: homeController.popularCategoryList
            );
          } else {
            return const PopularCategoryLoading();
          }
        })
      ],
    ));
  }
}
