import 'package:get/get.dart';
import 'package:health_fitness/app/modules/drawer/controller/contact_data_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/personal_profile_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/vessels_controllers/intutive_writings_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/weighing_and_perimeter_controller.dart';
import 'package:health_fitness/app/modules/drawer/controller/weighing_detail_controller.dart';

import '../controller/body_and_meedical_details_controller.dart';

class DrawerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalProfileController>(() => PersonalProfileController());
    Get.lazyPut<ContactDataController>(() => ContactDataController());
    Get.lazyPut<WeighingAndPerimeterController>(() => WeighingAndPerimeterController());
    Get.lazyPut<WeighingDetailController>(() => WeighingDetailController());
    Get.lazyPut<BodyAndMedicalDetailController>(() => BodyAndMedicalDetailController());
    Get.lazyPut<IntuitiveWritingController>(() => IntuitiveWritingController());
  }
}
