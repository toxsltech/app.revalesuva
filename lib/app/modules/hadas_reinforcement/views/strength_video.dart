import '../../../../export.dart';
import '../controller/strength_controller.dart';

class StrengthScreen extends GetView<StrengthController> {
  final controller = Get.put(StrengthController());
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
                text: keyBackToHadas.tr,
                textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ).marginOnly(bottom: margin_10),
          TextView(
            text: keyStrength.tr,
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
      () => controller.isLoading.value
          ? Container(
              height: Get.height * 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              ),
            )
          : controller.strengthVideoList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.strengthVideoList.length,
                  controller: controller.scrollController,
                  itemBuilder: (context, index) => Container(
                    height: 50,
                    padding: EdgeInsets.only(left: margin_0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        radius_15,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.6,
                          child: TextView(
                            text: controller.strengthVideoList[index].title
                                .toString(),
                            maxLine: 2,
                            textStyle: textStyleBodyLarge().copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ).marginOnly(right: margin_5),
                        InkWell(
                          onTap: () {
                            controller.initVideoPlayer(
                                controller.strengthVideoList[index].video!);
                            // controller.portionLists.value[i].expand =
                            //     !controller.portionLists.value[i].expand;
                            controller.update();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radius_15),
                                bottomLeft: Radius.circular(radius_15),
                              ),
                              color: buttonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(
                                  text: keyView.tr,
                                  textStyle: textStyleBodyMedium().copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).paddingAll(
                    margin_5,
                  ),
                )
              : SizedBox(
                  height: Get.height * 0.5,
                  child: Center(
                    child: noDataToShow(inputText: "No Strength Video Found"),
                  ),
                ),
    );
  }
}