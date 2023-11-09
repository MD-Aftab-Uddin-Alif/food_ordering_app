import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/data/models/about_us_model.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AboutUsController extends GetxController {
  RxBool isAboutUsLoading = true.obs;
  RxList<AboutUsModel> aboutUsList = <AboutUsModel>[].obs;
  Future<bool> fetchAboutUs() async {
    try {
      isAboutUsLoading.value = true;

      final response = await http.get(
        Uri.parse(Secret.investorApiBaseURL + Secret.aboutUs),
        headers: Constant.apiHeader,
      );
      if (response.statusCode == 200) {
        final aboutUsData = jsonDecode(response.body);
        if (aboutUsData.isNotEmpty) {
          aboutUsList.clear();
          aboutUsData.forEach((aboutUs) {
            aboutUsList.add(AboutUsModel.fromJson(aboutUs));
          });
          print('About Us Info Fetched');
          await storeAboutUsList();
        }
        return true;
      } else {
        print('Error: ${response.statusCode}');
      }
      return false;
    } catch (e) {
      print('${e.toString()} in fetchAboutUs');
      return false;
    }
  }

  Future<void> storeAboutUsList() async {
    try {
      // save data using GetxStorage
      GetStorage()
          .write('aboutUsList', aboutUsModelToJson(aboutUsList.toList()));
      print('About Us Data Saved to GetX Storage');
      await retrieveAboutUsList();
    } catch (e) {
      print('${e.toString()} in storeAboutUsList');
    }
  }

  Future<void> retrieveAboutUsList() async {
    try {
      // get data using GetxStorage
      final jsonString = GetStorage().read('aboutUsList');
      if (jsonString != null && jsonString.isNotEmpty) {
        aboutUsList.value = aboutUsModelFromJson(jsonString).obs;
      }
      isAboutUsLoading.value = false;
      print('About Us Data retrieved from GetX Storage');
    } catch (e) {
      print('${e.toString()} in retrieveAboutUsList');
    }
  }
}
