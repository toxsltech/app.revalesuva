import '../../../../../export.dart';

class MySuccessesScreen extends GetView<MySuccessesController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: _body(),
      ),
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
      child: SingleChildScrollView(
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
                          Radius.circular(
                            radius_5,
                          ),
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
                    text: keyBackToTools.tr,
                    textStyle: textStyleBodyMedium().copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ).marginOnly(
                bottom: margin_10,
              ),
              TextView(
                text: keyMySuccesses.tr,
                textStyle: textStyleBody1().copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(
                top: margin_70,
                bottom: margin_20,
              ),
              _mySuccessesWeight(),
              _mySuccessesTo(),
            ],
          ).paddingAll(
            margin_12,
          ),
        ),
      ),
    );
  }

  _mySuccessesWeight() {
    return Container(
      padding: EdgeInsets.all(
        margin_10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius_10,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Weight",
            textStyle: textStyleBodyLarge().copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.mySuccessesWeight.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  AssetImageWidget(
                    imageUrl: (controller.mySuccessesWeight[index].status == false) ? iconUnselected : iconSelected,
                    imageWidth: height_20,
                    imageHeight: height_20,
                  ).paddingOnly(
                    right: margin_5,
                  ),
                  TextView(text: controller.mySuccessesWeight[index].title ?? "", textStyle: textStyleBodyMedium())
                ],
              ).paddingSymmetric(
                vertical: margin_5,
              );
            },
          ),
        ],
      ),
    ).paddingOnly(
      bottom: margin_10,
    );
  }

  _mySuccessesTo() {
    return Container(
      padding: EdgeInsets.all(
        margin_10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius_10,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "To",
            textStyle: textStyleBodyLarge().copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.mySuccessesTo.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  AssetImageWidget(
                    imageUrl: (controller.mySuccessesTo[index].status == false) ? iconUnselected : iconSelected,
                    imageWidth: height_20,
                    imageHeight: height_20,
                  ).paddingOnly(
                    right: margin_5,
                  ),
                  TextView(text: controller.mySuccessesTo[index].title ?? "", textStyle: textStyleBodyMedium())
                ],
              ).paddingSymmetric(
                vertical: margin_5,
              );
            },
          ),
        ],
      ),
    );
  }
}
