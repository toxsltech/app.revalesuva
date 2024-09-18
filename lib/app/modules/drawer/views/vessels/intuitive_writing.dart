import 'package:health_fitness/app/core/values/validator.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_controller.dart';
import 'package:intl/intl.dart';

import '../../../../../export.dart';

class IntuitiveWritingScreen extends GetView<IntuitiveWritingController> {
  const IntuitiveWritingScreen({super.key});

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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                text: keyIntuitiveWriting.tr,
                textStyle: textStyleBody1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(right: margin_10),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(_addIntuitiveWriting());
                },
                child: Container(
                  padding: EdgeInsets.all(
                    margin_7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      radius_5,
                    ),
                  ),
                  child: AssetImageWidget(
                    imageUrl: iconAddIntuitive,
                    imageWidth: height_15,
                    imageHeight: height_15,
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            top: margin_70,
            bottom: margin_20,
          ),
          Obx(
            () => Expanded(
              child: (controller.intuitiveWritings.isNotEmpty == true)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _customRow(
                          title: controller.intuitiveWritings[index].title,
                          time: controller.intuitiveWritings[index].createdOn,
                          comment:
                              controller.intuitiveWritings[index].description,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.intuitiveDetailScreen,
                              arguments: {
                                'id': controller.intuitiveWritings[index].id,
                              },
                            );
                          },
                        );
                      },
                      itemCount: controller.intuitiveWritings.length,
                    )
                  : noDataToShow(inputText: keyNoData.tr),
            ),
          ),
        ],
      ).paddingAll(margin_12),
    );
  }

  _addIntuitiveWriting() {
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
                    text: keyAddIntuitiveWriting.tr,
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
            // physics: AlwaysScrollableScrollPhysics(),
            // shrinkWrap: true,
            children: [
              _intuitiveWritingForm(),
              _intuitiveWritingSave(),
              // _addWeightForm(),
              // _addWeightButton(),
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
            // labelText: 'Title',
            labelText: 'כותרת',
            labelMargin: margin_3,
            hint: '',
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
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
                Validator.ValidateFields(value, message: "כותרת"),
            // Validator.ValidateFields(value, message: "Title"),
          ).paddingOnly(
            bottom: margin_20,
          ),
          TextFieldWidget(
            hint: 'תיאור....',
            // hint: 'Description....',
            color: commentBgColor,
            decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                radius_3,
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            // isOutlined: true,
            // formatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
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
                Validator.ValidateFields(value, message: "תיאור"),
            // Validator.ValidateFields(value, message: "Description"),
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
        buttonText: keyAdd.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          if (controller.intuitiveWritingFormKey.currentState!.validate()) {
            controller.addIntuitiveWritingApiCall();
          }
        },
      ).marginSymmetric(
        horizontal: margin_10,
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
                Container(
                  width: Get.width * 0.7,
                  child: TextView(
                    text: title,
                    maxLine: 2,
                    textStyle: textStyleBodyLarge().copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextView(
                  text:
                      "${(DateFormat('dd-MM-yyyy').format(time) == DateFormat('dd-MM-yyyy').format(DateTime.now())) ? "Today" : (DateFormat('dd-MM-yyyy').format(time) == DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)))) ? 'Yesterday' : DateFormat('dd-MM-yyyy').format(time)}",
                  textStyle: textStyleBodyMedium().copyWith(
                    // fontSize: font_13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            TextView(
              text: comment,
              maxLine: 1,
              textStyle: textStyleBodyMedium().copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
