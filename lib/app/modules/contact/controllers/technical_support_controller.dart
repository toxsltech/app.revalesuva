import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:health_fitness/app/core/values/app_constant.dart';
import 'package:health_fitness/app/core/values/app_strings.dart';

import '../../../../main.dart';
import '../../../core/widgets/custom_flashbar.dart';
import '../../../data/common_models/message_response_model.dart';
import '../../../data/remote_service/entity/request_model/auth_reuest_model.dart';
import '../../../data/remote_service/network/api_provider.dart';
import '../models/dropdown_response.dart';

class TechnicalSupportController extends GetxController {
  @override
  void onInit() {
    getArgs();
    getDropdownList();
    super.onInit();
  }

  int page = 0;
  RxInt selectedOptionId = 0.obs;
  DropdownListResponseModel dropdownListResponseModel =
      DropdownListResponseModel();
  RxList<DropdownList> dropdownList = <DropdownList>[].obs;

  RxList<Type> listType = [
    Type(id: 0, title: 'Category 1'),
    Type(id: 1, title: 'Category 2'),
    Type(id: 2, title: 'Category 3'),
  ].obs;

  void selectOption(newValue) {
    selectedOptionId.value = newValue.id;
    debugPrint('Option Id : ${selectedOptionId.value}');
  }

  TextEditingController detailController = TextEditingController();
  RxString title = "".obs;

  getArgs() {
    if (Get.arguments != null) {
      title.value = Get.arguments['title'] ?? '';
    }
  }

  hitAddHelpApiCall() {
    var reqBody = AuthRequestModel.addHelpSupport(
      optionId: selectedOptionId.value,
      typeId: title.value == strTechnicalSupport
          ? TYPE_TECHNICAL_SUPPORT
          : TYPE_SERVICE_INQUIRY,
      message: detailController.text.trim(),
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().addHelpApiCall(dataBody: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        toast(messageResponseModel.message);
        Get.back();
        update();
        // customLoader.hide();
      }
      // customLoader.hide();
    }).onError((error, stackTrace) {
      toast(error.toString());
      // customLoader.hide();
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  getDropdownList() {
    APIRepository()
        .dropdownListApiCall(
      page: page,
    )
        .then(
      (value) {
        if (value != null) {
          dropdownListResponseModel = value;
          dropdownList.value.addAll(dropdownListResponseModel.list ?? []);
          dropdownList.refresh();
          update();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }
}

class Type {
  var title;
  var id;

  Type({this.id, this.title});
}
