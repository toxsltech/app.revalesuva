import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/shop/controllers/shop_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:simple_html_css/simple_html_css.dart';

class ShopScreen extends GetView<ShopController> {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        floatingActionButton: customFloatingBtn(
          onTap: () {
            Get.toNamed(AppRoutes.paymentScreen);
          },
        ),
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  iconBackGround1,
                ),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                customBackWidget()
                    .paddingOnly(left: margin_12, bottom: margin_60),
                _categoryList(),
                _searchAndFilter(),
                listView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _categoryList() => Obx(
        () => Container(
          height: height_100,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.categoryLists.length,
            itemBuilder: (context, index) {
              return Obx(
                () => Container(
                  width: width_85,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectedIndex.value = index;
                          controller.getShopListByCategory(
                              controller.categoryLists[index].id,controller.type);
                          controller.selectedId.value =  controller.categoryLists[index].id.toString();
                          controller.workshopList.refresh();
                          controller.selectedIndex.refresh();
                        },
                        child: NetworkImageWidget(
                          imageurl: controller.categoryLists[index].imageFile,
                          imageWidth: height_50,
                          imageHeight: height_50,
                          radiusAll: radius_50,
                          imageFitType: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: height_5,
                      ),
                      TextView(
                        textAlign: TextAlign.center,
                        text: "${controller.categoryLists[index].title}",
                        textStyle: textStyleBody2().copyWith(
                            height: height_0,
                            color: controller.selectedIndex.value == index
                                ? greenColor
                                : Colors.black),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  _searchAndFilter() => Row(
        children: [
          Expanded(
            child: _searchTextField(),
          ),
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
                                controller.type = 0;
                              } else if (index == 2) {
                                controller.type = 1;
                              }
                              controller.getShopListByCategory(controller.selectedId.value,controller.type);
                              controller.update();
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
                                  color:
                                  controller.foodSelectedIndex.value == index
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
                  ),
                ),
              ];
            },
          )
          // SizedBox(
          //   width: width_5,
          // ),
          // AssetImageWidget(
          //   imageUrl: iconFilter,
          //   imageHeight: height_50,
          //   imageWidth: height_50,
          // ),
        ],
      ).paddingSymmetric(horizontal: margin_12).paddingOnly(bottom: margin_15);

  _searchTextField() => TextFieldWidget(
        hint: keySearchByFreeText.tr,
        prefixIcon: Icon(Icons.search),
      );

  listView(BuildContext contexts) => Obx(
        () => controller.workshopList.value.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: margin_12,
                  right: margin_12,
                  bottom: margin_100,
                ),
                itemCount: controller.workshopList.value.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _viewContainer(index: index, context:contexts);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height_10,
                  );
                },
              )
            : Container(
                height: Get.height * 0.5,
                child: noDataToShow(inputText: "לא נמצאו סדנה ואירוע"),
                // child: noDataToShow(inputText: "No workshop & event found"),
              ),
      );

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  String removeAlllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  Widget _viewContainer({index,BuildContext? context}) => GestureDetector(
        onTap: () {
          // if (!controller.productList[index].isLocked!) {
          Get.toNamed(
            AppRoutes.shopDetailScreen,
            arguments: {
              "id": controller.workshopList.value[index].id,
            },
          );
          /*} else {
            toast(keyThisProductIsLocked.tr);
          }*/
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_12)),
          padding: EdgeInsets.all(margin_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NetworkImageWidget(
                    imageurl: controller.workshopList.value[index].imageFile,
                    imageHeight: height_70,
                    imageWidth: height_70,
                    imageFitType: BoxFit.fill,
                    radiusAll: radius_5,
                  ),
                  SizedBox(
                    width: width_10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text:
                              controller.workshopList.value[index].title ?? "",
                          textStyle: textStyleBody2(),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: height_10,
                        ),
                        // if (controller.productList[index].isLocked!)
                          TextView(
                              text: "${keyTicketPrice.tr} " +
                                  (controller.workshopList.value[index].price
                                      .toString()),
                              textStyle:
                                  textStyleBody2().copyWith(color: greenColor)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (controller.productList[index].isLocked!)
                            //   Icon(
                            //     Icons.lock,
                            //     size: height_15,
                            //   ),
                            Expanded(
                                child: /*TextView(
                                  textAlign: TextAlign.start,
                                  text: removeAllHtmlTags(controller
                                          .workshopList.value[index].description
                                          .toString()) ??
                                      "",
                                  textStyle: textStyleBodySmall().copyWith(
                                      color: Colors.grey.shade700,c
                                      fontWeight: FontWeight.w400)),*/
                                    RichText(
                              textAlign: TextAlign.start,
                              text: HTML.toTextSpan(
                                defaultTextStyle: textStyleBodySmall().copyWith(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w400),
                                context!,
                                controller
                                    .workshopList.value[index].description.toString(),
                                linksCallback: (dynamic link) {
                                  /*launchUrl(
                                    Uri.parse(link),
                                  );*/
                                },
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height_5,
              ),
              // if (!controller.productList[index].isLocked!)
                TextView(
                    // text: "מחיר הסדנה: " +
                        text: "Workshop price: " +
                        (controller.workshopList.value[index].price.toString()),
                    textStyle: textStyleBody2().copyWith(
                        color: greenColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
}
