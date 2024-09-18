import 'package:health_fitness/app/modules/fastingHistory/models/fasting_history_response_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../export.dart';

class FastingHistoryController extends GetxController {
  List weekDay = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  FastingHistoryListResponseModel fastingHistoryListResponseModel =
      FastingHistoryListResponseModel();
  RxList<DateTime> dateList = <DateTime>[].obs;
  List<DateTime> selectedDates = [];
  List<DateTime> ongoingSelectedDates = [];
  RxList<FastingHistory> fastingHistory = <FastingHistory>[].obs;

  @override
  void onInit() {
    // getFastingHistoryListApiCall();

    debugPrint(
        "Date : " + DateTime.now().subtract(Duration(days: 4)).toString());
    // selectedDates.addAll({
    //   // DateTime.now().subtract(Duration(days: 5)),
    //   // DateTime.now().subtract(Duration(days: 2)),
    //   // DateTime.now().subtract(Duration(days: 4)),
    // });
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    getFastingHistoryListApiCall();
    // TODO: implement onReady
    super.onReady();
  }

  DateRangePickerController dateController = DateRangePickerController();
  DateRangePickerController onGoingDateController = DateRangePickerController();

  // getSelectedDates() {
  //   availableDatesForMonth.clear();
  //   availabilityList.value.forEach((element) {
  //     if (element.isAvailable &&
  //         DateTime.parse(element.date)
  //             .isAfter(DateTime.now().subtract(Duration(hours: 24)))) {
  //       var date = changeIntoLocalDate(element.date + " 00:00:00");
  //       availableDatesForMonth.add(date);
  //       availableDatesForMonth.refresh();
  //     }
  //   });

  //need to call this to refresh the availableDatesForMonth
  //   dateController.selectedDate = DateTime.now();
  //
  //   dateController.notifyPropertyChangedListeners('selectedDate');
  //   update();
  // }

  getFastingHistoryListApiCall() {
    ongoingSelectedDates.clear();
    selectedDates.clear();
    APIRepository().getFastingHistoryList().then((value) {
      if (value != null) {
        fastingHistoryListResponseModel = value;
        // fastingHistory.addAll(fastingHistoryListResponseModel.list!);
        // fastingHistory.refresh();
        for (int i = 0; i < fastingHistoryListResponseModel.list!.length; i++) {
          if (fastingHistoryListResponseModel.list![i].typeId == 1) {
            selectedDates.add(
              fastingHistoryListResponseModel.list![i].startTime!,
            );
          } else {
            ongoingSelectedDates.add(
              fastingHistoryListResponseModel.list![i].startTime!,
            );
          }

          dateController.selectedDate = DateTime.now();
          onGoingDateController.selectedDate = DateTime.now();

          dateController.notifyPropertyChangedListeners('selectedDate');
          onGoingDateController.notifyPropertyChangedListeners('selectedDate');
          // selectedDates.refresh();
          // selectedDates.value.add(fastingHistory.value[i].createdOn.toString().split(" ").first);
        }

        debugPrint(
          selectedDates.toString(),
        );
        debugPrint(
          ongoingSelectedDates.toString(),
        );
        update();
      }
    }).onError((
      error,
      stackTrace,
    ) {
      debugPrint(
        "Error:::::${error.toString()}",
      );
      debugPrint(
        "Stack:::::$stackTrace",
      );
    });
  }
}
