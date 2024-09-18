import '../../../../export.dart';
import '../controller/health_consumerism_controller.dart';

class HealthConsumerismHomePage
    extends GetView<HealthConsumerismHomeController> {
  HealthConsumerismHomePage({super.key});
  final controller = Get.put(HealthConsumerismHomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HealthConsumerismHomeController>(builder: (controllers) {
      return SafeArea(
        child: Scaffold(
          body: _body(),
        ),
      );
    });
  }

  _body() {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              iconBG,
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /*controller.check!=null?*/ Row(
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
                text: keyBackToHome.tr,
                textStyle: textStyleBodyMedium(),
              ).marginOnly(right: margin_10)
            ],
          ).marginOnly(
            bottom: margin_10,
            top: margin_15,
          )/*:emptySizeBox()*/,
          TextView(
                  text: keyShop.tr,
                  textStyle: textStyleBody1()
                      .copyWith(fontSize: font_18, fontWeight: FontWeight.w600))
              .marginOnly(
            top: margin_70,
          ),
          _customRow(
              onTap: () {
                Get.toNamed(AppRoutes.featuredProduct);
              },
              text: keyFeaturedProduct.tr),
          _customRow(
            text: keyRecipes.tr,
            onTap: () {
              Get.toNamed(AppRoutes.recipeScreen);
            },
          ),
        ],
      ).marginOnly(right: margin_15, left: margin_15),
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
