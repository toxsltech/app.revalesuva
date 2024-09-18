import 'package:get/get.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeController>(
      () => RecipeController(),
    );
  }
}
