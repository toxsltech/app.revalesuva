import '../../../../export.dart';
import '../models/response_model/all_details_response.dart';
import '../models/response_model/weight_details_response.dart';

class WeighingDetailController extends GetxController {
  AllDetailsResponse? allDetailsResponse;
  RxList<AllDetailsList> allDetailsList = <AllDetailsList>[].obs;
  WeightDetailsResponse? weightDetailsResponse;
  RxList<WeightList> weightList2 = <WeightList>[].obs;
  List<WeightModel> weightList = [
    WeightModel(title: "Weight", value: "65.5"),
    WeightModel(title: "Belly line", value: "75"),
    WeightModel(title: "Chest line", value: "72"),
    WeightModel(title: "Hipline", value: "32")
  ];

  @override
  void onInit() async {
    getWeightDetailsAPI();
    getAllDetailsAPI();
    loginDataModel = await preferenceManger.getSavedLoginData();
    super.onInit();
  }

  getAllDetailsAPI() {
    repository.getAllDetailsApiCall("2").then((value) async {
      if (value != null) {
        allDetailsResponse = value;
        allDetailsList.value.addAll(allDetailsResponse!.list!);
        allDetailsList.refresh();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }

  getWeightDetailsAPI() {
    repository.getAllDetailsApiCall("1").then((value) async {
      if (value != null) {
        weightDetailsResponse = value;
        weightList2.value.addAll(weightDetailsResponse!.list!);
        weightList2.refresh();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }
}

class WeightModel {
  String title;
  String value;
  WeightModel({required this.title, required this.value});
}
