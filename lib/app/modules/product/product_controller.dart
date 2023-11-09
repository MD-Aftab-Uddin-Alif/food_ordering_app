import 'package:ePolli/app/data/models/product_model.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final CartController cartController = Get.put(CartController());

  final HomeController homeController = Get.put(HomeController());
  RxList<ProductModel> categorizedProductList = <ProductModel>[].obs;
  RxString title = ''.obs;

  Future<void> getCategorizedProductList(String category) async {
    categorizedProductList.clear();
    title.value = '';

    if (category != 'All') {
      title.value = homeController.isUSLocale.value
          ? homeController.productCategoryList[Get.arguments - 1].name
          : homeController.productCategoryList[Get.arguments - 1].nameBn ??
              homeController.productCategoryList[Get.arguments - 1].name;
      for (int i = 0; i < homeController.productList.length; i++) {
        if (homeController.productList[i].categoryId.toString() ==
                category.toString() &&
            homeController.productList[i].stock > 0) {
          categorizedProductList.add(homeController.productList[i]);
        }
      }
    } else {
      title.value = 'All '.tr;
      categorizedProductList.addAll(homeController.productList);
    }
  }

  bool isItemInCart(ProductModel product) {
    return cartController.cartProductList.any((element) {
      return element.productId == product.id ? true : false;
    });
  }

  bool isPreOrder(ProductModel product) {
    return product.deliveryDate != null && product.deliveryDate != ''
        ? true
        : false;
  }
}
