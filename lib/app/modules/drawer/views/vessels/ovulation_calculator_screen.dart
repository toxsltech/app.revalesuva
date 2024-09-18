import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/ovulation_calculator_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OvulationCalculatorScreen extends GetView<OvulationCalculatorController> {
  const OvulationCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OvulationCalculatorController>(
        init: OvulationCalculatorController(),
        builder: (controllers) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: backGroundColor,
              body: backGroundWidget(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      customBackWidget(
                        title: keyBack.tr,
                      ).paddingOnly(
                        left: margin_15,
                      ),
                      SizedBox(
                        height: height_50,
                      ),
                      title(),
                      SizedBox(
                        height: height_10,
                      ),
                      weekDay(),
                      editBar(),
                      _menturationCalenderView(),
                      _ovulationCalenderView(),
                      // calenderView(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget title() => Align(
        alignment: Alignment.centerRight,
        child: TextView(
            text: "${keyOvulationCalculator.tr}    ",
            textStyle: textStyleBody1()),
      );

  Widget weekDay() => Container(
        color: Colors.white,
        height: height_35,
        width: Get.width,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: margin_6,
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
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
          customRow(title: keyMenstruation.tr, circleColor: Colors.red),
          customRow(title: keyOvulation.tr, circleColor: orangeColor),
          // customRow(title: "Hormonal days", circleColor: Colors.black),
          Spacer(),
          controller.ovulationCycleList.value.isEmpty
              ? GestureDetector(
                  onTap: () {
                    Get.bottomSheet(Get.find<OvulationCalculatorController>()
                        .bottomSheet());
                  },
                  child: AssetImageWidget(
                    imageUrl: iconEdit,
                    imageHeight: height_30,
                    imageWidth: height_30,
                  ),
                )
              : emptySizeBox()
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
                  textStyle:
                      textStyleLabelSmall().copyWith(color: Colors.black))
              .paddingSymmetric(horizontal: margin_10)
        ],
      );

  Widget _menturationCalenderView() {
    return SizedBox(
      height: height_300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: margin_5),
        color: Colors.white,
        elevation: 2,
        child: GetBuilder<OvulationCalculatorController>(
            // init: FastingHistoryController(),
            builder: (controllers) {
          return SfDateRangePicker(
            showNavigationArrow: true,
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
            selectionColor: Colors.red,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: font_15),
              todayTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                  fontSize: font_15),
              specialDatesTextStyle: textStyleBodyMedium().copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: font_15),
              specialDatesDecoration: BoxDecoration(
                color: Colors.red,
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

  Widget _ovulationCalenderView() {
    return SizedBox(
      height: height_300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: margin_5),
        color: Colors.white,
        elevation: 2,
        child: GetBuilder<OvulationCalculatorController>(
            // init: FastingHistoryController(),
            builder: (controllers) {
          return SfDateRangePicker(
            showNavigationArrow: true,
            controller: controller.ovulationDateController,
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: "EEE",
              specialDates: controller.ovulationSelectedDates,
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
              if (controller.ovulationSelectedDates.isNotEmpty) {
                controller.ovulationDateController.selectedDate = controller
                    .selectedDates[controller.selectedDates.length - 1];
              } else {
                controller.ovulationDateController.selectedDate =
                    DateTime.now().add(
                  Duration(
                    days: -1000,
                    milliseconds: -(DateTime.now().microsecond),
                  ),
                );
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
                color: orangeColor,
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

  Widget calenderView() => Container(
      padding: EdgeInsets.all(margin_10),
      margin: EdgeInsets.all(margin_12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius_15)),
      child: SfDateRangePicker(
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.multiRange,
      ));

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
  }
}
