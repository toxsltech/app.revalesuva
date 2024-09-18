import 'package:health_fitness/app/modules/notification/controllers/notification_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:simple_html_css/simple_html_css.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: backGroundWidget(
            child: Column(
          children: [
            customBackWidget(title: "Notification")
                .paddingOnly(bottom: margin_50),
            _detailView(),
            /*Expanded(child:
                GetBuilder<NotificationController>(builder: (controller) {
              return ListView.separated(
                itemCount: controller.notificationList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(margin_5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius_5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextView(
                              textAlign: TextAlign.end,
                              text:
                                  controller.notificationList[index].date ?? "",
                              textStyle: textStyleBodySmall().copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  height: 0)),
                        ),
                        TextView(
                            text:
                                controller.notificationList[index].title ?? "",
                            textStyle: textStyleBodySmall()
                                .copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height_8,
                  );
                },
              );
            }))*/
          ],
        ).paddingSymmetric(horizontal: margin_12)),
      ),
    );
  }

  _detailView() => GetBuilder<NotificationController>(builder: (controller) {
        return Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notificationList2.length,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              return Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () {
                        controller.notificationList2[i].activeMeterIndex =
                            controller.notificationList2[i].activeMeterIndex ==
                                    i
                                ? null
                                : i;
                        print(controller.notificationList2[i].activeMeterIndex);
                        // controller.update();
                      },
                      child: Container(
                        margin: EdgeInsets.all(margin_5),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey.shade400),
                            /*boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],*/
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radius_10)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius_10),
                          ),
                          elevation: 0,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardColor: Colors.white,
                            ),
                            child: new ExpansionPanelList(
                              elevation: 0,
                              expandedHeaderPadding: EdgeInsets.only(
                                  bottom: margin_0, top: margin_0),
                              expandIconColor: controller.notificationList2[i]
                                          .activeMeterIndex ==
                                      i
                                  ? Colors.grey
                                  : Colors.black,
                              expansionCallback: (int index, bool status) {
                                controller.notificationList2[i]
                                    .activeMeterIndex = controller
                                            .notificationList2[i]
                                            .activeMeterIndex ==
                                        i
                                    ? null
                                    : i;
                                controller.update();
                              },
                              children: [
                                new ExpansionPanel(
                                  isExpanded: controller.notificationList2[i]
                                          .activeMeterIndex ==
                                      i,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) =>
                                          TextView(
                                    text:
                                        '${controller.notificationList2[i].title}',
                                    textAlign: TextAlign.start,maxLine: 1,
                                    textStyle: textStyleBodyLarge().copyWith(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                      fontSize: font_13,
                                    ),
                                  ).paddingOnly(
                                              left: margin_15, top: margin_10),
                                  body: Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        text: HTML.toTextSpan(
                                      context,
                                      "${controller.notificationList2[i].title}",
                                      defaultTextStyle:
                                          textStyleBody1().copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overrideStyle: <String, TextStyle>{
                                        "body": TextStyle(
                                            color: Colors.black,
                                            fontSize: font_18,
                                            fontFamily: "Poppins")
                                      },
                                    )).paddingOnly(
                                        bottom: margin_10, left: margin_15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      });
}
