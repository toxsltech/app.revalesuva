import 'package:get/get.dart';
import 'package:health_fitness/app/modules/shop/controllers/payment_controller.dart';

import '../controllers/shop_controller.dart';
import '../controllers/shop_detail_controller.dart';

class ShopBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController());
    Get.lazyPut<ShopDetailController>(() => ShopDetailController());
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}