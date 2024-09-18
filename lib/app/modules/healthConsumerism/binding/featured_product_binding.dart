import 'package:get/get.dart';
import 'package:health_fitness/app/modules/healthConsumerism/controller/featured_product_controller.dart';

class FeaturedProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeaturedProductController>(
      () => FeaturedProductController(),
    );
  }
}
