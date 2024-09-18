import 'package:health_fitness/app/modules/authentication/model/login_response_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../export.dart';
import '../model/question_list_Response.dart';

class GeneralDetailController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController apartmentTxtController = TextEditingController();
  TextEditingController floorTxtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController practiceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bloodTestController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  RxInt isBodyDetail = 0.obs;
  RxInt queNumber = 0.obs;
  RxString selectedButton = "".obs;
  RxString profileImage = "".obs;
  RxString backImage = "".obs;
  RxString sideImage = "".obs;
  RxString frontImage = "".obs;
  RxString bloodTestFile = "".obs;

  LoginResponseModel? loginResponseModel;
  LoginResponseModel loginSignUpResponseModel = LoginResponseModel();
  QuestionListResponseModel? questionListResponseModel;
  RxList<QuestionList> questionList = <QuestionList>[].obs;

  RxString selectedQue = "".obs;
  RxInt selectedQueNo = 0.obs;
  // List testList = ["que1", "que2", "que3"];

  @override
  void onInit() {
    getQuestionAPI();
    genderController.text = loginDataModel!.gender == male
        ? keyMale.tr
        : loginDataModel!.gender == female
            ? keyFemale.tr
            : keyOther.tr;
    profileImage.value = loginDataModel!.profileFile!;
    super.onInit();
  }

  getQuestionAPI() {
    repository.getQuestionApiCall().then((value) async {
      if (value != null) {
        questionListResponseModel = value;
        questionList.value.addAll(questionListResponseModel!.list!);
        selectedQue.value = questionList.first.title!;
        selectedButton.value =
            questionList.first.typeId == 1 ? keyYes.tr : keyNo.tr;
        debugPrint(questionListResponseModel.toString());
        questionList.refresh();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      //  showInSnackBar(message: error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }

  Future<MultipartFile?> convertToMultipart(String image) async {
    debugPrint(":::::::$image");
    MultipartFile? profileMultipartImage;
    if (image != "" && !image.contains("http")) {
      profileMultipartImage =
          await MultipartFile.fromFile(image, filename: image);
    }
    debugPrint("profileMultipartImage ${profileMultipartImage.toString()}");
    return profileMultipartImage;
  }

  hitUploadImageAPI(type, String value) async {
    // customLoader.show(Get.overlayContext);
    var uploadReq = AuthRequestModel.imageUploadReq(
        type: type, image: await convertToMultipart(value));
    APIRepository.imageUploadApiCall(dataBody: uploadReq).then((value) {
      // toast(value?.message, seconds: 1);
      Future.delayed(Duration(seconds: 2), () {
        // customLoader.hide();
      });
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  hitCheckAPI() {
    repository.checkApiCall().then((value) async {
      if (value != null) {
        debugPrint("checkApiCall");
        loginSignUpResponseModel = value;
        debugPrint(loginSignUpResponseModel.toString());
        preferenceManger.saveRegisterData(loginSignUpResponseModel.detail);
        Get.offAllNamed(AppRoutes.mainScreen);
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint(stackTrace.toString());
      //  showInSnackBar(message: error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }

  hitAddAnswerApi(String id, String answer, int? typeId, int? check) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.answerReq(
      quesId: id,
      typeId: typeId,
      answer: answer,
      profileCompleted: check,
    );
    APIRepository().addAnswerApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      answerController.text = "";
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  hitProfileSetUpApi() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.profileSetUpReq(
      address: streetController.text.trim(),
      city: cityController.text.trim(),
      age: ageController.text.trim(),
      apartmentNumber: apartmentTxtController.text.trim(),
      floor: floorTxtController.text.trim(),
      height: heightController.text.trim(),
      weight: weightController.text.trim(),
    );
    APIRepository().profileApiCall(dataBody: response).then((value) async {
      loginResponseModel = value;
      customLoader.hide();
      preferenceManger.saveRegisterData(loginResponseModel!.detail);
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  updateImageFile(Future<PickedFile?> imagePath, int? type) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      if (type == 0) {
        profileImage.value = file.path;
        hitUploadImageAPI(type, profileImage.value);
      } else if (type == 1) {
        frontImage.value = file.path;
        hitUploadImageAPI(type, frontImage.value);
      } else if (type == 2) {
        sideImage.value = file.path;
        hitUploadImageAPI(type, sideImage.value);
      } else if (type == 3) {
        backImage.value = file.path;
        hitUploadImageAPI(type, backImage.value);
      } else {
        // data['File[blood_test]'] = image;
      }
      update();
    }
  }

  updateFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 2) {
        // This file is Longer the
        toast("Please upload file less than 2 mb");
        return;
      }
      bloodTestFile.value = file.path;
      bloodTestController.text = file.path;
      hitUploadImageAPI(4, bloodTestController.text);
      bloodTestController.text = bloodTestController.text.split("/").last;
      print(bloodTestFile);
    } else {
      toast("אף קובץ לא נבחר");
      // toast("No file selected");
    }
    update();
  }
}
