import 'package:health_fitness/app/modules/drawer/models/my_successive_list_response_model.dart';

import '../../../../../export.dart';

class MySuccessesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    hitMySuccessiveListApiCall();
    super.onReady();
  }

  RxList<MySuccessiveListApiDataModel> mySuccessesWeight = <MySuccessiveListApiDataModel>[].obs;
  RxList<MySuccessiveListApiDataModel> mySuccessesTo = <MySuccessiveListApiDataModel>[].obs;

  MySuccessiveListApiResponseModel mySuccessiveListApiResponseModel = MySuccessiveListApiResponseModel();

  hitMySuccessiveListApiCall() {
    customLoader.show(Get.overlayContext);
    APIRepository().mySuccessiveListApiCall().then((value) {
      if (value != null) {
        mySuccessiveListApiResponseModel = value;
        mySuccessiveListApiResponseModel.list?.forEach((element) {
          if (element.typeId == 1) {
            mySuccessesWeight.add(element);
          } else {
            mySuccessesTo.add(element);
          }
        });
        customLoader.hide();
      }
      customLoader.hide();
    }).onError((error, stackTrace) {
      customLoader.hide();

      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }
}

class Successes {
  String? title;
  bool? completed;

  Successes({this.title, this.completed});
}
