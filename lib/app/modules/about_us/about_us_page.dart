import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/modules/about_us/about_us_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final AboutUsController _aboutUsController = Get.put(AboutUsController());
  bool _hasCallSupport = false;
  Future<void>? _launched;
  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us'.tr,
        ),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: Obx(
        () => _aboutUsController.isAboutUsLoading.value
            ? const Center(
                child: Image(
                  image: AssetImage('assets/images/loading.gif'),
                ),
              )
            : ListView.builder(
                itemCount: _aboutUsController.aboutUsList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ExpansionTileCard(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    baseColor: AppColor.secondary[200],
                    expandedColor: AppColor.secondary[200],
                    expandedTextColor: AppColor.bText,
                    elevation: 10,
                    initialElevation: 10.0,
                    shadowColor: Colors.black,
                    leading: CircleAvatar(
                      maxRadius: 25,
                      child: ClipOval(
                        child: Image.network(
                          Secret.baseURL +
                              _aboutUsController
                                  .aboutUsList[index].imageLocation,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 25,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            getLocalizedText(
                                    _aboutUsController.aboutUsList[index].name,
                                    _aboutUsController
                                        .aboutUsList[index].nameBn)
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    subtitle: Text(
                      getLocalizedText(
                        _aboutUsController.aboutUsList[index].designation,
                        _aboutUsController.aboutUsList[index].designationBn,
                      ).toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    children: <Widget>[
                      const Divider(
                        thickness: 1,
                        height: 2.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                getLocalizedText(
                                  _aboutUsController
                                      .aboutUsList[index].description,
                                  _aboutUsController
                                      .aboutUsList[index].descriptionBn,
                                ).toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          TextButton(
                            onPressed: _hasCallSupport
                                ? () => setState(() {
                                      _launched = _makePhoneCall(
                                        _aboutUsController
                                            .aboutUsList[index].phoneNumber,
                                      );
                                    })
                                : null,
                            child: Column(
                              children: <Widget>[
                                const Icon(Icons.call, color: Colors.black),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Call'.tr,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() {
                              _launched = launchUrl(
                                Uri(
                                  scheme: 'mailto',
                                  path: _aboutUsController
                                      .aboutUsList[index].email,
                                ),
                              );
                            }),
                            child: Column(
                              children: <Widget>[
                                const Icon(Icons.email_outlined,
                                    color: Colors.black),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Email'.tr,
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          // linkedin button here
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // open linkedin profile in external browser or linkedin app
                                _launched = launchUrl(
                                  mode: LaunchMode.externalApplication,
                                  Uri(
                                    scheme: 'http',
                                    path: _aboutUsController
                                        .aboutUsList[index].linkedIn,
                                  ),
                                );
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                const Image(
                                  image: AssetImage(
                                    'assets/images/logo/linkedin.png',
                                  ),
                                  height: 25,
                                  width: 25,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(
                                  'LinkedIn'.tr,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder<void>(
                            future: _launched,
                            builder: _launchStatus,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
