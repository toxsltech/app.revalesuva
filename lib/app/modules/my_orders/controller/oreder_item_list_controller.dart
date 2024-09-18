import '../../../../export.dart';
import '../models/order_item_list_model.dart';
import '../models/order_list_response.dart';

class OrderItemListController extends GetxController {
  final billingFormGlobalKey = GlobalKey<FormState>();

  OrderItemListResponse orderItemListResponse = OrderItemListResponse();
  RxList<OrderItemList> myOrderItemList = <OrderItemList>[].obs;
  var orderId;
  @override
  void onInit() {
    if (Get.arguments != null) {
      orderId = Get.arguments["id"];
    }
    getOrderItemList();
    // TODO: implement onInit
    super.onInit();
  }

  getOrderItemList() {
    myOrderItemList.clear();
    APIRepository().orderItemListApiCall(orderId).then(
      (value) {
        if (value != null) {
          orderItemListResponse = value;
          myOrderItemList.value.addAll(
            orderItemListResponse.list ?? [],
          );
          myOrderItemList.refresh();
          update();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }

  RxBool isEdit = false.obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedPaymentOption = 0.obs;

  List<shipmentModel> shipment = [
    shipmentModel(
        isActive: true, title: "Home delivery(up to 8 business days)"),
    shipmentModel(isActive: false, title: "Self-pickup")
  ];

  List<paymentModel> paymentOption = [
    paymentModel(isActive: true, title: "Secure credit card payment"),
    paymentModel(isActive: false, title: "Secure payment via paypal")
  ];

  RxInt count = 0.obs;

  decreaseCount() {
    if (count.value > 0) {
      count--;
      count.refresh();
    }
  }

  increaseCount() {
    if (count.value >= 0) {
      count++;
      count.refresh();
    }
  }
}

class shipmentModel {
  String? title;
  bool? isActive;

  shipmentModel({this.title, this.isActive});
}

class paymentModel {
  String? title;
  bool? isActive;

  paymentModel({this.title, this.isActive});
}
