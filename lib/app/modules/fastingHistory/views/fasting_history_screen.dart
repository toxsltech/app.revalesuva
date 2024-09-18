import 'package:health_fitness/app/modules/fastingHistory/controllers/fasting_history_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FastingHistoryScreen extends GetView<FastingHistoryController> {
  FastingHistoryScreen({super.key});
  final controller = Get.put(FastingHistoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FastingHistoryController>(
        init: FastingHistoryController(),
        builder: (controllers) {
          return Scaffold(
            body: backGroundWidget(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height_20,
                  ),
                  customBackWidget(
                    title: keyBack.tr,
                  ).paddingOnly(
                    left: margin_15,
                  ),
                  SizedBox(
                    height: height_70,
                  ),
                  title(),
                  SizedBox(
                    height: height_10,
                  ),
                  weekDay(),
                  editBar(),
                  // CalenderView(),
                  _completedCalenderView(),
                  _ongoingCalenderView(),
                ],
              ),
            )),
          );
        });
  }

  Widget title() => Align(
        alignment: Alignment.centerRight,
        child: TextView(text: "     מחשבון צום", textStyle: textStyleBody1()),
        // text: "     Fasting Calculator", textStyle: textStyleBody1()),
      );

  Widget weekDay() => Container(
        color: Colors.white,
        height: height_30,
        width: Get.width,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: margin_6),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return TextView(
              text: controller.weekDay[index],
              textStyle: textStyleBody2(),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: width_25,
          ),
        ),
      );

  editBar() => Row(
        children: [
          customRow(title: "הושלם", circleColor: appGreenColor),
          // customRow(title: "Completed", circleColor: appGreenColor),
          // customRow(title: "Ongoing", circleColor: voilateColor),
          customRow(title: "מתמשך", circleColor: voilateColor),
          /* Spacer(),
          AssetImageWidget(
            imageUrl: iconEdit,
            imageHeight: height_30,
            imageWidth: height_30,
          )*/
        ],
      ).paddingSymmetric(horizontal: margin_10, vertical: margin_15);

  Widget customRow({title, circleColor}) => Row(
        children: [
          CircleAvatar(
            radius: radius_5,
            backgroundColor: circleColor,
          ),
          TextView(
            text: title ?? "",
            textStyle: textStyleLabelSmall().copyWith(color: Colors.black),
          ).paddingSymmetric(horizontal: margin_10)
        ],
      );

  Widget _completedCalenderView() {
    return SizedBox(
      height: height_300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: margin_5),
        color: Colors.white,
        elevation: 2,
        child: GetBuilder<FastingHistoryController>(
            // init: FastingHistoryController(),
            builder: (controller) {
          return SfDateRangePicker(
            controller: controller.dateController,
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: "EEE",
              specialDates: controller.selectedDates,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: textStyleBodyLarge()
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            yearCellStyle: DateRangePickerYearCellStyle(
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: font_15),
              todayTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: font_15),
            ),
            // selectionMode: DateRangePickerSelectionMode.single,
            onViewChanged: (DateRangePickerViewChangedArgs args) {
              // if (controller.carId != null) {
              //   controller.visibleMonth = args.visibleDateRange.endDate!.month;
              //   controller.visibleYear = args.visibleDateRange.endDate!.year;
              //   if (controller.visibleYear >= DateTime.now().year) {
              //     if (controller.visibleMonth >= DateTime.now().month) {
              //       controller.hitGetAvailabilityForMonthApi();
              //     }
              //   }
              // }
            },
            onSelectionChanged: (DateRangePickerSelectionChangedArgs value) {
              // to disable manual selection on Calendar
              if (controller.selectedDates.isNotEmpty) {
                controller.dateController.selectedDate = controller
                    .selectedDates[controller.selectedDates.length - 1];
              } else {
                controller.dateController.selectedDate = DateTime.now().add(
                    Duration(
                        days: -1000,
                        milliseconds: -(DateTime.now().microsecond)));
              }
            },
            navigationMode: DateRangePickerNavigationMode.none,
            viewSpacing: 0,
            enablePastDates: true,
            // showNavigationArrow: true,
            initialSelectedDate: null,
            headerHeight: height_60,
            headerStyle: DateRangePickerHeaderStyle(
              textStyle:
                  textStyleTitleMedium().copyWith(fontWeight: FontWeight.bold),
            ),
            selectionShape: DateRangePickerSelectionShape.rectangle,
            selectionTextStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: font_15),
            selectionColor: greenColor,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: font_15),
              todayTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: orangeColor,
                  fontSize: font_15),
              specialDatesTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: font_15),
              specialDatesDecoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(radius_10),
              ),
            ),
          ).paddingOnly(
            left: margin_10,
            right: margin_10,
          );
        }),
      ),
    ).marginOnly(top: margin_15, bottom: margin_10);
  }

  Widget _ongoingCalenderView() {
    return SizedBox(
      height: height_300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: margin_5),
        color: Colors.white,
        elevation: 2,
        child: GetBuilder<FastingHistoryController>(
            // init: FastingHistoryController(),
            builder: (controller) {
          return SfDateRangePicker(
            controller: controller.onGoingDateController,
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: "EEE",
              specialDates: controller.ongoingSelectedDates,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: textStyleBodyLarge()
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            yearCellStyle: DateRangePickerYearCellStyle(
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: font_15),
              todayTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: font_15),
            ),
            // selectionMode: DateRangePickerSelectionMode.single,
            onViewChanged: (DateRangePickerViewChangedArgs args) {
              // if (controller.carId != null) {
              //   controller.visibleMonth = args.visibleDateRange.endDate!.month;
              //   controller.visibleYear = args.visibleDateRange.endDate!.year;
              //   if (controller.visibleYear >= DateTime.now().year) {
              //     if (controller.visibleMonth >= DateTime.now().month) {
              //       controller.hitGetAvailabilityForMonthApi();
              //     }
              //   }
              // }
            },
            onSelectionChanged: (DateRangePickerSelectionChangedArgs value) {
              // to disable manual selection on Calendar
              if (controller.ongoingSelectedDates.isNotEmpty) {
                controller.onGoingDateController.selectedDate =
                    controller.ongoingSelectedDates[
                        controller.ongoingSelectedDates.length - 1];
              } else {
                controller.onGoingDateController.selectedDate = DateTime.now()
                    .add(Duration(
                        days: -1000,
                        milliseconds: -(DateTime.now().microsecond)));
              }
            },
            navigationMode: DateRangePickerNavigationMode.none,
            viewSpacing: 0,
            enablePastDates: false,
            // showNavigationArrow: true,
            initialSelectedDate: null,
            headerHeight: height_60,
            headerStyle: DateRangePickerHeaderStyle(
              textStyle:
                  textStyleTitleMedium().copyWith(fontWeight: FontWeight.bold),
            ),
            selectionShape: DateRangePickerSelectionShape.rectangle,
            selectionTextStyle: textStyleBodyMedium().copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: font_15),
            selectionColor: colorAppColor,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: font_15),
              todayTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorAppColor,
                  fontSize: font_15),
              specialDatesTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: font_15),
              specialDatesDecoration: BoxDecoration(
                color: colorAppColor,
                borderRadius: BorderRadius.circular(radius_10),
              ),
            ),
          ).paddingOnly(
            left: margin_10,
            right: margin_10,
          );
        }),
      ),
    ).marginOnly(top: margin_15, bottom: margin_10);
  }

  // Widget _calenderView() {
  //   return GetBuilder<FastingHistoryController>(
  //       init: FastingHistoryController(),
  //       builder: (controllers) {
  //         return TableCalendar(
  //           eventLoader: (day) {
  //             return controller.selectedDates;
  //           },
  //           firstDay: DateTime.now(),
  //           lastDay: DateTime.utc(2030, 3, 14),
  //           focusedDay: DateTime.now(),
  //           calendarStyle: CalendarStyle(
  //             withinRangeDecoration: BoxDecoration(color: Colors.purple),
  //             todayDecoration: BoxDecoration(
  //               color: Colors.blue,
  //               shape: BoxShape.circle,
  //             ),
  //             selectedDecoration: BoxDecoration(
  //               color: Colors.red,
  //               shape: BoxShape.circle,
  //             ),
  //             todayTextStyle: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 22.0,
  //                 color: Colors.white),
  //           ),
  //           headerStyle: HeaderStyle(
  //             titleCentered: true,
  //             formatButtonDecoration: BoxDecoration(
  //               color: Colors.brown,
  //               borderRadius: BorderRadius.circular(22.0),
  //             ),
  //             formatButtonTextStyle: TextStyle(color: Colors.white),
  //             formatButtonShowsNext: false,
  //           ),
  //           startingDayOfWeek: StartingDayOfWeek.monday,
  //           calendarBuilders: CalendarBuilders(
  //             selectedBuilder: (context, date, events) => Container(
  //                 margin: const EdgeInsets.all(5.0),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     color: Theme.of(context).primaryColor,
  //                     borderRadius: BorderRadius.circular(8.0)),
  //                 child: Text(
  //                   date.day.toString(),
  //                   style: TextStyle(color: Colors.white),
  //                 )),
  //             todayBuilder: (context, date, events) => Container(
  //                 margin: const EdgeInsets.all(5.0),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     color: Colors.blue,
  //                     borderRadius: BorderRadius.circular(8.0)),
  //                 child: Text(
  //                   date.day.toString(),
  //                   style: TextStyle(color: Colors.white),
  //                 )),
  //           ),
  //           // calendarController: _controller,
  //         );
  //       });
  // }

  Widget CalenderView() => GetBuilder<FastingHistoryController>(
      init: FastingHistoryController(),
      builder: (controllers) {
        return Container(
          padding: EdgeInsets.all(margin_10),
          margin: EdgeInsets.all(margin_12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_15),
          ),
          child: SfDateRangePicker(
            selectableDayPredicate: (date) {
              return true;
            },
            toggleDaySelection: false,
            onSelectionChanged: (val) {
              print(val.value);
              print(
                controller.selectedDates.contains(val.value),
              );
              if (controller.selectedDates.contains(val.value)) {
              } else {
                controller.update();
                // onSelectionChanged;
              }
            },
            // enableMultiView: true,
            selectionColor:
                /*controller.fastingHistoryListResponseModel.list!.first.typeId ==
                        1
                    ? orangeColor
                    :*/
                greenColor,
            initialSelectedDates: controller.selectedDates,
            // initialSelectedDate: DateTime.now().subtract(Duration(days: 1)),
            selectionMode: DateRangePickerSelectionMode.multiple,
          ),
        );
      });

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (controller.dateList.contains(args.value)) {
      null;
    } else {
      controller.dateList.clear();
      controller.dateList.addAll(args.value);
      print(controller.dateList.length);
    }
    // TODO: implement your code here
  }
}
