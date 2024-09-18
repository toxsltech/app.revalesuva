/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';

class ItemView extends GetView<ItemController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      controller.onWillPop();
      return Future.value(true);
    }, child: SafeArea(child: GetBuilder<ItemController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(appBarTitleText: controller.imageArg?.title ?? ''),
        body: _body(),
      );
    })));
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin_20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: height_200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius_15), color: Colors.black),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius_15), child: cachedImage(controller.imageArg?.image ?? '', boxFit: BoxFit.cover)),
            ).marginOnly(bottom: height_10),
            ReadMoreTextWidget(
              controller.imageArg?.description ?? '',
              style: textStyleTitle().copyWith(fontWeight: FontWeight.w400),
              moreStyle: textStyleTitle().copyWith(color: colorAppColor),
              lessStyle: textStyleTitle(),
            ),
          ],
        ),
      ),
    );
  }
}
