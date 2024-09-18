import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_fitness/app/core/utils/helper_widget.dart';
import 'package:health_fitness/app/core/values/app_colors.dart';
import 'package:health_fitness/app/core/values/app_constant.dart';
import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/recipe_controller.dart';

// import 'package:popup_menu_2/contextual_menu.dart';

import '../../../core/translations/local_keys.dart';
import '../../../core/values/app_assets.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/text_styles.dart';
import '../../../core/widgets/asset_image.dart';
import '../../../core/widgets/text_view.dart';
import '../../../routes/app_routes.dart';

class RecipeScreen extends GetView<RecipeController> {
  RecipeScreen({super.key});

  GlobalKey key = GlobalKey();

  // GlobalKey<ContextualMenuState> keyState = GlobalKey<ContextualMenuState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              iconBackGround1,
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius_5),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: height_22,
                    ),
                  ).marginOnly(right: margin_10),
                ),
                TextView(
                  text: keyBack.tr,
                  textStyle: textStyleBodyMedium(),
                ).marginOnly(right: margin_10),
              ],
            ).marginOnly(
              top: margin_15,
            ),
            _productList().marginOnly(top: margin_100),
            searchTextField(),
            _addProducts()
          ],
        ).marginOnly(right: margin_15, left: margin_15),
      ),
    );
  }

  Widget _productList() {
    return Container(
      height: height_120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Column(
          children: [
            Obx(
              () => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectedIndex.value = index;
                      if (index == 0) {
                        controller.scheduledTime = 2;
                      } else if (index == 1) {
                        controller.scheduledTime = 3;
                      } else if (index == 2) {
                        controller.scheduledTime = 1;
                      } else if (index == 3) {
                        controller.scheduledTime = 4;
                      }
                      controller.getRecipeListAPI(controller.scheduledTime, controller.type, "");

                      controller.update();
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: radius_35,
                        child: AssetImageWidget(
                          imageUrl: controller.products[index]["icon"],
                        )),
                  ),
                  TextView(text: controller.products[index]["name"], textStyle: textStyleBody2().copyWith(fontSize: font_12, color: controller.selectedIndex.value == index ? greenColor : null))
                      .marginOnly(top: margin_10)
                ],
              ),
            )
          ],
        ).paddingOnly(right: margin_20),
        itemCount: controller.products.length,
      ),
    );
  }

  Widget searchTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: height_45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_22),
              color: Colors.white,
            ),
            child: TextFormField(
              textAlign: TextAlign.start,
              onChanged: (value) {
                Future.delayed(Duration(milliseconds: 200));
                controller.getRecipeListAPI(controller.scheduledTime, controller.type, value);
                controller.update();
              },
              decoration: InputDecoration(
                hintText: keySearchByFreeText.tr,
                hintStyle: textStyleBody2().copyWith(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search, size: 23),
                fillColor: Colors.white,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(margin_5),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(margin_5),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(margin_5),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(margin_5),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(margin_5),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
              controller: controller.searchController,
            ),
          ).paddingOnly(right: margin_7),
        ),
        /* Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                controller.foodTypeVisible = !(controller.foodTypeVisible);
              },
              child: AssetImageWidget(
                imageUrl: iconPopUp,
                imageHeight: 50,
                imageWidth: 50,
              ),
            ),
            controller.foodTypeVisible
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: 120,
                    // height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.foodType.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.foodSelectedIndex.value = index;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextView(
                                    text: controller.foodType[index]["name"],
                                    textStyle: textStyleBody2()
                                        .copyWith(fontSize: font_12)),
                                Icon(
                                  Icons.check,
                                  color: controller.foodSelectedIndex.value ==
                                          index
                                      ? greenColor
                                      : Colors.transparent,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : emptySizeBox()
          ],
        ),*/
        PopupMenuButton(
          offset: Offset(0, 45), // SET THE (X,Y) POSITION
          iconSize: 30,
          child: AssetImageWidget(
            imageUrl: iconPopUp,
            imageHeight: 50,
            imageWidth: 50,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                height: 50,
                enabled: false, // DISABLED THIS ITEM
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 120,
                  // height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.foodType.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.foodSelectedIndex.value = index;
                            if (index == 0) {
                              controller.type = 5;
                            } else if (index == 1) {
                              controller.type = 1;
                            } else if (index == 2) {
                              controller.type = 2;
                            } else if (index == 3) {
                              controller.type = 3;
                            }
                            controller.getRecipeListAPI(controller.scheduledTime, controller.type, "");
                            Get.back();
                            controller.update();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(text: controller.foodType[index]["name"], textStyle: textStyleBody2().copyWith(fontSize: font_12)),
                              Icon(
                                Icons.check,
                                color: controller.foodSelectedIndex.value == index ? greenColor : Colors.transparent,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ];
          },
        )
      ],
    ).paddingOnly(top: margin_10, bottom: margin_15);
  }

  _addProducts() {
    return GetBuilder<RecipeController>(
      builder: (controllers) {
        return Expanded(
          child: controller.recipeList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.recipeList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      debugPrint("RecipeId: " + controller.recipeList[index].id.toString());
                      Get.toNamed(
                        AppRoutes.recipeDetails,
                        arguments: {
                          "recipeId": controller.recipeList[index].id!,
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius_10), color: Colors.white, boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey.shade100)]),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(radius_5),
                              ),
                            ),
                            child: NetworkImageWidget(
                              imageurl: controller.recipeList[index].image!,
                              // "https://play-lh.googleusercontent.com/D8E8oEWhL06eATy5A8qbdcSBJJEPWQL-rhv-JTETD6ntmwb-qUEBF2tgQXt6W9iqcQ",
                              imageHeight: height_50,
                              imageFitType: BoxFit.cover,
                              imageWidth: height_50,
                              radiusAll: radius_5,
                            ).paddingOnly(left: margin_5, right: margin_5),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width * 0.6,
                                child: TextView(
                                  text: controller.recipeList[index].title!,
                                  maxLine: 1,
                                  textAlign: TextAlign.start,
                                  textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w500, fontSize: font_15),
                                ),
                              ),
                              Divider(
                                // height: 20,
                                thickness: 10,
                                // indent: 50,
                                // endIndent: 50,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  controller.recipeList[index].typeId == RECIPE_TYPE_VEGAN
                                      ? Row(
                                          children: [
                                            AssetImageWidget(
                                              imageUrl: iconVegan,
                                              imageHeight: 20,
                                              imageWidth: 20,
                                            ),
                                            SizedBox(
                                              width: height_5,
                                            ),
                                            TextView(text: keyVegan.tr, textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14)).marginOnly(right: margin_20),
                                          ],
                                        )
                                      : controller.recipeList[index].typeId == RECIPE_TYPE_VEGETARIAN
                                          ? Row(
                                              children: [
                                                AssetImageWidget(
                                                  imageUrl: iconVegetarian,
                                                  imageHeight: 20,
                                                  imageWidth: 20,
                                                ),
                                                SizedBox(
                                                  width: height_5,
                                                ),
                                                TextView(text: keyVegetarian.tr, textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14)).marginOnly(right: margin_20),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                AssetImageWidget(
                                                  imageUrl: iconMeat,
                                                  imageHeight: 20,
                                                  imageWidth: 20,
                                                ),
                                                SizedBox(
                                                  width: height_5,
                                                ),
                                                TextView(text: keyNonVegetarian.tr, textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14)).marginOnly(right: margin_20),
                                              ],
                                            ),
                                  controller.recipeList[index].recipeSchedule! == RECIPE_SCHEDULE_MORNING
                                      ? Row(
                                          children: [
                                            AssetImageWidget(
                                              imageUrl: iconMornings,
                                              imageHeight: 20,
                                              imageWidth: 20,
                                            ),
                                            SizedBox(
                                              width: height_5,
                                            ),
                                            TextView(
                                              text: keyMorning.tr,
                                              textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14),
                                            ),
                                          ],
                                        )
                                      : controller.recipeList[index].recipeSchedule! == RECIPE_SCHEDULE_NOON
                                          ? Row(
                                              children: [
                                                AssetImageWidget(
                                                  imageUrl: iconNoons,
                                                  imageHeight: 20,
                                                  imageWidth: 20,
                                                ),
                                                SizedBox(
                                                  width: height_5,
                                                ),
                                                TextView(
                                                  text: keyNoon.tr,
                                                  textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14),
                                                ),
                                              ],
                                            )
                                          : controller.recipeList[index].recipeSchedule! == RECIPE_SCHEDULE_EVENING
                                              ? Row(
                                                  children: [
                                                    AssetImageWidget(
                                                      imageUrl: iconEvenings,
                                                      imageHeight: 20,
                                                      imageWidth: 20,
                                                    ),
                                                    SizedBox(
                                                      width: height_5,
                                                    ),
                                                    TextView(
                                                      text: keyEvening.tr,
                                                      textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    AssetImageWidget(
                                                      imageUrl: iconRecommendations,
                                                      imageHeight: 20,
                                                      imageWidth: 20,
                                                    ),
                                                    SizedBox(
                                                      width: height_5,
                                                    ),
                                                    TextView(
                                                      text: keyRecommended.tr,
                                                      textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w400, fontSize: font_14),
                                                    ),
                                                  ],
                                                )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ).paddingOnly(bottom: margin_10),
                  ),
                )
              : noDataToShow(inputText: "לא נמצאו מתכונים"),
          // : noDataToShow(inputText: "No recipes found"),
        );
      },
    );
  }
}
