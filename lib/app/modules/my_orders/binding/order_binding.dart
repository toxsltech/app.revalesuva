import 'package:get/get.dart';

import '../controller/order_item_details_controller.dart';
import '../controller/order_list_controller.dart';
import '../controller/oreder_item_list_controller.dart';

class OrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderListController>(() => OrderListController());
    Get.lazyPut<OrderItemListController>(() => OrderItemListController());
    Get.lazyPut<OrderItemDetailsController>(() => OrderItemDetailsController());
  }
}
