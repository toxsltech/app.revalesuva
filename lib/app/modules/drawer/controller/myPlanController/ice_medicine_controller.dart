import '../../../../../export.dart';
import '../../models/response_model/my_plan_api_response_model.dart';

class IceMedicineController extends GetxController {
  @override
  void onInit() {
    getPlanEventDetail();
    super.onInit();
  }

  PlanListApiResponseModel planListApiResponseModel =
      PlanListApiResponseModel();
  List<PlanListDataModel> planListDataModel = <PlanListDataModel>[];

  getPlanEventDetail() {
    debugPrint(selectedDate.value.toString());
    APIRepository()
        .myPlanEventDetailApiCall(
            date: selectedDate.value.toString().split(" ").first, planId: 1)
        .then(
      (value) {
        if (value != null) {
          planListDataModel.clear();
          planListApiResponseModel = value;
          planListDataModel.addAll(planListApiResponseModel.list ?? []);
          update();
          customLoader.hide();
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

  applyEventApi(planId, eventId) {
    debugPrint(selectedDate.value.toString());
    APIRepository().applyEventApiCall(planId: planId, eventId: eventId).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          toast(messageResponseModel.message);
          getPlanEventDetail();
          update();
          customLoader.hide();
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

  List<iceDippingModel> iceDippingList = [
    iceDippingModel(status: "Exit a wait list"),
    iceDippingModel(status: "To a waiting list"),
    iceDippingModel(status: "Unsubscribe")
  ];

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
}

class iceDippingModel {
  String? status;
  String? time;

  iceDippingModel({this.status, this.time});
}
