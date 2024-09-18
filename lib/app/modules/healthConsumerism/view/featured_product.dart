import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/featured_product_controller.dart';

import '../../../../export.dart';
import '../../../core/values/validator.dart';
import '../../../core/widgets/custom_inkwell.dart';

class FeaturedProduct extends GetView<FeaturedProductController> {
  FeaturedProduct({super.key});

  final controller = Get.put(FeaturedProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedProductController>(builder: (controllers) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF6EBDD),
          floatingActionButton: FloatingActionButton.large(
            backgroundColor: greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            tooltip: 'תוֹסֶפֶת',
            // tooltip: 'Increment',
            onPressed: () {
              Get.bottomSheet(
                _bottomSheet(),
              );
            },
            child: TextView(
                // text: "רשימת קניות",
                text: keyListShopping.tr,
                textStyle: textStyleBody2()
                    .copyWith(color: Colors.white, fontSize: font_13)),
          ),
          body: _body(),
        ),
      );
    });
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        // height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  iconBackGround1,
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
            _productList().marginOnly(top: margin_100),
            searchTextField(),
            productDesc()
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
        itemBuilder: (context, index) => Obx(() => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = index;
                    controller.selectedCategoryId =
                        controller.categoryList[index].id!;
                    controller.getCategoryDetailsAPI(
                        id: controller.selectedCategoryId, search: "");
                    controller.getShoppingListAPI();
                    controller.selectedIndex.refresh();
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: radius_35,
                      child: NetworkImageWidget(
                        imageHeight: height_70,
                        imageWidth: height_70,
                        radiusAll: radius_35,
                        imageurl: controller.categoryList[index].image!,
                      )),
                ),
                TextView(
                    text: controller.categoryList[index].title!,
                    textStyle: textStyleBody2().copyWith(
                      fontSize: font_16,
                      color: controller.selectedIndex.value == index
                          ? greenColor
                          : null,
                    )).marginOnly(top: margin_10)
              ],
            ).paddingOnly(right: margin_20)),
        itemCount: controller.categoryList.length,
      ),
    );
  }

  Widget searchTextField() {
    return GetBuilder<FeaturedProductController>(builder: (controllers) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                Future.delayed(
                  Duration(milliseconds: 600),
                  () {
                    controller.getCategoryDetailsAPI(
                        id: controller.selectedCategoryId, search: value);
                  },
                );
                controller.update();
              },
              decoration: InputDecoration(
                  hintText: "לחפש",
                  // hintText: "Search",
                  hintStyle: textStyleBody2().copyWith(color: Colors.black),
                  prefixIcon: Icon(Icons.search, size: 23),
                  fillColor: Colors.white,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(margin_5),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(margin_5),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(margin_5),
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(margin_5),
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(margin_5),
                      borderSide: BorderSide(color: Colors.transparent))),
              controller: controller.searchController,
            ),
          )),
        ],
      ).paddingOnly(
        top: margin_15,
        bottom: margin_15,
      );
    });
  }

  Widget productDesc() {
    return GetBuilder<FeaturedProductController>(builder: (controllers) {
      return controller.categoryDetailsList.isNotEmpty
          ? GridView.count(
              padding: EdgeInsets.only(bottom: margin_100),
              // primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: margin_15,
              // physics: AlwaysScrollableScrollPhysics(),
              mainAxisSpacing: margin_15,
              crossAxisCount: 2,
              childAspectRatio: 5 / 6,
              children: List.generate(
                controller.categoryDetailsList.length,
                (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius_10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 2.0,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height_85,
                                decoration: BoxDecoration(
                                  color: Color(0xffF6EBDD),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ).paddingAll(
                                margin_5,
                              ),
                              NetworkImageWidget(
                                imageurl:
                                    controller.categoryDetailsList[index].image,
                                imageHeight: height_60,
                                imageWidth: height_60,
                                radiusAll: radius_50,
                                imageFitType: BoxFit.cover,
                              ),
                            ],
                          ),
                          TextView(
                            text: controller.categoryDetailsList[index].title!,
                            textStyle: textStyleHeading2().copyWith(
                                fontSize: font_15, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ).paddingOnly(
                            right: margin_7,
                          ),
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade300,
                          ).marginSymmetric(vertical: margin_10),
                          controller.categoryDetailsList[index].status == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        GetInkWell(
                                          onTap: () {
                                            controller.minus();
                                            if (controller
                                                    .categoryDetailsList[index]
                                                    .productQuantity !=
                                                0) {
                                              controller
                                                  .categoryDetailsList[index]
                                                  .productQuantity = controller
                                                      .categoryDetailsList[
                                                          index]
                                                      .productQuantity! -
                                                  1;
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: Icon(
                                              size: 20,
                                              Icons.remove,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        TextView(
                                          text: controller
                                              .categoryDetailsList[index]
                                              .productQuantity
                                              .toString(),
                                          // text: controller.n.value.toString(),
                                          textStyle: textStyleBody2(),
                                        ).paddingOnly(
                                            left: margin_8, right: margin_8),
                                        GetInkWell(
                                          onTap: () {
                                            controller.add();
                                            if (controller
                                                    .categoryDetailsList[index]
                                                    .quantity! ==
                                                controller
                                                    .categoryDetailsList[index]
                                                    .productQuantity!) {
                                              // toast("לא במלאי");
                                              // "More than ${controller.categoryDetailsList[index].quantity!} is not in stock");
                                            } else {
                                              controller
                                                  .categoryDetailsList[index]
                                                  .productQuantity = controller
                                                      .categoryDetailsList[
                                                          index]
                                                      .productQuantity! +
                                                  1;
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: Icon(
                                              size: 20,
                                              Icons.add,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    controller.categoryDetailsList[index]
                                                .productQuantity !=
                                            0
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.addProductApi(
                                                  productId: controller
                                                      .categoryDetailsList[
                                                          index]
                                                      .id,
                                                  quantity: controller
                                                      .categoryDetailsList[
                                                          index]
                                                      .productQuantity);
                                              controller.update();
                                            },
                                            child: Container(
                                              width: width_60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.black54),
                                              alignment: Alignment.center,
                                              child: TextView(
                                                textStyle: textStyleBody2()
                                                    .copyWith(
                                                        fontSize: font_15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                text: keySelect.tr,
                                                // text: "Select",
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: width_60,
                                          ),
                                  ],
                                ).paddingOnly(top: margin_0)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width_60,
                                      padding: EdgeInsets.all(
                                        5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        color: greenColor,
                                      ),
                                      child: TextView(
                                        textStyle: textStyleBody2().copyWith(
                                          fontSize: font_12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        text: keySelected.tr,
                                        // text: "Selected",
                                      ),
                                    ).marginOnly(bottom: margin_5),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ).paddingOnly(bottom: margin_20)
          : Container(
              height: height_150,
              child: noDataToShow(inputText: "לא נמצאו מוצרים"),
              // child: noDataToShow(inputText: "No products found"),
            );
    });
  }

  _bottomSheet() {
    return Container(
        height: Get.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_30),
                topRight: Radius.circular(radius_30))),
        child: Column(
          children: [
            Container(
              height: height_50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_30),
                    topRight: Radius.circular(radius_30)),
                color: greenColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                      text: keyShoppingList.tr,
                      textStyle: textStyleBody1()
                          .copyWith(fontSize: font_18, color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      color: Colors.white,
                      Icons.cancel,
                      size: 30,
                    ),
                  )
                ],
              ).paddingOnly(left: margin_20, right: margin_20),
            ),
            _addProducts()
          ],
        ));
  }

  _addProducts() {
    return GetBuilder<FeaturedProductController>(
      builder: (controllers) {
        return Expanded(
          child: controller.productDetailsList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.productDetailsList.length,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius_10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurRadius: 0.5, color: Colors.grey)
                              ]),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF6EBDD),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                  ).paddingAll(
                                    margin_5,
                                  ),
                                  NetworkImageWidget(
                                    imageurl: controller
                                        .productDetailsList[index]
                                        .productImage!,
                                    imageHeight: height_40,
                                    imageWidth: height_40,
                                    radiusAll: radius_50,
                                    imageFitType: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextView(
                                      text: controller.productDetailsList[index]
                                          .productName!,
                                      textStyle: textStyleBody1().copyWith(
                                          fontWeight: FontWeight.w600)),
                                  TextView(
                                      text: keyListQuantity.tr +
                                          controller.productDetailsList[index]
                                              .quantity
                                              .toString(),
                                      textStyle: textStyleBody1()
                                          .copyWith(color: Colors.grey))
                                ],
                              ),
                              /* GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: height_33,
                                  width: width_33,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radius_10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(blurRadius: 1, color: Colors.grey)
                                      ]),
                                  child: Icon(Icons.edit),
                                ).paddingOnly(
                                    bottom: margin_25, left: margin_50, right: margin_10),
                              ),*/
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.deleteProductAPI(
                                          controller
                                              .productDetailsList[index].id,
                                        );
                                        // controller.getShoppingListAPI();
                                        // Get.back();
                                        // Get.bottomSheet(
                                        //   _bottomSheet(),
                                        // );
                                        controller.update();
                                      },
                                      child: Container(
                                        height: height_33,
                                        width: width_33,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(radius_10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                color: Colors.grey)
                                          ],
                                        ),
                                        child: AssetImageWidget(
                                          imageUrl: iconDelete,
                                        ),
                                      ).paddingOnly(bottom: margin_25),
                                    ),
                                  ],
                                ).paddingOnly(left: margin_10),
                              ),
                            ],
                          ),
                        ).paddingOnly(
                            top: margin_7,
                            left: margin_15,
                            right: margin_15,
                            bottom: margin_8),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _customerDetails(),
                      SizedBox(
                        height: 15,
                      ),
                      // _shipment(),
                      _updateButton(
                        title: keyPlaceOrder.tr,
                        onTap: () {
                          if (controller.billingFormGlobalKey.currentState!
                              .validate()) {
                            controller.hitPlaceOrderApiCall();
                          }
                        },
                      ).paddingOnly(
                        right: margin_10,
                        bottom: margin_10,
                      )
                    ],
                  ),
                )
              : noDataToShow(inputText: "לא נמצאו מוצרים"),
          // : noDataToShow(inputText: "No products found"),
        );
      },
    );
  }

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
            // Obx(
            //   () => Visibility(
            //     visible: controller.isEdit.value,
            //     child: _updateButton(
            //       title: keyPlaceOrder.tr,
            //       onTap: () {
            //         if (controller.billingFormGlobalKey.currentState!
            //             .validate()) {
            //           // controller.hitPlaceOrderApiCall();
            //         }
            //       },
            //     ),
            //   ),
            // )
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
            GetBuilder<FeaturedProductController>(
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
                              controller.selectedIndexCart.value = index;
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
                              imageUrl:
                                  controller.selectedIndexCart.value == index
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
}
