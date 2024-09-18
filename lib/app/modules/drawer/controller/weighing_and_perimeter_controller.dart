import 'package:health_fitness/app/modules/drawer/models/response_model/measurement_model.dart';

import '../../../../export.dart';
import '../models/response_model/data_entry_response.dart';

class WeighingAndPerimeterController extends GetxController {
  TextEditingController hipLineTxtController = TextEditingController();
  TextEditingController chestLineTxtController = TextEditingController();
  TextEditingController bellyLineTxtController = TextEditingController();
  TextEditingController weightTxtController = TextEditingController();
  MeasurementResponse? measurementResponse;
  DataEntryDetailsResponse? entryDetailsResponse;
  RxList<MeasurementList> measurementList = <MeasurementList>[].obs;

  RxInt radioGroupValue = 0.obs;

  @override
  void onInit() {
    callApi();
    super.onInit();
  }
  // @override
  // void onReady() {
  //   callApi();
  //   super.onReady();
  // }

  callApi() {
    getWeightDetailsAPI();
    getMeasurementAPI();
  }

  setSelectedRadio(int val) {
    radioGroupValue.value = val;
    update();
  }

  addDataEntryApi() async {
    // customLoader.show(Get.overlayContext);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.addDataEntryReq(
        measurementId: radioGroupValue.value,
        belly: bellyLineTxtController.text.trim(),
        chest: chestLineTxtController.text.trim(),
        hip: hipLineTxtController.text.trim(),
        date: DateTime.now().toString());
    APIRepository().addDataEntryApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      ResponseModel responseModel = value;
      toast(responseModel.message);
      callApi();
      Get.back();
      bellyLineTxtController.clear();
      chestLineTxtController.clear();
      hipLineTxtController.clear();
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  addWeightApi() async {
    // customLoader.show(Get.overlayContext);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.addWeightReq(
        weight: weightTxtController.text.trim(),
        date: DateTime.now().toString());
    APIRepository().addWeightApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      ResponseModel responseModel = value;
      toast(responseModel.message);
      callApi();
      Get.back();
      weightTxtController.clear();
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  getMeasurementAPI() {
    repository.getMeasurementApiCall().then((value) async {
      if (value != null) {
        measurementResponse = value;
        measurementList.value.clear();
        measurementList.value.addAll(measurementResponse!.list!);
        measurementList.refresh();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }

  getWeightDetailsAPI() {
    repository.getEntryDetailsApiCall().then((value) async {
      if (value != null) {
        entryDetailsResponse = value;
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }
}
