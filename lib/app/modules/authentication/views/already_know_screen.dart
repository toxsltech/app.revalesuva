import '../../../../export.dart';
import '../controllers/already_know_controller.dart';

class AlreadyKnowScreen extends GetView<AlreadyKnowScreenController> {
  const AlreadyKnowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  _body() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            iconBackGround1,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headingText(),
          Card(
            elevation: 5,
            color: backGroundColor2,
            // margin: EdgeInsets.all(
            //   margin_10,
            // ),
            // padding: EdgeInsets.all(
            //   margin_10,
            // ),
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(
            //   radius_25,
            // ),
            // bottomRight: Radius.circular(
            //   radius_25,
            // ),
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.all(
                margin_10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "${keyHey.tr} ${controller.nameController.text}!\n" +
                        keyHereWhat.tr,
                    textStyle: textStyleHeading().copyWith(
                      fontSize: font_18,
                      fontWeight: FontWeight.w900,
                    ),
                  ).marginOnly(
                    top: margin_10,
                  ),
                  _form(),
                  _nextButton(),
                ],
              ),
            ),
          ).marginOnly(
            top: margin_70,
          ),
        ],
      ).marginOnly(top: margin_40, right: margin_15, left: margin_15),
    );
  }

  _nextButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: MaterialButtonWidget(
        buttonRadius: radius_10,
        minWidth: Get.width * 0.24,
        minHeight: 30,
        padding: margin_8,
        customPadding: EdgeInsets.all(8),
        buttonWidget: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: keyNext.tr,
              textStyle: textStyleBodyMedium().copyWith(
                  color: Colors.black,
                  fontSize: font_13,
                  fontWeight: FontWeight.w500),
            ).marginOnly(left: margin_0),
            SizedBox(
              width: width_15,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: font_12,
              color: Colors.black,
            ),
          ],
        ),
        buttonColor: buttonColor,
        onPressed: () {
          Get.toNamed(AppRoutes.generalDetailsScreen);
        },
      ),
    );
  }

  _form() {
    return Column(
      children: [
        TextFieldWidget(
          // labelText: keyFullName.tr,
          labelTextStyle: textStyleBodyMedium()
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
          decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius_8),
              borderSide: BorderSide(color: Colors.grey.shade400)),

          // hint: 'Revital Akilov',
          // hintStyle: textStyleBodyMedium()
          //     .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
          contentPadding:
              EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
          textController: controller.nameController,
          inputAction: TextInputAction.next,
          inputType: TextInputType.text,
          readOnly: true,
        ).marginOnly(top: margin_15),
        TextFieldWidget(
          // labelText: keyPhoneNumber.tr,
          labelTextStyle: textStyleBodyMedium()
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
          readOnly: true,
          decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius_8),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          hintStyle: textStyleBodyMedium()
              .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          radius: radius_10,
          textController: controller.phoneController,
          // hint: '0523456765',
          inputAction: TextInputAction.done,
          contentPadding:
              EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
          inputType: TextInputType.phone,
        ).marginSymmetric(vertical: margin_17),
        TextFieldWidget(
          // labelText: keyEmail.tr,
          labelTextStyle: textStyleBodyMedium()
              .copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
          decoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius_8),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          readOnly: true,
          // hintStyle: textStyleBodyMedium()
          //     .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          radius: radius_10,
          textController: controller.emailController,
          // hint: 'Revital23@toxsl.in',
          // obscureText: controller.viewPassword.value,
          inputAction: TextInputAction.done,
          contentPadding:
              EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
          inputType: TextInputType.phone,
        ),
      ],
    )
        .marginSymmetric(
          vertical: margin_10,
        )
        .marginOnly(bottom: margin_5);
  }

  _headingText() {
    return Center(
      child: Container(
        width: Get.width * 0.65,
        child: TextView(
          textAlign: TextAlign.center,
          text: keyNiceToMeetYou.tr,
          textStyle: textStyleHeading()
              .copyWith(fontSize: font_15, color: Colors.white),
        ),
      ),
    );
  }
}
