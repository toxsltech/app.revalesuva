
import '../../../../export.dart';

class MySuccessesBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MySuccessesController>(MySuccessesController());
  }
}
