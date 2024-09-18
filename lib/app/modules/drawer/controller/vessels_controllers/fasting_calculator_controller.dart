import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:health_fitness/export.dart';

import '../../models/response_model/get_track_time.dart';

class FastingCalculatorController extends GetxController
    with WidgetsBindingObserver {
  @override
  void dispose() {
    timer!.cancel();
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onInit() {
    backClicked = false;
    getFastingTrackListApiCall();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    // getSavedFastTime();
    super.onReady();
  }

  AppLifecycleState? _appLifecycleState;
  GetTrackTimeResponseModel getTrackTime = GetTrackTimeResponseModel();
  List<TrackTime> trackTime = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.paused == state) {
      debugPrint(state.toString());
      hitAddFastingTrackApiCall();
      update();
    }
  }

  getFastingTrackListApiCall({String type = "init"}) {
    APIRepository().getFastingTrackList().then((value) {
      if (value != null) {
        getTrackTime = value;
        trackTime.addAll(getTrackTime.list!);
        if (trackTime.isNotEmpty) {
          if (trackTime.first.stateId != 3) {
            fastTime = convertIntoSeconds(trackTime.first.totalTime);
            // initialValue = convertIntoSeconds(trackTime.first.totalTime);
            Duration diffrenceMinute = Duration(seconds: 0);
            if (type == "init") {
              diffrenceMinute = DateTime.now()
                  .difference(trackTime.first.fasting!.createdOn!);
            }
            // initialValue = trackTime.first.differenceMinutes!;
            initialValue = diffrenceMinute.inSeconds;
            debugPrint("initialValue : " + initialValue.toString());
            debugPrint("fastTime : " + fastTime.toString());
            if (initialValue < fastTime) {
              activeTimer = diffrenceMinute.inSeconds;
              // hitStartFastApiCall(startTime: initialValue, totalTime: fastTime);
              countDownController.restart(duration: fastTime);
              startTimer();
            } else {
              activeTimer = 0;
              initialValue = 0;
              fastTime = 0;
              customLoader.hide();
              update();
            }
          } else {
            activeTimer = 0;
            initialValue = 0;
            fastTime = 0;
            customLoader.hide();
            update();
          }
          debugPrint("initialValue : " + initialValue.toString());
          debugPrint("fastTime : " + fastTime.toString());
        }
        update();
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  convertIntoSeconds(time) {
    String hr = time.toString().split(":").first;
    String min = time.toString().split(":")[1];
    String sec = time.toString().split(":").last;
    int? finalTime = int.tryParse(hr);
    finalTime = finalTime! * 60 * 60;
    finalTime = finalTime + int.tryParse(min)! * 60;
    finalTime = finalTime + int.tryParse(sec)!;

    debugPrint(finalTime.toString());
    return finalTime;
  }

  int fastTime = 0;
  int activeTimer = 0;
  int initialValue = 0;
  int hoursValue = 0;
  int minutesValue = 0;

  RxString timerUpdate = 'היעד הוא 6 שעות! מוּכָן?'.obs;

  // RxString timerUpdate = 'Goal is 6 hours! Ready?'.obs;

  Timer? timer;

  var time;

  convertTimeToSeconds(hoursValue, minutesValue) {
    try {
      time = "$hoursValue:$minutesValue";
      debugPrint(time);
      fastTime = Duration(hours: hoursValue, minutes: minutesValue).inSeconds;
      debugPrint("Fast Time : $fastTime");
      preferenceManger.saveFastTime(fastTime);
      // startTimer();
      update();
    } catch (e, stackTrace) {
      debugPrint("Error : $e");
      debugPrint("StackTrace : $stackTrace");
    }
  }

  startTimer() {
    debugPrint("sfffffffff");
    // activeTimer = 0;
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        if (Get.currentRoute == AppRoutes.fastingCalculatorScreen) {
          if (activeTimer < fastTime) {
            activeTimer++;
            preferenceManger.saveLastTime(activeTimer);
            debugPrint("Countdown : " + activeTimer.toString());
          } else {
            timer.cancel();
            preferenceManger.saveLastTime(0);
            preferenceManger.saveFastTime(0);
          }
          update();
          print("----$activeTimer");
        } else {
          this.timer!.cancel();
        }
      },
    );
  }

  hitAddFastingTrackApiCall() {
    // var reqBody = AuthRequestModel.addOvulationTimings(
    //   ovulationCycleDate: ovulationCycleDateController.text,
    //   ovulationAvgCycleDay: ovulationCycleController.text,
    // );
    // customLoader.show(Get.overlayContext);
    print("backkkkkkk");
    APIRepository().addFastingTrackApiCall().then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        // toast(messageResponseModel.message);
        update();
        customLoader.hide();
      }
      // customLoader.hide();
    }).onError((error, stackTrace) {
      // toast(error.toString());
      customLoader.hide();
      debugPrint(
        "Error:::::${error.toString()}",
      );
      debugPrint(
        "Stack:::::$stackTrace",
      );
    });
  }

  final CountDownController countDownController = CountDownController();

  Future<int> getTime() async {
    try {
      lastAccessedTime = await preferenceManger.getLastAppTime();
      debugPrint("lastAccessedTime " + lastAccessedTime.toString());
      return calculateTimeDifference(lastAccessedTime);
    } catch (e) {
      debugPrint(
        "Error " + e.toString(),
      );
    }
    throw () {
      return null;
    };
  }

  bool backClicked = false;

  getSavedFastTime() async {
    backClicked = await preferenceManger.getButtonClicked();
    int time = await getTime();
    debugPrint(
      "ndjfnsdjnsdjnf " + backClicked.toString(),
    );
    fastTime = await preferenceManger.getFastTime() ?? 0;
    // if (time < fastTime) {
    initialValue = await preferenceManger.getLastTime() ?? 0;
    if (initialValue != 0) {
      initialValue = initialValue + 2;
      if (backClicked == true) {
      } else {
        initialValue = initialValue + time;
      }
      activeTimer = initialValue;
    }
    update();
  }

  hitStartFastApiCall({startTime, totalTime}) {
    var reqBody = AuthRequestModel.addFastTimings(
        totalTime: totalTime, startTime: startTime);
    // customLoader.show(Get.overlayContext);
    APIRepository().startFastApiCall(dataBody: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        toast(messageResponseModel.message);
        initialValue = 0;
        activeTimer = 0;
        convertTimeToSeconds(time?.hour, time?.minute);
        countDownController.restart(duration: fastTime);
        getFastingTrackListApiCall(type: "ADD");
        update();
        customLoader.hide();
      }
      customLoader.hide();
    }).onError((error, stackTrace) {
      toast(error.toString());
      customLoader.hide();
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  hitEndFastApiCall({endTime}) {
    try {
      var reqBody = AuthRequestModel.endFastTimings(
        endTime: endTime,
      );
      // customLoader.show(Get.overlayContext);
      APIRepository()
          .endFastApiCall(dataBody: reqBody, typeId: 1)
          .then((value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = MessageResponseModel();
          messageResponseModel = value;
          // toast(messageResponseModel.message);
          initialValue = 0;
          activeTimer = 0;
          update();
          customLoader.hide();
        }
        customLoader.hide();
      }).onError((error, stackTrace) {
        // toast(error.toString());
        customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      });
    } catch (e) {
      customLoader.hide();
    }
  }
}
