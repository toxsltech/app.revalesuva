import 'package:health_fitness/app/core/utils/time_ago.dart';
import 'package:intl/intl.dart';

import '../../../export.dart';
import '../values/app_global_values.dart';

int backPressCounter = 0;

SizedBox emptySizeBox() => const SizedBox(
      height: 0.0,
      width: 0.0,
    );

Center resultNotFound({message}) => Center(
      child: Text(
        message ?? keyNoResultFound.tr,
        style: textStyleBody2(),
      ),
    );

loadingWidget() => Center(
        child: CircularProgressIndicator(
      color: colorAppColor,
      backgroundColor: Colors.white,
    ));

utcToLocalReviewsDate(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMMM yyyy').format(dateTime);
  return df;
}

utcToLocalReviewsDateTime(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMMM yyyy hh:mm:ss a').format(dateTime);
  return df;
}

utcToLocalLatestNewsDate(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = DateFormat('dd MMM yyyy').format(dateTime);
  return df;
}

utCtoGMT(var dates) {
  var date = DateFormat("yyyy-MM-dd").format(DateTime.parse(dates).toUtc());
  return date;
}

timeNow(var date) {
  DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm:ss").parse(date, true).toLocal();
  var df = TimeAgo.timeAgoSinceDate(dateTime.toString());
  return df;
}

extension StringExtensions on String {
  String capitalized() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

convertTimeToLocal({dateString, dateFormat}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse('${dateString}Z');
    final convertLocal = strToDateTime.toLocal();
    DateFormat newFormat = DateFormat(dateFormat ?? "MM.dd.yyyy");
    return newFormat.format(convertLocal);
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

Widget getInkWell({child, onTap}) {
  return GestureDetector(
    onTap: onTap ?? () {},
    child: child,
  );
}

Widget noDataToShow({inputText, color = Colors.black}) {
  return Center(
      child: TextView(
          text: inputText ?? keyNoResultFound.tr, textStyle: textStyleBody1()));
}

Future<bool> onWillPop() {
  debugPrint(backPressCounter.toString());
  if (backPressCounter < 1) {
    showInSnackBar(message: keyPressToExitApp.tr);
    backPressCounter++;
    Future.delayed(Duration(milliseconds: 1500), () {
      backPressCounter--;
    });
    return Future.value(false);
  } else {
    if (GetPlatform.isAndroid) {
      SystemNavigator.pop();
    }
    return Future.value(true);
  }
}

Widget customBackWidget({title, onTap}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onTap ??
            () {
              Get.back(result: true);
            },
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(radius_5),
            ),
          ),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: height_22,
          ),
        ).marginOnly(right: margin_10),
      ),
      TextView(
        text: title ?? "",
        textStyle: textStyleBodyMedium().copyWith(
          fontWeight: FontWeight.w600,
        ),
      ).marginOnly(right: margin_10),
    ],
  ).marginOnly(bottom: margin_10, top: margin_15);
}

Widget backGroundWidget({required child}) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              iconBackGround1,
            ),
            fit: BoxFit.cover)),
    child: child,
  );
}

Widget customFloatingBtn({onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height_55,
      width: height_55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: greenColor, borderRadius: BorderRadius.circular(radius_50)),
      child: TextView(
        text: keyGoToPayment.tr,
        textStyle: textStyleLabelSmall().copyWith(
            fontWeight: FontWeight.bold, height: 0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget counterWidget({onPlusTap, onMinusTap, value}) => Row(
      children: [
        GestureDetector(
          onTap: onMinusTap,
          child: AssetImageWidget(
            imageUrl: iconSubtract,
            imageHeight: height_18,
            imageWidth: height_18,
          ),
        ),
        TextView(
                text: value ?? "0",
                textStyle: textStyleLabelSmall()
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold))
            .paddingSymmetric(horizontal: margin_8),
        GestureDetector(
          onTap: onPlusTap,
          child: AssetImageWidget(
            imageUrl: iconAdd,
            imageHeight: height_18,
            imageWidth: height_18,
          ),
        ),
      ],
    );

int calculateTimeDifference(String time) {
  DateTime? startDateTime = DateTime.tryParse(time); // Start datetime
  DateTime endDateTime = DateTime.now(); // End datetime

  // Calculate the difference
  Duration difference = endDateTime.difference(startDateTime!);

  // Convert difference to seconds
  int differenceInSeconds = difference.inSeconds;

  return differenceInSeconds;
}
