import 'package:health_fitness/export.dart';

import '../controller/order_item_details_controller.dart';

class OrderItemDetailsScreen extends GetView<OrderItemDetailsController> {
  const OrderItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderItemDetailsController>(builder: (controllers) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: controller.orderItemDetailsResponse.detail != null
              ? backGroundWidget(
                  child: Column(
                    children: [
                      customBackWidget(title: keyBackToStore.tr)
                          .paddingOnly(bottom: margin_50),
                      _productList(),
                      SizedBox(
                        height: height_15,
                      ),
                      _customerDetails(),
                      SizedBox(
                        height: height_15,
                      ),
                      // _shipment(),
                      SizedBox(
                        height: 15,
                      ),
                      // _couponCode(),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      controller.orderItemDetailsResponse.detail!.stateId ==
                              STATE_ORDER_CANCELLED
                          ? SizedBox()
                          : _updateButton(
                              title: "Cancel order",
                              onTap: () {
                                controller.hitCancelOrderItem();
                              }),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: margin_12),
                )
              : Center(child: CircularProgressIndicator()),
        ),
      );
    });
  }

  _productList() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius_10),
        ),
        padding: EdgeInsets.all(margin_10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
                text: controller.state!,
                textStyle: textStyleBody1().copyWith(
                    height: 0, color: greenColor, fontWeight: FontWeight.bold)),
            SizedBox(
              height: height_10,
            ),
            _productItem(),
          ],
        ),
      );

  Widget _productItem() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NetworkImageWidget(
          //   imageurl: controller.orderItemDetailsResponse.detail!.,
          //   imageWidth: height_50,
          //   imageHeight: height_50,
          //   imageFitType: BoxFit.fill,
          //   radiusAll: radius_8,
          // ),
          SizedBox(
            width: width_7,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    text:
                        "Order id: #${controller.orderItemDetailsResponse.detail!.uniqueId}",
                    textStyle: textStyleBody2()),
                TextView(
                  text:
                      "Paid: ${controller.orderItemDetailsResponse.detail!.price}",
                  textStyle: textStyleBody2().copyWith(color: greenColor),
                ),
                // SizedBox(
                //   height: height_5,
                // ),
                TextView(
                  text:
                      "Price: ${controller.orderItemDetailsResponse.detail!.totalPrice}",
                  textStyle: textStyleBody2().copyWith(color: greenColor),
                ),
                /* Obx(
                  () => counterWidget(
                    value: controller.count.value.toString(),
                    onPlusTap: () {
                      controller.increaseCount();
                    },
                    onMinusTap: () {
                      controller.decreaseCount();
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ],
      );

  _customerDetails() => Container(
        padding: EdgeInsets.all(margin_10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius_10),
        ),
        child: Column(
          children: [
            _titleAndEdit(),
            SizedBox(
              height: height_10,
            ),
            _shipmentDetails(),
            SizedBox(
              height: height_10,
            ),
            Obx(() => Visibility(
                visible: controller.isEdit.value, child: _updateButton()))
          ],
        ),
      );

  _titleAndEdit() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(text: keyShipmentDetail.tr, textStyle: textStyleBody1()),
          /*GestureDetector(
            onTap: () {
              controller.isEdit.value = !controller.isEdit.value;
            },
            child: AssetImageWidget(
              imageUrl: iconEdit,
              imageHeight: height_35,
              imageWidth: height_35,
            ),
          ),*/
        ],
      );

  _shipmentDetails() {
    return Form(
      key: controller.billingFormGlobalKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  text: "Name:",
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              TextView(
                  text: controller
                      .orderItemDetailsResponse.detail!.address!.fullName,
                  textStyle: TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  text: "Email:",
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              TextView(
                  text: controller
                      .orderItemDetailsResponse.detail!.address!.email,
                  textStyle: TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  text: "Phone:",
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              TextView(
                  text: controller
                      .orderItemDetailsResponse.detail!.address!.contactNo,
                  textStyle: TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  text: "Address:",
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              TextView(
                  text: controller
                      .orderItemDetailsResponse.detail!.address!.address,
                  textStyle: TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                  text: "Zipcode:",
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  )),
              TextView(
                  text: controller
                      .orderItemDetailsResponse.detail!.address!.zipCode,
                  textStyle: TextStyle(fontWeight: FontWeight.w400)),
            ],
          )
        ],
      ),
    );
  }

  _shipment() => Container(
        padding: EdgeInsets.all(margin_12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(text: keyShipment.tr, textStyle: textStyleBody1()),
            GetBuilder<OrderItemDetailsController>(
              builder: (controllers) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.shipment.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedIndex.value = index;
                              index == 0
                                  ? controller.shipmentType.value =
                                      TYPE_HOME_DELIVERY
                                  : controller.shipmentType.value =
                                      TYPE_SELF_PICKUP;
                              debugPrint(
                                  controller.shipmentType.value.toString());
                              controller.update();
                            },
                            child: AssetImageWidget(
                              imageUrl: controller.selectedIndex.value == index
                                  ? iconRadioFill
                                  : iconRadio,
                              imageWidth: height_20,
                              imageHeight: height_20,
                            ),
                          ),
                          SizedBox(
                            width: width_5,
                          ),
                          TextView(
                              text: "${controller.shipment[index].title}",
                              textStyle: textStyleBody2()
                                  .copyWith(color: Colors.grey.shade600)),
                        ],
                      ).paddingSymmetric(vertical: margin_2);
                    });
              },
            ),
          ],
        ),
      );

  Widget _updateButton({onTap, title}) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButtonWidget(
        onPressed: onTap ?? () {},
        //buttonRadius: radius_20,
        // minWidth: Get.width * 0.25,
        padding: margin_8,
        minHeight: 50,
        buttonText: title ?? keyUpdate.tr,
        buttonColor: Colors.grey.shade800,
      ),
    );
  }
}
