import 'package:health_fitness/app/modules/drawer/controller/myPlanController/the_gate_controller.dart';

import '../../../../export.dart';

class TheGateBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TheGateController>(TheGateController());
  }
}
