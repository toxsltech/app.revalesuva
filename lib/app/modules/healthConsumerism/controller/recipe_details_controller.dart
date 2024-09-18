import '../../../../export.dart';
import '../models/response_model/recipe_details_response.dart';

class RecipeDetailsController extends GetxController {
  RxBool selectedIngredient = false.obs;

  RecipeListDetails? recipeListDetails;
  var recipeId;

  @override
  void onInit() {
    initArg();
    super.onInit();
  }

  initArg() {
    if (Get.arguments != null) {
      if (Get.arguments["recipeId"] != null) {
        debugPrint("Recipe Id : " + Get.arguments["recipeId"].toString());
        recipeId = Get.arguments["recipeId"];
        getRecipeDetailsAPI(id: recipeId);
      }
    }
  }

  getRecipeDetailsAPI({int? id}) {
    repository.getRecipeDetailsApiCall(id).then((value) async {
      if (value != null) {
        recipeListDetails = value;
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }

  List methodPreparation = [
    {"numbers": "1.", "description": keyMethod1},
    {"numbers": "2.", "description": keyMethod2},
    {"numbers": "3.", "description": keyMethod3},
  ];
}
