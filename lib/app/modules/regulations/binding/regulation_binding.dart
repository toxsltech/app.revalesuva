import 'package:health_fitness/app/modules/regulations/controller/regulation_controller.dart';

import '../../../../export.dart';

class RegulationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegulationController>(
      () => RegulationController(),
    );
  }
}
