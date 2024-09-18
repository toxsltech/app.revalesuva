import 'package:health_fitness/app/core/values/validator.dart';

import '../../../../export.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../controllers/technical_support_controller.dart';

class TechnicalSupportScreen extends GetView<TechnicalSupportController> {
  TechnicalSupportScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _bodyWidget(),
    ));
  }

  _bodyWidget() {
    return Container(
      padding: EdgeInsets.all(margin_15),
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            iconBG,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
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
                      margin_2,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius_5))),
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
                  text: keyBack.tr,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ).marginOnly(
                  right: margin_10,
                ),
              ],
            ).marginOnly(bottom: margin_10),
            Obx(
              () => TextView(
                text: controller.title.value,
                textStyle: textStyleBody1()
                    .copyWith(fontWeight: FontWeight.w500, fontSize: font_17),
              ).paddingOnly(top: margin_70, left: margin_10),
            ),
            _selectedType(),
            Form(
              key: _formKey,
              child: TextFieldWidget(
                color: Colors.white,
                contentPadding: EdgeInsets.all(margin_10),
                radius: radius_8,
                validate: (value) =>
                    Validator.ValidateFields(value, message: "פרטים"),
                // Validator.ValidateFields(value, message: "Details"),
                hint: keyDetail.tr,
                shadow: true,
                textController: controller.detailController,
                maxline: 8,
                minLine: 8,
                hintStyle: textStyleBody2().copyWith(color: Colors.black),
                isOutlined: true,
              ),
            ),
            _sendButton()
          ],
        ),
      ),
    );
  }

  _selectedType() {
    return Obx(
      () => DropDownWidget(
        validate: (value) =>
            Validator.ValidateFields(value.toString(), message: ""),
        hint: keyNeedHelp.tr,
        icon: AssetImageWidget(
          imageUrl: iconDropDown,
          imageHeight: height_20,
        ).marginOnly(right: margin_10),
        dropdownMenuItems: controller.dropdownList.value.map((selectedType) {
          return DropdownMenuItem(
            child: new Text(
              selectedType.title!,
              style: TextStyle(color: Colors.black),
            ),
            value: selectedType,
          );
        }).toList(),
        onChanged: (newValue) {
          controller.selectOption(newValue);
        },
      ).marginSymmetric(vertical: margin_13),
    );
  }

  _sendButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keySend.tr,
        buttonColor: buttonColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (controller.selectedOptionId.value != 0) {
              controller.hitAddHelpApiCall();
            } else {
              toast("אנא בחר בכל אפשרות");
              // toast("Please choose any option");
            }
          }
        },
      ).marginOnly(top: margin_10),
    );
  }
}
