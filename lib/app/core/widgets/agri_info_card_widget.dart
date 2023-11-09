import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';

class AgriInfoCardWidget extends StatelessWidget {
  final String imageLocation;
  final String number;
  final String name;
  const AgriInfoCardWidget({
    super.key,
    required this.imageLocation,
    required this.number,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final nameLength = name.split(' ').length;
    return Container(
      width: 60,
      margin: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            Secret.baseURL + imageLocation,
            height: AppSize.imThirtyFive,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              number,
              maxLines: 1,
              style: TextStyle(
                fontSize: AppSize.fFourteen,
                color: AppColor.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  // * show only before first word
                  name.split(' ')[0],
                  maxLines: 2,
                  style: TextStyle(fontSize: AppSize.fTen),
                ),
              ),
              Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    // * show only after first word
                    nameLength != 3
                        ? name.split(' ')[1]
                        : '${name.split(' ')[1]} ${name.split(' ')[2]}',
                    maxLines: 2,
                    style: TextStyle(fontSize: AppSize.fTen),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
