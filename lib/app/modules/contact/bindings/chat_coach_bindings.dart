import 'package:health_fitness/app/modules/contact/controllers/chat_coach_controller.dart';

import '../../../../export.dart';

class ChatCoachBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatCoachController>(ChatCoachController());
  }
}
