import 'package:get/get.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/daily_nutrition_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/fasting_calculator_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/ovulation_calculator_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/vessels_controller.dart';

import '../../fastingHistory/controllers/fasting_history_controller.dart';

class VesselsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VesselsScreenController>(() => VesselsScreenController());
    Get.lazyPut<OvulationCalculatorController>(() => OvulationCalculatorController());
    Get.lazyPut<FastingCalculatorController>(() => FastingCalculatorController());
    Get.lazyPut<DailyNutritionController>(() => DailyNutritionController());
    Get.lazyPut<IntuitiveWritingController>(() => IntuitiveWritingController());
    Get.lazyPut<FastingHistoryController>(() => FastingHistoryController());
  }
}
