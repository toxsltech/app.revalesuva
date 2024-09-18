import 'package:health_fitness/export.dart';

import '../../../core/widgets/network_image.dart';
import '../controller/oreder_item_list_controller.dart';

class OrderItemListScreen extends GetView<OrderItemListController> {
  const OrderItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Container(
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                iconBackGround1,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              customBackWidget(title: keyBackToPersonalArea.tr)
                  .paddingOnly(bottom: margin_50),
              _productList(),
              SizedBox(
                height: height_15,
              ),
            ],
          ).paddingSymmetric(horizontal: margin_12),
        ),
      ),
    );
  }

  _productList() => Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
                // text: "פריט ההזמנה שלי".tr,
                text: "My Order Item".tr,
                textStyle: textStyleBody1().copyWith(height: 0)),
            SizedBox(
              height: height_10,
            ),
            Container(
              height: Get.height * 0.73,
              child: ListView.separated(
                itemCount: controller.myOrderItemList.value.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _viewContainer(index: index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.transparent,
                    height: height_20,
                  );
                },
              ),
            )
          ],
        ),
      );

  Widget _viewContainer({index}) => GestureDetector(
        onTap: () {
          // if (!controller.productList[index].isLocked!) {
          Get.toNamed(
            AppRoutes.orderItemDetailsScreen,
            arguments: {
              "id": controller.myOrderItemList.value[index].orderId,
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
                    imageurl:
                        controller.myOrderItemList.value[index].productImage,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: controller.myOrderItemList.value[index]
                                      .productName ??
                                  "",
                              textStyle: textStyleBody2(),
                            ),
                            TextView(
                              text: "Quantity: " +
                                  (controller
                                      .myOrderItemList.value[index].quantity
                                      .toString()),
                              textStyle: textStyleBody2().copyWith(),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: height_10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: "Paid: " +
                                  (controller.myOrderItemList.value[index].price
                                      .toString()),
                              textStyle:
                                  textStyleBody2().copyWith(color: greenColor),
                            ),
                            TextView(
                              text: "Price: " +
                                  (controller
                                      .myOrderItemList.value[index].totalPrice
                                      .toString()),
                              textStyle:
                                  textStyleBody2().copyWith(color: greenColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height_5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text:
                                  "Order on: ${controller.myOrderItemList.value[index].createdOn.toString().split(" ").first}",
                              textStyle: textStyleBody2(),
                            ),
                            TextView(
                              text: "view details>",
                              textStyle: textStyleBody2().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: greenColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
