import 'package:health_fitness/app/modules/hadas_reinforcement/controller/hadass_controller.dart';

import '../../../../export.dart';
import '../controller/strength_controller.dart';

class HadasBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadasController>(
      () => HadasController(),
    );
    Get.lazyPut<StrengthController>(
      () => StrengthController(),
    );
    Get.lazyPut<HadasController>(
      () => HadasController(),
    );
  }
}
