import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:health_fitness/app/modules/drawer/controller/weighing_and_perimeter_controller.dart';

// import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../export.dart';
import '../../../../core/values/validator.dart';

class WeighingAndPerimeterScreen extends GetView<WeighingAndPerimeterController> {
  WeighingAndPerimeterScreen({super.key});

  final controller = Get.put(WeighingAndPerimeterController());

  final dataEntryGlobalKey = GlobalKey<FormState>();
  final weightEntryGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeighingAndPerimeterController>(builder: (controllers) {
      return SafeArea(
        child: Scaffold(
          // appBar: CustomAppBar(),
          body: controller.entryDetailsResponse != null
              ? SingleChildScrollView(
                  child: Container(
                    // height: Get.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            iconBG,
                          ),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: margin_20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(radius_5))),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: height_22,
                                ),
                              ).marginOnly(right: margin_10),
                            ),
                            TextView(
                              text: keyBackToHome.tr,
                              textStyle: textStyleBodyMedium(),
                            ).marginOnly(right: margin_10)
                          ],
                        ).marginOnly(
                          bottom: margin_10,
                          top: margin_15,
                        ),
                        SizedBox(
                          height: height_100,
                        ),
                        msgBox(keyItsTimeFor.tr),
                        animatedGauge(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _customButton(
                                text: keyReweighing.tr,
                                onTap: () {
                                  Get.bottomSheet(_addWeightBottomSheet());
                                },
                              ),
                            ),
                            SizedBox(
                              width: width_20,
                            ),
                            Expanded(
                              child: _customButton(text: keyTheWeight.tr, onTap: () {}, isOutLined: true),
                            ),
                          ],
                        ),
                        _body()
                      ],
                    ).paddingSymmetric(horizontal: margin_12),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                ),
        ),
      );
    });
  }

  _body() {
    return Column(
      children: [
        SizedBox(
          height: height_20,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), bottomRight: Radius.circular(radius_10))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(margin_10),
                decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), bottomRight: Radius.circular(radius_10))),
                child: TextView(
                    textAlign: TextAlign.start,
                    text:
                        // "The system detects that you are ovulating and therefore it is not recommended to weigh these days.",
                        "המערכת מזהה שאת מבייצת ולכן לא מומלץ לשקול בימים אלו.",
                    textStyle: textStyleBodySmall().copyWith(fontSize: font_12, color: Colors.white, fontWeight: FontWeight.w400)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customListTile(leadingIcon: iconWeightMachine, title: keyLastWeight.tr, subtitle: controller.entryDetailsResponse!.detail!.weight.toString() + ' ק"ג  ' ?? ""),
                  _customListTile(leadingIcon: iconCalender, title: keyLastWeighingDate.tr, subtitle: controller.entryDetailsResponse!.detail!.weightDate.toString().split(" ").first ?? ""),
                ],
              ).paddingAll(margin_15),
            ],
          ),
        ),
        SizedBox(
          height: height_15,
        ),
        msgBox(keycongratulationMsg.tr),
        Container(
          alignment: Alignment.center,
          height: height_75,
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(color: greenColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), bottomRight: Radius.circular(radius_10))),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _titleValueWidget(
                  measureValue: [
                    controller.entryDetailsResponse!.detail!.bellyline != null ? '${double.parse(controller.entryDetailsResponse!.detail!.hipline.toString()).toStringAsFixed(1)}' : "No data",
                    controller.entryDetailsResponse!.detail!.bellyline != null ? '${double.parse(controller.entryDetailsResponse!.detail!.bellyline.toString()).toStringAsFixed(1)}' : "No data",
                    controller.entryDetailsResponse!.detail!.bellyline != null ? '${double.parse(controller.entryDetailsResponse!.detail!.chestine.toString()).toStringAsFixed(1)}' : "No data"
                  ][index],
                  title: [keyHipLine.tr, keyBellyLine.tr, keyChestLine.tr][index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return VerticalDivider(
                width: width_30,
                color: Colors.white,
                thickness: 2,
              );
            },
          ),
        ).paddingSymmetric(vertical: margin_15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: _customButton(
                    text: keyMeasurement.tr,
                    onTap: () {
                      Get.bottomSheet(_measurementBottomSheet());
                    })),
            SizedBox(
              width: width_20,
            ),
            Expanded(
                child: _customButton(
                    text: keyDataEntry.tr,
                    onTap: () {
                      if (controller.radioGroupValue.value == 0) {
                        toast("אנא בחר מידה תחילה");
                        // toast("Please select measurement first");
                        Get.bottomSheet(_measurementBottomSheet());
                      } else {
                        Get.bottomSheet(_dataEntryBottomSheet());
                      }
                    },
                    isOutLined: true)),
          ],
        ),
        SizedBox(
          height: height_15,
        ),
        Container(
          padding: EdgeInsets.all(margin_12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(radius_10)),
          child: Column(
            children: [
              _customListTile(
                  leadingIcon: iconChest,
                  title: keyLastChestLine.tr,
                  subtitle: controller.entryDetailsResponse!.detail!.chestine != null
                      ? '${double.parse(controller.entryDetailsResponse!.detail!.chestine.toString()).toStringAsFixed(1)} ${controller.entryDetailsResponse!.detail!.measurementType}'
                      : "No data"),
              _customListTile(
                      leadingIcon: iconAbdominal,
                      title: keyLastAbdominalLine.tr,
                      subtitle: controller.entryDetailsResponse!.detail!.bellyline != null
                          ? '${double.parse(controller.entryDetailsResponse!.detail!.bellyline.toString()).toStringAsFixed(1)} ${controller.entryDetailsResponse!.detail!.measurementType}'
                          : "No data")
                  .paddingSymmetric(vertical: margin_10),
              _customListTile(
                  leadingIcon: iconHip,
                  title: keyLastHipLine.tr,
                  subtitle: controller.entryDetailsResponse!.detail!.bellyline != null
                      ? '${double.parse(controller.entryDetailsResponse!.detail!.hipline.toString()).toStringAsFixed(1)} ${controller.entryDetailsResponse!.detail!.measurementType}'
                      : "No data"),
            ],
          ),
        ),
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.weighingDetailScreen);
                },
                child: TextView(
                  text: keySeeAllData.tr,
                  textStyle: textStyleBody2().copyWith(
                    color: greenColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: greenColor,
                  ),
                ))).paddingSymmetric(vertical: margin_10),
      ],
    );
  }

  _dataEntryBottomSheet() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), topRight: Radius.circular(radius_10))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_10),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), topRight: Radius.circular(radius_10)), color: greenColor),
            child: Row(
              children: [
                TextView(text: keyDataEntry.tr, textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
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
          Expanded(
            child: ListView(
              // physics: AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                _editDataEntryForm(),
                _addDataButton(),
              ],
            ).marginOnly(top: margin_15),
          )
        ],
      ).marginOnly(bottom: margin_15),
    );
  }

  _measurementBottomSheet() {
    return Container(
      height: 200,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), topRight: Radius.circular(radius_10))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_10),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), topRight: Radius.circular(radius_10)), color: greenColor),
            child: Row(
              children: [
                TextView(text: "בחר את סוג המדידה".tr, textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
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
          Container(
            height: 100,
            // height: height_150,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _radioButton(),
                // _editDataEntryForm(),
              ],
            ).marginOnly(top: margin_15),
          )
        ],
      ).marginOnly(bottom: margin_15),
    );
  }

  _addWeightBottomSheet() {
    return Container(
      height: height_250,
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: margin_10,
              vertical: margin_10,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_10), topRight: Radius.circular(radius_10)), color: greenColor),
            child: Row(
              children: [
                TextView(text: keyAddWeight.tr, textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
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
          Container(
            height: height_200,
            // height: height_100,
            child: ListView(
              // physics: AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                _addWeightForm(),
                _addWeightButton(),
              ],
            ).marginOnly(top: margin_15),
          )
        ],
      ),
    );
  }

  Widget _addDataButton() {
    return Align(
      // alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyAdd.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          // if (controller.cityTxtController.text.contains(" ") ||
          //     controller.streetTxtController.text.contains(" ")) {
          //   controller.cityTxtController.text =
          //       controller.cityTxtController.text.trim();
          //   controller.streetTxtController.text =
          //       controller.streetTxtController.text.trim();

          if (dataEntryGlobalKey.currentState!.validate()) {
            controller.addDataEntryApi();
            controller.update();
          }
          // }
        },
      ),
    ).marginSymmetric(horizontal: margin_10, vertical: margin_10);
  }

  Widget _addWeightButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyAdd.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          // if (controller.cityTxtController.text.contains(" ") ||
          //     controller.streetTxtController.text.contains(" ")) {
          //   controller.cityTxtController.text =
          //       controller.cityTxtController.text.trim();
          //   controller.streetTxtController.text =
          //       controller.streetTxtController.text.trim();

          if (weightEntryGlobalKey.currentState!.validate()) {
            controller.addWeightApi();
            controller.update();
          }
          // }
        },
      ),
    ).marginSymmetric(
      horizontal: margin_10,
      vertical: margin_10,
    );
  }

  _radioButton() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.measurementList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Obx(
                      () => Radio(
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: controller.measurementList.value[index].id,
                        groupValue: controller.radioGroupValue.value,
                        activeColor: greenColor,
                        onChanged: (value) {
                          // controller.setSelectedRadio(value!);
                          debugPrint(value.toString());
                          controller.radioGroupValue.value = value!;
                          controller.update();
                        },
                      ),
                    ),
                    TextView(text: controller.measurementList.value[index].typeId.toString(), textStyle: textStyleBody2().copyWith(color: Colors.black, fontSize: font_12)).paddingOnly(left: margin_5),
                  ],
                ).paddingOnly(right: margin_20);
              },
            ).marginOnly(left: margin_30),
          ),

        ],
      ).paddingOnly(
        top: margin_15,
        bottom: margin_15,
      );

  _editDataEntryForm() {
    return Form(
      key: dataEntryGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: keyHipLine.tr,
            labelMargin: margin_3,
            hint: '',
            decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            onChange: (value) {
              if (value == " ") {
                controller.hipLineTxtController.text = "";
              }
            },
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp('[ ]'),
              ),
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.deny(
                RegExp(r'[!@#$%^&*(),?":{}|<>-]'),
              )
            ],
            hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
            textController: controller.hipLineTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            maxLength: 4,
            validate: (value) => Validator.ValidateFields(value, message: keyChestLine.tr),
          ),
          TextFieldWidget(
            labelMargin: margin_3,
            labelText: keyBellyLine.tr,
            maxLength: 4,
            radius: radius_10,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp('[ ]'),
              ),
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),?":{}|<>-]'))
            ],
            decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium().copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
            textController: controller.bellyLineTxtController,
            validate: (value) => Validator.ValidateFields(
              value,
              message: keyHipLine.tr,
            ),
          ).marginSymmetric(
            vertical: margin_8,
          ),
          TextFieldWidget(
            radius: radius_10,
            labelText: keyChestLine.tr,
            labelMargin: margin_3,
            maxLength: 4,
            hint: '',
            decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius_20),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            isOutlined: true,
            inputFormatter: [
              FilteringTextInputFormatter.deny(RegExp('[ ]')),
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.deny(
                RegExp(
                  r'[!@#$%^&*(),?":{}|<>-]',
                ),
              )
            ],
            hintStyle: textStyleBodyMedium().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: margin_10,
              horizontal: margin_15,
            ),
            textController: controller.chestLineTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            validate: (value) => Validator.ValidateFields(
              value,
              message: keyBellyLine.tr,
            ),
          ),
        ],
      ).marginSymmetric(
        horizontal: margin_10,
      ),
    );
  }

  _addWeightForm() {
    return Form(
      key: weightEntryGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: keyWeight.tr,
            labelMargin: margin_3,
            hint: '',
            decoration: OutlineInputBorder(borderRadius: BorderRadius.circular(radius_20), borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            onChange: (value) {
              if (value == " ") {
                controller.weightTxtController.text = "";
              }
            },
            inputFormatter: [
              FilteringTextInputFormatter.deny(RegExp('[ ]')),
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),?":{}|<>-]'))
            ],
            hintStyle: textStyleBodyMedium().copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
            textController: controller.weightTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            maxLength: 4,
            validate: (value) => Validator.ValidateFields(value, message: keyWeight.tr),
          ),
        ],
      ).marginSymmetric(horizontal: margin_10),
    );
  }

  Widget msgBox(msg) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_12),
        color: violetLightColor,
      ),
      child: TextView(text: "$msg", textAlign: TextAlign.start, textStyle: textStyleBody2().copyWith(color: violetColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _titleValueWidget({measureValue, title}) => Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                textAlign: TextAlign.start,
                text: "$measureValue ",
                maxLine: 1,
                textStyle: textStyleTitleMedium().copyWith(color: Colors.white, fontSize: font_15),
              ),
              TextView(
                textAlign: TextAlign.start,
                text: '${controller.entryDetailsResponse!.detail!.measurementType}',
                textStyle: textStyleBody1().copyWith(color: Colors.white, fontSize: font_15),
              ),
            ],
          ),
          TextView(textAlign: TextAlign.start, text: "$title", textStyle: textStyleBody1().copyWith(color: Colors.white, fontWeight: FontWeight.normal))
        ],
      );

  Widget _customListTile({leadingIcon, title, subtitle}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leadingIcon != null
              ? AssetImageWidget(
                  imageUrl: leadingIcon,
                  imageHeight: height_30,
                  imageWidth: height_30,
                )
              : emptySizeBox(),
          SizedBox(
            width: width_5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: title,
                textStyle: textStyleBody2().copyWith(fontWeight: FontWeight.w500, fontSize: font_12, color: Colors.black87),
              ),
              TextView(
                text: subtitle,
                textStyle: textStyleBody2().copyWith(color: Colors.grey.shade600),
              ),
            ],
          )
        ],
      );

  Widget _customButton({text, onTap, isOutLined}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height_38,
        decoration: BoxDecoration(
            color: isOutLined == true ? Colors.transparent : buttonColor,
            borderRadius: BorderRadius.circular(radius_20),
            border: Border.all(color: isOutLined == true ? buttonColor : Colors.transparent, width: 2)),
        child: TextView(
          text: text,
          textStyle: textStyleBody1().copyWith(color: isOutLined == true ? buttonColor : Colors.white),
        ),
      ),
    );
  }

  Widget animatedGauge() {
    return SizedBox(
      height: 200,
      child: AnimatedRadialGauge(
        /// The animation duration.
        duration: const Duration(seconds: 1),
        curve: Curves.elasticOut,

        /// Define the radius.
        /// If you omit this value, the parent size will be used, if possible.
        radius: 120,

        /// Gauge value.
        value: double.parse(controller.entryDetailsResponse!.detail!.weight ?? "0.0"),

        /// Optionally, you can configure your gauge, providing additional
        /// styles and transformers.
        axis: GaugeAxis(
          /// Provide the [min] and [max] value for the [value] argument.
          min: 0,
          max: 1000,

          /// Render the gauge as a 180-degree arc.
          degrees: 180,

          /// Set the background color and axis thickness.
          style: const GaugeAxisStyle(
            thickness: 20,
            background: Color(0xFFDFE2EC),
            segmentSpacing: 4,
          ),

          /// Define the pointer that will indicate the progress (optional).
          pointer: GaugePointer.needle(
            borderRadius: 16,
            color: Color(0xFF193663),
            width: 10,
            height: 10,
          ),

          /// Define the progress bar (optional).
          progressBar: const GaugeProgressBar.basic(
            color: violetColor,
          ),

          /// Define axis segments (optional).
          segments: [
            const GaugeSegment(
              from: 0,
              to: 33.3,
              color: Color(0xFFD9DEEB),
              cornerRadius: Radius.zero,
            ),
            const GaugeSegment(
              from: 33.3,
              to: 66.6,
              color: Color(0xFFD9DEEB),
              cornerRadius: Radius.zero,
            ),
            const GaugeSegment(
              from: 66.6,
              to: 100,
              color: Color(0xFFD9DEEB),
              cornerRadius: Radius.zero,
            ),
          ],
        ),

        /// You can also, define the child builder.
        /// You will build a value label in the following way, but you can use the widget of your choice.
        ///
        /// For non-value related widgets, take a look at the [child] parameter.
        /// ```

        builder: (context, child, value) => Center(
          child: Text(
            controller.entryDetailsResponse!.detail!.weight ?? "0.0",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 46,
              fontWeight: FontWeight.bold,
            ),
          ),
        ) /*RadialGaugeLabel(
          value: double.parse(
              controller.entryDetailsResponse!.detail!.weight ?? "0.0"),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 46,
            fontWeight: FontWeight.bold,
          ),
        )*/
        ,

        /// ```
      ),
    );
  }

// Widget _getRadialGauge() {
//   return SizedBox(
//     height: height_200,
//     child: SfRadialGauge(
//       enableLoadingAnimation: true,
//       axes: <RadialAxis>[
//         // RadialAxis(radiusFactor: 0.9, centerY: 0.6, pointers: <GaugePointer>[
//         //   MarkerPointer(
//         //       value: double.parse(
//         //           controller.entryDetailsResponse!.detail!.weight ?? "0.0"),
//         //       markerOffset: -10),
//         // ], annotations: <GaugeAnnotation>[
//         //   GaugeAnnotation(
//         //       widget: Container(
//         //           child: Text(
//         //               '${controller.entryDetailsResponse!.detail!.weight}Kg',
//         //               style: TextStyle(
//         //                   fontSize: 25, fontWeight: FontWeight.bold))),
//         //       angle: 90,
//         //       positionFactor: 0.5)
//         // ])
//       ],
//     ),
//   );
// }
}
