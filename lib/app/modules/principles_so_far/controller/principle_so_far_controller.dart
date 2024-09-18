import 'package:health_fitness/app/modules/authentication/model/login_data_model.dart';
import 'package:health_fitness/export.dart';
import 'package:image_picker/image_picker.dart';

class PrincipleController extends GetxController {
  static RxString planType = ''.obs;

  @override
  void onInit() {
    getPlanType();
    super.onInit();
  }

  RxBool allCheck = true.obs;

  Rx<LoginDataModel> loginDataModel = LoginDataModel().obs;

  getPlanType() async {
    planType.value = await PreferenceManger().getPlanType();
    loginDataModel.value = await PreferenceManger().getSavedLoginData();
    profileImage.value = loginDataModel.value.profileFile!;
    planType.refresh();
    addCheckList();
    addUnCheckList();
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

  addCheckList() {
    checkList.add(
      checkListModel(
          title: "Principle 16-1 of each nutrient",
          icon: squareUnCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );

    checkList.add(checkListModel(
        title: "Principle 15-Finish eating 3-4 hours before bedtime",
        icon: squareUnCheckBox,
        check: false,
        nextText: "In conclusion",
        onTap: () {
          // Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
        }));

    checkList.add(
      checkListModel(
        title: "Principle 13- Ading Antioxidants",
        icon: squareUnCheckBox,
        check: false,
        nextText: "Finally",
        onTap: () {
          // Get.toNamed(AppRoutes.vesselsScreen);
        },
      ),
    );

    checkList.add(
      checkListModel(
          title: "Principle 12- Determining a key achievement",
          icon: squareCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.orderListScreen);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 11- As much movement as possible per day",
          icon: squareCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 10- End a cold water shower",
          icon: squareUnCheckBox,
          nextText: "In conclusion",
          onTap: () {
            // Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
          }),
    );
    checkList.add(
      checkListModel(
        title: "Principle 9- Training on an empty stomach",
        icon: squareUnCheckBox,
        check: false,
        nextText: "In conclusion",
        onTap: () {
          // Get.toNamed(AppRoutes.orderListScreen);
        },
      ),
    );
    checkList.add(
      checkListModel(
          title: "My Principle 8- 6-7 hours of sleep",
          icon: squareUnCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.myPlanScreen);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 7- Connect to your personal monthly cycle",
          icon: squareCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.starScreen);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 6- Eating according to real hunger",
          icon: squareCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 5- Victory picture",
          icon: squareCheckBox,
          nextText: "In conclusion",
          check: true,
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 4- Multiple chewing",
          icon: squareCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 3- Meal and snack structure",
          icon: squareCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 2- Natural Food",
          icon: squareCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.add(
      checkListModel(
          title: "Principle 1- Eating up to a quarter to satiety",
          icon: squareCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    checkList.refresh();
  }

  addUnCheckList() {
    unCheckList.add(
      checkListModel(
          title: "Principle 16-1 of each nutrient",
          icon: squareUnCheckBox,
          nextText: "Finally",
          check: false,
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );
    if (planType.value == "3") {
      unCheckList.add(checkListModel(
          title: "Principle 15-Finish eating 3-4 hours before bedtime",
          icon: squareUnCheckBox,
          nextText: "Finally",
          check: false,
          onTap: () {
            // Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
          }));
    }
    if (planType.value != "2") {
      unCheckList.add(
        checkListModel(
          title: "Principle 13- Ading Antioxidants",
          icon: squareUnCheckBox,
          nextText: "Finally",
          check: false,
          onTap: () {
            // Get.toNamed(AppRoutes.vesselsScreen);
          },
        ),
      );
    }

    unCheckList.add(
      checkListModel(
          title: "Principle 10- End a cold water shower",
          icon: squareUnCheckBox,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
          }),
    );
    unCheckList.add(
      checkListModel(
        title: "Principle 9- Training on an empty stomach",
        icon: squareUnCheckBox,
        check: false,
        nextText: "Finally",
        onTap: () {
          // Get.toNamed(AppRoutes.orderListScreen);
        },
      ),
    );
    unCheckList.add(
      checkListModel(
          title: "My Principle 8- 6-7 hours of sleep",
          icon: squareUnCheckBox,
          check: false,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.myPlanScreen);
          }),
    );

    unCheckList.add(
      checkListModel(
          title: "Principle 6- Eating according to real hunger",
          icon: squareUnCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );

    unCheckList.add(
      checkListModel(
          title: "Principle 3- Meal and snack structure",
          icon: squareUnCheckBox,
          check: true,
          nextText: "Finally",
          onTap: () {
            // Get.toNamed(AppRoutes.personalProfile);
          }),
    );

    unCheckList.refresh();
  }

  RxList<checkListModel> checkList = <checkListModel>[].obs;
  RxList<checkListModel> unCheckList = <checkListModel>[].obs;
}

class checkListModel {
  String? title;
  String? icon;
  void Function()? onTap;
  bool? check;
  String? nextText;

  checkListModel({
    this.title,
    this.onTap,
    this.icon,
    this.check,
    this.nextText,
  });
}
