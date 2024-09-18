/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/principles_so_far/controller/principle_so_far_controller.dart';

import '../../../../../export.dart';
import '../../../core/utils/image_picker_and_cropper.dart';
import '../../../core/widgets/image_picker_dialog.dart';

class PrincipleScreen extends GetView<PrincipleController> {
  final controller = Get.put<PrincipleController>(PrincipleController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor2,
        body: Container(
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
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
                      ),
                    ).marginOnly(right: margin_10),
                    TextView(
                      text: keyBackToPersonalArea.tr,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600, fontSize: font_12),
                    ).marginOnly(right: margin_10)
                  ],
                ).marginOnly(top: margin_15, left: margin_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: "Principles learned so far".tr,
                      // text: "עקרונות שנלמדו עד כה".tr,
                      textStyle: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: font_13,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextView(
                        text: "To the puzzle of principles".tr,
                        // text: "לפאזל העקרונות".tr,
                        textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: font_12,
                        ),
                      ).marginAll(margin_10),
                    )
                  ],
                ).marginOnly(
                  top: margin_90,
                  left: margin_10,
                  right: margin_10,
                ),
                // _profileImage(),
                Obx(
                  () => InkWell(
                    onTap: () {
                      controller.allCheck.value = !controller.allCheck.value;
                      controller.allCheck.refresh();
                    },
                    child: Container(
                      // width: Get.width,
                      child: Row(
                        children: [
                          AssetImageWidget(
                            imageUrl: controller.allCheck.value
                                ? filterIcon
                                : colorFilterIcon2,
                            imageHeight: height_20,
                            imageWidth: height_20,
                          ).marginSymmetric(horizontal: margin_5),
                          TextView(
                            text: controller.allCheck.value
                                // ? "הצג את כל העקרונות שלא יופעלו".tr
                                // : "ראה הכל",
                            ? "View all unfollowed principles".tr
                              : "See all",
                            textStyle: textStyleBodyMedium().copyWith(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                fontWeight: FontWeight.w400,
                                fontSize: font_12),
                          )
                        ],
                      ).marginOnly(
                        top: margin_20,
                        right: margin_10,
                      ),
                    ),
                  ),
                ),
                Container(
                        padding: EdgeInsets.all(margin_10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radius_10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextView(
                              text: "Completed 10/16".tr,
                              textStyle: textStyleBodyMedium().copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: font_12),
                            ).marginOnly(bottom: margin_10),
                            Obx(
                              () => ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.allCheck.value
                                    ? controller.checkList.length
                                    : controller.unCheckList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return controller.allCheck.value
                                      ? listTile(
                                          icon:
                                              controller.checkList[index].icon,
                                          text:
                                              controller.checkList[index].title,
                                          onTap:
                                              controller.checkList[index].onTap,
                                          check:
                                              controller.checkList[index].check,
                                          nextText: controller
                                                  .checkList[index].nextText ??
                                              "",
                                        )
                                      : listTile(
                                          icon: controller
                                              .unCheckList[index].icon,
                                          text: controller
                                              .unCheckList[index].title,
                                          onTap: controller
                                              .unCheckList[index].onTap,
                                          check: controller
                                              .unCheckList[index].check,
                                          nextText: controller
                                              .unCheckList[index].nextText,
                                        );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: textFieldColor,
                                    thickness: 1.3,
                                  );
                                },
                              ),
                            ),
                          ],
                        ))
                    .marginSymmetric(horizontal: margin_15, vertical: margin_15)
              ],
            ),
          ),
        ),
      ),
    );
  }

  listTile({text, icon, onTap, check, nextText}) => InkWell(
        child: Container(
          padding: EdgeInsets.all(
            margin_5,
          ),
          child: Row(
            children: [
              AssetImageWidget(
                // imageUrl: check == true ? squareCheckBox : squareUnCheckBox,
                imageUrl: icon,
                imageHeight: height_20,
                imageWidth: height_20,
              ).marginSymmetric(horizontal: margin_5),
              Expanded(
                child: TextView(
                  textAlign: TextAlign.start,
                  text: text,
                  textStyle: textStyleBody2().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextView(
                textAlign: TextAlign.start,
                text: nextText,
                textStyle: textStyleBody2().copyWith(
                  fontSize: font_11,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: font_10,
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  _profileImage() {
    return Container(
      height: height_200,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //       graphBg1,
      //     ),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      width: Get.width,
      child: Column(
        children: [
          Obx(
            () => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                  radius: radius_50,
                  backgroundColor: Colors.grey.shade300,
                  child: controller.profileImage.value.isNotEmpty
                      ? controller.profileImage.value.contains("http")
                          ? NetworkImageWidget(
                              imageurl: controller.profileImage.value,
                              placeHolder: iconProfile,
                              radiusAll: radius_50,
                              imageFitType: BoxFit.cover,
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(radius_50)),
                              // radius: radius_42,
                              // backgroundColor: Colors.grey.shade300,
                              child: Image.file(
                                File(controller.profileImage.value),
                                fit: BoxFit.fill,
                              ),
                            )
                      : AssetImageWidget(
                          imageUrl: iconProfile,
                          // imageHeight: 90,
                          radiusAll: radius_50,
                          // imageWidth: 90,
                          imageFitType: BoxFit.cover,
                        ),
                ).paddingAll(margin_20),
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: height_15,
                    ),
                    onPressed: () {
                      Get.bottomSheet(ImagePickerDialog(
                        galleryFunction: () {
                          Get.back();
                          controller.updateImageFile(imageFromGallery(), 0);
                        },
                        cameraFunction: () {
                          Get.back();
                          controller.updateImageFile(
                            imageFromCamera(),
                            0,
                          );
                        },
                        // title: "תמונת פרופיל",
                        title: "Profile Image",
                      ));
                    },
                    splashRadius: radius_5,
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.green.shade100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextView(
                  // text: 'לערוך תמונה',
                  text: 'Edit a photo',
                  textStyle: textStyleBodySmall().copyWith(
                      fontSize: font_13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white))
              .marginOnly(top: margin_5)
        ],
      ),
    );
  }
}

Widget doubleText(topText, bottomText) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: topText, maxLine: 1, textStyle: textStyleTitle())
            .marginOnly(bottom: margin_5),
        TextView(text: bottomText, textStyle: textStyleTitle(), maxLine: 1),
      ],
    );
