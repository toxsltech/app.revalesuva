import 'package:health_fitness/app/modules/authentication/model/login_data_model.dart';
import 'package:health_fitness/export.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static RxString planType = ''.obs;

  @override
  void onInit() {
    getPlanType();
    super.onInit();
  }

  Rx<LoginDataModel> loginDataModel = LoginDataModel().obs;

  getPlanType() async {
    planType.value = await PreferenceManger().getPlanType();
    loginDataModel.value = await PreferenceManger().getSavedLoginData();
    profileImage.value = loginDataModel.value.profileFile!;
    planType.refresh();
    addProfileList();
    debugPrint("Plan Type::::: ${planType.value}");
  }

  RxString profileImage = ''.obs;

  updateImageFile(Future<PickedFile?> imagePath, int? type) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImage.value = file.path;
    }
  }

  hitUpdateProfileApiCall() {}

  addProfileList() {
    profileList.add(
      ProfileListModel(
          title: keyPersonalProfile.tr,
          icon: iconProfileMenu,
          onTap: () {
            Get.toNamed(
              AppRoutes.personalProfile,
            );
          }),
    );
    if (planType.value == "3") {
      profileList.add(ProfileListModel(
          title: "Weighing and perimeter tracking",
          icon: iconWeightMachine,
          onTap: () {
            Get.toNamed(
              AppRoutes.weighingAndPerimeterScreen,
            );
          }));
    }
    if (planType.value != "2") {
      profileList.add(
        ProfileListModel(
          title: keyVessels.tr,
          icon: iconVessel,
          onTap: () {
            Get.toNamed(
              AppRoutes.vesselsScreen,
            );
          },
        ),
      );
    }
    profileList.add(
      ProfileListModel(
          title: keyShoppingList.tr,
          icon: iconShopping,
          onTap: () {
            Get.toNamed(
              AppRoutes.orderListScreen,
            );
          }),
    );
   /* profileList.add(
      ProfileListModel(
          title: keyRecipesILoved.tr,
          icon: iconLovedRecipe,
          onTap: () {
            Get.toNamed(
              AppRoutes.personalProfile,
            );
          }),
    );*/
    // profileList.add(
    //   ProfileListModel(
    //       title: "My Workshops/Events",
    //       icon: iconWorkShop,
    //       onTap: () {
    //         Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
    //       }),
    // );
    profileList.add(
      ProfileListModel(
          title: keyPrinciples.tr,
          icon: iconShopping,
          onTap: () {
            Get.toNamed(
              AppRoutes.principleScreen,
            );
          }),
    );
    profileList.add(
      ProfileListModel(
          title: keyMyPlan.tr,
          icon: iconMyPlan,
          onTap: () {
            Get.toNamed(
              AppRoutes.myPlanScreen,
              arguments: {
                "check":"true",
              }
            );
          }),
    );
    profileList.add(
      ProfileListModel(
          title: keyMyStars.tr,
          icon: iconMyStar,
          onTap: () {
            Get.toNamed(
              AppRoutes.starScreen,
            );
          }),
    );
    profileList.add(
      ProfileListModel(
          title: keyContact.tr,
          icon: iconContact,
          onTap: () {
            Get.toNamed(
              AppRoutes.personalProfile,
            );
          }),
    );
    profileList.refresh();
  }

  RxList<ProfileListModel> profileList = <ProfileListModel>[].obs;
}

class ProfileListModel {
  String? title;
  String? icon;
  void Function()? onTap;

  ProfileListModel({this.title, this.onTap, this.icon});
}
