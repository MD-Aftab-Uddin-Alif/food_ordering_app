import 'package:get/get.dart';

import '../modules/news/news_binding.dart';
import '../modules/news/news_page.dart';

class NewsRoutes {
  NewsRoutes._();

  static const news = '/news';

  static final routes = [
    GetPage(
      name: news,
      page: () => const NewsPage(),
      binding: NewsBinding(),
    ),
  ];
}
