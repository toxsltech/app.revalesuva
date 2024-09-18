import '../../../../export.dart';

class AlreadyKnowScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    getProfileData();
    super.onInit();
  }

  getProfileData() async {
    loginDataModel = await preferenceManger.getSavedLoginData();
    nameController.text = loginDataModel!.fullName!;
    phoneController.text = loginDataModel!.contactNo!;
    emailController.text = loginDataModel!.email!;
  }
}
