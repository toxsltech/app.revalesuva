/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/app/core/widgets/network_image.dart';

import '../../../../../export.dart';
import '../../../core/utils/image_picker_and_cropper.dart';
import '../../../core/widgets/image_picker_dialog.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  final ProfileController controller =
      Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  iconBackGround2,
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
                      ),
                    ),
                    TextView(
                      text: keyBackToHome.tr,
                      textStyle: textStyleBodyMedium().copyWith(
                          fontWeight: FontWeight.w600, fontSize: font_12),
                    ).marginOnly(right: margin_10)
                  ],
                ).marginOnly(top: margin_15, right: margin_10),
                _profileImage(),
                Container(
                  padding: EdgeInsets.all(margin_10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius_10),
                  ),
                  child: Obx(
                    () => ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.profileList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return listTile(
                          icon: controller.profileList[index].icon,
                          text: controller.profileList[index].title,
                          onTap: controller.profileList[index].onTap,
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
                ).marginSymmetric(horizontal: margin_15, vertical: margin_15)
              ],
            ),
          ),
        ),
      ),
    );
  }

  listTile({text, icon, onTap}) => InkWell(
        child: Container(
          padding: EdgeInsets.all(
            margin_5,
          ),
          child: Row(
            children: [
              AssetImageWidget(
                imageUrl: icon,
                imageHeight: height_25,
                imageWidth: height_25,
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
              Icon(
                Icons.arrow_forward_ios,
                size: font_15,
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
                              imageHeight: 100,
                              imageWidth: 100,
                              imageFitType: BoxFit.fill,
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
                          controller.updateImageFile(imageFromCamera(), 0);
                        },
                        title: "תמונת פרופיל",
                        // title: "Profile Image",
                      ));
                    },
                    splashRadius: radius_5,
                    style: IconButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.green.shade100),
                  ),
                ),
              ],
            ),
          ),
          TextView(
                  text: 'לערוך תמונה',
                  // text: 'Edit a photo',
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
