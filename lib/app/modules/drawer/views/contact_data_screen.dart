import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:health_fitness/app/modules/drawer/controller/contact_data_controller.dart';

import '../../../../export.dart';
import '../../../core/values/validator.dart';

class ContactDataScreen extends GetView<ContactDataController> {
  final contactFormGlobalKey = GlobalKey<FormState>();
  ContactDataScreen({super.key});

  final controller = Get.put(ContactDataController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor2,
        body: GetBuilder(
          init: ContactDataController(),
          builder: (controllers) {
            return SingleChildScrollView(
              child: Container(
                // height: Get.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      iconBackGround2,
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
                            padding: EdgeInsets.all(
                              2,
                            ),
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
                          ).marginOnly(
                            right: margin_10,
                          ),
                        ),
                        TextView(
                          text: keyBackToPersonalProfile.tr,
                          textStyle: textStyleBodyMedium().copyWith(
                              fontWeight: FontWeight.w600, fontSize: font_12),
                        ).marginOnly(right: margin_10)
                      ],
                    ).marginOnly(bottom: margin_10),
                    TextView(
                      text: keyContactData.tr,
                      textStyle: textStyleBody1()
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height_50,
                    ),
                    Container(
                      // padding: EdgeInsets.all(margin_10),
                      margin: EdgeInsets.symmetric(vertical: margin_6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius_25),
                          bottomRight: Radius.circular(radius_25),
                        ),
                      ),
                      child: _profileDetail(),
                    ).marginOnly(top: margin_30),
                  ],
                ).paddingAll(margin_12).marginOnly(top: margin_20),
              ),
            );
          },
        ),
      ),
    );
  }

  _profileDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleAndEdit(),
          _customText(
            title: keyEmail.tr,
            subTitle: controller.emailTxtController.text,
            icon: iconEmail,
          ),
          _customText(
            title: keyPhone.tr,
            subTitle: controller.phoneTxtController.text,
            icon: iconPhone,
          ),
          _customText(
            title: keyAge.tr,
            subTitle: controller.ageTxtController.text,
            icon: iconAge,
          ),
          _customText(
            title: keyGender.tr,
            subTitle: controller.genderTxtController.text,
            icon: iconGender,
          ),
          _customText(
            title: keyFloor.tr,
            subTitle: controller.floorTxtController.text,
            icon: iconCity,
          ),
          _customText(
            title: keyApartment.tr,
            subTitle: controller.apartmentTxtController.text,
            icon: iconCity,
          ),
          _customText(
            title: keyStreet.tr,
            subTitle: controller.streetTxtController.text,
            icon: iconLogoutFill,
          ),
          _customText(
            title: keyCity.tr,
            subTitle: controller.cityTxtController.text,
            icon: iconCity,
          ),
          // _customText(
          //     title: keyPractice.tr,
          //     subTitle: 'Practice Content',
          //     icon: iconPractice),
        ],
      );

  Widget EditRow({required String title, required Widget texField}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextView(
                    textAlign: TextAlign.start,
                    text: title + " :",
                    textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.bold, fontSize: font_12))
                .paddingOnly(top: margin_11, right: margin_5),
          ),
          Expanded(flex: 3, child: texField),
        ],
      ).paddingOnly(bottom: margin_10);

  _customText({title, icon, subTitle}) => Row(
        children: [
          AssetImageWidget(
            imageUrl: icon,
            imageHeight: height_25,
          ).marginOnly(right: margin_10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                  text: title, textStyle: textStyleBodyMedium().copyWith()),
              TextView(
                  text: subTitle,
                  textStyle: textStyleBody1()
                      .copyWith(fontSize: font_12, color: Colors.black54))
            ],
          )
        ],
      ).paddingOnly(left: margin_10, right: margin_10, bottom: margin_10);

  _titleAndEdit() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_12)),
          color: greenColor),
      height: height_40,
      child: Row(
        children: [
          TextView(
              text: controller.name.value,
              textStyle: textStyleBody2()
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(enableDrag: true, _bottomSheet());
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(radius_5))),
              child: Icon(
                Icons.mode,
                size: height_15,
              ),
            ),
          )
        ],
      ),
    ).marginOnly(bottom: margin_15);
  }

  _bottomSheet() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius_10),
              topRight: Radius.circular(radius_10))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: margin_10, vertical: margin_10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_10),
                    topRight: Radius.circular(radius_10)),
                color: greenColor),
            child: Row(
              children: [
                TextView(
                    text: keyEditContactData.tr,
                    textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: height_18,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            // height: height_100,
            child: ListView(
              // physics: AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              children: [
                _editForm(),
                _updateButton(),
              ],
            ).marginOnly(top: margin_15),
          )
        ],
      ).marginOnly(bottom: margin_15),
    );
  }

  _editForm() {
    return Form(
      key: contactFormGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: keyFullName.tr,
            labelMargin: margin_3,
            hint: keyFullName.tr,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            onChange: (value) {
              if (value == " ") {
                controller.nameTxtController.text = "";
              }
            },
            formatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.nameTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) => Validator.ValidateName(value),
          ),
          TextFieldWidget(
            readOnly: true,
            labelMargin: margin_3,
            labelText: keyPhone.tr,
            radius: radius_10,
            hint: keyPhone.tr,
            maxLength: 10,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.phoneTxtController,
            validate: (value) => Validator.ValidateName(value),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            readOnly: true,
            radius: radius_10,
            labelText: keyEmail.tr,
            labelMargin: margin_3,
            hint: 'Email',
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.emailTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            validate: (value) => Validator.ValidateName(value),
          ),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            labelText: keyAge.tr,
            hint: 'Age',
            maxLength: 3,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.ageTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyAge.tr),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            readOnly: true,
            radius: radius_10,
            labelMargin: margin_3,
            labelText: keyGender.tr,
            hint: 'Gender',
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.genderTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyGender.tr),
          ),

          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            labelText: keyFloor.tr,
            hint: keyFloor.tr,
            maxLength: 20,
            // inputFormatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.floorTxtController,
            onChange: (value) {
              if (value == " ") {
                controller.floorTxtController.text = "";
              }
            },
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyFloor.tr),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            labelText: keyApartment.tr,
            hint: keyApartment.tr,
            maxLength: 20,
            // inputFormatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.apartmentTxtController,
            onChange: (value) {
              if (value == " ") {
                controller.apartmentTxtController.text = "";
              }
            },
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyApartment.tr),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            hint: keyStreet.tr,
            labelText: keyStreet.tr,
            maxLength: 40,
            // inputFormatter: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            onChange: (value) {
              if (value == " ") {
                controller.streetTxtController.text = "";
              }
            },
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.streetTxtController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyStreet.tr),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            radius: radius_10,
            labelMargin: margin_3,
            labelText: keyCity.tr,
            hint: keyCity.tr,
            maxLength: 20,
            // inputFormatter: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.cityTxtController,
            onChange: (value) {
              if (value == " ") {
                controller.cityTxtController.text = "";
              }
            },
            inputAction: TextInputAction.next,
            inputType: TextInputType.text,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyCity.tr),
          ),
          // TextFieldWidget(
          //   radius: radius_10,
          //   hint: 'Practice',
          //   labelMargin: margin_3,
          //   labelText: keyPractice.tr,
          //   decoration: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(radius_20),
          //       borderSide: BorderSide(color: Colors.grey.shade400)),
          //   isOutlined: true,
          //   hintStyle: textStyleBodyMedium()
          //       .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          //   contentPadding: EdgeInsets.symmetric(
          //       vertical: margin_10, horizontal: margin_15),
          //   textController: controller.practiceTxtController,
          //   inputAction: TextInputAction.next,
          //   inputType: TextInputType.text,
          //   validate: (value) => Validator.ValidateName(value),
          // ).marginSymmetric(vertical: margin_8),
        ],
      ).marginSymmetric(horizontal: margin_10),
    );
  }

  Widget _isGenderDropDown() {
    return (controller.genderList.isNotEmpty)
        ? DropdownButtonFormField2<String>(
            // buttonHeight: height_40,
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: margin_0, vertical: margin_0),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(radius_0),
                  borderSide: BorderSide(color: Colors.grey, width: margin_1)),
            ),
            value: controller.genderTxtController.text.isNotEmpty
                ? controller.genderTxtController.text
                : keyMale.tr,
            hint: TextView(
              text: "Select your gender",
              textStyle: textStyleBody1().copyWith(
                color: Colors.black,
              ),
            ).marginOnly(left: 0),
            items: controller.genderList
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return "strPleaseSelectGender";
              }
              return null;
            },
            onChanged: (value) {
              controller.selectedValue = value.toString();
              controller.genderTxtController.text = controller.selectedValue;
              controller.update();
            },
            onSaved: (value) {
              controller.selectedValue = value.toString();
            },
          )
        : SizedBox();
  }

  Widget _updateButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyUpdate.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          // if (controller.cityTxtController.text.contains(" ") ||
          //     controller.streetTxtController.text.contains(" ")) {
          //   controller.cityTxtController.text =
          //       controller.cityTxtController.text.trim();
          //   controller.streetTxtController.text =
          //       controller.streetTxtController.text.trim();

          if (contactFormGlobalKey.currentState!.validate()) {
            controller.hitProfileSetUpApi();
            controller.update();
          }
          // }
        },
      ),
    ).marginSymmetric(horizontal: margin_10, vertical: margin_10);
  }
}
