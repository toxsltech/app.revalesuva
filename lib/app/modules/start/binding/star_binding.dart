import 'package:get/get.dart';

import '../controller/star_controller.dart';

class StarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarController>(() => StarController());
  }
}
