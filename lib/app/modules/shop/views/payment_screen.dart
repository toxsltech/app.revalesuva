import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/shop/controllers/payment_controller.dart';
import 'package:health_fitness/export.dart';

import '../../../core/values/validator.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: margin_50),
          child: backGroundWidget(
            child: Column(
              children: [
                customBackWidget(title: keyBackToStore.tr)
                    .paddingOnly(bottom: margin_90),
                _productList(),
                SizedBox(
                  height: height_15,
                ),
                _customerDetails(),
                SizedBox(
                  height: height_15,
                ),
                _shipment(),
                SizedBox(
                  height: 15,
                ),
                // _couponCode(),
                // SizedBox(
                //   height: 15,
                // ),
                // _payment(),
                SizedBox(
                  height: 15,
                ),
              ],
            ).paddingSymmetric(horizontal: margin_12),
          ),
        ),
      ),
    );
  }

  _productList() => Obx(
        () => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_10)),
          padding: EdgeInsets.all(margin_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                  text: keyYourOrder.tr,
                  textStyle: textStyleBody1().copyWith(height: 0)),
              SizedBox(
                height: height_10,
              ),
              ListView.separated(
                itemCount: controller.cartList.value.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _productItem(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey.shade300,
                    height: height_20,
                  );
                },
              )
            ],
          ),
        ),
      );

  Widget _productItem(index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageWidget(
            imageurl: controller.cartList.value[index].productImage,
            imageWidth: height_50,
            imageHeight: height_50,
            imageFitType: BoxFit.fill,
            radiusAll: radius_8,
          ),
          SizedBox(
            width: width_7,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    text:
                        // "שם מוצר: ${controller.cartList.value[index].productName}",
                        "Product name: ${controller.cartList.value[index].productName}",
                    textStyle: textStyleBody2()),
                TextView(
                  text: "${keyTicketPrice.tr} ${controller.cartList.value[index].price}",
                  textStyle: textStyleBody2().copyWith(color: greenColor),
                ),
                // SizedBox(
                //   height: height_5,
                // ),
                TextView(
                  text:
                      "${keyListQuantity.tr} ${controller.cartList.value[index].quantity}",
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
          GestureDetector(
            onTap: () {
              controller.hitDeleteCartItem(controller.cartList.value[index].id);
              controller.cartList.refresh();
            },
            child: AssetImageWidget(
              imageUrl: iconDelete,
              imageWidth: height_40,
              imageHeight: height_40,
              imageFitType: BoxFit.fill,
              radiusAll: radius_8,
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
            _formField(),
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
          TextView(text: keyCustomerDetail.tr, textStyle: textStyleBody1()),
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

  _formField() {
    return Form(
      key: controller.billingFormGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
            maxLength: 30,
            labelMargin: margin_3,
            hint: keyFullName.tr,
            decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius_20),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.nameTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            validate: (value) => Validator.ValidateName(value),
          ),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            maxLength: 30,
            hint: keyEmail.tr,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.emailTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            validate: (value) => Validator.validateEmail(
              value,
            ),
          ).paddingSymmetric(vertical: margin_10),
          TextFieldWidget(
            labelMargin: margin_3,
            radius: radius_10,
            hint: keyPhone.tr,
            maxLength: 10,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.phoneTxtController,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyPhone.tr),
          ),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            hint: keyAddress.tr,
            maxLength: 32,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.addressTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.streetAddress,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyAddress.tr),
          ).paddingSymmetric(vertical: margin_10),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            maxLength: 6,
            hint: keyZipCode.tr,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.zipTxtController,
            // inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyZipCode.tr),
          ),
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
            GetBuilder<PaymentController>(
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

  _payment() => GetBuilder<PaymentController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.all(margin_12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(text: keyPaymentInfo.tr, textStyle: textStyleBody1()),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.paymentOption.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedPaymentOption.value = index;
                            controller.update();
                          },
                          child: AssetImageWidget(
                            imageUrl:
                                controller.selectedPaymentOption.value == index
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
                            text: "${controller.paymentOption[index].title}",
                            textStyle: textStyleBody2()
                                .copyWith(color: Colors.grey.shade600)),
                      ],
                    ).paddingSymmetric(vertical: margin_2);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text:
                        // "הסכום הכולל לתשלום ${controller.itemCartListResponseModel.totalPrice}",
                        "Total amount to be paid ${controller.itemCartListResponseModel.totalPrice}",
                    textStyle: textStyleBody2().copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  _updateButton(
                    title: keyPlaceOrder.tr,
                    onTap: () {
                      if (controller.billingFormGlobalKey.currentState!
                          .validate()) {
                        controller.hitPlaceOrderApiCall();
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        );
      });

  _couponCode() => Container(
        padding: EdgeInsets.all(margin_12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(text: keyCouponCode.tr, textStyle: textStyleBody1()),
            SizedBox(
              height: height_5,
            ),
            TextFieldWidget(
              labelMargin: margin_3,
              hint: keyHaveAcouponCode.tr,
              decoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius_20),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              contentPadding: EdgeInsets.symmetric(
                  vertical: margin_10, horizontal: margin_15),
              textController: controller.couponTxtController,
              inputType: TextInputType.name,
              // validate: (value) => Validator.ValidateName(value),
            ),
            SizedBox(
              height: height_5,
            ),
            _updateButton(
              title: "Apply",
              onTap: () {},
            )
          ],
        ),
      );

  Widget _updateButton({onTap, title}) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButtonWidget(
        onPressed: onTap ?? () {},
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: title ?? keyUpdate.tr,
        buttonColor: Colors.grey.shade800,
      ),
    );
  }
}
