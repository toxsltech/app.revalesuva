import 'package:get/get.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/health_consumerism_controller.dart';

class HealthConsumerismBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthConsumerismHomeController>(
      () => HealthConsumerismHomeController(),
    );
  }
}
