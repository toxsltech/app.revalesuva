import 'package:health_fitness/app/modules/authentication/model/login_data_model.dart';
import 'package:health_fitness/app/modules/authentication/model/login_response_model.dart';
import 'package:health_fitness/export.dart';

class ContactDataController extends GetxController {
  TextEditingController nameTxtController = TextEditingController();
  TextEditingController phoneTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController ageTxtController = TextEditingController();
  TextEditingController genderTxtController = TextEditingController();
  TextEditingController apartmentTxtController = TextEditingController();
  TextEditingController floorTxtController = TextEditingController();
  TextEditingController streetTxtController = TextEditingController();
  TextEditingController cityTxtController = TextEditingController();
  TextEditingController practiceTxtController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode apartmentFocusNode = FocusNode();
  FocusNode floorFocusNode = FocusNode();
  FocusNode streetFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode practiceFocusNode = FocusNode();
  LoginDataModel? loginDataModel;
  RxString name = "".obs;
  RxString email = "".obs;
  LoginResponseModel? loginResponseModel;

  final List<String> genderList = [
    keyMale.tr,
    keyFemale.tr,
    keyOther.tr,
  ];
  String selectedValue = keyMale.tr;

  RxBool isEdit = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getProfileData();
    super.onInit();
  }

  // void onReady() {
  //   getProfileData();
  //   super.onReady();
  // }

  getProfileData() async {
    loginDataModel = await preferenceManger.getSavedLoginData();
    nameTxtController.text = loginDataModel!.fullName ?? "";
    emailTxtController.text = loginDataModel!.email ?? "";
    ageTxtController.text = loginDataModel!.age ?? "";
    phoneTxtController.text = loginDataModel!.countryCode.toString() +
            loginDataModel!.contactNo.toString() ??
        "";
    streetTxtController.text = loginDataModel!.address ?? "";
    apartmentTxtController.text = loginDataModel!.apartment ?? "";
    floorTxtController.text = loginDataModel!.floor ?? "";
    cityTxtController.text = loginDataModel!.city ?? "";
    genderTxtController.text = loginDataModel!.gender == male
        ? keyMale.tr
        : loginDataModel!.gender == female
            ? keyFemale.tr
            : keyOther.tr ?? "";
    // ageTxtController.text = loginDataModel!.age ?? "";
    name.value = loginDataModel!.fullName ?? "";
    // email.value = loginDataModel!.email ?? "";
    debugPrint(nameTxtController.text);
    update();
  }

  hitProfileSetUpApi() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.profileSetUpReq(
      fullName: nameTxtController.text.trim(),
      address: streetTxtController.text.trim(),
      city: cityTxtController.text.trim(),
      apartmentNumber: apartmentTxtController.text.trim(),
      floor: floorTxtController.text.trim(),
      age: ageTxtController.text.trim(),
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
}
