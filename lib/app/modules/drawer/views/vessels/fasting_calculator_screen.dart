import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:health_fitness/app/core/widgets/custom_time_picker.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/fasting_calculator_controller.dart';
import 'package:health_fitness/export.dart';
import 'package:intl/intl.dart';

class FastingCalculatorScreen extends GetView<FastingCalculatorController> {
  FastingCalculatorScreen({super.key});

  // final controller =
  //     Get.put<FastingCalculatorController>(FastingCalculatorController());

  @override
  Widget build(BuildContext context) {
    print(controller.activeTimer);
    // return FutureBuilder(
    //   future: Future.delayed(
    //     Duration(
    //       seconds: 2,
    //     ),
    //   ),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       } else {
    return WillPopScope(
      onWillPop: () {
        controller.hitAddFastingTrackApiCall();
        Get.back();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<FastingCalculatorController>(
            builder: (FastingCalculatorController controllers) {
              print("Initial::::::::::::::::::::${controller.initialValue}");
              print("Fast Time::::::::::::::::::::${controller.fastTime}");
              return backGroundWidget(
                child: Column(
                  children: [
                    customBackWidget(
                        title: keyBack.tr,
                        onTap: () {
                          // Get.delete<FastingCalculatorController>();
                          controller.hitAddFastingTrackApiCall();
                          Get.back();
                          preferenceManger.saveButtonClicked(true);
                        }).paddingOnly(
                      left: margin_15,
                    ),
                    SizedBox(
                      height: height_60,
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(
                        margin_10,
                      ),
                      decoration: BoxDecoration(
                        color: textBgColor,
                        borderRadius: BorderRadius.circular(
                          radius_5,
                        ),
                      ),
                      child: TextView(
                        text: controller.timerUpdate.value,
                        textStyle:
                            textStyleBody1().copyWith(color: textColorFast),
                      ),
                    ).paddingAll(margin_10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GetBuilder<FastingCalculatorController>(builder: (
                          FastingCalculatorController controllers,
                        ) {
                          print(
                              "Initial::::::::::::::::::::${controller.initialValue}");
                          print(
                              "Fast Time::::::::::::::::::::${controller.fastTime}");
                          var initialTime = (controller.fastTime != 0 &&
                                  controller.initialValue < controller.fastTime)
                              ? controller.initialValue
                              : 0;

                          print("ssssssss$initialTime");
                          return CircularCountDownTimer(
                            duration: controller.fastTime,
                            initialDuration: initialTime,
                            controller: controller.countDownController,
                            width: Get.width * 0.5,
                            height: Get.height * 0.5,
                            ringColor: Colors.white,
                            fillColor: appGreenColor,
                            backgroundColor: appBackgroundColor,
                            strokeWidth: 10.0,
                            isTimerTextShown: false,
                            strokeCap: StrokeCap.round,
                            onStart: () {
                              if (controller.timer?.isActive != true) {
                                // controller.startTimer();
                              }
                              debugPrint('Countdown Started');
                            },
                            onComplete: () {
                              if (controller.initialValue >=
                                  controller.fastTime) {
                                controller.initialValue = 0;
                                controller.fastTime = 0;
                              }
                              controller.timer?.cancel();
                              customLoader.hide();
                            },
                            onChange: (String timeStamp) {
                              if (timeStamp == controller.fastTime.toString()) {
                                preferenceManger.saveLastTime(0);
                                controller.initialValue = 0;
                                controller.fastTime = 0;
                                controller.activeTimer = 0;
                                preferenceManger.saveFastTime(0);
                              }
                              debugPrint('Countdown Changed $timeStamp');
                            },
                            timeFormatterFunction:
                                (defaultFormatterFunction, duration) {
                              if (duration.inSeconds == 0) {
                                return "Start ${controller.initialValue}";
                              } else {
                                return "${Function.apply(defaultFormatterFunction, [
                                      duration
                                    ])} ${controller.initialValue}";
                              }
                            },
                          ).paddingSymmetric(
                            vertical: margin_5,
                            // ),
                          );
                        }),
                        _inSideProgressBar(), // /*Positioned(top: height_90, left: width_35, child:*/ _inSideProgressBar() /*)*/,
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.fastingHistoryScreen);
                      },
                      child: TextView(
                        text: "היסטוריה בצום",
                        // text: "Fasting history",
                        textStyle: textStyleBody2().copyWith(
                            color: greenColor,
                            decorationColor: greenColor,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    // }
    //     }
    //   },
    // );
  }

  _inSideProgressBar() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                controller.time = await showTimePickerCustom(
                  context: Get.overlayContext!,
                  initialTime: TimeOfDay(hour: 0, minute: 0),
                  // cancelText: "Abort",
                  cancelText: keyAbort.tr,
                  confirmText: keyApproval.tr,
                  // confirmText: "Approval",
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        alwaysUse24HourFormat: true,
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          // This uses the _timePickerTheme defined above
                          timePickerTheme: _timePickerTheme,
                          textButtonTheme: TextButtonThemeData(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => headingTextColor),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => colorWhite),
                              // overlayColor: MaterialStateColor.resolveWith(
                              //     (states) => colorWhite),
                            ),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                  },
                );
                final now = DateTime.now();
                final dt = DateTime(now.year, now.month, now.day,
                    controller.time?.hour, controller.time?.minute);
                debugPrint(dt.toString());
                controller.hitStartFastApiCall(
                    startTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(
                      DateTime.now(),
                    ),
                    totalTime: dt.toString().split(".").first);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_5),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(radius_15),
                ),
                child: TextView(
                  text: controller.fastTime == 0
                      ? keyStarFast.tr
                      : controller.activeTimer.toString(),
                  textStyle: textStyleBody1().copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: height_15,
            ),
            TextView(text: keyStartFastEarlier.tr, textStyle: textStyleBody2())
          ],
        ),
      );
  final _timePickerTheme = TimePickerThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    dayPeriodBorderSide: BorderSide(color: greenColor, width: 4),
    dayPeriodColor: greenColor,
    dayPeriodTextColor: Colors.black,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: greenColor, width: 4),
    ),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? greenColor
            : Colors.grey.shade300),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? Colors.white : Colors.white),
    dialHandColor: Colors.white,
    dialBackgroundColor: greenColor,
    hourMinuteTextStyle:
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    dayPeriodTextStyle:
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    helpTextStyle: TextStyle(
        fontSize: font_15, fontWeight: FontWeight.bold, color: Colors.black),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected) ? greenColor : Colors.white),
    entryModeIconColor: greenColor,
  );
}
