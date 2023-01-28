import 'package:flutter_application/model/category.dart';
import 'package:flutter_application/model/product.dart';
import 'package:flutter_application/service/local_service/local_ad_banner_service.dart';
import 'package:get/get.dart';
import 'package:flutter_application/model/ad_banner.dart';
import 'package:flutter_application/service/remote_service/remote_banner_service.dart';
import 'package:flutter_application/service/remote_service/remote_popular_product_service.dart';

import '../service/local_service/local_category_service.dart';
import '../service/local_service/local_product_service.dart';
import '../service/remote_service/remote_popular_category.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Category> popularCategoryList =
      List<Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();
    getAdBanners();
    getPopularCategories();
    getPopularProducts();
    super.onInit();
  }

  void getAdBanners() async {
    try {
      isBannerLoading(true);
      //assigning local ad banners before call api
      if (_localAdBannerService.getAdBanners().isNotEmpty) {
        bannerList.assignAll(_localAdBannerService.getAdBanners());
      }
      // Call Api
      var result = await RemoteBannerService().get();
      if (result != null) {
        // assign api result
        bannerList.assignAll(adBannerListFromJson(result.body));
        //save api result to local db
        _localAdBannerService.assignAllAdBanners(
            adBanners: adBannerListFromJson(result.body));
      }
    } finally {
      isBannerLoading(false);
    }
  }

  void getPopularCategories() async {
    try {
      isPopularCategoryLoading(true);
      //assigning local category before call api
      if (_localCategoryService.getPopularCategories().isNotEmpty) {
        popularCategoryList
            .assignAll(_localCategoryService.getPopularCategories());
      }
      // Call Api
      var result = await RemotePopularCategoryService().get();
      if (result != null) {
        // assign Api result
        popularCategoryList.assignAll(popularCategoryListFromJson(result.body));
        // save API result to local db
        _localCategoryService.assignAllPopularCategories(
            popularCategories: popularCategoryListFromJson(result.body));
      }
    } finally {
      print(popularCategoryList.length);
      isPopularCategoryLoading(false);
    }
  }

  void getPopularProducts() async {
    try {
      isPopularProductLoading(true);
      // Assigning local product before call API
      if (_localProductService.getPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }
      // Call API
      var result = await RemotePopularProductService().get();
      if (result != null) {
        // Assign API result
        popularProductList.assignAll(popularProductListFromJson(result.body));
        // save API to result to local db
        _localProductService.assignAllPopularProducts(
            popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      print(popularProductList.length);
      isPopularProductLoading(false);
    }
  }
}
