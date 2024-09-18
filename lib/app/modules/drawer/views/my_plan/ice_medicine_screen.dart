import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:health_fitness/export.dart';
import 'package:intl/intl.dart';

import '../../controller/myPlanController/ice_medicine_controller.dart';

class IceMedicineScreen extends GetView<IceMedicineController> {
  IceMedicineScreen({super.key});
  final controller = Get.put(IceMedicineController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: backGroundWidget(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customBackWidget(title: keyBack.tr)
                    .paddingOnly(left: margin_12),
                SizedBox(
                  height: height_60,
                ),
                TextView(
                  text: "רפואת קרח",
                  textStyle: textStyleBody1(),
                ).paddingOnly(right: margin_12),
                _horizontalCalender(),
                SizedBox(
                  height: height_20,
                ),
                Expanded(
                  child: _listView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  _horizontalCalender() => Obx(
        () => Container(
          padding: EdgeInsets.all(margin_8),
          color: greenColor,
          child: EasyInfiniteDateTimeLine(
            // showTimelineHeader: false,
            controller: _controller,
            firstDate: DateTime.now(),
            focusDate: controller.selectedDate.value,
            lastDate: DateTime(2999),
            activeColor: appBackgroundColor,
            dayProps: EasyDayProps(
              height: Get.width / 6,
              // You must specify the width in this case.
              width: Get.width / 7,
            ),
            itemBuilder: (context, dayNumber, dayName, monthName, fullDate,
                    isSelected) =>
                GestureDetector(
              onTap: () {
                controller.selectedDate.value = fullDate;
                controller.getPlanEventDetail();
                isSelected = true;
                print(isSelected);
              },
              child: Column(
                children: [
                  TextView(
                    text: "${dayName.capitalizeFirst}",
                    textStyle: textStyleBodyLarge().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      // fontSize: font_20,
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      backgroundColor: (isSelected == true)
                          ? Colors.white
                          : Colors.transparent,
                      radius: radius_100,
                      child: TextView(
                        text: "$dayNumber",
                        textStyle: textStyleBodyLarge().copyWith(
                          color: (isSelected == true)
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          // fontSize: font_20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onDateChange: (selectedDate) {
              controller.selectedDate.value = selectedDate;
              print(selectedDate);
            },
            headerBuilder: (context, date) => Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.startDate.value.isAfter(DateTime.now())) {
                        // _controller.jumpToDate(startDate.subtract(Duration(days: 6)));
                        controller.startDate.value = controller.startDate.value
                            .subtract(Duration(days: 6));
                        _controller.animateToDate(
                          controller.startDate.value,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  TextView(
                    text:
                        "${DateFormat('MMMM yyyy').format(controller.startDate.value)}",
                    textStyle: textStyleBodyLarge().copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: font_18,
                    ),
                  ).paddingOnly(
                    bottom: margin_10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (startDate.isBefore(DateTime.now())) {
                      controller.startDate.value =
                          controller.startDate.value.add(Duration(days: 6));
                      _controller.animateToDate(
                        controller.startDate.value,
                      );
                      // }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /*_horizontalCalender() => Container(
        padding: EdgeInsets.all(margin_8),
        color: greenColor,
        child: HorizontalWeekCalendarr(
          // height: height_60,
          onWeekChange: (value) {},
          onDateChange: (date) {
            print(date);
          },
        ),
      );*/

  _listView() => GetBuilder<IceMedicineController>(
        builder: (controller) {
          return controller.planListDataModel.isEmpty
              ? noDataToShow()
              : ListView.builder(
                  itemCount: controller.planListDataModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius_12),
                      ),
                      padding: EdgeInsets.all(margin_10),
                      margin: EdgeInsets.only(
                          left: margin_15, right: margin_15, bottom: margin_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextView(
                                  text: controller
                                          .planListDataModel[index].title ??
                                      '',
                                  textStyle: textStyleBody1()
                                      .copyWith(fontWeight: FontWeight.bold)),
                              TextView(
                                text: change24To12Format(controller
                                    .planListDataModel[index].dateTime
                                    .toString()
                                    .split(" ")
                                    .last
                                    .split(".")
                                    .first),
                                textStyle: textStyleBody1().copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: font_14),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          _customRow1(index: index),
                          _customRow2(index: index),
                          controller.planListDataModel[index].registerUser <=
                                  controller
                                      .planListDataModel[index].noAllowPerson
                              ? _statusContainer(
                                  title: controller.planListDataModel[index]
                                              .isApplied !=
                                          true
                                      ? "Apply"
                                      : "Applied",
                                  onTap: () {
                                    if (controller.planListDataModel[index]
                                            .isApplied !=
                                        true) {
                                      controller.applyEventApi(
                                          controller
                                              .planListDataModel[index].planId,
                                          controller
                                              .planListDataModel[index].id);
                                    }
                                  },
                                )
                              : _statusContainer(
                                  title: "Event is full, no seat is available",
                                )
                        ],
                      ),
                    );
                  },
                );
        },
      );

  String change24To12Format(String time) {
    DateTime time12 = DateFormat.Hm().parse(time);

    // Format the time to AM/PM format
    String timeAmPmFormat = DateFormat.jm().format(time12);
    return timeAmPmFormat;
  }

  _customRow1({index}) => Row(
        children: [
          AssetImageWidget(
            imageUrl: iconProfileMenu,
            imageHeight: height_25,
            imageWidth: height_25,
          ),
          SizedBox(
            width: width_8,
          ),
          Row(
            children: [
              TextView(text: "Host:", textStyle: textStyleBody2()),
              TextView(
                  text: " ${controller.planListDataModel[index].host ?? ''}",
                  textStyle: textStyleBody2().copyWith(
                      color: Colors.grey, fontWeight: FontWeight.normal)),
            ],
          )
        ],
      ).paddingOnly(top: margin_10);

  _customRow2({index}) => Row(
        children: [
          AssetImageWidget(
            imageUrl: iconShopping,
            imageHeight: height_25,
            imageWidth: height_25,
          ),
          SizedBox(
            width: width_8,
          ),
          TextView(
              text: controller.planListDataModel[index].registerUser
                          .toString() ==
                      controller.planListDataModel[index].noAllowPerson
                          .toString()
                  ? "Time full," +
                      " ${controller.planListDataModel[index].registerUser ?? ''} on waiting list"
                  : "" +
                      " ${controller.planListDataModel[index].registerUser ?? ''} on waiting list",
              textStyle: textStyleBody2())
        ],
      ).paddingSymmetric(vertical: margin_10);

  _statusContainer({onTap, required title}) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
          decoration: BoxDecoration(
              color: headingTextColor,
              borderRadius: BorderRadius.circular(radius_12)),
          child: TextView(
              text: title,
              textStyle: textStyleBody2()
                  .copyWith(fontSize: font_10, color: Colors.white)),
        ),
      );
}
