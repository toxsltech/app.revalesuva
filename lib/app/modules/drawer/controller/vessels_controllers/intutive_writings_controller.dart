import 'package:health_fitness/app/modules/drawer/models/response_model/intuitive_writing_list_api_response_model.dart';

import '../../../../../export.dart';

class IntuitiveWritingController extends GetxController {
  RxList<IntuitiveWritingListDataModel> intuitiveWritings =
      <IntuitiveWritingListDataModel>[].obs;

  final GlobalKey<FormState> intuitiveWritingFormKey = GlobalKey<FormState>();

  TextEditingController intuitiveTitle = TextEditingController();
  TextEditingController intuitiveComment = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    getIntuitiveWritingList(isFrom: "controller");
    super.onReady();
  }

  addIntuitiveWritingApiCall() {
    var reqBody = AuthRequestModel.addIntuitiveWriting(
        title: intuitiveTitle.text, description: intuitiveComment.text);
    APIRepository().addIntuitiveWriting(data: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        Get.back();
        getIntuitiveWritingList(isFrom: "controller");
        intuitiveTitle.clear();
        intuitiveComment.clear();
        toast(messageResponseModel.message);
      }
    }).onError((error, stackTrace) {
      debugPrint("Error:::::$error");
      debugPrint("Stacktrace:::::$stackTrace");
    });
  }

  IntuitiveWritingListResponseModel intuitiveWritingListResponseModel =
      IntuitiveWritingListResponseModel();

  getIntuitiveWritingList({isFrom}) {
    if (isFrom == "controller") {
      customLoader.show(Get.overlayContext);
    }
    APIRepository().getIntuitiveWritingList().then((value) {
      if (value != null) {
        intuitiveWritings.clear();
        intuitiveWritingListResponseModel = value;
        intuitiveWritings.addAll(intuitiveWritingListResponseModel.list ?? []);
        intuitiveWritings.refresh();
        customLoader.hide();
      }
      customLoader.hide();
    }).onError((error, stackTrace) {
      customLoader.hide();
      debugPrint("Error:::::$error");
      debugPrint("Stacktrace:::::$stackTrace");
    });
  }
}
