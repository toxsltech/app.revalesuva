import 'package:health_fitness/export.dart';

logoutDialog() {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.only(bottom: margin_10),
          margin: EdgeInsets.symmetric(horizontal: margin_40),
          decoration: BoxDecoration(
              color: greenColor,
              boxShadow: [
                BoxShadow(color: greenColor, blurRadius: 4),
              ],
              border: Border.all(color: greenColor, width: width_4),
              borderRadius: BorderRadius.circular(margin_10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getInkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: margin_40),
                decoration: BoxDecoration(
                    color: greenColor,
                    // boxShadow: [BoxShadow(color: greenColor, blurRadius: 4)],
                    // border: Border.all(color: greenColor, width: width_4),
                    borderRadius: BorderRadius.circular(margin_10)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AssetImageWidget(imageUrl: iconLogo, imageHeight: height_70)
                        .marginOnly(bottom: height_10),
                    TextView(
                      text: keyLogOutHeading.tr,
                      textStyle: textStyleTitle(),
                      maxLine: 5,
                      textAlign: TextAlign.center,
                    ).marginOnly(bottom: height_10),
                    Row(
                      children: [
                        Expanded(
                            child: _yesBtn(
                                    onTap: () {
                                      Get.find<HomeController>()
                                          .hitLogoutApiCall();
                                    },
                                    label: keyLogOut.tr)
                                .marginOnly(left: width_10)),
                        Expanded(child: _noBtn().marginOnly(right: width_10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

deleteAccountDialog() {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin_40),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4)],
              border: Border.all(color: Colors.white, width: width_4),
              borderRadius: BorderRadius.circular(margin_10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getInkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: margin_40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 4)],
                    border: Border.all(color: Colors.white, width: width_4),
                    borderRadius: BorderRadius.circular(margin_10)),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AssetImageWidget(imageUrl: iconLogo, imageHeight: 70)
                        .marginOnly(bottom: height_10),
                    TextView(
                      text: keyDeleteHeading.tr,
                      maxLine: 5,
                      textAlign: TextAlign.center,
                      textStyle: textStyleTitle(),
                    ).marginOnly(bottom: height_10),
                    Row(
                      children: [
                        Expanded(
                            child: _yesBtn(
                          onTap: () {
                            storage.remove(LOCALKEY_token);
                            log.e(storage.read(LOCALKEY_token));
                            log.e(storage.read(LOCALKEY_myAccount));
                            Get.offAllNamed(AppRoutes.logIn);
                            toast(stringAccountDeleteSuccess);
                          },
                          label: keyDelete.tr,
                        ).marginOnly(left: width_10)),
                        Expanded(child: _noBtn().marginOnly(right: width_10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Widget _yesBtn({onTap, label}) {
  return MaterialButtonWidget(
      onPressed: onTap ?? () {},
      buttonText: label ?? '',
      buttonColor: buttonColor);
}

Widget _noBtn() {
  return MaterialButtonWidget(
      onPressed: () {
        Get.back();
      },
      textColor: Colors.black,
      buttonText: keyCancel.tr,
      buttonColor: Colors.white);
}

appExpirationDialog() {
  return Get.dialog(
    AlertDialog(
      title: Container(
          height: height_150,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10),
              )),
          child: AssetImageWidget(
              imageUrl: iconAlertGif, imageFitType: BoxFit.cover)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: margin_10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
                    text: stringDemoExpired,
                    maxLine: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleTitle())
                .marginOnly(bottom: height_10),
            TextView(
                    text: stringAppDemoExpiredDesc,
                    maxLine: 5,
                    textAlign: TextAlign.center,
                    textStyle: textStyleSubTitle())
                .marginOnly(bottom: height_10),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_10)),
    ),
    barrierColor: Colors.grey.shade300,
    barrierDismissible: false,
  );
}
