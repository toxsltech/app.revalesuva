/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */
import 'package:health_fitness/app/modules/authentication/model/login_response_model.dart';

import '../../../../export.dart';

class SplashController extends GetxController {
  LoginResponseModel loginSignUpResponseModel = LoginResponseModel();

  @override
  void onInit() {
    changeLanguage();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _navigateToNextScreen();
    super.onInit();
  }

  changeLanguage() {
    Get.updateLocale(
      Locale("he"),
    );
  }

  _navigateToNextScreen() => Timer(Duration(milliseconds: 3500), () async {
        /*if (appExpirationDateCheck()) {
          appExpirationDialog();
        } else {*/
        navigate();
      });

  navigate() async {
    bool? isFirstLaunched = await preferenceManger.getStatusFirstLaunch();
    // if (isFirstLaunched != null && isFirstLaunched) {
    if (preferenceManger.getAuthToken() != null) {
      // if (!Get.put(PushNotificationsManager()).comingFromNotification) {
      hitCheckAPI();
      // }
    } else {
      Get.offAllNamed(AppRoutes.logIn, arguments: {"fromSplash": true});
    }
    // } else {
    //   Get.offAllNamed(AppRoutes.logIn);
    // }
  }

  hitCheckAPI() {
    repository.checkApiCall().then((value) async {
      if (value != null) {
        loginSignUpResponseModel = value;
        debugPrint("Plan Type : " + loginSignUpResponseModel.detail!.planType.toString());
        saveData(loginSignUpResponseModel);
        checkUserStep();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint(stackTrace.toString());
      //  showInSnackBar(message: error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }

  saveData(LoginResponseModel? loginResponseModel) {
    preferenceManger.saveAuthToken(loginResponseModel?.accessToken ?? "");
    preferenceManger.savePlanType(loginResponseModel?.detail!.planType.toString());
    preferenceManger.saveRegisterData(loginResponseModel!.detail);
    update();
  }

  checkUserStep() async {
    // LoginSignUpResponseModel userData =
    //     await preferenceManger.getSavedLoginData();
    debugPrint(loginSignUpResponseModel.detail!.profileCompleted.toString() + " {{{{{{{{{{{{{{{{{{{");

    /*if (loginSignUpResponseModel.detail!.profileCompleted == 1) {*/
    Get.offAllNamed((AppRoutes.mainScreen));
    /*} else {
      Get.offAllNamed(AppRoutes.logIn);
    }*/
  }

  bool appExpirationDateCheck() {
    return DateTime.now().isAfter(DateTime(
      2024,
      06,
      13,
    ).add(Duration(days: 15)));
  }
}
