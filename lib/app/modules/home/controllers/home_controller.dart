/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:health_fitness/app/modules/shop/controllers/shop_controller.dart';

import '../../../../../export.dart';
import '../../authentication/model/login_response_model.dart';

class HomeController extends GetxController {
  RxBool isfaq = true.obs;
  int backPressCounter = 0;
  CustomLoader customLoader = CustomLoader();
  MyAccountModel? myAccountModel;
  int bottomNavIndex = 0;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> startDate = DateTime.now().obs;

  final EasyInfiniteDateTimelineController dateTimelineController =
      EasyInfiniteDateTimelineController();

  var currentViewType = ViewType.bottomNav;

  RxBool showMore = false.obs;
  RxList toDoList = [false, false, false, false, false, false].obs;

  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
  }

  @override
  void onInit() {
    hitCheckAPI();
    super.onInit();
    startTimer1();
    startTimer2();
  }
  String profilePic = "";

  LoginResponseModel loginSignUpResponseModel = LoginResponseModel();
  hitCheckAPI() {
    repository.checkApiCall().then((value) async {
      if (value != null) {
        loginSignUpResponseModel = value;
        profilePic = loginSignUpResponseModel.detail!.profileFile??"";

        debugPrint(
          "Plan Type : " + loginSignUpResponseModel.detail!.planType.toString(),
        );
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint(
        "error ::::::::: " + error.toString(),
      );
      debugPrint(
        stackTrace.toString(),
      );
      //  showInSnackBar(message: error.toString());
    });
  }

  var minute1 = 0.obs;
  var sec1 = 0.obs;
  var totalSec1 = 0.obs;
  Timer? _timer1;
  RxString minuteString1 = "".obs;
  RxString secondString1 = "".obs;
  int animationDuration1 = 60; //in sec1

  void startTimer1() {
    _timer1 = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        totalSec1.value = totalSec1.value + 1;
        if (sec1 < 60) {
          sec1.value++;
        } else {
          sec1.value = 0;
        }
        try {
          if (totalSec1 % 60 == 0) {
            minute1.value++;
            if (minute1.value == 1) {
              _timer1?.cancel();
              sec1.value = 0;
            }
          }
          secondString1.value =
              sec1.value < 10 ? "0${sec1.value}" : "${sec1.value}";
          minuteString1.value =
              minute1.value < 10 ? "0${minute1.value}" : "${minute1.value}";
        } catch (e) {}
      },
    );
  }

  var minute2 = 0.obs;
  var sec2 = 0.obs;
  var totalSec2 = 0.obs;
  Timer? timer2;
  RxString minuteString2 = "".obs;
  RxString secondString2 = "".obs;
  int animationDuration2 = 120; //in sec1

  void startTimer2() {
    timer2 = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        totalSec2.value++;
        if (sec2 < 60) {
          sec2.value++;
        } else {
          sec2.value = 0;
        }
        try {
          if (totalSec2 % 60 == 0) {
            minute2.value++;
            if (minute2.value == 2) {
              timer2?.cancel();
              sec2.value = 0;
            }
          }
          secondString2.value =
              sec2.value < 10 ? "0${sec2.value}" : "${sec2.value}";
          minuteString2.value =
              minute2.value < 10 ? "0${minute2.value}" : "${minute2.value}";
        } catch (e) {}
      },
    );
  }

  hitLogoutApiCall() {
    repository.logoutApiCall().then((value) async {
      if (value != null) {
        customLoader.hide();
        ResponseModel _loginResponseModel = value;
        preferenceManger.clearLoginData();
        storage.remove(LOCALKEY_token);
        Get.offAllNamed(AppRoutes.logIn);
        toast(_loginResponseModel.message ?? "");
      }
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      debugPrint(stackTrace.toString());
      toast(error.toString());
    });
  }

  updateBottomNavIndex(int index) {
    bottomNavIndex = index;
    if (bottomNavIndex == 3) {
      Get.put<ShopController>(ShopController());
    }
    update();
  }

  Future<bool> onWillPop() {
    debugPrint(backPressCounter.toString());
    if (backPressCounter < 1) {
      Get.snackbar(
        stringAppName,
        stringExitWarning,
        borderRadius: 6.0,
        backgroundColor: colorMistyRose,
        margin: EdgeInsets.zero,
        colorText: colorVioletM,
      );
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
}

class DrawerModel {
  String? title;
  String? icon;
  void Function()? onTap;

  DrawerModel({
    this.title,
    this.onTap,
    this.icon,
  });
}

class Item {
  String? image;
  String? title;
  String? description;

  Item({
    this.image,
    this.title,
    this.description,
  });
}
