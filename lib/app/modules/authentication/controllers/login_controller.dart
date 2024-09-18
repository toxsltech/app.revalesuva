/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../../../../../export.dart';
import '../model/login_response_model.dart';

class LoginController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Connectivity connectivity = Connectivity();
  ConnectivityResult? result;

  FocusNode nameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  // late TextEditingController emailController;
  TextEditingController forgetEmailController = TextEditingController();
  //late TextEditingController passwordController;
  // late FocusNode emailFocusNode;
  // late FocusNode forgetEmailFocusNode;
  // late FocusNode passwordFocusNode;
  FocusNode loginFocusNode = FocusNode();
  FocusNode forgetEmailFocusNode = FocusNode();
  LoginResponseModel? loginResponseModel;
  MyAccountModel? myAccountModel;
  CustomLoader customLoader = CustomLoader();
  RxBool loader = false.obs;
  // bool viewPassword = false;
  RxBool viewPassword = true.obs;

  @override
  void onInit() {
    if (kDebugMode) {
      nameController.text = "Neeta@toxsl.in";
      passwordController.text = "Admin@123";
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    customLoader.hide();
    super.dispose();
  }

  @override
  void onReady() {
    if (storage.read(LOCALKEY_token) != null &&
        storage.read(LOCALKEY_myAccount) == null) {
      // hitMyAccountAPI();
    } else {
      if (storage.read(LOCALKEY_myAccount) != null) {
        myAccountModel =
            MyAccountModel.fromJson(storage.read(LOCALKEY_myAccount));
      }
    }
    update();
  }

  /*===================================================================== Password Visibility  ==========================================================*/
  showOrHidePasswordVisibility() {
    viewPassword.value = !viewPassword.value;
    // update();
  }

  //APIs

  /*===================================================================== Login API Call  ==========================================================*/
  hitLoginAPI() {
    loader.value = true;
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.loginReq(
      email: nameController.text.trim().toLowerCase().trim(),
      password: passwordController.text.trim(),
    );
    APIRepository().loginApiCall(dataBody: loginReq).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        customLoader.hide();
        storage.write(LOCALKEY_token, loginResponseModel?.accessToken);
        toast(loginResponseModel!.message);

        saveData(loginResponseModel);
        if (loginResponseModel!.detail!.profileCompleted == 1) {
          Get.offAllNamed(AppRoutes.mainScreen);
        } else {
          Get.offAllNamed(AppRoutes.alreadyKnowScreen);
        }
        loader.value = false;
      }
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      loader.value = false;
      print(stackTrace);
      toast(error);
    });
  }

  saveData(LoginResponseModel? loginResponseModel) {
    preferenceManger.saveAuthToken(loginResponseModel!.accessToken);
    preferenceManger
        .savePlanType(loginResponseModel.detail!.planType.toString());
    preferenceManger.saveRegisterData(loginResponseModel.detail);
  }

  /*===================================================================== Forgot password API Call  ==========================================================*/
  hitForgetAPI() {
    // customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    var loginReq = AuthRequestModel.forgetReq(
        email: forgetEmailController.text.trim().toLowerCase());
    APIRepository.forgetApiCall(dataBody: loginReq).then((value) {
      toast(value?.message, seconds: 1);
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        forgetEmailController.clear();
        // customLoader.hide();
      });
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  /*===================================================================== My account details API Call  ==========================================================*/
  hitMyAccountAPI() {
    APIRepository.myAccountApiCall().then((value) {
      myAccountModel = value;
      storage.write(LOCALKEY_myAccount, myAccountModel);
    }).onError((error, stackTrace) {
      toast(error);
    });
  }
}
