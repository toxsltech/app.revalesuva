/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:simple_html_css/simple_html_css.dart';

import '../../../../export.dart';
import '../controllers/static_page_controller.dart';

class StaticPageScreen extends GetView<StaticPageController> {
  StaticPageScreen({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(StaticPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
      // init: StaticPageController(),
      builder: (controllers) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: backGroundColor2,
            // appBar: CustomAppBar(appBarTitleText: controller.title ?? ""),
            body: controller.isLoadingPage
                ? Center(
                    child: CircularProgressIndicator(
                      color: greenColor,
                    ),
                  )
                : Container(
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
                              text: keyBack.tr,
                              textStyle: textStyleBodyMedium().copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ).marginOnly(
                              right: margin_10,
                            ),
                          ],
                        ).marginOnly(
                            bottom: margin_10,
                            right: margin_10,
                            top: margin_10),
                        controller.staticPageResponseModel.detail != null
                            ? Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: HTML.toTextSpan(
                                        defaultTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        context,
                                        controller.staticPageResponseModel
                                                .detail!.title!
                                                .trim() ??
                                            "",
                                        linksCallback: (dynamic link) {
                                          launchUrl(
                                            Uri.parse(link),
                                          );
                                        },
                                      ),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: HTML.toTextSpan(
                                        defaultTextStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        context,
                                        controller.staticPageResponseModel
                                                .detail!.description ??
                                            "",
                                        linksCallback: (dynamic link) {
                                          launchUrl(Uri.parse(link));
                                        },
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(
                                    top: margin_80,
                                    left: margin_10,
                                    right: margin_10,
                                    bottom: margin_5),
                              )
                            : Container(
                                height: Get.height * 0.8,
                                child: noDataToShow(inputText: keyNoData.tr)),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
