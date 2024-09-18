import '../../../../export.dart';
import '../controller/star_controller.dart';

class StarScreen extends GetView<StarController> {
  StarScreen({super.key});

  // final controller = Get.put(StarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  ).marginOnly(right: margin_10, left: margin_10),
                ),
                /*TextView(
                  text: 'Back'.tr,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),*/
              ],
            ).marginOnly(top: margin_10),
            AssetImageWidget(
              imageUrl: iconStar,
            ).marginOnly(top: margin_80, left: margin_15, right: margin_15),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: margin_15, vertical: margin_20),
              height: height_40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius_10),
                  color: textBgColor),
              alignment: Alignment.center,
              child: TextView(
                textStyle: textStyleBodyLarge().copyWith(
                    color: starTextColor, fontWeight: FontWeight.w500),
                text: keyHowFarYouGain.tr,
              ),
            ),
            // _customRow(
            //     text: keyHowYouGetStar.tr,
            //     onTap: () {
            //       showDialog(
            //           context: Get.overlayContext!,
            //           builder: (context) {
            //             return Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Dialog(
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         borderRadius:
            //                             BorderRadius.circular(radius_10),
            //                         color: Colors.white),
            //                     alignment: Alignment.center,
            //                     child: Column(
            //                       children: [
            //                         Align(
            //                           alignment: Alignment.topRight,
            //                           child: GestureDetector(
            //                             onTap: () {
            //                               Get.back();
            //                             },
            //                             child: AssetImageWidget(
            //                               imageUrl: iconCancel,
            //                               imageHeight: height_25,
            //                               color: Colors.green,
            //                             ),
            //                           ),
            //                         ),
            //                         Stack(
            //                           alignment: Alignment.center,
            //                           children: [
            //                             AssetImageWidget(
            //                               imageUrl: iconDialogProfile,
            //                               imageHeight: height_110,
            //                             ),
            //                             Positioned(
            //                               top: margin_37,
            //                               child: CircleAvatar(
            //                                 radius: radius_40,
            //                                 child: AssetImageWidget(
            //                                   imageUrl: iconGirl,
            //                                   imageFitType: BoxFit.fill,
            //                                 ),
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                         TextView(
            //                             text: 'Well Done Queen!',
            //                             textStyle: textStyleBody1().copyWith(
            //                                 fontWeight: FontWeight.w600,
            //                                 fontSize: font_20)),
            //                         TextView(
            //                                 text:
            //                                     'You met your goal and got 5 stars',
            //                                 textStyle:
            //                                     textStyleBody1().copyWith())
            //                             .marginSymmetric(vertical: margin_10),
            //                         TextView(
            //                             text:
            //                                 'To view your successes click here',
            //                             textStyle: textStyleBody1().copyWith(
            //                               decoration: TextDecoration.underline,
            //                               decorationColor:
            //                                   Colors.green.shade800,
            //                               color: Colors.green.shade800,
            //                             )).marginOnly(bottom: margin_20),
            //                       ],
            //                     ).paddingAll(margin_10),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           });
            //     }),
            Obx(
              () => Expanded(
                child: controller.starList.value.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        itemCount: controller.starList.value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: margin_10, right: margin_10),
                            margin: EdgeInsets.symmetric(
                                vertical: margin_6, horizontal: margin_15),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ], borderRadius: BorderRadius.circular(radius_8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width * 0.8,
                                      child: TextView(
                                        text: controller
                                            .starList.value[index].question!,
                                        textStyle: textStyleBodyLarge()
                                            .copyWith(
                                                fontSize: font_13,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    // AssetImageWidget(
                                    //   imageUrl: iconAddWithoutCircle,
                                    //   imageHeight: height_15,
                                    //   color: Colors.green,
                                    // )
                                  ],
                                ),
                                TextView(
                                  text:
                                      controller.starList.value[index].answer!,
                                  maxLine: 1000,
                                  textStyle: textStyleBodyLarge().copyWith(
                                      fontSize: font_13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : noDataToShow(),
              ),
            )
            // _customRow(text: keyStarEquivalence.tr),
          ],
        ));
  }

  Widget _customRow({title, text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: margin_10, right: margin_10),
        margin: EdgeInsets.symmetric(vertical: margin_6, horizontal: margin_15),
        // height: height_50,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: title,
                  textStyle: textStyleBodyLarge()
                      .copyWith(fontSize: font_13, fontWeight: FontWeight.w500),
                ),
                AssetImageWidget(
                  imageUrl: iconAddWithoutCircle,
                  imageHeight: height_15,
                  color: Colors.green,
                )
              ],
            ),
            TextView(
              text: text,
              textStyle: textStyleBodyLarge().copyWith(
                  fontSize: font_13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
