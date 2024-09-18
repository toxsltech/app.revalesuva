import 'package:health_fitness/app/modules/drawer/controller/personal_profile_controller.dart';

import '../../../../export.dart';

class PersonalProfileScreen extends GetView<PersonalProfileController> {
  const PersonalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(radius_5))),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: height_22,
                        ),
                      ).marginOnly(right: margin_10)),
                  TextView(
                    text: keyBackToPersonalArea.tr,
                    textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: font_12,
                    ),
                  ).marginOnly(right: margin_10)
                ],
              ).marginOnly(bottom: margin_10),
              TextView(
                text: keyPersonalProfile.tr,
                textStyle: textStyleBody1(),
              ).marginOnly(bottom: margin_10),
              SizedBox(
                height: height_50,
              ),
              _customRow(
                  onTap: () {
                    Get.toNamed(AppRoutes.contactDataScreen);
                  },
                  text: keyGeneralInFoAndContData.tr),
              _customRow(
                text: keyBodyDataAndMedicalInfo.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.bodyAndMedicalScreen);
                },
              ),
              // _customRow(
              //   text: keyBodyDataAndMedicalInfo.tr,
              //   onTap: () {
              //     Get.toNamed(AppRoutes.body);
              //   },
              // ),
            ],
          ).paddingAll(margin_12).marginSymmetric(vertical: margin_20),
        ),
      ),
    );
  }

  _customRow({text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: margin_10, right: margin_10),
        margin: EdgeInsets.symmetric(vertical: margin_6),
        height: height_50,
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
