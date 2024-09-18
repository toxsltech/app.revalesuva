import 'package:health_fitness/app/modules/contact/controllers/contact_controller.dart';

import '../../../../export.dart';

class ContactBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
