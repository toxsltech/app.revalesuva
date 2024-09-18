import 'package:get/get.dart';
import 'package:health_fitness/app/modules/torah_portion/controller/torah_portion_controller.dart';

class TorahBookBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TorahBookController>(() => TorahBookController());
  }
}
