

import 'home_routes.dart';
import 'splash_routes.dart';
import 'sign_in_routes.dart';
import 'sign_up_routes.dart';
import 'custom_navigation_bar_routes.dart';
import 'product_details_routes.dart';
import 'product_routes.dart';
import 'cart_routes.dart';
import 'more_routes.dart';
import 'profile_routes.dart';
import 'order_history_routes.dart';
import 'about_us_routes.dart';
import 'terms_conditions_routes.dart';
import 'complete_profile_routes.dart';
import 'checkout_routes.dart';
import 'news_routes.dart';
import 'verification_routes.dart';
import 'forgot_password_routes.dart';
import 'refer_routes.dart';
import 'update_password_routes.dart';
import 'order_placed_routes.dart';
import 'bkash_payment_routes.dart';

class AppPages {
  AppPages._();

  static const initial = '/splash';

  static final routes = [
    ...UpdatePasswordRoutes.routes,
    ...HomeRoutes.routes,
    ...ReferRoutes.routes,
    ...SplashRoutes.routes,
    ...SignInRoutes.routes,
    ...VerificationRoutes.routes,
    ...NewsRoutes.routes,
    ...SignUpRoutes.routes,
    ...CustomNavigationBarRoutes.routes,
    ...CheckoutRoutes.routes,
    ...ProductDetailsRoutes.routes,
    ...ProductRoutes.routes,
    ...ForgotPasswordRoutes.routes,
    ...CartRoutes.routes,
    ...MoreRoutes.routes,
    ...ProfileRoutes.routes,
    ...OrderPlacedRoutes.routes,
    ...OrderHistoryRoutes.routes,
    ...TermsConditionsRoutes.routes,
    ...AboutUsRoutes.routes,
    ...CompleteProfileRoutes.routes,
    ...BkashPaymentRoutes.routes,
  ];
}
