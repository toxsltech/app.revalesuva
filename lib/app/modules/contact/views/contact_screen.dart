import 'package:health_fitness/app/modules/contact/controllers/contact_controller.dart';

import '../../../../export.dart';

class ContactScreen extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            iconBG,
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
                text: keyBackToPersonalArea.tr,
                textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(right: margin_10),
            ],
          ).marginOnly(bottom: margin_10),
          TextView(
            text: keyContact.tr,
            textStyle: textStyleBody1().copyWith(
              fontWeight: FontWeight.w500,
            ),
          ).paddingOnly(top: margin_70),
          _contactServices(),
        ],
      ).paddingAll(
        margin_12,
      ),
    );
  }

  _contactServices() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.contactList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (controller.contactList[index] == keyChatCoach.tr) {
              Get.toNamed(AppRoutes.chatCoach);
            } else if (controller.contactList[index] == keyTechnicalHelp.tr) {
              Get.toNamed(
                AppRoutes.technicalSupportScreen,
                arguments: {
                  'title': keyTechnicalHelp.tr,
                },
              );
            } /*else {
              Get.toNamed(
                AppRoutes.technicalSupportScreen,
                arguments: {'title': keyServiceEnquiry.tr},
              );
            }*/
          },
          child: Container(
            padding: EdgeInsets.all(margin_10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                radius_10,
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: controller.contactList[index].toString(),
                  textStyle: textStyleBodyLarge().copyWith(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: height_15,
                ).paddingOnly(
                  right: margin_10,
                ),
              ],
            ),
          ).paddingAll(
            margin_5,
          ),
        ),
      ),
    );
  }
}
