import 'package:get/get.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/recipe_details_controller.dart';

class RecipeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeDetailsController>(
      () => RecipeDetailsController(),
    );
  }
}
