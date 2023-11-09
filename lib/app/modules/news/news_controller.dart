import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/data/models/news_model.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  final storage = const FlutterSecureStorage();
  RxBool isNewsLoading = true.obs;
  RxList<NewsModel> newsList = <NewsModel>[].obs;

  Future<bool> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse(Secret.news),
        headers: Constant.apiHeader,
      );
      if (response.statusCode == 200) {
        final fetchedNews = jsonDecode(response.body)['data'];
        if (fetchedNews.isNotEmpty) {
          newsList.clear();
          fetchedNews.forEach((fetchedNew) {
            newsList.add(NewsModel.fromJson(fetchedNew));
          });
          print('News Data Fetched');
          storeNewsList();
        }
        return true;
      }
      return false;
    } catch (e) {
      print('${e.toString()} in fetchNews');
      return false;
    }
  }

  Future<void> storeNewsList() async {
    try {
      // save data using GetxStorage
      GetStorage().write('newsList', newsModelToJson(newsList.toList()));
      print('News Data Saved to GetX Storage');
      await retrieveNewsList();
    } catch (e) {
      print('${e.toString()} in storeNewsList');
    }
  }

  Future<void> retrieveNewsList() async {
    try {
      // get data using GetxStorage
      final jsonString = GetStorage().read('newsList');
      if (jsonString != null && jsonString.isNotEmpty) {
        newsList.value = newsModelFromJson(jsonString).obs;
      }
      isNewsLoading.value = false;
      print('News Data retrieved from GetX Storage');
    } catch (e) {
      print('${e.toString()} in retrieveNewsList');
    }
  }
}
