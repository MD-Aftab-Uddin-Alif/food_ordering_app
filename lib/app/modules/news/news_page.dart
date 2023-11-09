import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_controller.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'.tr),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (!newsController.isNewsLoading.value) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.hTen,
                vertical: AppSize.hTen,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // open linkedin profile in external browser or linkedin app
                        launchUrl(
                          mode: LaunchMode.externalApplication,
                          Uri(
                            scheme: 'http',
                            path: newsController.newsList[index].source,
                          ),
                        );
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.secondary[200],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Hero(
                              tag: 'news${newsController.newsList[index].id}',
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image:
                                    '${Secret.baseURL}${newsController.newsList[index].image}',
                                fit: BoxFit.contain,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/logo/epolli.png');
                                },
                              ),
                            ),
                            title: Text(
                              homeController.isUSLocale.value
                                  ? newsController.newsList[index].title
                                      .toString()
                                  : newsController.newsList[index].titleBn !=
                                          null
                                      ? newsController.newsList[index].titleBn
                                          .toString()
                                      : newsController.newsList[index].title
                                          .toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: AppColor.primary,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_note_outlined,
                                    color: AppColor.secondary,
                                  ),
                                  Constant.sbWTen,
                                  Text(
                                    homeController.isUSLocale.value
                                        ? newsController
                                            .newsList[index].sourceAuthor
                                            .toString()
                                        : newsController.newsList[index]
                                                    .sourceAuthorBn !=
                                                null
                                            ? newsController
                                                .newsList[index].sourceAuthorBn
                                                .toString()
                                            : newsController
                                                .newsList[index].sourceAuthor
                                                .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColor.bText,
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.remove_red_eye_outlined,
                              //       color: AppColor.secondary,
                              //       size: 20,
                              //     ),
                              //     Constant.sbWTen,
                              //     Text(
                              //        newsController.newsList[index].views
                              //           .toString(),
                              //       style: const TextStyle(
                              //         fontSize: 16,
                              //         color: AppColor.bText,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: newsController.newsList.length,
            );
          } else {
            return const Center(
              child: Image(
                image: AssetImage('assets/images/loading.gif'),
              ),
            );
          }
        }),
      ),
    );
  }
}
