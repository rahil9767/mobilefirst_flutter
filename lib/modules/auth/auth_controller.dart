import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobilefirst_flutter/api/api.dart';
import 'package:mobilefirst_flutter/models/models.dart';
import 'package:mobilefirst_flutter/routes/app_pages.dart';
import 'package:mobilefirst_flutter/shared/shared.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
List<String> scopes = <String>[
  'rahil9767@gmail.com',
  'https://www.googleapis.com/auth/contacts.readonly',
];



class AuthController extends GetxController {
  final ApiRepository apiRepository;
  AuthController({required this.apiRepository});
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  final prefs = Get.find<SharedPreferences>();
  //by this variable we are saving the values that Google account contains
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  @override
  void onInit() {


    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
  }
  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) {
        print("USERNAME");
        prefs.setString("name", "${value?.displayName}");
        prefs.setString("email", "${value?.email}");
        print(value?.displayName);
        print(value?.email);
        Get.toNamed(Routes.HOME);

      });
    } catch (error) {
      print("ERRRRPPPPPRRR");
      print(error);
    }
  }

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);

      _isAuthorized = isAuthorized;

    if (isAuthorized) {
      // _handleGetContact(_currentUser!);
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();
  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      if (!registerTermsChecked) {
        CommonWidget.toast('Please check the terms first.');
        return;
      }

      final res = await apiRepository.register(
        RegisterRequest(
          email: registerEmailController.text,
          password: registerPasswordController.text,
        ),
      );


      if (res!.token.isNotEmpty) {
        prefs.setString(StorageConstants.token, res.token);
        print('Go to Home screen>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      }
    }
  }


  // login(BuildContext context) async {
  //   googleAccount.value = await _googleSignin.signIn();
  //   Get.toNamed(Routes.HOME);
  // }
  //
  // logout() async {
  //   googleAccount.value = await _googleSignin.signOut();
  // }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
