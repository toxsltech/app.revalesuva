/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';

class ForgetScreen extends GetView<LoginController> {
  final formGlobalKey = GlobalKey<FormState>();
  final forgetController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(),
        body: GetBuilder<LoginController>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        iconBackGround1,
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(radius_5))),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: height_22,
                            ),
                          ).marginOnly(right: margin_10)),
                      TextView(
                        text: keyBackToLoginScreen.tr,
                        textStyle: textStyleBodyMedium().copyWith(
                            fontWeight: FontWeight.w600, fontSize: font_12),
                      )
                    ],
                  ).marginOnly(bottom: margin_10),
                  Padding(
                    padding: EdgeInsets.all(margin_10),
                    // padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextView(
                                text: keyForgotPass.tr,
                                textStyle: textStyleTitle())
                            .marginOnly(bottom: margin_15, top: margin_30),
                        TextView(
                                text: keyReset.tr,
                                maxLine: 2,
                                textAlign: TextAlign.center,
                                textStyle: textStyleTitle())
                            .marginOnly(bottom: margin_30),
                        Form(
                          key: formGlobalKey,
                          child: TextFieldWidget(
                            radius: radius_12,
                            textController: controller.forgetEmailController,
                            hint: keyEmail.tr,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: margin_8, horizontal: margin_15),
                            focusNode: controller.forgetEmailFocusNode,
                            validate: (value) {
                              if (value!.isEmpty)
                                return keyEnterEmail.tr;
                              else if (value.length > 0 &&
                                  !GetUtils.isEmail(value))
                                return keyEnterValidEmail.tr;
                              else
                                return null;
                            },
                          ),
                        ).marginOnly(bottom: margin_30),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButtonWidget(
                                buttonRadius: radius_20,
                                minWidth: Get.width * 0.25,
                                padding: margin_8,
                                buttonColor: buttonColor,
                                onPressed: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    controller.hitForgetAPI();
                                  }
                                },
                                buttonText: keySend.tr,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).marginOnly(top: margin_50),
                ],
              ).paddingAll(margin_12).marginOnly(top: margin_20),
            ),
          );
        }),
      ),
    );
  }
}
