import 'package:health_fitness/app/modules/drawer/controller/myPlanController/the_gate_controller.dart';

import '../../../../../export.dart';
import '../../../../core/widgets/network_image.dart';

class TheGateScreen extends GetView<TheGateController> {
  final TheGateController controller =
      Get.put<TheGateController>(TheGateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: _bodyWidget(),
    );
  }

  _bodyWidget() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    iconBackGround1,
                  ),
                  fit: BoxFit.fill),
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
                    text: keyInformation.tr,
                    textStyle: textStyleBody1().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextFieldWidget(
                    shadow: true,
                    //color: Colors.grey.shade300,
                    radius: radius_10,
                    hint: keyFreeText.tr,
                    onChange: (value) {
                      controller.searchController.text = value;
                      controller.getVideoLesson(
                        controller.searchController.text.trim(),
                      );
                      controller.update();
                    },
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.black,
                    ),
                    hintStyle: textStyleBody2(),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: margin_8, horizontal: margin_15),
                    textController: controller.searchController,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                    // validate: (value) => Validator.validateEmail(value),
                  ).marginOnly(bottom: margin_5, top: margin_15),
                  Obx(
                    () => controller.isLoading.value
                        ? Container(
                            height: Get.height * 0.5,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: greenColor,
                              ),
                            ),
                          )
                        : controller.videoList.value.isNotEmpty
                            ? ListView.builder(
                                controller: controller.scrollController,
                                primary: false,
                                shrinkWrap: true,
                                reverse: false,
                                itemBuilder: (context, index) {
                                  return _lessonVideo2(
                                    title: removeAllHtmlTags(controller.videoList[index].title!),
                                    status: controller.videoList[index].title,
                                    // image: controller.videoList[index].image,
                                    description: controller
                                                .videoList[index].isLock ==
                                            true
                                        // ? "To watch the video, you need to complete the viewing of the previous video."
                                        ? "כדי לצפות בסרטון, עליך להשלים את הצפייה בסרטון הקודם"
                                        : controller.videoList[index].review!
                                                    .remainingTime ==
                                                "0"
                                            ?keyView.tr
                                            : controller.videoList[index]
                                                .review!.remainingTime,
                                    summary: removeAllHtmlTags(
                                      controller.videoList[index].description!,
                                    ),
                                    // video: controller.lessonVideos[index].video,
                                    expanded:
                                        controller.videoList[index].expanded,
                                    // summaryImage: controller.lessonVideos[index].summaryImage,
                                    index: index,
                                  );
                                },
                                itemCount: controller.videoList.value.length,
                              )
                            : Container(
                                height: Get.height * 0.7,
                                child: noDataToShow(
                      inputText: "לא נמצא מידע"),
                      //           inputText: "No information found"),
                              ),
                  ),
                ],
              ).paddingAll(margin_12).marginSymmetric(vertical: margin_15),
            ),
          ),
          GetBuilder<TheGateController>(
              builder: (TheGateController controllers) {
            return controller.videoListResponseModel.meta != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: keyPreviousPage.tr,
                        textStyle: textStyleBody1().copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                          decorationColor: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.videoListResponseModel.meta!
                                      .currentPage! <=
                                  controller.videoListResponseModel.meta!
                                      .pageCount! &&
                              controller.videoListResponseModel.meta!
                                      .currentPage! >
                                  1) {
                            controller.page--;
                            controller.getVideoLesson("");
                          }
                        },
                        child: Container(
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: buttonColor,
                            ),
                          ),
                          height: 25,
                          width: 22,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextView(
                        text: controller
                            .videoListResponseModel.meta!.currentPage
                            .toString(),
                        textStyle: textStyleBody1().copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller
                                  .videoListResponseModel.meta!.currentPage! <
                              controller
                                  .videoListResponseModel.meta!.pageCount!) {
                            controller.page++;
                            controller.getVideoLesson("");
                          }
                        },
                        child: Container(
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          height: 25,
                          width: 22,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextView(
                        text: keyNextPage.tr,
                        textStyle: textStyleBody1().copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                          decorationColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: margin_20)
                : emptySizeBox();
          }),
        ],
      );

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  _lessonVideo2({
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
    return Column(
      children: [
        Container(
          height: 50,
          padding: EdgeInsets.only(
            right: margin_10,
          ),
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
                child:
                TextView(
                  text: controller.videoList.value[index].title!,
                  maxLine: 2,
                  textStyle: textStyleBodyLarge().copyWith(
                    color: Colors.black,
                  ),
                ),
              ).marginOnly(right: margin_0),
              InkWell(
                onTap: () {
                  if (index == 0) {
                    Get.toNamed(
                      AppRoutes.videoPlayerScreen,
                      arguments: {
                        "videoLink":
                            controller.videoList.value[index].videoFile,
                        "videoId": controller.videoList.value[index].id,
                        "stateId": controller.videoList.value[index].review !=
                                null
                            ? controller.videoList.value[index].review!.stateId
                            : 2,
                        "startTime":
                            controller.videoList.value[index].review != null
                                ? controller
                                    .videoList.value[index].review!.startTime
                                : 0,
                        "endTime": controller.videoList.value[index].review !=
                                null
                            ? controller.videoList.value[index].review!.endTime
                            : 0,
                      },
                    );
                  } else {
                    if (controller.videoList[index - 1].isLock == false) {
                      Get.toNamed(
                        AppRoutes.videoPlayerScreen,
                        arguments: {
                          "videoLink":
                              controller.videoList.value[index].videoFile,
                          "videoId": controller.videoList.value[index].id,
                          "stateId":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.stateId
                                  : 2,
                          "startTime":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.startTime
                                  : 0,
                          "endTime":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.endTime
                                  : 0,
                        },
                      );
                    } else {
                      toast(
                          "כדי לצפות בסרטון, עליך להשלים את הצפייה בסרטון הקודם");
                          // "To watch the video, you need to complete the viewing of the previous video.");
                    }
                  }
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
                  child: /*index == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextView(
                              text: "View ",
                              textStyle: textStyleBodyMedium().copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.play_circle_outline,
                              size: 25,
                            ),
                          ],
                        )
                      : controller.videoList.value[index - 1].isLock == false
                          ?*/
                      Row(
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
                  /*: Icon(
                              Icons.lock,
                              size: 25,
                            ),*/
                ),
              ),
            ],
          ),
        ).paddingAll(
          margin_5,
        ),
      ],
    );
  }

  _lessonVideo({
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
    return Column(
      children: [
        Container(
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
                            controller.videoList.value[index].thumbnailFile ??
                                "",
                        imageHeight: height_100,
                        imageWidth: height_100,
                        radiusAll: radius_8,
                        imageFitType: BoxFit.cover,
                      ),
                      InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.toNamed(
                              AppRoutes.videoPlayerScreen,
                              arguments: {
                                "videoLink":
                                    controller.videoList.value[index].videoFile,
                                "videoId": controller.videoList.value[index].id,
                                "stateId":
                                    controller.videoList.value[index].review !=
                                            null
                                        ? controller.videoList.value[index]
                                            .review!.stateId
                                        : 2,
                                "startTime":
                                    controller.videoList.value[index].review !=
                                            null
                                        ? controller.videoList.value[index]
                                            .review!.startTime
                                        : 0,
                                "endTime":
                                    controller.videoList.value[index].review !=
                                            null
                                        ? controller.videoList.value[index]
                                            .review!.endTime
                                        : 0,
                              },
                            );
                          } else {
                            if (controller.videoList[index - 1].isLock ==
                                false) {
                              Get.toNamed(
                                AppRoutes.videoPlayerScreen,
                                arguments: {
                                  "videoLink": controller
                                      .videoList.value[index].videoFile,
                                  "videoId":
                                      controller.videoList.value[index].id,
                                  "stateId": controller
                                              .videoList.value[index].review !=
                                          null
                                      ? controller.videoList.value[index]
                                          .review!.stateId
                                      : 2,
                                  "startTime": controller
                                              .videoList.value[index].review !=
                                          null
                                      ? controller.videoList.value[index]
                                          .review!.startTime
                                      : 0,
                                  "endTime": controller
                                              .videoList.value[index].review !=
                                          null
                                      ? controller.videoList.value[index]
                                          .review!.endTime
                                      : 0,
                                },
                              );
                            }
                          }
                        },
                        child: Container(
                          height: height_100,
                          width: height_100,
                          padding: EdgeInsets.all(
                            margin_20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(
                              radius_8,
                            ),
                          ),
                          child: AssetImageWidget(
                            imageUrl: index == 0
                                ? playIcon
                                : controller.videoList.value[index - 1]
                                            .isLock ==
                                        false
                                    ? playIcon
                                    : lockIcon,

                            // controller.videoList.value[index].review != null
                            //         ? controller.videoList.value[index].review!
                            //                     .stateId ==
                            //                 0
                            //             ? lockIcon
                            //             : playIcon
                            //         : lockIcon,
                          ),
                        ),
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
                            text: controller.videoList.value[index].title ?? "",
                            maxLine: 1,
                            textStyle: textStyleBodyLarge().copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                            thickness: 2,
                          ),
                          TextView(
                            text: description ?? "",
                            maxLine: 3,
                            textStyle: textStyleBodyLarge().copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: font_10point5,
                            ),
                          ),
                          Spacer(),
                          if (controller.lessonVideos[0].status != 0)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.videoList.value[index].expanded =
                                        !controller
                                            .videoList.value[index].expanded!;
                                    controller.videoList.refresh();
                                  },
                                  child: TextView(
                                    textAlign: TextAlign.start,
                                    text: "Lesson Summary",
                                    textStyle: textStyleBodyLarge().copyWith(
                                      color: appGreenColor,
                                      fontSize: font_15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                (expanded != true)
                                    ? AssetImageWidget(
                                        imageUrl: downIcon,
                                        imageHeight: height_20,
                                        imageWidth: height_20,
                                      )
                                    : RotatedBox(
                                        quarterTurns: 2,
                                        child: AssetImageWidget(
                                          imageUrl: downIcon,
                                          imageHeight: height_20,
                                          imageWidth: height_20,
                                        ),
                                      ),
                              ],
                            ),
                        ],
                      ).paddingOnly(
                        left: margin_4,
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
        Container(
          height: 50,
          padding: EdgeInsets.only(left: margin_10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_15,
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: controller.videoList.value[index].title!,
                textStyle: textStyleBodyLarge().copyWith(
                  color: Colors.black,
                ),
              ),
              InkWell(
                onTap: () {
                  if (index == 0) {
                    Get.toNamed(
                      AppRoutes.videoPlayerScreen,
                      arguments: {
                        "videoLink":
                            controller.videoList.value[index].videoFile,
                        "videoId": controller.videoList.value[index].id,
                        "stateId": controller.videoList.value[index].review !=
                                null
                            ? controller.videoList.value[index].review!.stateId
                            : 2,
                        "startTime":
                            controller.videoList.value[index].review != null
                                ? controller
                                    .videoList.value[index].review!.startTime
                                : 0,
                        "endTime": controller.videoList.value[index].review !=
                                null
                            ? controller.videoList.value[index].review!.endTime
                            : 0,
                      },
                    );
                  } else {
                    if (controller.videoList[index - 1].isLock == false) {
                      Get.toNamed(
                        AppRoutes.videoPlayerScreen,
                        arguments: {
                          "videoLink":
                              controller.videoList.value[index].videoFile,
                          "videoId": controller.videoList.value[index].id,
                          "stateId":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.stateId
                                  : 2,
                          "startTime":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.startTime
                                  : 0,
                          "endTime":
                              controller.videoList.value[index].review != null
                                  ? controller
                                      .videoList.value[index].review!.endTime
                                  : 0,
                        },
                      );
                    }
                  }
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius_15),
                      bottomRight: Radius.circular(radius_15),
                    ),
                    color: buttonColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: "View ",
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
      ],
    );
  }
}
