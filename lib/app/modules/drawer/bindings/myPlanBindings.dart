import 'package:get/get.dart';
import 'package:health_fitness/app/modules/drawer/controller/myPlanController/my_plan_controller.dart';

import '../controller/myPlanController/ice_medicine_controller.dart';

class MyPlanBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPlanController>(() => MyPlanController());
    Get.lazyPut<IceMedicineController>(() => IceMedicineController());
  }
}
