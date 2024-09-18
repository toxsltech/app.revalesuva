import 'package:health_fitness/export.dart';

import '../controller/order_list_controller.dart';

class OrderListScreen extends GetView<OrderListController> {
  const OrderListScreen({super.key});

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
                  fit: BoxFit.cover)),
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
                text: "My Order".tr,
                // text: "ההזמנה שלי".tr,
                textStyle: textStyleBody1().copyWith(height: 0)),
            SizedBox(
              height: height_10,
            ),
            Container(
              height: Get.height * 0.73,
              child: ListView.separated(
                itemCount: controller.myOrderList.value.length,
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
            AppRoutes.orderItemListScreen,
            arguments: {
              "id": controller.myOrderList.value[index].id,
            },
          );
          /*} else {
            toast(keyThisProductIsLocked.tr);
          }*/
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_12),
          ),
          padding: EdgeInsets.all(margin_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text:
                                  "Order ID : #${controller.myOrderList.value[index].uniqueId}",
                              textStyle: textStyleBody2()
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            TextView(
                              text:
                                  "${controller.myOrderList.value[index].createdOn.toString().split(" ").first}",
                              textStyle: textStyleBody2()
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        TextView(
                          text: "Shipped to:",
                          textStyle: textStyleBody2()
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 20,
                            ),
                            TextView(
                              text:
                                  "${controller.myOrderList.value[index].address!.fullName}",
                              textStyle: textStyleBody2(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 20,
                            ),
                            TextView(
                              text:
                                  "${controller.myOrderList.value[index].address!.address}-${controller.myOrderList.value[index].address!.zipCode}",
                              textStyle: textStyleBody2(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.contacts_sharp,
                              size: 20,
                            ),
                            TextView(
                              text:
                                  "${controller.myOrderList.value[index].address!.contactNo}",
                              textStyle: textStyleBody2(),
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
                                text: "Total price : " +
                                    (controller.myOrderList.value[index].price
                                        .toString()),
                                textStyle: textStyleBody2()
                                    .copyWith(color: greenColor)),
                            TextView(
                              text:
                                  "${controller.myOrderList.value[index].itemCount} Item",
                              textStyle: textStyleBody2()
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              SizedBox(
                height: height_5,
              ),
            ],
          ),
        ),
      );
}
