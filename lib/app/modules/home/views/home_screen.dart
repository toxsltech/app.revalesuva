/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../export.dart';
import '../../../core/widgets/double_back_press.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: backGroundColor,
            resizeToAvoidBottomInset: false,
            body: controller.loginSignUpResponseModel.detail != null
                ? _body()
                : Center(
                    child: CircularProgressIndicator(
                      color: greenColor,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        TextView(
            text: keyGood.tr +
                controller.loginSignUpResponseModel.detail!.fullName!,
            textStyle: textStyleBody1()
                .copyWith(fontWeight: FontWeight.bold, fontSize: font_18)),
        TextView(
          // text: "So what's on the show today",
          text: "אז מה יש היום בתוכנית",
          textStyle: textStyleBody1().copyWith(
            fontSize: font_12,
          ),
        ),
        SizedBox(
          height: height_15,
        ),
        Container(
          padding: EdgeInsets.all(margin_5),
          decoration: _customDecoration1(),
          child: TextView(
            text:
                // "♡ What fun!\nTo schedule arrival times for the workshop click here",
                "♡ איזה כיף!\nלתיאום זמני הגעה לסדנה לחץ כאן ",
            textStyle: textStyleBody1().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: font_15,
            ),
          ),
        ),
        SizedBox(
          height: height_15,
        ),
        _toDoContainer(),
        SizedBox(
          height: height_15,
        ),
        _graph(),
        SizedBox(
          height: height_15,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: _customTimer(
                  timer:
                      "${controller.minuteString1.value}:${controller.secondString1.value}",
                  title: "רץ",
                  // title: "Running",
                  // text1: "Start time",
                  text1: "שעת התחלה",
                  text2: "20:30 ",
                  text3: "Total ",
                  tex4: "9 minutes",
                  animationDuration: controller.animationDuration1,
                ),
              ),
              SizedBox(
                width: width_15,
              ),
              Expanded(
                child: _customTimer(
                    timer:
                        "${controller.minuteString2.value}:${controller.secondString2.value}",
                    title: "רץ",
                    // title: "Running",
                    // text1: "Start time",
                    text1: "שעת התחלה",
                    text2: "20:30 ",
                    text3: "Total ",
                    tex4: "9 minutes",
                    color: pinkLightColor,
                    animationDuration: controller.animationDuration2),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height_15,
        ),
        _calender(),
        SizedBox(
          height: 50,
        ),
      ],
    ).paddingAll(margin_12);
  }

  _toDoContainer() => Stack(
        children: [
          Container(
            decoration: _customDecoration2(),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.list_alt),
                    SizedBox(
                      width: width_10,
                    ),
                    TextView(
                        text: "לעשות",
                        // text: "To Do",
                        textStyle: textStyleBody1().copyWith(
                            fontWeight: FontWeight.bold, fontSize: font_15)),
                    Spacer(),
                    TextView(
                      // text: "2/5 Progress",
                      text: "2/5 התקדמות",
                      textStyle: textStyleBody1()
                          .copyWith(fontSize: font_13)
                          .copyWith(color: starTextColor),
                    ),
                    SizedBox(
                      width: width_5,
                    ),
                    Container(
                      padding: EdgeInsets.all(margin_2),
                      width: width_80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_20),
                          border: Border.all(color: greenColor)),
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        barRadius: Radius.circular(radius_20),
                        lineHeight: 10.0,
                        percent: 0.5,
                        progressColor: greenColor,
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ).paddingAll(margin_5),
                Container(
                    margin: EdgeInsets.only(right: margin_15),
                    decoration: BoxDecoration(
                      color: appLightGreenColor,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(
                          radius_15,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        TextView(
                            // text: "  Meeting On 02 may 2024",
                            text: "פגישה ב-02 במאי 2024  ",
                            textStyle: textStyleBody1().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: font_15)),
                        Spacer(),
                        TextView(
                            // text: "See more",
                            text: "ראה עוד",
                            textStyle: textStyleBody1().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: font_15)),
                        Icon(Icons.arrow_right),
                      ],
                    )),
                Obx(
                  () => ListView.builder(
                      padding:
                          EdgeInsets.only(top: margin_10, bottom: margin_20),
                      itemCount: !controller.showMore.value
                          ? 3
                          : controller.toDoList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: height_25,
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: greenColor,
                                value: controller.toDoList[index],
                                onChanged: (value) {
                                  controller.toDoList[index] =
                                      !controller.toDoList[index];
                                },
                              ),
                              TextView(
                                  // text: "Morning Task",
                                  text: "משימת בוקר",
                                  textStyle: textStyleBody1())
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -0,
            left: -0,
            child: _addIcon(),
          )
        ],
      );

  _addIcon() => GestureDetector(
        onTap: () {
          controller.showMore.value = !controller.showMore.value;
        },
        child: Container(
          height: height_40,
          width: height_40,
          decoration: BoxDecoration(
            color: greenColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                height_33,
              ),
            ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ).paddingOnly(top: margin_5, left: margin_5),
        ),
      );

  _graph() => Container(
        padding: EdgeInsets.all(margin_10),
        decoration: _customDecoration1(),
        child: Column(
          children: [
            Row(
              children: [
                AssetImageWidget(
                  imageUrl: iconWeightMachine,
                  imageHeight: height_20,
                  imageWidth: height_20,
                ),
                SizedBox(
                  width: width_10,
                ),
                TextView(
                  text: "מגמת משקל",
                  // text: "Weight Trend",
                  textStyle:
                      textStyleBody1().copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextView(
                  text: "ראה עוד",
                  // text: "See More",
                  textStyle: textStyleBody1().copyWith(color: starTextColor),
                ),
                Icon(
                  Icons.navigate_next,
                ),
              ],
            ),
            _customGraph(),
          ],
        ),
      );

  Widget _customTimer({
    timer,
    title,
    text1,
    text2,
    text3,
    tex4,
    color,
    animationDuration,
  }) =>
      Container(
        padding: EdgeInsets.all(margin_15),
        decoration: _customDecoration1(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularCountDownTimer(
                  width: 130,
                  height: 130,
                  initialDuration: 0,
                  duration: animationDuration ?? 60,
                  strokeWidth: 4,
                  isTimerTextShown: false,
                  fillColor: color ?? appLightGreenColor,
                  ringColor: Colors.grey.shade200,
                ),
                CircleAvatar(
                  backgroundColor: color ?? appLightGreenColor,
                  radius: radius_50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height_40,
                        child: TextView(
                          text: "$timer",
                          textStyle: textStyleBody1().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: font_25,
                          ),
                        ),
                      ),
                      TextView(
                        text: "$title",
                        textStyle: textStyleBody1().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: font_14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height_5,
            ),
            _customRow(text1: "$text1", text2: "$text2"),
            _customRow(text1: "$text3", text2: "$tex4"),
            SizedBox(
              height: height_10,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: "ראה עוד",
                    // text: "See More",
                    textStyle: textStyleBody1().copyWith(
                      color: appColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: appColor,
                  )
                ],
              ),
            )
          ],
        ),
      );

  _customRow({text1, text2}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
            text: "$text1",
            textStyle: textStyleBody1().copyWith(
              fontSize: font_15,
            ),
          ),
          TextView(
            text: "$text2",
            textStyle: textStyleBody1().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: font_15,
            ),
          ),
        ],
      );
  _customDecoration1() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          radius_15,
        ),
        bottomRight: Radius.circular(
          radius_15,
        ),
      ),
    );
  }

  _customDecoration2() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(
          radius_15,
        ),
        bottomLeft: Radius.circular(
          radius_15,
        ),
      ),
    );
  }

  final List<_ChartData> data = [
    _ChartData(0, 8),
    _ChartData(1.2, 5),
    _ChartData(2.5, 7),
    _ChartData(3.6, 4),
    _ChartData(2.8, 5),
    _ChartData(20.5, 3)
  ];
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  _customGraph() => SizedBox(
        height: height_120,
        child: SfCartesianChart(
            margin: EdgeInsets.zero,
            borderColor: Colors.transparent,
            plotAreaBorderColor: Colors.transparent,
            primaryXAxis: CategoryAxis(
              axisLine: AxisLine(color: Colors.transparent),
              majorGridLines: MajorGridLines(color: Colors.transparent),
            ),
            primaryYAxis: NumericAxis(
              isVisible: false,
            ),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, double>>[
              AreaSeries<_ChartData, double>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                gradient: LinearGradient(
                    colors: [voilateLightColor, voilateColor],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter),
              )
            ]),
      );

  _calender() => Container(
        // padding: EdgeInsets.all(margin_4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius_15,
          ),
        ),
        child: Column(
          children: [
            _horizontalCalender(),
            SizedBox(
              height: height_10,
            ),
            Column(
              children: [
                _constContainer(
                  bgColor: yellowColor,
                  // title: "Monday task",
                  title: "משימת בוקר",
                  trailing: Row(
                    children: [
                      TextView(
                        // text: "More",
                        text: "יותר",
                        textStyle: textStyleBody1(),
                      ),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                _constContainer(
                  bgColor: skyLightColor,
                  title: "משימת בוקר",
                  // title: "Monday task",
                  trailing: Row(
                    children: [
                      Icon(Icons.note_alt_outlined),
                      Icon(Icons.calendar_month),
                    ],
                  ),
                ).paddingSymmetric(vertical: margin_5),
                _constContainer(
                  bgColor: appLightGreenColor,
                  title: "משימת בוקר",
                  // title: "Monday task",
                  trailing: Icon(Icons.note_alt_outlined),
                ),
              ],
            ).paddingAll(margin_8),
          ],
        ),
      );

  _horizontalCalender() => Obx(
        () => Container(
          padding: EdgeInsets.only(
              bottom: margin_5, left: margin_5, right: margin_5),
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(radius_15)),
          child: EasyInfiniteDateTimeLine(
            // showTimelineHeader: false,
            controller: controller.dateTimelineController,
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
                isSelected = true;
                debugPrint("$isSelected");
                debugPrint("${controller.selectedDate.value}");
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
              () => Container(
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                      radius_10,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.startDate.value
                            .isAfter(DateTime.now())) {
                          controller.startDate.value = controller
                              .startDate.value
                              .subtract(Duration(days: 6));
                          controller.dateTimelineController.animateToDate(
                            controller.startDate.value,
                          );
                        }
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    TextView(
                      text:
                          "${DateFormat('MMMM yyyy').format(controller.startDate.value)}",
                      textStyle: textStyleBodyLarge().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: font_16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.startDate.value =
                            controller.startDate.value.add(Duration(days: 6));
                        controller.dateTimelineController.animateToDate(
                          controller.startDate.value,
                        );
                      },
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _constContainer({title, titleColor, bgColor, trailing}) => Container(
        padding: EdgeInsets.all(margin_7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            radius_15,
          ),
        ),
        child: Row(
          children: [
            TextView(
              text: "$title",
              textStyle: textStyleBody1()
                  .copyWith(fontWeight: FontWeight.bold, color: titleColor),
            ),
            Spacer(),
            trailing ?? SizedBox()
          ],
        ),
      );
}

class _ChartData {
  _ChartData(this.x, this.y);

  final double x;
  final int y;
}
