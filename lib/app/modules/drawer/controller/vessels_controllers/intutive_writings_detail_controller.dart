import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_controller.dart';

import '../../../../../export.dart';

class IntuitiveWritingDetailController extends GetxController {
  final IntuitiveWritingController intuitiveWritingController = Get.put(IntuitiveWritingController());

  final GlobalKey<FormState> intuitiveWritingFormKey = GlobalKey<FormState>();
  TextEditingController intuitiveTitle = TextEditingController();
  TextEditingController intuitiveComment = TextEditingController();

  @override
  void onInit() {
    getDataById();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  var id;
  int index = -1;

  getDataById() {
    if (Get.arguments != null) {
      id = Get.arguments['id'] ?? 0;
      index = intuitiveWritingController.intuitiveWritings.indexWhere((element) => element.id == id);
      intuitiveTitle.text = intuitiveWritingController.intuitiveWritings[index].title ?? "";
      intuitiveComment.text = intuitiveWritingController.intuitiveWritings[index].description ?? "";
    }
  }

  updateIntuitiveWritingApiCall() {
    var reqBody = AuthRequestModel.addIntuitiveWriting(title: intuitiveTitle.text, description: intuitiveComment.text);
    APIRepository().updateIntuitiveWriting(data: reqBody, id: id).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        intuitiveWritingController.getIntuitiveWritingList();
        intuitiveWritingController.intuitiveWritings.refresh();
        Get.back();
        toast(messageResponseModel.message);
      }
    }).onError((error, stackTrace) {
      debugPrint("Error:::::$error");
      debugPrint("Stacktrace:::::$stackTrace");
    });
  }

  hitIntuitiveDeleteApiCall({id}) {
    customLoader.show(Get.overlayContext);
    APIRepository().deleteIntuitiveWriting(id: id).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        intuitiveWritingController.getIntuitiveWritingList();
        intuitiveWritingController.intuitiveWritings.refresh();
        Get.back();
        toast(messageResponseModel.message);
        customLoader.hide();
      }
      customLoader.hide();
    }).onError((error, stackTrace) {
      debugPrint("Error:::::$error");
      customLoader.hide();
      debugPrint("Stacktrace:::::$stackTrace");
    });
  }
}

class IntuitiveModel {
  var title;
  var comment;
  var time;
  var id;

  IntuitiveModel({this.id, this.title, this.comment, this.time});
}
