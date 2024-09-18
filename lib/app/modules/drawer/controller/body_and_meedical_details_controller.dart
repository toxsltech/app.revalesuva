import '../../../../export.dart';
import '../../authentication/model/login_response_model.dart';

class BodyAndMedicalDetailController extends GetxController {
  RxBool isEdit = false.obs;
  RxBool editMedicalQus = false.obs;
  RxInt selectedButton = 1.obs;
  LoginResponseModel? loginResponseModel;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  List<TextEditingController> textControllers = [];
  List<TeamMember> dataList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onInit
    hitCheckAPI();
    super.onReady();
  }

  var planType;

  getProfileData() async {
    try {
      loginDataModel = await preferenceManger.getSavedLoginData();
      planType = loginDataModel!.planType;
      debugPrint(
        "Plan Type : " + planType.toString(),
      );
      weightController.text = loginDataModel!.weight ?? "";
      heightController.text = loginDataModel!.height ?? "";
      ageController.text = loginDataModel!.age ?? "";
      textControllers =
          List.generate(loginDataModel!.quetionDetails!.length, (index) {
        return TextEditingController();
      });
      for (int i = 0; i < loginDataModel!.quetionDetails!.length; i++) {
        textControllers[i].text =
            loginDataModel!.quetionDetails![i].title.toString();
      }
      update();
    } catch (e, stack) {
      debugPrint("Error:::::${e.toString()}");
      debugPrintStack(stackTrace: stack);
    }
  }

  LoginResponseModel loginSignUpResponseModel = LoginResponseModel();

  hitCheckAPI() {
    repository.checkApiCall().then((value) async {
      if (value != null) {
        debugPrint("checkApiCall");
        loginSignUpResponseModel = value;
        debugPrint(loginSignUpResponseModel.toString());
        preferenceManger.saveRegisterData(loginSignUpResponseModel.detail);
        getProfileData();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint(stackTrace.toString());
      //  showInSnackBar(message: error.toString());
      Get.offAllNamed(AppRoutes.logIn);
    });
  }

  hitProfileSetUpApi() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.profileSetUpReq(
      weight: weightController.text.trim(),
      height: heightController.text.trim(),
      age: ageController.text.trim(),
    );
    APIRepository().profileApiCall(dataBody: response).then((value) async {
      loginResponseModel = value;
      customLoader.hide();
      preferenceManger.saveRegisterData(loginResponseModel!.detail);
      getProfileData();
      Get.back();
      toast(value.message);
      update();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  hitAddAnswerApi(String id, String answer, int? typeId) async {
    // customLoader.show(Get.overlayContext);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.answerReq(
      quesId: id,
      typeId: typeId,
      answer: answer,
      profileCompleted: 1,
    );
    APIRepository().addAnswerApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  hitUpdateAnswerApi() async {
    customLoader.show(Get.overlayContext);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.updateAnswerReq(
      jsonAnswer: jsonEncode(dataList),
    );
    APIRepository().updateAnswerApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      hitCheckAPI();
      dataList.clear();
      Get.back();
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  RxList<MedicalQuestionsModel> medicalQuestionList = <MedicalQuestionsModel>[
    MedicalQuestionsModel(
        id: 1,
        question:
            'Are there any medical problems/ illness from which you suffer?',
        answer: 'Yes. I have blood pressure problems and i take pills.',
        isSelected: false),
    MedicalQuestionsModel(
        id: 2,
        question: 'Have you ever been hospitalize?',
        answer: 'No.',
        isSelected: false),
    MedicalQuestionsModel(
        id: 3,
        question: 'Do you take medication regularly?',
        answer: 'Yes.',
        isSelected: false),
    MedicalQuestionsModel(
        id: 4,
        question:
            'Are there any medical problems/ illness from which you suffer?',
        answer: 'Yes. I have blood pressure problems and i take pills.',
        isSelected: false),
    MedicalQuestionsModel(
        id: 5,
        question:
            'Are there any medical problems/ illness from which you suffer?',
        answer: 'Yes. I have blood pressure problems and i take pills.',
        isSelected: false),
  ].obs;
}

class MedicalQuestionsModel {
  int? id;
  String? answer;
  String? question;
  bool isSelected;
  bool groupValue;

  MedicalQuestionsModel(
      {this.answer,
      this.question,
      this.id,
      required this.isSelected,
      this.groupValue = true});
}

class TeamMember {
  int id;
  String questionId;
  String title;
  String typeId;

  TeamMember(this.id, this.questionId, this.title, this.typeId);

  // Convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'title': title,
      'type_id': typeId,
    };
  }
}
