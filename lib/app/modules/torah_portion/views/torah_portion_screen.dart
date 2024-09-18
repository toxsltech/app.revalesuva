import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:health_fitness/export.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../controller/torah_portion_controller.dart';

class TorahBookScreen extends GetView<TorahBookController> {
   TorahBookScreen({super.key});
  final controller = Get.put(TorahBookController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TorahBookController>(
      builder: (controllers) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: backGroundColor,
            body: backGroundWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customBackWidget(title: keyBackToHome.tr)
                      .paddingOnly(bottom: margin_50),
                  // _chooseDate(),
                  SizedBox(
                    height: height_10,
                  ),
                  TextView(
                    text: keyTorahPortion.tr,
                    textAlign: TextAlign.start,
                    textStyle: textStyleBodyLarge().copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: font_15,
                    ),
                  ).marginOnly(bottom: margin_20, right: margin_10),
                  _detailView(
                    list: controller.detailList,
                  ),
                ],
              )
                  .paddingSymmetric(
                    horizontal: margin_12,
                  )
                  .marginOnly(bottom: margin_30),
            ),
          ),
        );
      },
    );
  }

  _detailView({required List<queAnsModel> list}) => Obx(
        () => Expanded(
          child: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                )
              : controller.portionLists.value.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.portionLists.value.length,
                      padding: EdgeInsets.only(bottom: margin_15),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        return GestureDetector(
                          onTap: () {
                            controller.portionLists.value[i].activeMeterIndex =
                                controller.portionLists.value[i]
                                            .activeMeterIndex ==
                                        i
                                    ? null
                                    : i;
                            controller.update();
                          },
                          child: Column(
                            children: [
                              _enterBusinessTypeTextField(context, i),
                              // _isBusinessTypeDropDown(context, i),
                              // quesView(),
                            ],
                          ),
                        );
                      },
                    )
                  // : noDataToShow(inputText: "עדיין לא נוספה פרשת!"),
          : noDataToShow(inputText: "No Torah portion added yet!"),
        ),
      );

  _enterBusinessTypeTextField(context, i) => Container(
        width: Get.width,
        // height: ,
        // margin: EdgeInsets.all(margin_5),
        // padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.shade400),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius_15),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.all(margin_5),
                    padding: EdgeInsets.only(right: margin_10),
                    width: Get.width * 0.9,
                    // height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          maxLine: 2,
                          text: controller.portionLists.value[i].title!,
                          textAlign: TextAlign.start,
                          textStyle: textStyleBodyLarge().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: font_13,
                          ),
                        ),
                        TextView(
                          text: controller.portionLists.value[i].createdOn
                              .toString()
                              .split(" ")
                              .first,
                          textAlign: TextAlign.start,
                          textStyle: textStyleBodyLarge().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: font_12,
                          ),
                        ),

                      ],
                    ).paddingOnly(left: margin_10, top: margin_10),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.selectedIndex.value =
                        controller.selectedIndex.value == i.toString()
                            ? ""
                            : i.toString();
                    // controller.portionLists.value[i].expand =
                    //     !controller.portionLists.value[i].expand;
                    controller.update();
                  },
                  child: Container(
                    width: 50,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius_15),
                        bottomLeft: controller.selectedIndex.value == i.toString()
                            ? Radius.circular(
                                0,
                              )
                            : Radius.circular(
                                radius_15,
                              ),
                      ),
                      color: buttonColor,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            controller.selectedIndex.value == i.toString()
                ? Container(
              // height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Align(
                // alignment: Alignment.topLeft,
                child: Html(data: '${controller.portionLists.value[i].description}',style: {
                  "img": Style(
                    width:Width(Get.width-40),
                    // height:Height(100),
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),

                },),/*RichText(
                                text: HTML.toTextSpan(
                                  context,
                                  "${controller.portionLists.value[i].description}",
                                  defaultTextStyle: textStyleBody1().copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overrideStyle: <String, TextStyle>{
                                    "body": TextStyle(
                                        color: Colors.black,
                                        fontSize: font_18,
                                        fontFamily: "Poppins")
                                  },
                                ),
                              ).paddingOnly(
                                bottom: margin_10,
                                left: margin_0,
                              ),*/
              ),
            ).paddingOnly(top: margin_10)
                : emptySizeBox()
          ],
        ),
      ).paddingOnly(top: margin_8);

  _isBusinessTypeDropDown(context, i) {
    return controller.portionLists.value[i].expand!
        ? Container(
            // height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: HTML.toTextSpan(
                  context,
                  "${controller.portionLists.value[i].description}",
                  defaultTextStyle: textStyleBody1().copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  overrideStyle: <String, TextStyle>{
                    "body": TextStyle(
                        color: Colors.black,
                        fontSize: font_18,
                        fontFamily: "Poppins")
                  },
                ),
              ).paddingOnly(
                bottom: margin_10,
                left: margin_15,
              ),
            ),
          )
        : emptySizeBox();
  }

  Widget quesView() {
    return Container(
      height: 100,
      child: ListView.builder(
          itemCount: controller.portionLists.value.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(margin_15),
              margin: EdgeInsets.all(margin_10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.selectedQue.value = index;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextView(
                              textAlign: TextAlign.start,
                              text: "What is Muslim Date App?",
                              textStyle: textStyleTitleMedium()),
                        ),
                        SizedBox(
                          width: width_8,
                        ),
                        Icon(
                          controller.selectedQue.value != index
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.selectedQue.value == index,
                      child: Column(
                        children: [
                          Divider(
                            height: height_10,
                            color: Colors.grey.shade300,
                          ),
                          TextView(
                            textAlign: TextAlign.justify,
                            text: 'Muslim Date App is a dating app ' * 10,
                            textStyle: textStyleBodySmall(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  customTile(
          {String? question,
          String? answer,
          void Function(bool)? onExpansionChanged,
          bool maintainState = false}) =>
      Stack(
        children: [
          Container(
            // width: Get.width * 0.85,
            margin: EdgeInsets.symmetric(
                horizontal: margin_10, vertical: margin_10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(radius_10)),
            child: Container(
              child: ExpansionTile(
                maintainState: maintainState,
                title: TextView(
                    textAlign: TextAlign.start,
                    text: question ?? '',
                    textStyle: textStyleTitle(),
                    maxLine: 3),
                children: [
                  /*  Divider(
                    color: Colors.grey,
                  ).marginAll(margin_6),*/
                  Align(
                    alignment: Alignment.topLeft,
                    child: HtmlWidget(
                      answer!,
                      // onLinkTap: (url, context, attributes, element) {},
                    ).marginAll(margin_10),
                  )
                ],
                onExpansionChanged: onExpansionChanged,
              ),
            ),
          ),
        ],
      );

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
