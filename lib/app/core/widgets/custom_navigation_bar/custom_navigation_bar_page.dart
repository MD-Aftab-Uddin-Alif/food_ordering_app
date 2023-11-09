import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/cart/cart_page.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/home/home_page.dart';
import 'package:ePolli/app/modules/more/more_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationBarPage extends StatefulWidget {
  static const String routeName = "/custom-navigation-bar";
  const CustomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBarPage> createState() =>
      _CustomNavigationBarPageState();
}

class _CustomNavigationBarPageState extends State<CustomNavigationBarPage> {
  int currentIndex = 0;
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  @override
  initState() {
    var passedIndex = Get.arguments;
    if (passedIndex != null) {
      currentIndex = passedIndex;
      passedIndex = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomePage(),
          CartPage(),
          MorePage(),
        ],
      ),
      // * Add a bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: "Home".tr,
            activeIcon: const Icon(Icons.home),
          ),
          // BottomNavigationBarItem(
          //   icon: const ImageIcon(
          //     AssetImage("assets/images/nav_bar/my_farms.png"),
          //   ),
          //   label: "My Farms".tr,
          //   activeIcon: const ImageIcon(
          //     AssetImage("assets/images/nav_bar/my_farms.png"),
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   icon: Badge(
          //     isLabelVisible: true,
          //     label: Obx(() {
          //       return Text(
          //         farmBookingController.farmBookingProjectList.length
          //             .toString(),
          //         style: TextStyle(
          //           color: AppColor.primary,
          //           fontSize: AppSize.fTwelve,
          //         ),
          //       );
          //     }),
          //     child: const ImageIcon(
          //       AssetImage("assets/images/nav_bar/booking.png"),
          //     ),
          //   ),
          //   label: "Farm Booking".tr,
          //   activeIcon: Badge(
          //     label: Obx(() {
          //       return Text(
          //         farmBookingController.farmBookingProjectList.length
          //             .toString(),
          //         style: TextStyle(
          //           color: AppColor.primary,
          //           fontSize: AppSize.fTwelve,
          //         ),
          //       );
          //     }),
          //     child: const ImageIcon(
          //       AssetImage("assets/images/nav_bar/booking.png"),
          //     ),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: true,
              label: Obx(() {
                return Text(
                  cartController.cartProductList.length.toString(),
                  style: TextStyle(
                    color: AppColor.wIcon,
                    fontSize: AppSize.fTwelve,
                  ),
                );
              }),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: AppSize.iTwentyFour,
                color: AppColor.wIcon,
              ),
            ),
            label: 'Cart', 
),

          BottomNavigationBarItem(
            icon: const Icon(Icons.more_vert_outlined),
            label: "More".tr,
            activeIcon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
