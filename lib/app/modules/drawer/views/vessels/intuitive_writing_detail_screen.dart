import 'package:health_fitness/app/core/values/validator.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_detail_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../export.dart';

class IntuitiveWritingDetailScreen
    extends GetView<IntuitiveWritingDetailController> {
  const IntuitiveWritingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backGroundColor,
      body: _body(),
    ));
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
                  text: keyIntuitiveWriting.tr,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ).marginOnly(
              bottom: margin_10,
            ),
            Center(
              child: TextView(
                text:
                    "${DateFormat('dd MMMM yyyy').format(controller.intuitiveWritingController.intuitiveWritings[controller.index].createdOn!)}",
                textStyle: textStyleBodyLarge().copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingOnly(
                top: margin_70,
                bottom: margin_10,
              ),
            ),
            Container(
              padding: EdgeInsets.all(
                margin_10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  radius_5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.6,
                        child: TextView(
                          text: controller.intuitiveWritingController
                                  .intuitiveWritings[controller.index].title ??
                              "",
                          textStyle: textStyleBodyLarge().copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(_editIntuitiveWriting());
                            },
                            child: AssetImageWidget(
                              imageUrl: iconEdit,
                              imageHeight: height_40,
                              imageWidth: height_40,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.hitIntuitiveDeleteApiCall(
                                  id: controller.intuitiveWritingController
                                      .intuitiveWritings[controller.index].id);
                            },
                            child: AssetImageWidget(
                              imageUrl: iconDelete,
                              imageHeight: height_40,
                              imageWidth: height_40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: height_2,
                  ),
                  TextView(
                    text: controller.intuitiveWritingController
                            .intuitiveWritings[controller.index].description ??
                        "",
                    textStyle: textStyleBodyLarge().copyWith(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ).paddingAll(
          margin_12,
        ),
      ),
    );
  }

  _customRow({title, onTap, comment, time}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          margin_10,
        ),
        margin: EdgeInsets.symmetric(vertical: margin_6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius_8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: title,
                  textStyle: textStyleBodyLarge().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextView(
                  text: DateFormat('dd-MM-yyyy').format(time),
                  textStyle: textStyleBodyMedium().copyWith(
                    fontSize: font_13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            TextView(
              text: comment,
              textStyle: textStyleBodyMedium().copyWith(),
            ),
          ],
        ),
      ),
    );
  }

  _editIntuitiveWriting() {
    return Container(
      height: height_300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            radius_10,
          ),
          topRight: Radius.circular(
            radius_10,
          ),
        ),
      ),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: margin_10,
              vertical: margin_10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_10),
                    topRight: Radius.circular(radius_10)),
                color: greenColor),
            child: Row(
              children: [
                TextView(
                    text: keyUpdateIntuitiveWriting.tr,
                    textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: height_18,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              _intuitiveWritingForm(),
              _intuitiveWritingSave(),
            ],
          ).marginOnly(top: margin_15)
        ],
      ),
    );
  }

  _intuitiveWritingForm() {
    return Form(
      key: controller.intuitiveWritingFormKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: 'Title',
            labelMargin: margin_3,
            hint: '',
            decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                radius_20,
              ),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            isOutlined: true,
            maxLength: 30,
            onChange: (value) {
              if (value == " ") {
                controller.intuitiveTitle.text = "";
              }
            },
            // formatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.intuitiveTitle,
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: "Title"),
          ).paddingOnly(
            bottom: margin_20,
          ),
          TextFieldWidget(
            hint: 'Description....',
            color: commentBgColor,
            decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                radius_3,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            maxline: 6,
            minLine: 5,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.intuitiveComment,
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: "Description"),
          ).paddingOnly(
            bottom: margin_20,
          ),
        ],
      ).marginSymmetric(horizontal: margin_10),
    );
  }

  _intuitiveWritingSave() {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButtonWidget(
        elevation: 0.0,
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: "Update".tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          if (controller.intuitiveWritingFormKey.currentState!.validate()) {
            controller.updateIntuitiveWritingApiCall();
          }
        },
      ).marginSymmetric(
        horizontal: margin_10,
      ),
    );
  }
}
