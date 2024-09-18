import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_detail_controller.dart';

import '../../../../export.dart';

class IntuitiveDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<IntuitiveWritingDetailController>(IntuitiveWritingDetailController());
  }
}
