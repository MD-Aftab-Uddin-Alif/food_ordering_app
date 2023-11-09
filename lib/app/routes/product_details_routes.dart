import 'package:get/get.dart';

import '../modules/product_details/product_details_binding.dart';
import '../modules/product_details/product_details_page.dart';

class ProductDetailsRoutes {
  ProductDetailsRoutes._();

  static const productDetails = '/product-details';

  static final routes = [
    GetPage(
      name: productDetails,
      page: () => const ProductDetailsPage(),
      binding: ProductDetailsBinding(),
    ),
  ];
}
