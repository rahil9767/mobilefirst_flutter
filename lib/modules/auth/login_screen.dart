import 'package:flutter/material.dart';
import 'package:mobilefirst_flutter/shared/shared.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends  GetView<AuthController>  {
  // final AuthController controller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonWidget.appBar(
            context,
            'Sign In',
            Icons.arrow_back,
            Colors.white,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
        ),
      ],
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            CommonWidget.rowHeight(),
            CommonWidget.rowHeight(height: 80),
            BorderButton(
              text: 'Sign In',
              backgroundColor: Colors.white,
              onPressed: () {
                controller.handleSignIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
