import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/daily_nutrition_controller.dart';
import 'package:health_fitness/app/modules/drawer/models/category_api_response_model.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/qr_screen.dart';
import 'package:health_fitness/export.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

class DailyNutritionPlanningScreen extends GetView<DailyNutritionController> {
  DailyNutritionPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: backGroundWidget(
          child: Container(
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height_25,
                  ),
                  customBackWidget(title: keyBack.tr),
                  SizedBox(
                    height: height_15,
                  ),
                  TextView(
                    text: "תכנון תזונה יומי",
                    // text: "Daily Nutrition Planning",
                    textStyle: textStyleBody1(),
                  ),
                  SizedBox(
                    height: height_25,
                  ),
                  // _scanner(),
                  controller.breakFastList.isEmpty &&
                          controller.lunchList.isEmpty &&
                          controller.dinnerFastList.isEmpty
                      ? Container(
                          height: Get.height * 0.6,
                          // child: noDataToShow(inputText: "No Nutrition found"),
                          child: noDataToShow(inputText: "לא נמצאה תזונה"),
                        )
                      : Column(
                          children: [
                            controller.breakFastList.isNotEmpty
                                ? _rowHeading(title: "ארוחת בוקר")
                                // ? _rowHeading(title: "Breakfast")
                                : emptySizeBox(),
                            controller.breakFastList.isNotEmpty
                                ? _breakFastDetailView()
                                : emptySizeBox(),
                            controller.lunchList.isNotEmpty
                                ? _rowHeading(title: "ארוחת צהריים")
                                // ? _rowHeading(title: "Lunch")
                                : emptySizeBox(),
                            controller.lunchList.isNotEmpty
                                ? _lunchDetailView()
                                : emptySizeBox(),
                            controller.dinnerFastList.isNotEmpty
                                ? _rowHeading(title: "אֲרוּחַת עֶרֶב")
                                // ? _rowHeading(title: "Dinner")
                                : emptySizeBox(),
                            controller.dinnerFastList.isNotEmpty
                                ? _dinnerDetailView()
                                : emptySizeBox(),
                            SizedBox(
                              height: 25,
                            ),
                            _addButton(),
                          ],
                        ),
                ],
              ).paddingSymmetric(horizontal: margin_12),
            ),
          ),
        ),
      ),
    );
  }

  _addButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyAdd.tr,
        buttonColor: buttonColor,
        onPressed: () {
          // if (formGlobalKey.currentState!.validate()) {
          if (controller.selectedItemsList.isNotEmpty) {
            controller.hitAddNutritionApiCall();
          } else {
            toast("נא לבחור את רכיבי התזונה");
            // toast("Please select the nutrients");
          }

          // }
          // Get.toNamed(AppRoutes.alreadyKnowScreen);
        },
      ),
    );
  }

  _scanner() => Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(QrScreen());
            },
            child: AssetImageWidget(
              imageUrl: scannerImg,
              imageWidth: height_60,
              imageHeight: height_60,
            ).paddingOnly(top: margin_15, right: margin_15, bottom: margin_10),
          ),
          TextView(
            text: "Scan",
            textStyle: textStyleBody2(),
          ),
        ],
      );

  _rowHeading({required title}) => Padding(
        padding: EdgeInsets.symmetric(vertical: margin_8),
        child: Row(
          children: [
            TextView(text: title, textStyle: textStyleBody1()),
            Spacer(),
            TextView(
                // text: "Check if you have   ",
                text: "סמן אם יש לך   ",
                textStyle:
                    textStyleBody2().copyWith(fontWeight: FontWeight.normal)),
            AssetImageWidget(
              imageUrl: checkBox,
              imageHeight: height_20,
              imageWidth: height_20,
            ),
          ],
        ),
      );

  _breakFastDetailView() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_12,
            ),
            color: Colors.white),
        padding: EdgeInsets.all(margin_15),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.breakFastList.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.breakFastList[i].isCheck == true &&
                              controller.breakFastList[i].items?.isNotEmpty ==
                                  true) {
                            Get.dialog(
                              Container(
                                height: Get.height,
                                width: Get.width,
                                color: Colors.white10,
                                alignment: Alignment.center,
                                child: Container(
                                  height: Get.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          /*color: greenColor,*/ blurRadius: 4),
                                    ],
                                    border: Border.all(
                                        color: greenColor, width: width_4),
                                    borderRadius:
                                        BorderRadius.circular(margin_10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .breakFastList[i].items?.length,
                                        itemBuilder: (context, index) {
                                          debugPrint(
                                            "breakFastList index : " +
                                                controller.breakFastList[i]
                                                    .items![index].isSelected
                                                    .toString(),
                                          );
                                          return Obx(
                                            () => Container(
                                              padding: EdgeInsets.all(
                                                margin_10,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .breakFastList[i]
                                                          .items![index]
                                                          .isSelected =
                                                      !controller
                                                          .breakFastList[i]
                                                          .items![index]
                                                          .isSelected;

                                                  controller.breakFastList
                                                      .refresh();
                                                  controller.update();
                                                  if (controller
                                                      .breakFastList[i]
                                                      .items![index]
                                                      .isSelected) {
                                                    // int selectedIndex = controller
                                                    //     .selectedItemsList
                                                    //     .indexWhere((element) =>
                                                    //         element ==
                                                    //         controller
                                                    //             .breakFastList[i].id);
                                                    controller.selectedItemsList
                                                        .add(
                                                      DailyNutrition(
                                                        controller
                                                            .breakFastList[i]
                                                            .typeId
                                                            .toString(),
                                                        controller
                                                            .breakFastList[i].id
                                                            .toString(),
                                                        controller
                                                            .breakFastList[i]
                                                            .items![i]
                                                            .id
                                                            .toString(),
                                                      ),
                                                    );
                                                    debugPrint(
                                                      controller
                                                          .selectedItemsList
                                                          .toString(),
                                                    );
                                                    // controller.intID.add(controller
                                                    //     .breakFastList[i]
                                                    //     .items![index]
                                                    //     .id!);
                                                  } else {
                                                    controller.selectedItemsList
                                                        .removeWhere((element) =>
                                                            element
                                                                .nutritionId ==
                                                            controller
                                                                .breakFastList[
                                                                    i]
                                                                .items![i]
                                                                .id
                                                                .toString());
                                                    debugPrint(controller
                                                        .selectedItemsList
                                                        .toString());
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextView(
                                                        text: controller
                                                            .breakFastList[i]
                                                            .items![index]
                                                            .title
                                                            .toString(),
                                                        textStyle:
                                                            textStyleBodyLarge()),
                                                    AssetImageWidget(
                                                      imageUrl: controller
                                                                  .breakFastList[
                                                                      i]
                                                                  .items![index]
                                                                  .isSelected ==
                                                              false
                                                          ? unCheckBox
                                                          : checkBox,
                                                      imageWidth: height_20,
                                                      imageHeight: height_20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ).paddingAll(
                                  margin_40,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            margin_9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                radius_20,
                              ),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.breakFastList[i].title}",
                                style: textStyleBodyLarge().copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ).paddingOnly(bottom: margin_8, left: margin_5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (list[i].items?.isNotEmpty == true) {
                        controller.breakFastList[i].isCheck =
                            !controller.breakFastList[i].isCheck;
                        controller.update();
                        debugPrint(
                          controller.breakFastList[i].isCheck.toString(),
                        );
                        if (controller.breakFastList[i].isCheck) {
                          // controller.selectedItemsList.add(
                          //   AuthRequestModel.dailyNutritionReqModel(
                          //       typeId: list[i].typeId,
                          //       categoryId: list[i].id,
                          //       subCategoryItemsId: list[i].items![i].id),
                          // );
                        } else {
                          int selectedIndex = controller.selectedItemsList
                              .indexWhere((element) =>
                                  element == controller.breakFastList[i].id);
                          if (selectedIndex != -1) {
                            controller.breakFastList[i].items!
                                .forEach((element) {
                              element.isSelected = false;
                            });
                            if (controller.selectedItemsList[selectedIndex] !=
                                null) {
                              // List<String> newList = controller
                              //     .selectedItemsList[selectedIndex]
                              //     .split(',');
                              // print(newList);
                              // newList.removeAt(selectedIndex);
                            }
                            // controller.selectedItemsList[selectedIndex]["sub_category_id"] = newList.join(',');
                            controller.selectedItemsList
                                .removeAt(selectedIndex);
                          }
                        }
                        controller.update();
                        controller.breakFastList.refresh();
                        // }
                      },
                      child: AssetImageWidget(
                        imageUrl:
                            controller.breakFastList.value[i].isCheck == false
                                ? unCheckBox
                                : checkBox,
                        imageWidth: height_20,
                        imageHeight: height_20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  _lunchDetailView() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_12,
            ),
            color: Colors.white),
        padding: EdgeInsets.all(margin_15),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.lunchList.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.lunchList[i].isCheck == true &&
                              controller.lunchList[i].items?.isNotEmpty ==
                                  true) {
                            Get.dialog(
                              Container(
                                width: Get.width,
                                color: Colors.white10,
                                alignment: Alignment.center,
                                child: Container(
                                  height: Get.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          /*color: greenColor,*/ blurRadius: 4),
                                    ],
                                    border: Border.all(
                                        color: greenColor, width: width_4),
                                    borderRadius:
                                        BorderRadius.circular(margin_10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .lunchList[i].items?.length,
                                        itemBuilder: (context, index) {
                                          debugPrint("lunchList index : " +
                                              controller.lunchList[i]
                                                  .items![index].isSelected
                                                  .toString());
                                          return Obx(
                                            () => Container(
                                              padding: EdgeInsets.all(
                                                margin_10,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .lunchList[i]
                                                          .items![index]
                                                          .isSelected =
                                                      !controller
                                                          .lunchList[i]
                                                          .items![index]
                                                          .isSelected;

                                                  controller.lunchList
                                                      .refresh();
                                                  controller.update();
                                                  if (controller
                                                      .lunchList[i]
                                                      .items![index]
                                                      .isSelected) {
                                                    controller.selectedItemsList
                                                        .add(
                                                      DailyNutrition(
                                                        controller
                                                            .lunchList[i].typeId
                                                            .toString(),
                                                        controller
                                                            .lunchList[i].id
                                                            .toString(),
                                                        controller.lunchList[i]
                                                            .items![0].id
                                                            .toString(),
                                                      ),
                                                    );
                                                    debugPrint(
                                                      controller
                                                          .selectedItemsList
                                                          .toString(),
                                                    );
                                                    // controller.intID.add(controller
                                                    //     .breakFastList[i]
                                                    //     .items![index]
                                                    //     .id!);
                                                  } else {
                                                    controller.selectedItemsList
                                                        .removeWhere((element) =>
                                                            element
                                                                .nutritionId ==
                                                            controller
                                                                .lunchList[i]
                                                                .items![i]
                                                                .id
                                                                .toString());
                                                    debugPrint(controller
                                                        .selectedItemsList
                                                        .toString());
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextView(
                                                        text: controller
                                                            .lunchList[i]
                                                            .items![index]
                                                            .title
                                                            .toString(),
                                                        textStyle:
                                                            textStyleBodyLarge()),
                                                    AssetImageWidget(
                                                      imageUrl: controller
                                                                  .lunchList[i]
                                                                  .items![index]
                                                                  .isSelected ==
                                                              false
                                                          ? unCheckBox
                                                          : checkBox,
                                                      imageWidth: height_20,
                                                      imageHeight: height_20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ).paddingAll(
                                  margin_40,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            margin_9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                radius_20,
                              ),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.lunchList[i].title}",
                                style: textStyleBodyLarge().copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ).paddingOnly(bottom: margin_8, left: margin_5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (list[i].items?.isNotEmpty == true) {
                        controller.lunchList[i].isCheck =
                            !controller.lunchList[i].isCheck;
                        controller.update();
                        debugPrint(
                          controller.lunchList[i].isCheck.toString(),
                        );
                        if (controller.lunchList[i].isCheck) {
                        } else {
                          int selectedIndex = controller.selectedItemsList
                              .indexWhere((element) =>
                                  element.categoryId ==
                                  controller.lunchList[i].id.toString());
                          if (selectedIndex != -1) {
                            controller.lunchList[i].items!.forEach((element) {
                              element.isSelected = false;
                            });
                            controller.selectedItemsList
                                .removeAt(selectedIndex);
                          }
                        }
                        controller.update();
                        controller.lunchList.refresh();
                        // }
                      },
                      child: AssetImageWidget(
                        imageUrl: controller.lunchList.value[i].isCheck == false
                            ? unCheckBox
                            : checkBox,
                        imageWidth: height_20,
                        imageHeight: height_20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  _dinnerDetailView() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_12,
            ),
            color: Colors.white),
        padding: EdgeInsets.all(margin_15),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.dinnerFastList.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.dinnerFastList[i].isCheck == true &&
                              controller.dinnerFastList[i].items?.isNotEmpty ==
                                  true) {
                            Get.dialog(
                              Container(
                                width: Get.width,
                                color: Colors.white10,
                                alignment: Alignment.center,
                                child: Container(
                                  height: Get.height * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        /*color: greenColor,*/ blurRadius: 4),
                                    ],
                                    border: Border.all(
                                        color: greenColor, width: width_4),
                                    borderRadius:
                                    BorderRadius.circular(margin_10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .dinnerFastList[i].items?.length,
                                        itemBuilder: (context, index) {
                                          debugPrint(
                                            "dinnerFastList index : " +
                                                controller.dinnerFastList[i]
                                                    .items![index].isSelected
                                                    .toString(),
                                          );
                                          return Obx(
                                            () => Container(
                                              padding: EdgeInsets.all(
                                                margin_10,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .dinnerFastList[i]
                                                          .items![index]
                                                          .isSelected =
                                                      !controller
                                                          .dinnerFastList[i]
                                                          .items![index]
                                                          .isSelected;

                                                  controller.dinnerFastList
                                                      .refresh();
                                                  controller.update();
                                                  if (controller.dinnerFastList[i]
                                                      .items![index].isSelected) {
                                                    controller.selectedItemsList
                                                        .add(
                                                      DailyNutrition(
                                                        controller
                                                            .dinnerFastList[i]
                                                            .typeId
                                                            .toString(),
                                                        controller
                                                            .dinnerFastList[i].id
                                                            .toString(),
                                                        controller
                                                            .dinnerFastList[i]
                                                            .items![i]
                                                            .id
                                                            .toString(),
                                                      ),
                                                    );
                                                    debugPrint(
                                                      controller.selectedItemsList
                                                          .toString(),
                                                    );
                                                  } else {
                                                    controller.selectedItemsList
                                                        .removeWhere((element) =>
                                                            element.nutritionId ==
                                                            controller
                                                                .dinnerFastList[i]
                                                                .items![i]
                                                                .id
                                                                .toString());
                                                    debugPrint(controller
                                                        .selectedItemsList
                                                        .toString());
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextView(
                                                        text: controller
                                                            .dinnerFastList[i]
                                                            .items![index]
                                                            .title
                                                            .toString(),
                                                        textStyle:
                                                            textStyleBodyLarge()),
                                                    AssetImageWidget(
                                                      imageUrl: controller
                                                                  .dinnerFastList[
                                                                      i]
                                                                  .items![index]
                                                                  .isSelected ==
                                                              false
                                                          ? unCheckBox
                                                          : checkBox,
                                                      imageWidth: height_20,
                                                      imageHeight: height_20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ).paddingAll(
                                  margin_40,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            margin_9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                radius_20,
                              ),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.dinnerFastList[i].title}",
                                style: textStyleBodyLarge().copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ).paddingOnly(bottom: margin_8, left: margin_5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.dinnerFastList[i].isCheck =
                            !controller.dinnerFastList[i].isCheck;
                        controller.update();
                        debugPrint(
                          controller.dinnerFastList[i].isCheck.toString(),
                        );
                        if (controller.dinnerFastList[i].isCheck) {
                        } else {
                          int selectedIndex = controller.selectedItemsList
                              .indexWhere((element) =>
                                  element.categoryId ==
                                  controller.dinnerFastList[i].id.toString());
                          if (selectedIndex != -1) {
                            controller.dinnerFastList[i].items!
                                .forEach((element) {
                              element.isSelected = false;
                            });
                            controller.selectedItemsList
                                .removeAt(selectedIndex);
                          }
                        }
                        controller.update();
                        controller.dinnerFastList.refresh();
                        // }
                      },
                      child: AssetImageWidget(
                        imageUrl: controller.dinnerFastList[i].isCheck == false
                            ? unCheckBox
                            : checkBox,
                        imageWidth: height_20,
                        imageHeight: height_20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  _detailView({required RxList<DailyNutritionCategoryDataModel> list}) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_12,
            ),
            color: Colors.white),
        padding: EdgeInsets.all(margin_15),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (list[i].isCheck == true &&
                              list[i].items?.isNotEmpty == true) {
                            Get.dialog(
                              Container(
                                height: Get.height,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: list[i].items?.length,
                                  itemBuilder: (context, index) {
                                    debugPrint(list[i]
                                        .items![index]
                                        .isSelected
                                        .toString());
                                    return Obx(
                                      () => Container(
                                        padding: EdgeInsets.all(
                                          margin_10,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            list[i].items![index].isSelected =
                                                !list[i]
                                                    .items![index]
                                                    .isSelected;
                                            list.refresh();
                                            controller.update();
                                            if (list[i]
                                                .items![index]
                                                .isSelected) {
                                              int selectedIndex = controller
                                                  .selectedItemsList
                                                  .indexWhere((element) =>
                                                      element == list[i].id);
                                              controller.intID.add(
                                                  list[i].items![index].id!);
                                              if (selectedIndex != -1) {
                                                // controller.selectedItemsList[
                                                //         selectedIndex] =
                                                //     controller.intID.join(",");
                                                debugPrint(
                                                    "selectedItemsLists : ${controller.selectedItemsList}");
                                              }
                                            } else {
                                              int selectedIndex = controller
                                                  .selectedItemsList
                                                  .indexWhere((element) =>
                                                      element == list[i].id);
                                              // List<String> newList = controller
                                              //     .selectedItemsList[
                                              //         selectedIndex]
                                              //     .split(',');
                                              int newIndex = controller.intID
                                                  .indexWhere((element) =>
                                                      element ==
                                                      list[i]
                                                          .items![index]
                                                          .id!);
                                              // newList.removeAt(newIndex);
                                              // controller.intID
                                              //     .removeAt(newIndex);
                                              // controller.selectedItemsList[
                                              //         selectedIndex] =
                                              //     newList.join(',');
                                              debugPrint(controller
                                                  .selectedItemsList
                                                  .toString());
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextView(
                                                  text: list[i]
                                                      .items![index]
                                                      .title
                                                      .toString(),
                                                  textStyle:
                                                      textStyleBodyLarge()),
                                              AssetImageWidget(
                                                imageUrl: list[i]
                                                            .items![index]
                                                            .isSelected ==
                                                        false
                                                    ? unCheckBox
                                                    : checkBox,
                                                imageWidth: height_20,
                                                imageHeight: height_20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ).paddingAll(
                                margin_40,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            margin_9,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                radius_20,
                              ),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${list[i].title}",
                                style: textStyleBodyLarge().copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ).paddingOnly(bottom: margin_8, right: margin_5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (list[i].items?.isNotEmpty == true) {
                        list[i].isCheck = !list[i].isCheck;
                        controller.update();
                        debugPrint(
                          list[i].isCheck.toString(),
                        );
                        if (list[i].isCheck) {
                          // controller.selectedItemsList.add(
                          //   AuthRequestModel.dailyNutritionReqModel(
                          //       typeId: list[i].typeId,
                          //       categoryId: list[i].id,
                          //       subCategoryItemsId: list[i].items![i].id),
                          // );
                          controller.selectedItemsList.add(
                            DailyNutrition(
                              list[i].typeId.toString(),
                              list[i].id.toString(),
                              list[i].items![i].id.toString(),
                            ),
                          );
                          debugPrint(
                            controller.selectedItemsList.toString(),
                          );
                        } else {
                          int selectedIndex = controller.selectedItemsList
                              .indexWhere((element) => element == list[i].id);
                          if (selectedIndex != -1) {
                            list[i].items!.forEach((element) {
                              element.isSelected = false;
                            });
                            if (controller.selectedItemsList[selectedIndex] !=
                                null) {
                              // List<String> newList = controller
                              //     .selectedItemsList[selectedIndex]
                              //     .split(',');
                              // print(newList);
                              // newList.removeAt(selectedIndex);
                            }
                            // controller.selectedItemsList[selectedIndex]["sub_category_id"] = newList.join(',');
                            controller.selectedItemsList
                                .removeAt(selectedIndex);
                          }
                        }
                        controller.update();
                        list.refresh();
                        // }
                      },
                      child: AssetImageWidget(
                        imageUrl:
                            list[i].isCheck == false ? unCheckBox : checkBox,
                        imageWidth: height_20,
                        imageHeight: height_20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

  _showMultiSelect() {
    return MultiSelectDialogField(
      items: controller.dietVegetables,
      title: Text("Vegetables"),
      selectedColor: Colors.black,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(40)),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      buttonIcon: Icon(
        Icons.keyboard_arrow_down_rounded,
      ),
      buttonText: Text(
        "Favorite Animals",
        style: textStyleBodyLarge().copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onConfirm: (results) {
        print(results);
      },
    );
  }
}

/*
Expanded(
flex: 8,
child: */
/*GetBuilder(
                        init: controller,
                        builder: (controller) =>*/ /*

// GetBuilder(
// init: controller,
// builder: (context) {
*/
/*return*/ /*
 MultiSelectDialogFieldd(
*/
/*initialValue: (controller.selectedItemsList.indexWhere((element) => element['sub_category_id'] == list[i].id) != -1)
                                  ? (controller.selectedItemsList[controller.selectedItemsList
                                              .indexWhere((element) => element['sub_category_id'] == list[i].id)]["sub_category_id"] ==
                                          null)
                                      ? []
                                      : (controller.selectedItemsList[
                                              controller.selectedItemsList.indexWhere((element) => element['sub_category_id'] == list[i].id)]
                                          ["sub_category_id"]) as List<DailyNutritionSubCategoryDataModel>
                                  : <DailyNutritionSubCategoryDataModel>[],*/ /*

// initialValue: [],
backgroundColor: Colors.white,
disabled: (list[i].isCheck == true && controller.breakFastList[i].items?.isNotEmpty == true) ? false : true,
items: controller.breakFastList[i].items!
    .map((diets) => MultiSelectItem<DailyNutritionSubCategoryDataModel>(diets, diets.title.toString()))
    .toList(),
title: Text(
"${list[i].title}",
),
selectedColor: Colors.black,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.all(
Radius.circular(
radius_20,
),
),
border: Border.all(
color: Colors.grey,
width: 2,
),
),
buttonIcon: Icon(
Icons.keyboard_arrow_down_rounded,
),
buttonText: Text(
"${list[i].title}",
style: textStyleBodyLarge().copyWith(
color: Colors.black,
fontWeight: FontWeight.w500,
),
),
onConfirm: (results) {
List<int> intID = [];
// int selectedIndex = controller.selectedItemsList.indexWhere((element) => element['sub_category_id'] == list[i].id);
*/
/*if (selectedIndex != -1) {
                                  controller.selectedItemsList[selectedIndex]["sub_category_id"] = intID;
                                  print(controller.selectedItemsList);
                                }*/ /*

for (int ij = 0; ij < results.length; ij++) {
intID.add(results[ij].id!);
if (ij == (results.length - 1)) {
int selectedIndex = controller.selectedItemsList.indexWhere((element) => element['sub_category_id'] == list[i].id);
if (selectedIndex != -1) {
controller.selectedItemsList[selectedIndex]["sub_category_id"] = intID.join(",");
print(jsonEncode(controller.selectedItemsList));
}
}
}
//_selectedAnimals = results;
},
).paddingOnly(
bottom: margin_8,
),
// },
// ),
// ),
),*/
