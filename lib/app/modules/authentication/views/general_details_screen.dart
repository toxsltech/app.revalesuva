import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_fitness/app/core/utils/image_picker_and_cropper.dart';
import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../export.dart';
import '../../../core/values/validator.dart';
import '../../../core/widgets/image_picker_dialog.dart';
import '../controllers/general_details_controller.dart';

class GeneralDetailsScreen extends GetView<GeneralDetailController> {
  GeneralDetailsScreen({super.key});

  final generalFormGlobalKey = GlobalKey<FormState>();
  final bodyFormGlobalKey = GlobalKey<FormState>();

  // final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GeneralDetailController(),
      builder: (GetxController controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFF6EBDD),
            body: _body(),
          ),
        );
      },
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        // height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  iconBackGround2,
                ),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            _profileImage(),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_25), bottomRight: Radius.circular(radius_25))),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isBodyDetail.value == 0
                        ? _generalDetails()
                        : controller.queNumber.value == 1
                            ? _questionWidget()
                            : _bodyDetail(),
                    _buttons(),
                  ],
                ),
              ),
            ).marginSymmetric(horizontal: margin_15).marginOnly(top: margin_30, bottom: margin_10),
          ],
        ),
      ),
    );
  }

  _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(onTap: () {
          if (controller.queNumber.value == 1) {
            controller.queNumber.value = 0;
            controller.isBodyDetail.value = 1;
          } else if (controller.isBodyDetail.value == 1) {
            controller.isBodyDetail.value = 0;
          } else {
            Get.back();
            // Get.toNamed(AppRoutes.alreadyKnowScreen);
          }
          print("que no ==> ${controller.queNumber.value} is body -->${controller.isBodyDetail.value}");
        }),
        CustomButton(
            check: controller.questionList.length == controller.selectedQueNo.value + 1 && controller.queNumber.value == 1 ? "checkFinish" : "",
            onTap: () {
              debugPrint("============>${controller.isBodyDetail.value}");
              debugPrint("============>${controller.queNumber.value}");
              debugPrint("============>${controller.selectedQueNo.value}");
              if (controller.isBodyDetail.value == 0) {
                if (generalFormGlobalKey.currentState!.validate()) {
                  controller.hitProfileSetUpApi();
                  controller.isBodyDetail.value = 1;
                }
              } else if (controller.isBodyDetail.value == 1 && controller.queNumber.value == 0) {
                if (bodyFormGlobalKey.currentState!.validate()) {
                  if (controller.frontImage.isEmpty) {
                    toast("נא להעלות תמונה קדמית");
                    // toast("Please upload front image");
                  } else if (controller.sideImage.isEmpty) {
                    toast("נא להעלות תמונת צד");
                    // toast("Please upload side image");
                  } else if (controller.backImage.isEmpty) {
                    toast("נא להעלות תמונה חזרה");
                    // toast("Please upload back image");
                  } else {
                    controller.hitProfileSetUpApi();
                    controller.queNumber.value = 1;
                  }
                }
              } else if (controller.questionList.length != controller.selectedQueNo.value + 1) {
                controller.selectedQue.value = controller.questionList[controller.selectedQueNo.value + 1].title!;
                controller.selectedQueNo.value = controller.selectedQueNo.value + 1;
                controller.answerController.clear();
                controller.update();
              } else if (controller.questionList.length == controller.selectedQueNo.value + 1) {
                controller.hitAddAnswerApi(
                    controller.questionList[controller.selectedQueNo.value].id.toString(), controller.answerController.text.trim(), controller.questionList[controller.selectedQueNo.value].typeId, 1);
                controller.hitCheckAPI();
              } else {
                controller.hitAddAnswerApi(
                    controller.questionList[controller.selectedQueNo.value].id.toString(), controller.answerController.text.trim(), controller.questionList[controller.selectedQueNo.value].typeId, 0);
                controller.hitCheckAPI();
              }
            }),
      ],
    ).marginSymmetric(horizontal: margin_15, vertical: margin_10);
  }

  _profileImage() {
    return Obx(() => Center(
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                CircleAvatar(
                  radius: radius_42,
                  backgroundColor: Colors.grey.shade300,
                  child: controller.profileImage.value.isNotEmpty
                      ? controller.profileImage.value.contains("http")
                          ? NetworkImageWidget(
                              imageurl: controller.profileImage.value,
                              placeHolder: iconProfile,
                              imageHeight: 90,
                              radiusAll: radius_42,
                              imageWidth: 90,
                              imageFitType: BoxFit.fill,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(radius_42)),
                              // radius: radius_42,
                              // backgroundColor: Colors.grey.shade300,
                              child: Image.file(
                                height: 90,
                                File(controller.profileImage.value),
                                fit: BoxFit.fill,
                              ),
                            )
                      : AssetImageWidget(
                          imageUrl: iconProfile,
                          imageHeight: 90,
                          radiusAll: radius_42,
                          imageWidth: 90,
                          imageFitType: BoxFit.fill,
                        ),
                ).paddingAll(margin_20),
                Positioned(
                    child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: font_15,
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
                  style: IconButton.styleFrom(foregroundColor: Colors.grey, backgroundColor: Colors.green.shade100),
                ))
              ]),
              TextView(text: keyInsertAPicture.tr, textStyle: textStyleBodySmall().copyWith(fontSize: font_15, fontWeight: FontWeight.w500, color: Colors.white))
                  .marginOnly(top: margin_5, bottom: margin_60)
            ],
          ),
        ));
  }

  _generalDetails() {
    return Form(
            key: generalFormGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "כמה פרטים כלליים:",
                  // text: "Some general details:",
                  textStyle: textStyleHeading().copyWith(fontSize: font_15),
                ),

                TextFieldWidget(
                  readOnly: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  shadow: true,
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  textController: controller.genderController,
                  hint: keyGender.tr,
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.text,
                  // validate: (value) => Validator.ValidateFields(value),
                ).marginOnly(bottom: margin_10, top: margin_15),
                TextFieldWidget(
                  shadow: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  maxLength: 30,
                  textController: controller.floorTxtController,
                  hint: keyFloor.tr,
                  onChange: (value) {
                    if (value == " ") {
                      controller.floorTxtController.text = "";
                    }
                  },
                  // inputFormatter: [
                  //   FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  // ],
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value, message: keyFloor.tr),
                ).marginOnly(
                  bottom: margin_10,
                ),
                TextFieldWidget(
                  shadow: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  maxLength: 30,
                  textController: controller.apartmentTxtController,
                  hint: keyApartment.tr,
                  onChange: (value) {
                    if (value == " ") {
                      controller.apartmentTxtController.text = "";
                    }
                  },
                  // inputFormatter: [
                  //   FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  // ],
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value, message: keyApartment.tr),
                ).marginOnly(
                  bottom: margin_10,
                ),
                TextFieldWidget(
                  shadow: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  maxLength: 30,
                  textController: controller.streetController,
                  hint: keyStreet.tr,
                  onChange: (value) {
                    if (value == " ") {
                      controller.streetController.text = "";
                    }
                  },
                  // inputFormatter: [
                  //   FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  // ],
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value, message: keyStreet.tr),
                ).marginOnly(
                  bottom: margin_10,
                ),
                TextFieldWidget(
                  shadow: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  // inputFormatter: [
                  //   FilteringTextInputFormatter.deny(RegExp('[ ]'))
                  // ],
                  onChange: (value) {
                    if (value == " ") {
                      controller.cityController.text = "";
                    }
                  },
                  maxLength: 20,
                  textController: controller.cityController,
                  hint: keyCity.tr,
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value, message: keyCity.tr),
                ),
                // TextFieldWidget(
                //   shadow: true,
                //   decoration: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(radius_20),
                //       borderSide: BorderSide(color: Colors.grey.shade400)),
                //   hintStyle: textStyleBodyMedium().copyWith(
                //       color: Colors.grey, fontWeight: FontWeight.w500),
                //   radius: radius_10,
                //   textController: controller.statusController,
                //   hint: keyStatus.tr,
                //   suffixIcon: Icon(
                //     Icons.keyboard_arrow_down_outlined,
                //     size: font_20,
                //   ),
                //   inputAction: TextInputAction.next,
                //   contentPadding: EdgeInsets.symmetric(
                //       vertical: margin_10, horizontal: margin_15),
                //   inputType: TextInputType.text,
                //   validate: (value) =>
                //       Validator.ValidateFields(value, message: keyStatus.tr),
                // ).marginSymmetric(vertical: margin_10),
                // TextFieldWidget(
                //   shadow: true,
                //   decoration: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(radius_20),
                //       borderSide: BorderSide(color: Colors.grey.shade400)),
                //   hintStyle: textStyleBodyMedium().copyWith(
                //       color: Colors.grey, fontWeight: FontWeight.w500),
                //   radius: radius_10,
                //   textController: controller.practiceController,
                //   hint: keyPractice.tr,
                //   // obscureText: controller.viewPassword.value,
                //   inputAction: TextInputAction.done,
                //   contentPadding: EdgeInsets.symmetric(
                //       vertical: margin_10, horizontal: margin_15),
                //   inputType: TextInputType.text,
                //   validate: (value) =>
                //       Validator.ValidateFields(value, message: keyPractice.tr),
                // ),
              ],
            ).marginSymmetric(vertical: margin_10, horizontal: margin_15))
        .marginOnly(bottom: margin_5);
  }

  _bodyDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bodyDetailForm(),
        _richText(),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(ImagePickerDialog(
                    galleryFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromGallery(), 1);
                    },
                    cameraFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromCamera(), 1);
                    },
                    title: "תמונה קדמית",
                    // title: "Front Image",
                  ));
                },
                child: Container(
                  // width: height_80,
                  // height: height_80,
                  child: DottedBorder(
                      dashPattern: [8, 2],
                      strokeWidth: radius_2,
                      color: Colors.grey.shade300,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(radius_12),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.frontImage.value.isNotEmpty
                                ? controller.frontImage.value.contains("http")
                                    ? NetworkImageWidget(
                                        imageurl: controller.frontImage.value,
                                        placeHolder: iconProfile,
                                        imageHeight: height_70,
                                        radiusAll: radius_12,
                                        imageWidth: height_70,
                                        imageFitType: BoxFit.fill,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(radius_12)),
                                        // radius: radius_42,
                                        // backgroundColor: Colors.grey.shade300,
                                        child: Image.file(
                                          height: height_75,
                                          File(controller.frontImage.value),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                : AssetImageWidget(
                                    imageUrl: iconImage,
                                    imageHeight: 90,
                                    imageWidth: 90,
                                    imageFitType: BoxFit.fill,
                                  ),
                            TextView(text: keyFront.tr, textStyle: textStyleBody2().copyWith())
                          ],
                        ),
                      )),
                ).marginSymmetric(horizontal: margin_8, vertical: margin_10),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(ImagePickerDialog(
                    galleryFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromGallery(), 2);
                    },
                    cameraFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromCamera(), 2);
                    },
                    title: "תמונת צד",
                    // title: "Side Image",
                  ));
                },
                child: Container(
                  //  width: height_80,
                  // height: height_80,
                  child: DottedBorder(
                      dashPattern: [8, 2],
                      strokeWidth: radius_2,
                      color: Colors.grey.shade300,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(radius_12),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.sideImage.value.isNotEmpty
                                ? controller.sideImage.value.contains("http")
                                    ? NetworkImageWidget(
                                        imageurl: controller.sideImage.value,
                                        placeHolder: iconProfile,
                                        imageHeight: height_80,
                                        radiusAll: radius_12,
                                        imageWidth: height_80,
                                        imageFitType: BoxFit.fill,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(radius_12)),
                                        // radius: radius_42,
                                        // backgroundColor: Colors.grey.shade300,
                                        child: Image.file(
                                          height: height_75,
                                          File(controller.sideImage.value),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                : AssetImageWidget(
                                    imageUrl: iconImage,
                                    imageHeight: 90,
                                    imageWidth: 90,
                                    imageFitType: BoxFit.fill,
                                  ),
                            TextView(text: keySide.tr, textStyle: textStyleBody2().copyWith())
                          ],
                        ),
                      )),
                ).marginSymmetric(horizontal: margin_5, vertical: margin_10),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(ImagePickerDialog(
                    galleryFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromGallery(), 3);
                    },
                    cameraFunction: () {
                      Get.back();
                      controller.updateImageFile(imageFromCamera(), 3);
                    },
                    title: "תמונה אחורה",
                    // title: "Back Image",
                  ));
                },
                child: Container(
                  //  width: height_80,
                  //  height: height_80,
                  child: DottedBorder(
                      dashPattern: [8, 2],
                      strokeWidth: radius_2,
                      color: Colors.grey.shade300,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(radius_12),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.backImage.value.isNotEmpty
                                ? controller.backImage.value.contains("http")
                                    ? NetworkImageWidget(
                                        imageurl: controller.backImage.value,
                                        placeHolder: iconProfile,
                                        imageHeight: height_80,
                                        radiusAll: radius_12,
                                        imageWidth: height_80,
                                        imageFitType: BoxFit.fill,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(radius_12)),
                                        // radius: radius_42,
                                        // backgroundColor: Colors.grey.shade300,
                                        child: Image.file(
                                          height: height_75,
                                          File(controller.backImage.value),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                : AssetImageWidget(
                                    imageUrl: iconImage,
                                    imageHeight: 90,
                                    imageWidth: 90,
                                    imageFitType: BoxFit.fill,
                                  ),
                            TextView(text: keyBack.tr, textStyle: textStyleBody2().copyWith())
                          ],
                        ),
                      )),
                ).marginSymmetric(horizontal: margin_5, vertical: margin_10),
              ),
            ),
          ],
        ).marginSymmetric(horizontal: margin_15).marginOnly(bottom: margin_10),
      ],
    );
  }

  _bodyDetailForm() {
    return Form(
            key: bodyFormGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  textAlign: TextAlign.start,
                  text: keyAddSomeBodyDetail.tr,
                  textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.w500),
                ).marginOnly(top: margin_15),
                TextFieldWidget(
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  shadow: true,
                  radius: radius_10,
                  hint: keyWeight.tr,
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  textController: controller.weightController,
                  inputAction: TextInputAction.next,
                  inputFormatter: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^0+'),
                    ),
                    // FilteringTextInputFormatter.digitsOnly,
                  ],
                  inputType: TextInputType.number,
                  maxLength: 5,
                  validate: (value) => Validator.ValidateFields(value, message: keyWeight.tr),
                ).marginOnly(bottom: margin_10, top: margin_15),
                TextFieldWidget(
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  shadow: true,
                  radius: radius_10,
                  hint: keyAge.tr,
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  textController: controller.ageController,
                  inputAction: TextInputAction.next,
                  inputFormatter: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^0+'),
                    ),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  inputType: TextInputType.number,
                  maxLength: 3,
                  validate: (value) => Validator.ValidateFields(value, message: keyAge.tr),
                ).marginOnly(bottom: margin_10, top: margin_0),
                TextFieldWidget(
                  shadow: true,
                  decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
                  hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
                  radius: radius_10,
                  textController: controller.heightController,
                  hint: keyHeight.tr,
                  maxLength: 5,
                  inputFormatter: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^0+'),
                    ),
                    // FilteringTextInputFormatter.digitsOnly,
                  ],
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.number,
                  validate: (value) => Validator.ValidateFields(value, message: keyHeight.tr),
                ),
                /*TextFieldWidget(
                  onTap: () {
                    controller.updateFile();
                  },
                  readOnly: true,
                  shadow: true,
                  decoration: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius_20),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  //color: Colors.grey.shade200,
                  hintStyle: textStyleBodyMedium().copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  radius: radius_10,
                  textController: controller.bloodTestController,
                  hint: keyRaisingBloodTests.tr,
                  suffixIcon: AssetImageWidget(
                    imageUrl: iconUpload.tr,
                    imageWidth: height_10,
                    imageHeight: height_10,
                  ).marginAll(margin_10),
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.emailAddress,
                  validate: (value) => Validator.ValidateFields(value,
                      message: keyRaisingBloodTests.tr),
                ).marginSymmetric(vertical: margin_10),*/
              ],
            ).marginSymmetric(horizontal: margin_15))
        .marginOnly(bottom: margin_5);
  }

  _richText() {
    return Column(
      children: [
        RichText(
          text: TextSpan(text: keyPictureBefore.tr, style: textStyleBodyMedium().copyWith(fontWeight: FontWeight.w600, fontSize: font_12), children: [
            TextSpan(text: keyExplanatory.tr, style: textStyleBodyMedium().copyWith(fontWeight: FontWeight.w600, fontSize: font_12)),
            TextSpan(
                text: keyVideoForPhotography.tr,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      surfaceTintColor: Colors.white,
                      child: Stack(alignment: Alignment.topRight, children: [
                        Container(
                          height: height_180,
                          color: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.play_circle_outline_outlined,
                              size: 90,
                              color: Colors.black,
                            ),
                          ),
                        ).paddingAll(margin_10),
                        Positioned(
                            top: 10,
                            right: radius_12,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.cancel,
                                size: font_35,
                                color: Colors.black,
                              ),
                            ))
                      ]),
                    ));
                  },
                style: textStyleBodyMedium().copyWith(fontWeight: FontWeight.bold, fontSize: font_12))
          ]),
        ).marginSymmetric(horizontal: margin_15),
        /*     Center(
          child: Divider(
            color: Colors.black,
            indent: Get.width * 0.35,
            endIndent: Get.width * 0.3,
            thickness: 1.2,
          ),
        )*/
      ],
    );
  }

  _borderContainer({title, type}) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(ImagePickerDialog(
          galleryFunction: () {
            Get.back();
            controller.updateImageFile(imageFromGallery(), type);
          },
          cameraFunction: () {
            Get.back();
            controller.updateImageFile(imageFromCamera(), type);
          },
          title: "תמונת פרופיל",
          // title: "Profile Image",
        ));
      },
      child: Container(
        width: height_80,
        height: height_80,
        child: DottedBorder(
            dashPattern: [8, 2],
            strokeWidth: radius_2,
            color: Colors.grey.shade300,
            borderType: BorderType.RRect,
            radius: Radius.circular(radius_12),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.frontImage.value.isNotEmpty
                      ? controller.frontImage.value.contains("http")
                          ? NetworkImageWidget(
                              imageurl: controller.frontImage.value,
                              placeHolder: iconProfile,
                              imageHeight: height_80,
                              radiusAll: radius_2,
                              imageWidth: height_80,
                              imageFitType: BoxFit.fill,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(radius_2)),
                              // radius: radius_42,
                              // backgroundColor: Colors.grey.shade300,
                              child: Image.file(
                                height: height_80,
                                File(controller.frontImage.value),
                                fit: BoxFit.fill,
                              ),
                            )
                      : AssetImageWidget(
                          imageUrl: iconImage,
                          imageHeight: 90,
                          imageWidth: 90,
                          imageFitType: BoxFit.fill,
                        ),
                  TextView(text: title, textStyle: textStyleBody2().copyWith())
                ],
              ),
            )),
      ).marginSymmetric(horizontal: margin_8, vertical: margin_10),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: keySomeMedicalIssues.tr, textStyle: textStyleBody2()),
        LinearPercentIndicator(
          width: Get.width * 0.80,
          padding: EdgeInsets.zero,
          lineHeight: height_6,
          percent: double.parse((((controller.selectedQueNo.value + 1) / controller.questionList.length)).toString()),
          barRadius: Radius.circular(radius_15),
          progressColor: Colors.orangeAccent,
        ).paddingOnly(top: margin_20, bottom: margin_5),
        TextView(
            text: "${controller.selectedQueNo.value + 1}שֶׁל   ${controller.questionList.value.length}",
            // "${controller.selectedQueNo.value + 1} of ${controller.questionList.value.length}",
            textStyle: textStyleBody2()),
        SizedBox(
          height: height_5,
        ),
        Obx(
          () => TextView(
              textAlign: TextAlign.start, text: controller.selectedQue.value, textStyle: textStyleBody2().copyWith(color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: font_12)),
        ),
        SizedBox(
          height: height_10,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomButton(
                onTap: () {
                  // controller.selectedButton.value = keyNo.tr;
                  controller.questionList[controller.selectedQueNo.value].typeId = 0;
                  debugPrint(controller.questionList[controller.selectedQueNo.value].typeId.toString());
                  controller.update();
                },
                isFiled: controller.questionList[controller.selectedQueNo.value].typeId == 0 ? true : false,
                title: keyNo.tr,
              )),
              SizedBox(
                width: width_15,
              ),
              Expanded(
                  child: CustomButton(
                      onTap: () {
                        controller.questionList[controller.selectedQueNo.value].typeId = 1;
                        debugPrint(controller.questionList[controller.selectedQueNo.value].typeId.toString());
                        controller.update();
                      },
                      isFiled: controller.questionList[controller.selectedQueNo.value].typeId == 1 ? true : false,
                      title: keyYes.tr)),
            ],
          ),
        ),
        SizedBox(
          height: height_20,
        ),
        Obx(
          () => Visibility(
            visible: controller.questionList[controller.selectedQueNo.value].typeId == 1,
            child: TextFieldWidget(
              color: Colors.grey.shade200,
              contentPadding: EdgeInsets.all(margin_7),
              radius: radius_5,
              hint: keyPrivate.tr,
              shadow: true,
              textController: controller.answerController,
              maxline: 5,
              minLine: 5,
              hintStyle: textStyleBody2().copyWith(color: Colors.black54),
              isOutlined: true,
            ),
          ),
        ),
      ],
    ).paddingAll(margin_15);
  }
}

Widget CustomButton({onTap, title, isFiled, check}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_10),
      decoration: BoxDecoration(
          color: isFiled == false ? Colors.white : Colors.black87, border: Border.all(color: isFiled == false ? Colors.black87 : Colors.white), borderRadius: BorderRadius.circular(radius_20)),
      child: TextView(
        text: title != null
            ? title
            : check == "checkFinish"
                ? '${keyFinish.tr}     >'
                : '${keyNext.tr}     >',
        textStyle: textStyleBody2().copyWith(color: isFiled == false ? Colors.black87 : Colors.white),
      ),
    ),
  );
}

Widget CustomTextButton({onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.arrow_back_ios,
          size: font_15,
        ),
        TextView(text: keyPreviousStage.tr, textStyle: textStyleBodyMedium().copyWith(fontSize: font_14)).marginOnly(left: margin_5),
      ],
    ),
  );
}
