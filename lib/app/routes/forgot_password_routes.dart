import 'package:get/get.dart';

import '../modules/forgot_password/forgot_password_binding.dart';
import '../modules/forgot_password/forgot_password_page.dart';

class ForgotPasswordRoutes {
  ForgotPasswordRoutes._();

  static const forgotPassword = '/forgot-password';

  static final routes = [
    GetPage(
      name: forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
