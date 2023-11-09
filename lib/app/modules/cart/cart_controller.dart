import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/data/models/cart_product_model.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  RxInt cartProductCount = 0.obs;
  RxBool isCartLoading = true.obs;
  RxDouble subTotalPrice = 0.0.obs;
  RxList<CartProductModel> cartProductList = <CartProductModel>[].obs;

  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());

  // Store a list of CartModel objects using Flutter Secure Storage
  Future<void> storeCartList() async {
    try {
      // save data using GetxStorage
      GetStorage()
          .write('cartList', cartProductModelToJson(cartProductList.toList()));
      print('Cart Data Saved to GetX Storage');
      await retrieveCartList();
    } catch (e) {
      print('${e.toString()} in storeCartList');
    }
  }

  // Retrieve the list of AgriInfoModel objects from Flutter Secure Storage
  Future<void> retrieveCartList() async {
    try {
      isCartLoading.value = true;
      // get data using GetxStorage
      final jsonString = GetStorage().read('cartList');
      if (jsonString != null && jsonString.isNotEmpty) {
        cartProductList.value = cartProductModelFromJson(jsonString).obs;
      }
      isCartLoading.value = false;
      print('Cart Data retrieved from GetX Storage');
    } catch (e) {
      print('${e.toString()} in retrieveCartList');
    }
  }

  Future<void> addProductToCart(int productId, int minimumQuantity) async {
    try {
      isCartLoading.value = true;
      cartProductList.add(
        CartProductModel(
          productId: productId,
          quantity: minimumQuantity,
        ),
      );
      await storeCartList();
    } catch (e) {
      customSnackbar('Error'.tr, 'Product Not Added to Cart'.tr, 'warning');
      print('${e.toString()} in addProductToCart');
    }
  }

  Future<void> removeProductFromCart(int productId) async {
    try {
      isCartLoading.value = true;
      cartProductList.removeWhere(
        (element) => element.productId == productId,
      );
      await storeCartList();
      subTotalPriceCal();
    } catch (e) {
      print('${e.toString()} in removeProductFromCart');
    }
  }

  Future<void> increaseProductQuantity(
      int productId, int currentQuantity) async {
    try {
      isCartLoading.value = true;
      cartProductList
          .firstWhere(
            (element) => element.productId == productId,
          )
          .quantity = currentQuantity + 1;
      await storeCartList();
      subTotalPriceCal();
    } catch (e) {
      print('${e.toString()} in increaseProductQuantity');
      customSnackbar(
          'Error'.tr, 'Product Quantity Not Increased'.tr, 'warning');
    }
  }

  Future<void> decreaseProductQuantity(
      int productId, int currentQuantity) async {
    try {
      isCartLoading.value = true;
      cartProductList
          .firstWhere(
            (element) => element.productId == productId,
          )
          .quantity = currentQuantity - 1;
      await storeCartList();
      subTotalPriceCal();
    } catch (e) {
      customSnackbar(
          'Error'.tr, 'Product Quantity Not Decreased'.tr, 'warning');
      print('${e.toString()} in decreaseProductQuantity');
    }
  }

  subTotalPriceCal() {
    try {
      subTotalPrice.value = 0.0;
      for (var cartProduct in cartProductList) {
        var product = homeController.productList.firstWhere(
          (element) => element.id == cartProduct.productId,
        );
        if (product.discountPercentage == 0) {
          double price = product.regularPrice;
          subTotalPrice.value =
              subTotalPrice.value + (cartProduct.quantity.toDouble() * price);
        } else {
          double price = product.discountedPrice;
          subTotalPrice.value =
              subTotalPrice.value + (cartProduct.quantity.toDouble() * price);
        }
      }
    } catch (e) {
      print('${e.toString()} in subTotalPriceCal');
    }
  }
}
