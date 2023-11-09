import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageLabelCardWidget extends StatelessWidget {
  final String routeName;
  final int typeId;
  final String image;
  final String label;
  const ImageLabelCardWidget({
    super.key,
    required this.routeName,
    required this.typeId,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          routeName,
          arguments: typeId,
        );
      },
      child: Container(
        height: AppSize.siConHeight + 10,
        width: AppSize.siConWidth,
        decoration: BoxDecoration(
          color: AppColor.primary,
          boxShadow: Constant.boxShadow,
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.rTen),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              height: AppSize.imForty,
              image: NetworkImage(
                Secret.baseURL + image,
              ),
            ),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSize.fTwelve,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
