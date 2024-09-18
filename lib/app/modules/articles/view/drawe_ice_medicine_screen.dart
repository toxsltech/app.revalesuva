import 'package:simple_html_css/simple_html_css.dart';

import '../../../../export.dart';
import '../../../core/widgets/network_image.dart';
import '../controller/drawer_ice_medicine_controller.dart';

class SideDrawerIceMedicineScreen extends GetView<SideDrawerIceMedicineController> {
  SideDrawerIceMedicineScreen({super.key});

  final controller = Get.put(SideDrawerIceMedicineController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideDrawerIceMedicineController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: _bodyWidget(context),
          ),
        );
      },
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return controller.articlesDetails.detail != null
        ? Container(
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
                  customBackWidget(
                    title: keyBackToArticles.tr,
                  ).marginOnly(
                    left: margin_10,
                  ),
                  TextView(
                      text: controller.articlesDetails.detail!.title!,
                      textStyle: textStyleBody1().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: font_17,
                      )).marginOnly(
                    top: margin_80,
                    bottom: margin_10,
                    right: margin_15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: margin_15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          radius_10,
                        ),
                        bottomRight: Radius.circular(
                          radius_10,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radius_10),
                          ),
                        ),
                        videoViewWidget(),

                        RichText(
                          textAlign: TextAlign.start,
                          text: HTML.toTextSpan(
                            defaultTextStyle: textStyleBodyMedium().copyWith(),
                            context,
                            // "This thread has been automatically locked since there has not been any recent activity after it was closed. If you are still experiencing a similar issue, please open a new bug, including the output of flutter doctor -v and a minimal reproduction of the issue."
                            controller.articlesDetails.detail!.description!,

                            linksCallback: (dynamic link) {
                              launchUrl(
                                Uri.parse(link),
                              );
                            },
                          ),
                        ).marginSymmetric(horizontal: margin_10).marginOnly(
                              top: margin_10,
                              bottom: margin_10,
                            ),
                        // TextView(
                        //   text: controller.articlesDetails.detail!.description!,
                        //   textStyle: textStyleBodyMedium().copyWith(),
                        // ).marginSymmetric(horizontal: margin_10)
                      ],
                    ),
                  ).marginOnly(bottom: margin_10)
                ],
              ),
            ))
        : Container(
            height: Get.height,
            child: Center(child: CircularProgressIndicator()),
          );
  }

  videoViewWidget() {
    return GestureDetector(
      onTap: () {
        /* Get.toNamed(
          AppRoutes.articleVideoPlayerScreen,
          arguments: {
            "videoLink": controller.articlesDetails.detail!.videoFile,
            "videoId": controller.articlesDetails.detail!.id,
            "startTime": 0,
            "endTime": 0,
          },
        );*/
      },
      child: Container(
        // width: Get.width,
        height: Get.width/1.5,
        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.only(topRight: Radius.circular(radius_20), topLeft: Radius.circular(radius_20))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            NetworkImageWidget(
              imageurl: controller.articlesDetails.detail!.thumbnailFile,
              imageWidth: Get.width,
              imageHeight: Get.width,
              radiusTopLeft: radius_10,
              radiusTopRight: radius_10,
              imageFitType: BoxFit.fill,
            ),
            /*  Icon(
              Icons.play_circle_outline,
              size: font_45,
            )*/
          ],
        ),
      ),
    );
  }
}
