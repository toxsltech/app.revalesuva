/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:permission_handler/permission_handler.dart';

import '../../../export.dart';

class ImagePickerDialog extends StatelessWidget {
  final String title;
  final galleryFunction;
  final cameraFunction;

  const ImagePickerDialog({
    Key? key,
    required this.title,
    required this.galleryFunction,
    required this.cameraFunction,
  }) : super(key: key);

  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(margin_5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogTitle(),
                _dialogButton(),
              ],
            ).marginAll(margin_20)),
        _cancelButton()
      ],
    ).marginAll(margin_10);
  }

  Widget _dialogTitle() => TextView(
        text: title,
        textStyle: textStyleDisplayLarge().copyWith(fontSize: font_17),
        textAlign: TextAlign.start,
      ).paddingOnly(bottom: margin_15);

  _cancelButton() => MaterialButtonWidget(
        onPressed: () {
          Get.back();
        },
        buttonRadius: margin_5, buttonColor: Colors.white,
        // buttonBgColor: Colors.white,
        textColor: Colors.black,
        buttonText: keyCancel.tr,
      ).paddingSymmetric(vertical: margin_15).paddingOnly(bottom: margin_10);

  Widget _dialogButton() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: cameraFunction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextView(
                  // text: 'Take Image',
                  text: 'קח תמונה',
                  textStyle: textStyleBodyLarge(),
                  textAlign: TextAlign.start,
                ).paddingSymmetric(vertical: margin_12),
              ],
            ),
          ),
          SizedBox(
            width: margin_2,
          ),
          InkWell(
            onTap: galleryFunction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextView(
                  // text: 'Choose Image',
                  text: 'בחר תמונה',
                  textStyle: textStyleBodyLarge(),
                  textAlign: TextAlign.start,
                ).paddingSymmetric(vertical: margin_12),
              ],
            ),
          )
        ],
      );
}
