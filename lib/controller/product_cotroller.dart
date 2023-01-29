import 'package:flutter_application/model/product.dart';
import 'package:flutter_application/service/remote_service/remote_product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  static ProductController instance = Get.find();
  RxList<Product> productList = List<Product>.empty(growable: true).obs;
  RxBool isProductLoading = false.obs; 

  @override
  void onInit(){
    getProducts();
    super.onInit();
  }

  void getProducts() async{
    try {
      isProductLoading(true);
      var result = await RemoteProductService().get();
      if(result != null){
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
      print(productList.length);
    }
  }
}