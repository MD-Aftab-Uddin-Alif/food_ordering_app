import 'package:get/get.dart';

import '../modules/product/product_binding.dart';
import '../modules/product/product_page.dart';

class ProductRoutes {
  ProductRoutes._();

  static const product = '/product';

  static final routes = [
    GetPage(
      name: product,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
  ];
}
