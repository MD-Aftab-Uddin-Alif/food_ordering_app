import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxBool isProductAddedToCart = false.obs;

  CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());

  isThisProductAddedToCart(int productId) {
    try {
      isProductAddedToCart.value = false;
      for (var element in cartController.cartProductList) {
        if (element.productId == productId) {
          isProductAddedToCart.value = true;
        }
      }
    } catch (e) {
      print('${e.toString()} in isThisProductAddedToCart');
    }
  }

  isThisProductPreOrder(dynamic eventDate) {
    try {
      if (eventDate != null && eventDate != '') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('${e.toString()} in isThisProductPreOrder');
    }
  }
}
