import 'package:mobilefirst_flutter/modules/auth/auth.dart';
import 'package:mobilefirst_flutter/modules/home/home.dart';
import 'package:mobilefirst_flutter/modules/me/cards/cards_screen.dart';
import 'package:mobilefirst_flutter/modules/modules.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      // children: [
      //   GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
      //   GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
      // ],
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        children: [
          GetPage(name: Routes.CARDS, page: () => CardsScreen()),
        ]),
  ];
}
