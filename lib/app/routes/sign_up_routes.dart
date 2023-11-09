import 'package:get/get.dart';

import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_page.dart';

class SignUpRoutes {
  SignUpRoutes._();

  static const signUp = '/sign-up';

  static final routes = [
    GetPage(
      name: signUp,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
  ];
}
