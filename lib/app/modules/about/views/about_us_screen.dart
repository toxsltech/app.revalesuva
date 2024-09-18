/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and re
 * s
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';

class AboutUsScreen extends StatelessWidget {
  final controller = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                height: Get.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        iconBackGround1,
                      ),
                      fit: BoxFit.fill),
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
                            ).marginOnly(right: margin_10, left: margin_10)),
                        TextView(
                            text: keyBackToHome.tr,
                            textStyle: textStyleBodyMedium())
                      ],
                    ).marginOnly(
                      bottom: margin_10,
                      top: margin_15,
                    ),
                    SizedBox(
                      height: height_60,
                    ),
                    tileList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  tileList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _listTileIconView(
              label: "Version",
              // leadingIcon: iconsDelete,
              description: "${controller.versionNumber ?? ""}"),
          _listTileIconView(
              label: "Rate App",
              // leadingIcon: iconsDelete,
              onSeeAllTap: () async {
                final InAppReview inAppReview = InAppReview.instance;
                if (await inAppReview.isAvailable()) {
                  inAppReview.requestReview();
                }
              },
              description: "If you like us, Rate us"),
          _listTileIconView(
              label: "Share App",
              // leadingIcon: iconsDelete,
              onSeeAllTap: () async {
                final String appLink =
                    'https://play.google.com/store/apps/details?id=com.';
                final String message = 'Check out this app: $appLink';
                await FlutterShare.share(
                    title: 'Share App', linkUrl: appLink, text: message);
              },
              description: "If you like us, let other's know"),
          _listTileIconView(
              label: "More Apps",
              onSeeAllTap: () async {
                await launchUrl(Uri.parse(
                    "https://play.google.com/store/apps/details?id=${controller.packageName}"));
              },
              description: "Check other apps we have"),
          _listTileIconView(
            label: "Copyrights",
            description: "ToXSL Technologies Private Limited",
          ),
          _listTileIconView(
            label: "Server URL",
            description: "$crashBaseUrl",
          ),
        ],
      ).marginOnly(top: margin_20);

  Widget _listTileIconView(
          {label, leadingIcon, onSeeAllTap, icon, description}) =>
      InkWell(
        onTap: onSeeAllTap ?? () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (leadingIcon != null)
                        ? AssetImageWidget(
                            imageUrl: leadingIcon,
                            imageFitType: BoxFit.cover,
                            imageHeight: height_25,
                          ).marginOnly(right: margin_12)
                        : SizedBox(),
                    (icon != null)
                        ? Icon(
                            icon,
                            color: Colors.yellow,
                            size: height_25,
                          ).marginOnly(right: margin_12)
                        : emptySizeBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: label ?? "",
                          textStyle: textStyleDisplayMedium().copyWith(
                            color: Colors.black,
                            fontSize: font_15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextView(
                          text: description ?? "",
                          textStyle: textStyleDisplayMedium().copyWith(
                            color: Colors.black,
                            fontSize: font_15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: margin_16, horizontal: margin_15),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      );
}
