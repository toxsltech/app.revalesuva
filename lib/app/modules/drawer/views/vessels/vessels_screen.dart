import '../../../../../export.dart';
import '../../controller/vessels_controllers/vessels_controller.dart';

class VesselsScreen extends GetView<VesselsScreenController> {
  final VesselsScreenController controller =
      Get.put<VesselsScreenController>(VesselsScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        // appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  _appBar() {
    return CustomAppBar(
      bgColor: greenColor,
      leadingIcon: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(radius_5))),
        child: Icon(
          Icons.arrow_back,
          size: font_24,
        ),
      ).paddingOnly(top: margin_18, left: margin_10),
      appBarTitleText: keyBackToPersonalArea.tr,
      titleTextStyle: textStyleBody1(),
    );
  }

  _body() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            iconBG,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      margin_2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius_5),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: height_22,
                    ),
                  ).marginOnly(
                    right: margin_10,
                  ),
                ),
                TextView(
                  text: keyBackToPersonalArea.tr,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(
                  right: margin_10,
                ),
              ],
            ).marginOnly(
              bottom: margin_10,
            ),
            TextView(
              text: keyVessels.tr,
              textStyle: textStyleBody1().copyWith(
                fontWeight: FontWeight.w500,
              ),
            ).paddingOnly(top: margin_70),
            // (controller.planType.value == '3')
            /* ?*/ _customRow(
              // text: 'מחשבון ביוץ',
              text: keyOvulationCalculator.tr,
              onTap: () {
                Get.toNamed(AppRoutes.ovulationCalculatorScreen);
              },
            ),
            // : emptySizeBox(),
            // (controller.planType.value == '3')
            /*?*/ _customRow(
              // text: 'תכנון תזונה יומי',
              text: keyDailyPlanning.tr,
              onTap: () {
                Get.toNamed(AppRoutes.dailyNutritionScreen);
              },
            ),
            // : emptySizeBox(),
            _customRow(
              text: 'כתיבה אינטואיטיבית לעצמי',
              // text: 'Intuitive writing for myself',
              onTap: () {
                Get.toNamed(
                  AppRoutes.intuitiveWritingScreen,
                );
              },
            ),
            (controller.planType.value == '3' ||
                    controller.planType.value == '1')
                ? _customRow(
                    // text: 'My Successes',
                    text: 'ההצלחות שלי',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.mySuccessesRoute,
                      );
                    },
                  )
                : emptySizeBox(),
            // (controller.planType.value == '3')
            //     ?
            _customRow(
              // text: 'Fasting Calculator',
              text: 'מחשבון צום',
              onTap: () {
                Get.toNamed(
                  AppRoutes.fastingCalculatorScreen,
                );
              },
            ),
            // : emptySizeBox(),
            /*_customRow(
              // text: 'מידע תזונתי',
              text: 'Nutritional Information',
              onTap: () {},
            ),*/
          ],
        ).paddingAll(
          margin_12,
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
