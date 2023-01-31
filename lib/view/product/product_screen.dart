import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application/componnent/main_header.dart';
import 'package:flutter_application/controller/controllers.dart';
import 'package:flutter_application/view/product/components/product_grid.dart';
import 'package:flutter_application/view/product/components/product_loading_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainHeader(),
          Expanded(child: Obx(() {
            if (productController.productList.isNotEmpty) {
              return ProductGrid(products: productController.productList);
            } else {
              return const ProductLoadingGrid();
            }
          }))
        ],
      ),
    );
  }
}
