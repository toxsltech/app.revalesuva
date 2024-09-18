import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/shop/controllers/shop_detail_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:intl/intl.dart';
import 'package:simple_html_css/simple_html_css.dart';

class ShopDetailScreen extends GetView<ShopDetailController> {
  const ShopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopDetailController>(
      builder: (controllers) {
        return controller.shopLDetailsResponseModel.product!=null?
          SafeArea(
          child: Scaffold(
            backgroundColor: backGroundColor,
            floatingActionButton:
                controller.shopLDetailsResponseModel.product!.isCartAdded ==
                        true
                    ? customFloatingBtn(
                        onTap: () {
                          Get.offNamed(AppRoutes.paymentScreen);
                          // Get.off(BrainTree());
                        },
                      )
                    : null,
            body: backGroundWidget(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    customBackWidget(title: keyBack.tr)
                        .paddingOnly(bottom: margin_60),
                    detailView(context),
                    SizedBox(
                      height: height_15,
                    ),
                    // _chooseDate(),
                    SizedBox(
                      height: height_10,
                    ),
                    controller.shopLDetailsResponseModel.product!.quantity == 0
                        ? SizedBox()
                        : /*controller.shopLDetailsResponseModel.product!
                                    .isCartAdded ==
                                false
                            ?*/ Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Obx(
                                      () => counterWidget(
                                        onMinusTap: () {
                                          controller.decreaseCount();
                                          controller.update();
                                        },
                                        onPlusTap: () {
                                          if (controller.count.value <
                                              controller
                                                  .shopLDetailsResponseModel
                                                  .product!
                                                  .quantity!) {
                                            controller.increaseCount();
                                            controller.update();
                                          }
                                        },
                                        value: controller.count.toString(),
                                      ),
                                    ),
                                    Spacer(),
                                    controller.count.value != 0
                                        ? _addToCarBtn()
                                        : emptySizeBox(),
                                  ],
                                ),
                              )
                            /*: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: margin_20, vertical: margin_10),
                                decoration: BoxDecoration(
                                  color: headingTextColor,
                                  borderRadius: BorderRadius.circular(
                                    radius_20,
                                  ),
                                ),
                                child: TextView(
                                  // text: "כבר בעגלה",
                                  text: "Already in a cart",
                                  textStyle: textStyleLabelLarge().copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),*/
                    ,SizedBox(
                      height: height_10,
                    ),
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
          ),
        ):Center(child: CircularProgressIndicator(color: greenColor,),);
      },
    );
  }

  detailView(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(radius_10),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageWidget(
                imageurl:
                    controller.shopLDetailsResponseModel.product!.imageFile!,
                imageWidth: Get.width,
                imageFitType: BoxFit.fill,
                imageHeight: height_150,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: controller.shopLDetailsResponseModel.product!.title!,
                    textStyle:
                        textStyleBody1().copyWith(fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: Colors.grey.shade400,
                    height: height_5,
                  ),
                  /*TextView(
                    textAlign: TextAlign.start,
                    text: removeAllHtmlTags(controller
                        .shopLDetailsResponseModel.product!.description!),
                    textStyle: textStyleBodySmall().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: font_13,
                    ),
                  ),*/
                  RichText(
                    textAlign: TextAlign.start,
                    text: HTML.toTextSpan(
                      defaultTextStyle: textStyleBodySmall().copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400),
                      context!,
                      controller
                          .shopLDetailsResponseModel.product!.description!.toString(),
                      linksCallback: (dynamic link) {
                        launchUrl(
                          Uri.parse(link),
                        );
                      },
                    ),
                  ),
                  TextView(
                    textAlign: TextAlign.start,
                    text: controller
                                .shopLDetailsResponseModel.product!.quantity !=
                            0
                        // ? "נשאר רק: ${controller.shopLDetailsResponseModel.product!.quantity}"
                        ? "Only left : ${controller.shopLDetailsResponseModel.product!.quantity}"
                        // : "אזל במלאי",
                        : "Out of stock",
                    textStyle: textStyleBodySmall().copyWith(
                      fontWeight: FontWeight.w500,
                      color: greenColor,
                      fontSize: font_13,
                    ),
                  ),
                ],
              ).paddingAll(margin_10),
            ],
          ),
        ),
      );

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  _chooseDate() => Obx(
        () => GestureDetector(
          onTap: () {
            _selectDate();
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_25),
            ),
            child: Row(
              children: [
                (controller.dateSelected.value == false)
                    ? TextView(
                        // text: "בחירת תאריך לסדנה",
                        text: "Choosing a date for the workshop",
                        textStyle: textStyleLabelSmall().copyWith(
                            color: Colors.grey.shade700, fontSize: font_12))
                    : TextView(
                        text:
                            "${DateFormat('dd MMMM yyyy').format(controller.selectedDate.value)}",
                        textStyle: textStyleLabelSmall().copyWith(
                            color: Colors.grey.shade700, fontSize: font_12)),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: height_20,
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.overlayContext!,
        initialDate: controller.selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectedDate.value = picked;
      controller.dateSelected.value = true;
      controller.update();
    }
  }

  _addToCarBtn() => GestureDetector(
        onTap: () {
          if (controller.count.value != 0) {
            controller.hitAddToCartApiCall();
          }
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
          decoration: BoxDecoration(
            color: headingTextColor,
            borderRadius: BorderRadius.circular(
              radius_20,
            ),
          ),
          child: TextView(
            // text: "הוסף לעגלה",
            text: "Add to cart",
            textStyle: textStyleLabelLarge().copyWith(
              color: Colors.white,
            ),
          ),
        ),
      );

  _detailView({required List<queAnsModel> list}) =>
      GetBuilder<ShopDetailController>(builder: (controller) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: () {
                list[i].activeMeterIndex =
                    list[i].activeMeterIndex == i ? null : i;
                controller.update();
              },
              child: Container(
                margin: EdgeInsets.all(margin_5),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey.shade400),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius_8)),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius_8),
                  ),
                  elevation: 0,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Colors.white,
                    ),
                    child: new ExpansionPanelList(
                      elevation: 0,
                      expandedHeaderPadding:
                          EdgeInsets.only(bottom: margin_0, top: margin_0),
                      expandIconColor: list[i].activeMeterIndex == i
                          ? Colors.grey
                          : Colors.black,
                      expansionCallback: (int index, bool status) {
                        list[i].activeMeterIndex =
                            list[i].activeMeterIndex == i ? null : i;
                        controller.update();
                      },
                      children: [
                        new ExpansionPanel(
                          isExpanded: list[i].activeMeterIndex == i,
                          headerBuilder: (BuildContext context,
                                  bool isExpanded) =>
                              TextView(
                                      text: '${list[i].que}',
                                      textAlign: TextAlign.start,
                                      textStyle: textStyleBodyLarge().copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: font_16,
                                      ))
                                  .paddingOnly(left: margin_15, top: margin_10),
                          body: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: HTML.toTextSpan(
                                context,
                                "${list[i].ans}",
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
                            ).paddingOnly(bottom: margin_10, left: margin_15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}
