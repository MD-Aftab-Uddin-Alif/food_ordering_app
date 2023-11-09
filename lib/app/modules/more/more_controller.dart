import 'package:ePolli/app/data/models/investor_model.dart';
import 'package:ePolli/app/modules/order_history/order_history_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MoreController extends GetxController {
  RxBool isPersonalDetailsCompleted = false.obs;
  RxBool isBankDetailsCompleted = false.obs;
  RxBool isNomineeDetailsCompleted = false.obs;
  final ProfileController profileController = Get.put(ProfileController());

  void isPersonalDetailsComplete() {
    if (profileController.investorInfo.value.fullName != null &&
        profileController.investorInfo.value.fullName != "" &&
        profileController.investorInfo.value.phoneNumber != null &&
        profileController.investorInfo.value.phoneNumber != "" &&
        profileController.investorInfo.value.email != "" &&
        profileController.investorInfo.value.email != null &&
        profileController.investorInfo.value.address != null &&
        profileController.investorInfo.value.address != "" &&
        profileController.investorInfo.value.nidNumber != null &&
        profileController.investorInfo.value.nidNumber != "") {
      isPersonalDetailsCompleted.value = true;
    } else {
      isPersonalDetailsCompleted.value = false;
    }
  }

  void isBankDetailsComplete() {
    if (profileController.investorInfo.value.bankName != null &&
        profileController.investorInfo.value.bankName != "" &&
        profileController.investorInfo.value.bankBranchName != null &&
        profileController.investorInfo.value.bankBranchName != "" &&
        profileController.investorInfo.value.accountHolderName != null &&
        profileController.investorInfo.value.accountHolderName != "" &&
        profileController.investorInfo.value.accountNumber != null &&
        profileController.investorInfo.value.accountNumber != "") {
      isBankDetailsCompleted.value = true;
    } else {
      isBankDetailsCompleted.value = false;
    }
  }

  void isNomineeDetailsComplete() {
    if (profileController.investorInfo.value.nomineeName != null &&
        profileController.investorInfo.value.nomineeName != "" &&
        profileController.investorInfo.value.nomineePhoneNumber != null &&
        profileController.investorInfo.value.nomineePhoneNumber != "" &&
        profileController.investorInfo.value.relationship != null &&
        profileController.investorInfo.value.relationship != "" &&
        profileController.investorInfo.value.nomineeNidNumber != null &&
        profileController.investorInfo.value.nomineeNidNumber != "") {
      isNomineeDetailsCompleted.value = true;
    } else {
      isNomineeDetailsCompleted.value = false;
    }
  }

  void signOutMethod() {
    Get.back();
    const storage = FlutterSecureStorage();
    final googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    storage.delete(key: 'investorKey');
    storage.delete(key: 'isSignedIn');
    OrderHistoryController orderHistoryController =
        Get.put(OrderHistoryController());
    orderHistoryController.orderList.clear();
    ProfileController profileController = Get.put(ProfileController());
    profileController.investorInfo = InvestorModel(
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
      ongoingFunded: 0.0,
      investmentRefund: 0.0,
      totalProfit: 0.0,
      referralId: '',
      referredById: '',
      referredPoints: 0,
      totalRegistered: 0,
    ).obs;
    Get.offNamedUntil(SplashRoutes.splash, (route) => false);
  }
}
