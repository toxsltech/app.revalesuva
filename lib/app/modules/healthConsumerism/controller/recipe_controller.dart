import 'package:health_fitness/app/modules/healthConsumerism/models/response_model/recipe_list_response.dart';

import '../../../../export.dart';
import '../models/data_model/recipe_detail_data_model.dart';

class RecipeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List products = [
    {"icon": iconEvening, "name": keyEvening.tr},
    {"icon": iconMorning, "name": keyNoon.tr},
    {"icon": iconNoon, "name": keyMorning.tr},
    {"icon": iconRecommended, "name": keyRecommended.tr},
  ];
  RecipeListResponse? recipeResponse;
  List<RecipeList> recipeList = [];
  RxInt foodSelectedIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  bool foodTypeVisible = false;

  List foodType = [
    {"name": keyAll.tr},
    {"name": keyVegan.tr},
    {"name": keyVegetarian.tr},
    {"name": keyNonVegetarian.tr},
  ];

  int scheduledTime = 2;
  int type = 5;

  @override
  void onInit() {
    getRecipeListAPI(scheduledTime, type, "");
    super.onInit();
  }

  getRecipeListAPI(schedule, type, search) {
    recipeList.clear();
    repository.getRecipeListApiCall(schedule, type, search).then((value) async {
      if (value != null) {
        recipeResponse = value;
        recipeList.clear();
        recipeList.addAll(recipeResponse!.list!);
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }
}
