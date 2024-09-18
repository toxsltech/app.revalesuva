/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../export.dart';
import '../../../core/values/validator.dart';

class LoginScreen extends GetView<LoginController> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: _body(context)),
    );
  }

  _body(context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  iconBackGround,
                ),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: AssetImageWidget(
                  imageUrl: iconLogo,
                  imageHeight: height_100,
                )).marginSymmetric(vertical: margin_50),
            /*TextView(text: keyWelcomeSatiety.tr,
              textStyle: textStyleHeading().copyWith(
                  fontSize: font_25),

            ).marginSymmetric(horizontal: margin_40) ,*/
            SizedBox(
              height: height_30,
            ),
            _form(),
            _forgotPassword(),
            _loginButton(context),
          ],
        ).marginSymmetric(horizontal: margin_15),
      ),
    );
  }

  _forgotPassword() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.forgotPassword);
      },
      child: TextView(
        text: keyForgotPassword.tr,
        textStyle: textStyleBody1().copyWith(
          decoration: TextDecoration.underline,
          // decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 2,
          fontSize: font_13,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).marginOnly(bottom: margin_10, right: margin_5);
  }

  _loginButton(context) {
    return Align(
      alignment: Alignment.topLeft,
      child: MaterialButtonWidget(
        buttonRadius: radius_10,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyLogin.tr,
        textColor: Colors.black,
        buttonColor: buttonColor,
        onPressed: () async {
          if (formGlobalKey.currentState!.validate()) {
            controller.result = await controller.connectivity.checkConnectivity();
            if (controller.result == ConnectivityResult.none) {
              toast(
                keyNoInternet.tr,
              );
            } else {
              controller.hitLoginAPI();
            }
          }
          // Get.toNamed(AppRoutes.alreadyKnowScreen);
        },
      ),
    );
  }

  _form() {
    return Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              TextFieldWidget(
                shadow: true,
                //color: Colors.grey.shade300,
                radius: radius_10,
                hint: keyEmail.tr,
                suffixIcon: InkWell(
                  child: Icon(
                    Icons.visibility,
                    color: Colors.transparent,
                  ),
                ),
                hintStyle: textStyleBody2(),
                contentPadding: EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
                textController: controller.nameController,
                inputAction: TextInputAction.next,
                inputType: TextInputType.text,
                validate: (value) => Validator.validateEmail(value),
              ).marginOnly(bottom: margin_15, top: margin_15),
              Obx(
                () => TextFieldWidget(
                  obscureText: controller.viewPassword.value,
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.showOrHidePasswordVisibility();
                    },
                    child: Icon(
                      (controller.viewPassword.value == true) ? Icons.visibility_off_rounded : Icons.visibility,
                      color: (controller.viewPassword.value == true) ? Colors.grey : appColor,
                    ),
                  ),
                  shadow: true,
                  hintStyle: textStyleBody2(),
                  radius: radius_10,
                  textController: controller.passwordController,
                  hint: keyPassword.tr,
                  inputAction: TextInputAction.done,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value, message: keyPassword.tr),
                ),
              ),
            ]).marginSymmetric(vertical: margin_10))
        .marginOnly(top: margin_10, bottom: margin_5);
  }
}
