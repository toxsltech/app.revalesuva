import 'package:health_fitness/app/modules/drawer/controller/myPlanController/my_plan_controller.dart';

import '../../../../../export.dart';

class MyPlanScreen extends GetView<MyPlanController> {
  MyPlanScreen({super.key});
  final controller = Get.put(MyPlanController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPlanController>(init: MyPlanController(),builder: (controllers) {
      return Scaffold(
        backgroundColor: backGroundColor,
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  iconBackGround1,
                ),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*controller.check != ""
                  ?*/
              customBackWidget(title: keyBackToPersonalArea.tr)
                  /*: emptySizeBox()*/,
              SizedBox(
                height: height_80,
              ),
              TextView(
                text: keyMyPlan.tr,
                textStyle: textStyleBody1().copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              _customRow(
                  onTap: () {
                    Get.toNamed(AppRoutes.theGateRoute);
                  },
                  text: keyInformation.tr),
              _customRow(
                text: keyIceMedicine.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.iceMedicineScreen);
                },
              ),
            ],
          ).paddingAll(margin_12).marginSymmetric(vertical: margin_20),
        ),
      );
    });
  }

  _customRow({text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: margin_10, right: margin_10),
        margin: EdgeInsets.symmetric(vertical: margin_6),
        height: height_40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(radius_8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
                text: text,
                textStyle: textStyleBodyMedium().copyWith(fontSize: font_13)),
            Icon(
              Icons.arrow_forward_ios,
              size: font_15,
            )
          ],
        ),
      ),
    );
  }
}
