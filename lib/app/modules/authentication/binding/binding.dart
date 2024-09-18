/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';
import '../controllers/already_know_controller.dart';
import '../controllers/body_details_controller.dart';
import '../controllers/general_details_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.put(AlreadyKnowScreenController());
    Get.lazyPut<GeneralDetailController>(
      () => GeneralDetailController(),
    );
    Get.lazyPut<BodyDetailController>(
      () => BodyDetailController(),
    );

  }
}
