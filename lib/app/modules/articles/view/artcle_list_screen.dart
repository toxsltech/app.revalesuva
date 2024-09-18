import 'package:flutter/cupertino.dart';
import 'package:health_fitness/app/modules/articles/controller/article_list_controller.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../../export.dart';
import '../../../core/widgets/network_image.dart';

class TheArticleScreen extends GetView<TheArticleController> {
  final TheArticleController controller = Get.put(TheArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(contexts) => Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              iconBackGround1,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customBackWidget(
                title: keyBack.tr,
              ),
              SizedBox(
                height: height_80,
              ),
              TextView(
                text: keyArticles.tr,
                textStyle: textStyleBody1().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: font_17,
                ),
              ).marginOnly(
                right: margin_5,
              ),
              Obx(
                () => controller.articleList.value.isNotEmpty
                    ? ListView.builder(
                        controller: controller.scrollController,
                        primary: false,
                        shrinkWrap: true,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return articleListWidget(
                            context: contexts,
                            title: controller.articleList[index].title,
                            // image: controller.articleList[index].image,
                            summary: removeAllHtmlTags(
                              controller.articleList[index].description!,
                            ),
                            index: index,
                          );
                        },
                        itemCount: controller.articleList.value.length,
                      )
                    : Container(
                        height: Get.height * 0.7,
                        child: noDataToShow(inputText: "לא נמצאו שיעורים"),
                        // child: noDataToShow(inputText: "No lessons found"),
                      ),
              ),
            ],
          ).paddingAll(margin_12).marginSymmetric(vertical: margin_20),
        ),
      );

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  articleListWidget({
    BuildContext? context,
    title,
    description,
    image,
    status,
    video,
    summary,
    summaryImage,
    expanded,
    index,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.sideDrawerIceMedicineScreen,
          arguments: {
            "id": controller.articleList.value[index].id,
          },
        );
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.only(right: margin_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius_15,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                        //    width: Get.width * 0.6,
                child: TextView(
                  text: controller.articleList.value[index].title.toString(),
                  maxLine: 1,
                  textStyle: textStyleBodyLarge().copyWith(
                    color: Colors.black,
                  ),
                ),
              ).marginOnly(right: margin_5),
            ),
            Container(
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
                    text: keyRead.tr,
                    textStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(" "),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ).paddingAll(
        margin_5,
      ),
    );
  }

  _lessonVideo({
    BuildContext? context,
    title,
    description,
    image,
    status,
    video,
    summary,
    summaryImage,
    expanded,
    index,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.sideDrawerIceMedicineScreen,
          arguments: {
            "id": controller.articleList.value[index].id,
          },
        );
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius_5,
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(
          margin_8,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    NetworkImageWidget(
                      imageurl:
                          controller.articleList.value[index].thumbnailFile ??
                              "",
                      imageHeight: height_100,
                      imageWidth: height_100,
                      radiusAll: radius_8,
                      imageFitType: BoxFit.cover,
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: height_100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: controller.articleList.value[index].title ?? "",
                          maxLine: 1,
                          textStyle: textStyleBodyLarge().copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: Colors.black12,
                          thickness: 2,
                        ),
                        /* TextView(
                          text:
                             summary ??
                                  "",
                          maxLine: 3,
                          textStyle: textStyleBodyLarge().copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: font_10point5,
                          ),
                        ),*/
                        RichText(
                          textAlign: TextAlign.start,
                          text: HTML.toTextSpan(
                            defaultTextStyle: textStyleBodyLarge().copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: font_9,
                            ),
                            context!,
                            controller.articleList[index].description!,
                            linksCallback: (dynamic link) {
                              launchUrl(
                                Uri.parse(link),
                              );
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ).paddingOnly(
                      right: margin_4,
                    ),
                  ),
                ),
              ],
            ),
            if (expanded == true)
              Column(
                children: [
                  TextView(
                    text: summary ?? "",
                    textStyle: textStyleBodyLarge().copyWith(
                      color: Colors.black54,
                      fontSize: font_12,
                    ),
                  ),
                  // AssetImageWidget(
                  //   imageUrl: demoImg ?? "",
                  //   imageHeight: Get.height * 0.3,
                  //   imageWidth: Get.width,
                  //   imageFitType: BoxFit.fitHeight,
                  // ),
                ],
              ).paddingAll(
                margin_5,
              ),
          ],
        ),
      ).paddingAll(
        margin_5,
      ),
    );
  }
}
