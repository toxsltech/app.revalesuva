import '../../../../export.dart';
import '../../../core/widgets/double_back_press.dart';
import '../controller/hadass_controller.dart';

class HadasScreen extends GetView<HadasController> {
  final controller = Get.put(HadasController());
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: _bodyWidget(),
        ),
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
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.back();
          //       },
          //       child: Container(
          //         padding: EdgeInsets.all(
          //           margin_2,
          //         ),
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius:
          //                 BorderRadius.all(Radius.circular(radius_5))),
          //         child: Icon(
          //           Icons.arrow_back,
          //           color: Colors.black,
          //           size: height_22,
          //         ),
          //       ).marginOnly(
          //         right: margin_10,
          //       ),
          //     ),
          //     TextView(
          //       text: keyBackToPersonalArea.tr,
          //       textStyle: textStyleBodyMedium().copyWith(
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // ).marginOnly(bottom: margin_10),
          TextView(
            text: keyHadasRein.tr,
            textStyle: textStyleBody1().copyWith(
              fontSize: font_18,
              fontWeight: FontWeight.w700,
            ),
          ).paddingOnly(top: margin_80, bottom: margin_15),
          _hadasServices(),
        ],
      ).paddingAll(
        margin_12,
      ),
    );
  }

  _hadasServices() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.contactList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (controller.contactList[index] == keyTorahPortion.tr) {
              Get.toNamed(AppRoutes.torahBookScreen);
            } else if (controller.contactList[index] == keyStrength.tr) {
              Get.toNamed(
                AppRoutes.strengthScreen,
              );
            } else {
              Get.toNamed(
                AppRoutes.meditationScreen,
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
                      imageUrl:
                          controller.contactList[index] == keyTorahPortion.tr
                              ? icon_book_torah2
                              : controller.contactList[index] == keyStrength.tr
                                  ? icon_dumbell
                                  : icon_yoga,
                      imageHeight: 20,
                    ).paddingOnly(right: margin_10),
                    TextView(
                      text: controller.contactList[index].toString(),
                      textStyle: textStyleBodyLarge().copyWith(
                        color: Colors.black,
                      ),
                    ).marginOnly(right: margin_10),
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
