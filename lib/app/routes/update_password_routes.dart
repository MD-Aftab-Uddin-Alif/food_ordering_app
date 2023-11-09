import 'package:get/get.dart';

import '../modules/update_password/update_password_binding.dart';
import '../modules/update_password/update_password_page.dart';

class UpdatePasswordRoutes {
  UpdatePasswordRoutes._();

  static const updatePassword = '/update-password';

  static final routes = [
    GetPage(
      name: updatePassword,
      page: () => const UpdatePasswordPage(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}
