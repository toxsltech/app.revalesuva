import '../../../../export.dart';
import '../controller/regulation_controller.dart';

class RegulationScreen extends GetView<RegulationController> {
  final controller = Get.put(RegulationController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
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
                  padding: EdgeInsets.all(
                    margin_2,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(radius_5))),
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
                text: keyBackToHome.tr,
                textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(
                right: margin_10,
              ),
            ],
          ).marginOnly(bottom: margin_10),
          TextView(
            text: keyRegulation.tr,
            textStyle: textStyleBody1().copyWith(
              fontSize: font_18,
              fontWeight: FontWeight.w700,
            ),
          ).paddingOnly(top: margin_80, bottom: margin_15),
          _regulation(),
        ],
      ).paddingAll(
        margin_12,
      ),
    );
  }

  _regulation() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.contactList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (controller.contactList[index] == keyShip.tr) {
              Get.toNamed(
                AppRoutes.staticPageScreen,
                arguments: {
                  "title": keyShip.tr,
                  "pageType": TYPE_SHIPPING_RETURN_POLICY
                },
              );
            } else if (controller.contactList[index] == keyPrivacy.tr) {
              Get.toNamed(
                AppRoutes.staticPageScreen,
                arguments: {"title": keyPrivacy.tr, "pageType": TYPE_PRIVACY},
              );
            } else if (controller.contactList[index] == keyTermOfUse.tr) {
              Get.toNamed(
                AppRoutes.staticPageScreen,
                arguments: {
                  "title": keyTermOfUse.tr,
                  "pageType": TYPE_TERM_CONDITION
                },
              );
            } else {
              Get.toNamed(
                AppRoutes.staticPageScreen,
                arguments: {
                  "title": keyAccessibility.tr,
                  "pageType": TYPE_ACCESSIBILITY
                },
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(margin_10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius_15,
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AssetImageWidget(
                      imageUrl: controller.contactList[index] == keyShip.tr
                          ? icon_shipping
                          : controller.contactList[index] == keyPrivacy.tr
                              ? icon_privacy
                              : controller.contactList[index] == keyTermOfUse.tr
                                  ? icon_terms
                                  : icon_wheel,
                      imageHeight: 20,
                    ).paddingOnly(
                      right: margin_10,
                      left: margin_10,
                    ),
                    TextView(
                      text: controller.contactList[index].toString(),
                      textStyle: textStyleBodyLarge().copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: height_20,
                ).paddingOnly(
                  right: margin_10,
                ),
              ],
            ),
          ).paddingAll(
            margin_5,
          ),
        ),
      ),
    );
  }
}
