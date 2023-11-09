import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/data/models/agri_info_model.dart';
import 'package:ePolli/app/data/models/investor_model.dart';
import 'package:ePolli/app/data/models/product_category_model.dart';
import 'package:ePolli/app/data/models/product_model.dart';
import 'package:ePolli/app/data/models/recommended_product_model.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final storage = const FlutterSecureStorage();
  RxBool isFirstLoading = true.obs;
  RxBool isAgriInfoLoading = true.obs;
  RxBool isProjectCategoriesLoading = true.obs;
  RxBool isProductCategoriesLoading = true.obs;
  RxBool isProjectsLoading = true.obs;
  RxBool isProductsLoading = true.obs;
  RxBool isProfileFetched = false.obs;
  RxBool isEveryThingFetched = false.obs;
  RxBool isSigned = false.obs;
  RxBool isUSLocale = true.obs;

  RxList<AgriInfoModel> agriInfoList = <AgriInfoModel>[].obs;
  RxList<ProductCategoryModel> productCategoryList =
      <ProductCategoryModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<RecommendedProductModel> recommendedProductList =
      <RecommendedProductModel>[].obs;

  final ProfileController profileController = Get.put(ProfileController());
  final SplashController splashController = Get.put(SplashController());

  Future<void> getInvestorInfo() async {
    try {
      int id = profileController.investorInfo.value.id;
      final response = await http.get(
        Uri.parse('${Secret.investorApiBaseURL}${Secret.profile}/$id'),
        headers: Constant.apiHeader,
      );

      if (response.statusCode == 200) {
        final fetchedInvestorInfos = jsonDecode(response.body);
        if (fetchedInvestorInfos.isNotEmpty) {
          // add fetched data to investorInfo
          profileController.investorInfo.value =
              InvestorModel.fromJson(fetchedInvestorInfos);
          isProfileFetched.value = true;
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('${e.toString()} in getInvestorInfo');
    }
  }

  Future<bool> fetchAgriInfo() async {
    try {
      final response = await http.get(
        Uri.parse(Secret.agriInfo),
        headers: Constant.apiHeader,
      );

      if (response.statusCode == 200) {
        final agriInfo = jsonDecode(response.body);
        if (agriInfo.isNotEmpty) {
          agriInfoList.clear();
          agriInfo.forEach((agriInfo) {
            agriInfoList.add(AgriInfoModel.fromJson(agriInfo));
          });
          print('Agri Info Fetched');
          await storeAgriInfoList();
        }
        return true;
      } else {
        print('Error: ${response.statusCode}');
      }
      return false;
    } catch (e) {
      print('${e.toString()} in fetchAgriInfo');
      return false;
    }
  }

  

  Future<bool> fetchProductCategories() async {
    try {
      final response = await http.get(
        Uri.parse(Secret.investorApiBaseURL + Secret.productCategories),
        headers: Constant.apiHeader,
      );

      if (response.statusCode == 200) {
        final productCategories = jsonDecode(response.body);
        if (productCategories.isNotEmpty) {
          productCategoryList.clear();
          productCategories.forEach((productCategories) {
            productCategoryList
                .add(ProductCategoryModel.fromJson(productCategories));
          });
          print('Product Categories Fetched');
          await storeProductCategoryList();
        }
        return true;
      } else {
        print('Error: ${response.statusCode} in fetchProductCategories');
      }

      return false;
    } catch (e) {
      print('${e.toString()} in fetchProductCategories');
      return false;
    }
  }

 

  Future<void> getProducts() async {
    try {
      isProductsLoading.value = true;
      final response = await http.get(
        Uri.parse(Secret.investorApiBaseURL + Secret.allProducts),
        headers: Constant.apiHeader,
      );

      if (response.statusCode == 200) {
        final products = jsonDecode(response.body);
        if (products.isNotEmpty) {
          productList.clear();
          products.forEach((product) {
            productList.add(ProductModel.fromJson(product));
          });
        }
      } else {
        print('Error: ${response.statusCode} in getProducts');
      }
      isProductsLoading.value = false;
    } catch (e) {
      print('${e.toString()} in getProducts');
    }
  }

 

  Future<void> getRecommendedProducts() async {
    try {
      final response = await http.get(
        Uri.parse(Secret.investorApiBaseURL + Secret.recommendedProducts),
        headers: Constant.apiHeader,
      );

      if (response.statusCode == 200) {
        final recommendedProducts = jsonDecode(response.body);
        if (recommendedProducts.isNotEmpty) {
          recommendedProductList.clear();
          recommendedProducts.forEach((recommendedProduct) {
            recommendedProductList
                .add(RecommendedProductModel.fromJson(recommendedProduct));
          });
        }
      } else {
        print('Error: ${response.statusCode} in getRecommendedProducts');
      }
    } catch (e) {
      print('${e.toString()} in getRecommendedProducts');
    }
  }

  // Store a list of AgriInfoModel objects using Flutter Secure Storage
  Future<void> storeAgriInfoList() async {
    try {
      // save data using GetxStorage
      GetStorage()
          .write('agriInfoList', agriInfoModelToJson(agriInfoList.toList()));
      print('Agri Info Data Saved to GetX Storage');
      await retrieveAgriInfoList();
    } catch (e) {
      print('${e.toString()} in storeAgriInfoList');
    }
  }

  // Retrieve the list of AgriInfoModel objects from Flutter Secure Storage
  Future<void> retrieveAgriInfoList() async {
    try {
      // get data using GetxStorage
      final jsonString = GetStorage().read('agriInfoList');
      if (jsonString != null && jsonString.isNotEmpty) {
        agriInfoList.value = agriInfoModelFromJson(jsonString).obs;
      }
      isAgriInfoLoading.value = false;
      print('Agri Info Data retrieved from GetX Storage');
    } catch (e) {
      print('${e.toString()} in retrieveAgriInfoList');
    }
  }

  



  // Store a list of Product Category Model objects using Flutter Secure Storage
  Future<void> storeProductCategoryList() async {
    try {
      // save data using GetxStorage
      GetStorage().write('productCategoryList',
          productCategoryModelToJson(productCategoryList.toList()));
      await retrieveProductCategoryList();
      print('Product Category Data Saved to Secure Storage');
    } catch (e) {
      print('${e.toString()} in storeProductCategoryList');
    }
  }

// Retrieve the list of Product Category Model objects from Flutter Secure Storage
  Future<void> retrieveProductCategoryList() async {
    try {
      // get data using GetxStorage
      final jsonString = GetStorage().read('productCategoryList');
      if (jsonString != null && jsonString.isNotEmpty) {
        productCategoryList.value =
            productCategoryModelFromJson(jsonString).obs;
      }
      isProductCategoriesLoading.value = false;
      print('Product Category Data retrieved from GetX Storage');
    } catch (e) {
      print('${e.toString()} in retrieveProductCategoryList');
    }
  }

  // store isUSLocale value in GetX Storage
  Future<void> storeIsUsLocale() async {
    try {
      // save data using GetxStorage
      GetStorage().write('isUSLocale', isUSLocale.value);
      print('isUSLocale Data Saved to GetX Storage');
      retrieveIsUsLocale();
    } catch (e) {
      print('${e.toString()} in storeIsUsLocale');
    }
  }

  // retrieve isUSLocale value from GetX Storage
  Future<void> retrieveIsUsLocale() async {
    try {
      // get data using GetxStorage
      final isUSLocaleValue = GetStorage().read('isUSLocale');
      if (isUSLocaleValue != null) {
        isUSLocale.value = isUSLocaleValue;
      } else {
        isUSLocale.value = true;
      }
      if (isUSLocale.value) {
        Get.updateLocale(const Locale('en', 'US'));
      } else {
        Get.updateLocale(const Locale('bn', 'BD'));
      }
      print('isUSLocale Data retrieved from GetX Storage');
      print('isUSLocale Value: ${isUSLocale.value}');
    } catch (e) {
      print('${e.toString()} in retrieveIsUsLocale');
    }
  }
}
