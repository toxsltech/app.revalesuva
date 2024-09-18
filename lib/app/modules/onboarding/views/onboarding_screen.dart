/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() => SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            PageView(
              onPageChanged: (value) {
                controller.onSwipePage(value);
              },
              controller: controller.controller,
              children: controller.listOfScreens,
            ),
            Positioned(
              top: height_25,
              right: width_10,
              // left: width_250,
              child: Obx(
                () => controller.selectedPageIndex.value == 2
                    ? emptySizeBox()
                    : TextButton(
                        onPressed: controller.moveToLoginRoute,
                        child: TextView(text: "Skip", textStyle: textStyleButton().copyWith(color: Colors.black, fontWeight: FontWeight.w500))),
              ),
            ),
          ],
        ),
      );

  _skipButton() => MaterialButtonWidget(
        onPressed: controller.moveToLoginRoute,
        // height: height_10,
        padding: margin_5,
        buttonRadius: radius_8,
        buttonText: 'strSkip',
      );
}
