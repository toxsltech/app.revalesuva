import '../../../../export.dart';
import '../../../core/values/validator.dart';
import '../controllers/body_details_controller.dart';

class BodyDetailsScreen extends GetView<BodyDetailController> {
  BodyDetailsScreen({super.key});
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _body(),
    ));
  }

  _body() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _profileImage(),
            _form(),
            _richText(),
            Row(
              children: [
                _customCameraPhotosContainer(title: 'Front'),
                _customCameraPhotosContainer(title: 'Side'),
                _customCameraPhotosContainer(title: 'Back'),
              ],
            ).marginSymmetric(horizontal: margin_15),
            // _buttons()
          ],
        ).marginOnly(top: margin_30),
      ],
    );
  }

  _profileImage() {
    return Center(
      child: Column(
        children: [
          Stack(alignment: Alignment.bottomCenter, children: [
            CircleAvatar(
              radius: radius_42,
              backgroundColor: Colors.grey.shade300,
              child: AssetImageWidget(
                imageUrl: iconProfile,
                imageFitType: BoxFit.fill,
              ),
            ).paddingAll(margin_20),
            Positioned(
                child: IconButton(
              icon: Icon(
                Icons.edit,
                size: font_15,
              ),
              onPressed: () {},
              style: IconButton.styleFrom(
                  foregroundColor: Colors.grey,
                  backgroundColor: Colors.green.shade100),
            ))
          ]),
          TextView(
                  text: keyEditPhoto.tr,
                  textStyle: textStyleBodySmall()
                      .copyWith(fontSize: font_15, fontWeight: FontWeight.w500))
              .marginOnly(top: margin_5)
        ],
      ),
    );
  }

  _form() {
    return Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  textAlign: TextAlign.start,
                  text: keyAddSomeBodyDetail.tr,
                  textStyle: textStyleHeading().copyWith(fontSize: font_15),
                ).marginOnly(top: margin_20),
                TextFieldWidget(
                  shadow: true,
                  color: Colors.grey.shade200,
                  radius: radius_10,
                  hint: keyWeight.tr,
                  hintStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: margin_10, horizontal: margin_15),
                  textController: controller.weightController,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.text,
                  validate: (value) => Validator.ValidateFields(value),
                ).marginOnly(bottom: margin_10, top: margin_15),
                TextFieldWidget(
                  shadow: true,
                  color: Colors.grey.shade200,
                  hintStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  textController: controller.heightController,
                  hint: keyHeight.tr,
                  // obscureText: controller.viewPassword.value,
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.emailAddress,
                  validate: (value) => Validator.ValidateFields(value),
                ),
                /*TextFieldWidget(
                  shadow: true,
                  color: Colors.grey.shade200,
                  hintStyle: textStyleBodyMedium().copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  radius: radius_10,
                  textController: controller.bloodTestController,
                  hint: keyRaisingBloodTests.tr,
                  suffixIcon: Icon(
                    Icons.add,
                    size: font_30,
                  ),
                  inputAction: TextInputAction.next,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: margin_10, horizontal: margin_15),
                  inputType: TextInputType.emailAddress,
                  validate: (value) => Validator.ValidateFields(value),
                ).marginSymmetric(vertical: margin_10),*/
              ],
            ).marginSymmetric(vertical: margin_10, horizontal: margin_15))
        .marginOnly(top: margin_10, bottom: margin_5);
  }

  _richText() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
              text: 'Explanatory ',
              style: textStyleBodyMedium()
                  .copyWith(fontWeight: FontWeight.w600, fontSize: font_13),
              children: [
                TextSpan(
                    text: 'video for photography',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.dialog(Dialog(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          surfaceTintColor: Colors.white,
                          child:
                              Stack(alignment: Alignment.topRight, children: [
                            Container(
                              height: height_180,
                              color: Colors.white,
                              child: Center(
                                child: Icon(
                                  Icons.play_circle_outline_outlined,
                                  size: 90,
                                  color: Colors.black,
                                ),
                              ),
                            ).paddingAll(margin_10),
                            Positioned(
                                top: -5,
                                right: radius_12,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.cancel,
                                    size: font_35,
                                    color: Colors.black,
                                  ),
                                ))
                          ]),
                        ));
                      },
                    style: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.w600, fontSize: font_13)),
                TextSpan(
                    text: keyPictureBefore.tr,
                    style: textStyleBodyMedium().copyWith(
                        fontWeight: FontWeight.bold, fontSize: font_15))
              ]),
        ).marginSymmetric(horizontal: margin_15),
        Center(
          child: Divider(
            color: Colors.black,
            indent: Get.width * 0.35,
            endIndent: Get.width * 0.3,
            thickness: 1.2,
          ),
        )
      ],
    );
  }

  _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.generalDetailsScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: font_15,
              ),
              TextView(
                      text: keyPreviousStage.tr,
                      textStyle:
                          textStyleBodyMedium().copyWith(fontSize: font_14))
                  .marginOnly(left: margin_5),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              TextView(
                      text: keyNextStage.tr,
                      textStyle:
                          textStyleBodyMedium().copyWith(fontSize: font_14))
                  .marginOnly(left: margin_5),
              Icon(
                Icons.arrow_forward_ios,
                size: font_15,
              ),
            ],
          ),
        )
      ],
    ).marginSymmetric(horizontal: margin_15, vertical: margin_10);
  }

  _customCameraPhotosContainer({title}) {
    return Container(
      height: height_85,
      width: height_85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_15),
        color: Colors.grey.shade300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: font_50,
            color: Colors.black,
          ),
          TextView(
              text: title,
              textStyle:
                  textStyleBodyMedium().copyWith(fontWeight: FontWeight.w600))
        ],
      ),
    ).marginSymmetric(horizontal: margin_8, vertical: margin_20);
  }
}
