import 'package:health_fitness/export.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../controller/recipe_details_controller.dart';

class RecipeDetails extends GetView<RecipeDetailsController> {
  RecipeDetails({super.key});

  final controller = Get.put(RecipeDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return GetBuilder<RecipeDetailsController>(builder: (controllers) {
      return controller.recipeListDetails != null
          ? SingleChildScrollView(
              child: Container(
              width: Get.width,
              // height: Get.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        iconBG,
                      ),
                      fit: BoxFit.fill)),
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
                          ).marginOnly(right: margin_10)),
                      TextView(
                        text: keyBack.tr,
                        textStyle: textStyleBodyMedium(),
                      ).marginOnly(right: margin_10)
                    ],
                  ).marginOnly(
                    top: margin_15,
                  ),
                  _details(context).paddingOnly(
                    top: margin_110,
                  ),
                  _ingredients(),
                  _method()
                ],
              ).marginOnly(
                  right: margin_15, left: margin_15, bottom: margin_15),
            ))
          : Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
    });
  }

  Widget _details(BuildContext context) {
    return GetBuilder<RecipeDetailsController>(builder: (controllers) {
      return Container(
        // height: height_300,
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius_10), color: Colors.grey, boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey.shade100)]),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.grey.shade400,
              ),
              height: height_150,
            ),
            Container(
              // height: height_190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.3,
                        child: TextView(
                            text: controller.recipeListDetails!.detail!.title
                                .toString(),
                            maxLine: 2,
                            textAlign: TextAlign.start,
                            textStyle:
                                textStyleBody1().copyWith(fontSize: font_18)),
                      ),
                      Row(
                        children: [
                          controller.recipeListDetails!.detail!.typeId ==
                                  RECIPE_TYPE_VEGAN
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
                                    TextView(
                                            text: keyVegan.tr,
                                            textStyle: textStyleBody1()
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: font_14))
                                        .marginOnly(right: margin_5),
                                  ],
                                )
                              : controller.recipeListDetails!.detail!.typeId ==
                                      RECIPE_TYPE_VEGETARIAN
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
                                        TextView(
                                                text: keyVegetarian.tr,
                                                textStyle: textStyleBody1()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: font_14))
                                            .marginOnly(right: margin_5),
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
                                        TextView(
                                                text: keyNonVegetarian.tr,
                                                textStyle: textStyleBody1()
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: font_14))
                                            .marginOnly(right: margin_5),
                                      ],
                                    ),
                          controller.recipeListDetails!.detail!
                                      .recipeSchedule! ==
                                  RECIPE_SCHEDULE_MORNING
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
                                      textStyle: textStyleBody1().copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: font_14),
                                    ),
                                  ],
                                )
                              : controller.recipeListDetails!.detail!
                                          .recipeSchedule! ==
                                      RECIPE_SCHEDULE_NOON
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
                                          textStyle: textStyleBody1().copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: font_14),
                                        ),
                                      ],
                                    )
                                  : controller.recipeListDetails!.detail!
                                              .recipeSchedule! ==
                                          RECIPE_SCHEDULE_EVENING
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
                                              textStyle: textStyleBody1()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: font_14),
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
                                              textStyle: textStyleBody1()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: font_14),
                                            ),
                                          ],
                                        )
                        ],
                      )
                    ],
                  ),
                  TextView(
                      text: keyName.tr,
                      textStyle: textStyleBody1().copyWith(
                          fontSize: font_15, color: Colors.grey.shade600)),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                  ).paddingOnly(
                    top: margin_10,
                    bottom: margin_10,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: HTML.toTextSpan(
                      defaultTextStyle: textStyleBody1().copyWith(
                        fontSize: font_15,
                      ),
                      context,
                      controller.recipeListDetails!.detail!.description!,
                      linksCallback: (dynamic link) {
                        // launchUrl(
                        // Uri.parse(link),
                        // );
                      },
                    ),
                  ).paddingOnly(
                    bottom: margin_10,
                  ),
                  TextView(
                    text:
                        "$keyCalories ${controller.recipeListDetails!.detail!.density!}",
                    textStyle: textStyleBody1().copyWith(
                      fontSize: font_15,
                      color: Colors.grey.shade600,
                    ),
                  ).paddingOnly(
                    top: margin_5,
                    bottom: margin_5,
                  )
                ],
              ).paddingOnly(top: margin_10, left: margin_10, right: margin_10),
            )
          ],
        ),
      ).marginOnly(bottom: margin_20);
    });
  }

  String htmlToPlainText(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String plainText = htmlString.replaceAll(exp, '');
    debugPrint("Plain Text : " + plainText);
    return plainText;
  }

  _ingredients() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(text: keyIngredients.tr, textStyle: textStyleBody1()),
          Divider(
            thickness: 2,
            color: Colors.grey.shade300,
          ).marginOnly(top: margin_5),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.recipeListDetails!.detail!.ingredient!.length,
            itemBuilder: (context, index) => Row(
              children: [
                Obx(
                  () => Checkbox(
                    checkColor: Colors.black,
                    value: controller.selectedIngredient.value,
                    onChanged: (value) {
                      // controller.selectedIngredient.value =
                      //     !controller.selectedIngredient.value;
                    },
                  ),
                ),
                TextView(
                    text: controller.recipeListDetails!.detail!
                        .ingredient![index].ingredientName!,
                    textStyle: textStyleBody1().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600))
              ],
            ),
          ),
          TextView(
              textAlign: TextAlign.start,
              text: keyIngredientTitle.tr,
              textStyle: textStyleBody1()
                  .copyWith(fontSize: font_13, color: Colors.grey.shade600)),
        ],
      ).paddingOnly(
          left: margin_10, right: margin_10, bottom: margin_15, top: margin_10),
    );
  }

  _method() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius_10,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(text: keyMethod, textStyle: textStyleBody1())
              .paddingOnly(left: margin_5),
          Divider(
            thickness: 2,
            color: Colors.grey.shade300,
          ).paddingOnly(top: margin_5),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) => Row(
              children: [
                TextView(
                    text: controller.methodPreparation[index]["numbers"],
                    textStyle: textStyleBody1().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600)),
                TextView(
                    text: controller.recipeListDetails!.detail!.method!,
                    textStyle: textStyleBody2().copyWith(
                        fontSize: font_13point5,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600))
              ],
            ),
          )
        ],
      ).paddingOnly(
          top: margin_5, left: margin_5, right: margin_5, bottom: margin_5),
    ).paddingOnly(top: margin_20);
  }
}
