import 'package:get/get.dart';
import 'package:health_fitness/app/modules/principles_so_far/controller/principle_so_far_controller.dart';

class PrincipleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrincipleController>(
      () => PrincipleController(),
    );
  }
}
