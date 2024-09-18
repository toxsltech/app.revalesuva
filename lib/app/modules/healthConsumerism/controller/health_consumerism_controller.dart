import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:health_fitness/export.dart';

class HealthConsumerismHomeController extends GetxController {
  var check;
  @override
  void onInit() {
    // TODO: implement onInit
    if(Get.arguments!=null)
      {
        check = Get.arguments["check"];
      }
    super.onInit();
  }

}
