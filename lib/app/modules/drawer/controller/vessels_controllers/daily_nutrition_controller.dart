import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:health_fitness/app/core/values/app_constant.dart';
import 'package:health_fitness/app/data/remote_service/network/api_provider.dart';
import 'package:health_fitness/app/modules/drawer/models/category_api_response_model.dart';
import 'package:health_fitness/app/modules/drawer/models/sub_category_api_response_model.dart';

import '../../../../core/widgets/custom_flashbar.dart';
import '../../../../data/common_models/message_response_model.dart';
import '../../../../data/remote_service/entity/request_model/auth_reuest_model.dart';

class DailyNutrition {
  String typeId;
  String categoryId;
  String nutritionId;

  DailyNutrition(this.typeId, this.categoryId, this.nutritionId);

  Map toJson() => {
        'type_id': typeId,
        'category_id': categoryId,
        'nutrition_id': nutritionId,
      };
}

class DailyNutritionController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getNutritionCategoryListApiCall(TYPE_BREAKFAST);
    getNutritionCategoryListApiCall(TYPE_LUNCH);
    getNutritionCategoryListApiCall(TYPE_DINNER);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  RxList<DailyNutritionCategoryDataModel> breakFastList =
      <DailyNutritionCategoryDataModel>[].obs;
  RxList<DailyNutritionCategoryDataModel> lunchList =
      <DailyNutritionCategoryDataModel>[].obs;
  RxList<DailyNutritionCategoryDataModel> dinnerFastList =
      <DailyNutritionCategoryDataModel>[].obs;

  List<DailyNutrition> selectedItemsList = [];

  List<int> intID = [];

  List<String> titleList = [];

  List<DailyNutritionSubCategoryDataModel> initialValueList = [];

  static List<DailyNutritionSubCategoryDataModel> dietsVeg =
      <DailyNutritionSubCategoryDataModel>[];
  static List<DailyNutritionSubCategoryDataModel> dietsCarbs =
      <DailyNutritionSubCategoryDataModel>[];
  static List<DailyNutritionSubCategoryDataModel> dietsFats =
      <DailyNutritionSubCategoryDataModel>[];
  static List<DailyNutritionSubCategoryDataModel> dietsProtein =
      <DailyNutritionSubCategoryDataModel>[];

  /*static List<Diets> dietsProtein = [
    Diets(id: 1, name: "EGGS"),
    Diets(id: 2, name: "ALMOND"),
    Diets(id: 3, name: "MILK"),
    Diets(id: 4, name: "FISH"),
    Diets(id: 5, name: "PEANUTS"),
    Diets(id: 6, name: "SHELLFISH"),
  ];*/

  /*static List<Diets> dietsCarbs = [
    Diets(id: 1, name: "GARLIC"),
    Diets(id: 2, name: "BUTTER"),
    Diets(id: 4, name: "CHICKEN"),
  ];*/

  /*static List<Diets> dietsFats = [
    Diets(id: 1, name: "NUTS"),
    Diets(id: 2, name: "AVOCADO"),
    Diets(id: 3, name: "OLIVE OIL"),
    Diets(id: 4, name: "CHIA SEEDS"),
    Diets(id: 5, name: "SEEDS"),
  ];*/

  // final dietProteins = dietsProtein.map((diets) => MultiSelectItem<Diets>(diets, diets.name.toString())).toList();
  var dietVegetables;
  var dietProteins;
  var dietCarbs;
  var dietFats;

  // final dietCarbs = dietsCarbs.map((diets) => MultiSelectItem<Diets>(diets, diets.name.toString())).toList();
  // final dietFats = dietsFats.map((diets) => MultiSelectItem<Diets>(diets, diets.name.toString())).toList();

  DailyNutritionCategoryResponseModel dailyNutritionCategoryResponseModel =
      DailyNutritionCategoryResponseModel();

  DailyNutritionCategoryDataModel dailyNutritionCategoryDataModel =
      DailyNutritionCategoryDataModel();

  getNutritionCategoryListApiCall(typeId) {
    APIRepository().getNutritionCategoryList(typeId).then((value) async {
      if (value != null) {
        dailyNutritionCategoryResponseModel = value;
        if (typeId == TYPE_BREAKFAST) {
          breakFastList.addAll(dailyNutritionCategoryResponseModel.list!);
          update();
        } else if (typeId == TYPE_LUNCH) {
          lunchList.addAll(dailyNutritionCategoryResponseModel.list!);
          update();
        } else {
          dinnerFastList.addAll(dailyNutritionCategoryResponseModel.list!);
          update();
        }
         /*dailyNutritionCategoryResponseModel.list?.forEach((element) {
          if (element.typeId == TYPE_BREAKFAST) {
            breakFastList.add(element);
            print("Break::::::::::::$breakFastList ${element.typeId}");
            update();
          } else if (element.typeId == TYPE_LUNCH) {
            lunchList.add(element);
            print("Lunch::::::::::::${element.title} ${element.typeId}");
            update();
          } else {
            dinnerFastList.add(element);
            print("Dinner::::::::::::${element.title} ${element.typeId}");
            update();
          }
        });*/
        breakFastList.refresh();
        lunchList.refresh();
        dinnerFastList.refresh();
        for (int i = 0; i < breakFastList.length; i++) {
          getNutritionSubCategoryListApiCall(
              typeId: typeId, id: breakFastList[i].id, index: i);
          // await Future.delayed(
          //   Duration(
          //     seconds: 2,
          //   ),
          // );
        }
        for (int i = 0; i < lunchList.length; i++) {
          getNutritionSubCategoryListApiCall(
              typeId: typeId, id: lunchList[i].id, index: i);
          // await Future.delayed(
          //   Duration(
          //     seconds: 2,
          //   ),
          // );
        }
        for (int i = 0; i < dinnerFastList.length; i++) {
          getNutritionSubCategoryListApiCall(
              typeId: typeId, id: dinnerFastList[i].id, index: i);
          // await Future.delayed(
          //   Duration(
          //     seconds: 2,
          //   ),
          // );
        }
      }
    }).onError((error, stackTrace) {
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  DailyNutritionSubCategoryResponseModel
      dailyNutritionSubCategoryResponseModel =
      DailyNutritionSubCategoryResponseModel();
  DailyNutritionSubCategoryDataModel dailyNutritionSubCategoryDataModel =
      DailyNutritionSubCategoryDataModel();

  clearData() {
/*    dietsVeg.clear();
    dietsProtien.clear();
    dietsCarbs.clear();
    dietsFats.clear();
    dietCarbs = <MultiSelectItem>[];
    dietFats = <MultiSelectItem>[];
    dietVegetables = <MultiSelectItem>[];
    dietProteins = <MultiSelectItem>[];*/
  }

  hitAddNutritionApiCall() {
    var reqBody = AuthRequestModel.addDailyNutritionReq(
      dailyNutrition: selectedItemsList,
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().addDailyNutritionApiCall(dataBody: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        toast(messageResponseModel.message);
        Get.back();
        update();
        // customLoader.hide();
      }
      // customLoader.hide();
    }).onError((error, stackTrace) {
      toast(error.toString());
      // customLoader.hide();
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  getNutritionSubCategoryListApiCall({typeId, id, index}) {
    dailyNutritionSubCategoryResponseModel =
        DailyNutritionSubCategoryResponseModel();
    APIRepository()
        .getNutritionSubCategoryList(typeId: typeId, id: id)
        .then((value) {
      if (value != null) {
        dailyNutritionSubCategoryResponseModel = value;
        if (dailyNutritionSubCategoryResponseModel.list!.isNotEmpty) {
          if (typeId == TYPE_BREAKFAST) {
            breakFastList[index]
                .items!
                .addAll(dailyNutritionSubCategoryResponseModel.list!);
            debugPrint(
                "---------------->>${breakFastList[index].items!.length}        ${dailyNutritionSubCategoryResponseModel.list!.length}");
          } else if (typeId == TYPE_LUNCH) {
            lunchList[index]
                .items!
                .addAll(dailyNutritionSubCategoryResponseModel.list!);
            debugPrint(
                "---------------->>${lunchList[index].items!.length}        ${dailyNutritionSubCategoryResponseModel.list!.length}");
          } else {
            dinnerFastList[index]
                .items!
                .addAll(dailyNutritionSubCategoryResponseModel.list!);
            debugPrint(
                "---------------->>${dinnerFastList[index].items!.length}        ${dailyNutritionSubCategoryResponseModel.list!.length}");
          }
        } else {
          // breakFastList[index].items!.clear();
        }
        breakFastList.refresh();
        lunchList.refresh();
        dinnerFastList.refresh();
      }
    }).onError((error, stackTrace) {
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }
}

class queAnsModel {
  String? que;
  String? ans;
  bool? isCheck;
  int? activeMeterIndex;

  queAnsModel(
      {this.que, this.ans, this.isCheck = false, this.activeMeterIndex});
}
