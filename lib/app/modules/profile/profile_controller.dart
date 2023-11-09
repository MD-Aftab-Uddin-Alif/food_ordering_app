import 'dart:convert';

import 'package:ePolli/app/core/helpers/firebase_notification.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/data/models/investor_model.dart';
import 'package:ePolli/app/modules/checkout/checkout_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final storage = const FlutterSecureStorage();
  RxBool isProfileUploading = false.obs;
  RxBool isProfileCompleted = false.obs;
  RxString profileImageLocation = ''.obs;
  RxString nidBackImageLocation = ''.obs;
  RxString nidFrontImageLocation = ''.obs;
  Rx<InvestorModel> investorInfo = InvestorModel(
    id: 0,
    imageLocation: '',
    fullName: '',
    phoneNumber: '',
    email: '',
    password: '',
    address: '',
    nidNumber: '',
    nidFrontImageLocation: '',
    nidBackImageLocation: '',
    bankName: '',
    bankBranchName: '',
    accountHolderName: '',
    accountNumber: '',
    nomineeName: '',
    relationship: '',
    nomineePhoneNumber: '',
    nomineeNidNumber: '',
    nomineeNidFrontImageLocation: '',
    nomineeNidBackImageLocation: '',
    token: '',
    investmentRefund: 0.0,
    ongoingFunded: 0.0,
    totalProfit: 0.0,
    referralId: '',
    referredById: '',
    referredPoints: 0,
    totalRegistered: 0,
  ).obs;

  //fetch investor info from server
  Future<void> fetchInvestorInfoFromServer() async {
    try {
      var id = investorInfo.value.id;
      final response = await http.post(
          Uri.parse('${Secret.investorApiBaseURL}${Secret.profile}/$id'),
          headers: Constant.apiHeader,
          body: {
            'token': '$gFCMToken',
          });
      if (response.statusCode == 200) {
        final msg = jsonDecode(response.body)['message'];
        if (msg == 'Success') {
          saveInvestorDataToSecureStorage(jsonDecode(response.body)['data']);
        }
      } else {
        print('Error: ${response.statusCode} in fetchInvestorInfoFromServer');
      }
    } catch (e) {
      print('${e.toString()} in fetchInvestorInfoFromServer');
    }
  }

  // save invertor data to local storage after sign up
  Future<void> saveInvestorDataToSecureStorage(
    Map<String, dynamic> investorData,
  ) async {
    try {
      isProfileComplete();
      // deleting if any previous investor data exists if exists
      await storage.delete(key: 'investorKey');

      // Convert the InvestorModel to a JSON string
      final investorJsonData = json.encode(investorData);

      // Store the InvestorModel JSON string in the investorInfo variable
      investorInfo.value = InvestorModel.fromJson(investorData);

      // Store the JSON string in secure storage
      await storage.write(key: 'investorKey', value: investorJsonData);

      // Storing that user is signed in
      await storage.write(key: 'isSignedIn', value: 'true');
    } catch (e) {
      print('${e.toString()} in saveInvestorDataToSecureStorage');
    }
  }

  Future<void> getInvestorFromSecureStorage() async {
    try {
      // Retrieve the JSON string from secure storage
      final investorJson = await storage.read(key: 'investorKey');

      if (investorJson != null) {
        // Convert the JSON string back to InvestorModel and store it in investorInfo variable
        investorInfo.value = InvestorModel.fromJson(json.decode(investorJson));
      }
    } catch (e) {
      print('${e.toString()} in getInvestorFromSecureStorage');
    }
  }

  Future<void> updateInvestorPersonalInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required String address,
    required String nidNUmber,
    String nidBackImageLocation = '',
  }) async {
    try {
      isProfileUploading.value = true;
      int id = investorInfo.value.id;
      final response = await http.put(
        Uri.parse('${Secret.investorApiBaseURL}${Secret.updateProfile}/$id'),
        headers: Constant.apiHeader,
        body: {
          'fullName': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'address': address,
          'nidNumber': nidNUmber,
        },
      );

      if (response.statusCode == 200) {
        final msg = jsonDecode(response.body)['message'];
        if (msg == 'Success') {
          saveInvestorDataToSecureStorage(jsonDecode(response.body)['data']);

          customSnackbar('Profile Updated'.tr,
              'Your profile has been updated successfully'.tr, 'success');
        } else {
          customSnackbar(
              'Profile Update Failed'.tr, 'Something went wrong'.tr, 'warning');
        }
      } else {
        print('Error: ${response.statusCode} in updateInvestorPersonalInfo');
      }
      isProfileUploading.value = false;
    } catch (e) {
      print('${e.toString()} in updateInvestorPersonalInfo');
    }
  }

  Future<void> isProfileComplete() async {
    try {
      var investor = investorInfo.value;

      if (investor.address != '' &&
          investor.address != null &&
          investor.nidNumber != '' &&
          investor.nidNumber != null &&
          investor.bankName != '' &&
          investor.bankName != null &&
          investor.bankBranchName != '' &&
          investor.bankBranchName != null &&
          investor.accountHolderName != '' &&
          investor.accountHolderName != null &&
          investor.accountNumber != '' &&
          investor.accountNumber != null) {
        isProfileCompleted.value = true;
      } else {
        isProfileCompleted.value = false;
      }
    } catch (e) {
      print('${e.toString()} in isProfileComplete');
    }
  }

  Future<void> updateShippingInfo({
    required String newPhoneNumber,
    required String email,
    required String address,
  }) async {
    try {
      final CheckoutController checkoutController =
          Get.put(CheckoutController());
      checkoutController.isShippingInfoUpdateButtonLoading.value = true;
      int id = investorInfo.value.id;
      final response = await http.put(
        Uri.parse('${Secret.investorApiBaseURL}${Secret.shippingInfo}/$id'),
        headers: Constant.apiHeader,
        body: {
          'phoneNumber': newPhoneNumber,
          'email': email,
          'address': address,
        },
      );

      if (response.statusCode == 200) {
        final msg = jsonDecode(response.body)['message'];
        if (msg == 'Success') {
          saveInvestorDataToSecureStorage(jsonDecode(response.body)['data']);

          customSnackbar('Shipping Info Updated'.tr,
              'Your shipping info has been updated successfully'.tr, 'success');
        } else {
          customSnackbar('Shipping Info Update Failed'.tr,
              'Something went wrong'.tr, 'warning');
        }
      } else {
        print('Error: ${response.statusCode} in updateShippingInfo');
      }
      checkoutController.isShippingInfoUpdateButtonLoading.value = false;
    } catch (e) {
      print('${e.toString()} in updateShippingInfo');
    }
  }

  uploadProfileImage() async {
    try {
      var id = investorInfo.value.id;
      // upload the image file to server
      final uri = Uri.parse(
        '${Secret.investorApiBaseURL}${Secret.updateProfileImage}$id',
      );
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(Constant.apiHeader);
      request.files.add(
        await http.MultipartFile.fromPath(
            'profileImage', profileImageLocation.value),
      );

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        investorInfo.value.imageLocation = jsonResponse['location'].toString();
        saveInvestorDataToSecureStorage(investorInfo.value.toJson());
      } else {
        customSnackbar('Profile Image Upload Failed'.tr,
            'Something went wrong'.tr, 'warning');
      }
    } catch (e) {
      print('${e.toString()} in uploadProfileImage');
    }
  }

  uploadNidFrontImage() async {
    try {
      var id = investorInfo.value.id;
      // upload the image file to server
      final uri = Uri.parse(
          '${Secret.investorApiBaseURL}${Secret.updateNidFrontImage}$id');
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(Constant.apiHeader);
      request.files.add(
        await http.MultipartFile.fromPath(
            'nidFrontImage', nidFrontImageLocation.value),
      );

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        investorInfo.value.nidFrontImageLocation =
            jsonResponse['location'].toString();
        saveInvestorDataToSecureStorage(investorInfo.value.toJson());
      } else {
        customSnackbar('NID Front Image Upload Failed'.tr,
            'Something went wrong'.tr, 'warning');
      }
    } catch (e) {
      print('${e.toString()} in uploadNidFrontImage');
    }
  }

  uploadNidBackImage() async {
    try {
      var id = investorInfo.value.id;
      // upload the image file to server
      final uri = Uri.parse(
          '${Secret.investorApiBaseURL}${Secret.updateNidBackImage}$id');
      var request = http.MultipartRequest('POST', uri);

      request.headers.addAll(Constant.apiHeader);
      request.files.add(
        await http.MultipartFile.fromPath(
            'nidBackImage', nidBackImageLocation.value),
      );

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        investorInfo.value.nidBackImageLocation =
            jsonResponse['location'].toString();
        saveInvestorDataToSecureStorage(investorInfo.value.toJson());
      } else {
        customSnackbar('NID Back Image Upload Failed'.tr,
            'Something went wrong'.tr, 'warning');
      }
    } catch (e) {
      print('${e.toString()} in uploadNidBackImage');
    }
  }
}
