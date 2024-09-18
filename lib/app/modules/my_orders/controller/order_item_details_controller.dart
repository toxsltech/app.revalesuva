import '../../../../export.dart';
import '../models/order_item_details_model.dart';

class OrderItemDetailsController extends GetxController {
  final billingFormGlobalKey = GlobalKey<FormState>();

  OrderItemDetailsResponse orderItemDetailsResponse =
      OrderItemDetailsResponse();
  RxInt shipmentType = TYPE_HOME_DELIVERY.obs;
  var id;
  String? state;
  int page = 0;

  @override
  void onInit() {
    if (Get.arguments != null) {
      id = Get.arguments["id"];
    }
    getOrderItemDetails();
    // TODO: implement onInit
    super.onInit();
  }

  getOrderItemDetails() {
    APIRepository().orderItemDetailsApiCall(id, page).then(
      (value) {
        if (value != null) {
          orderItemDetailsResponse = value;

          if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_CANCELLED) {
            print("");
            state = "Cancelled";
          } else if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_OUT_FOR_DELIVERY) {
            state = "Out for delivery";
          } else if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_PLACED) {
            state = "Order placed";
          } else if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_DELIVERED) {
            state = "Delivered";
          } else if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_PACKED) {
            state = "Packed";
          } else if (orderItemDetailsResponse.detail!.stateId ==
              STATE_ORDER_SHIPPED) {
            state = "Shipped";
          } else {
            state = "";
          }
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

  hitCancelOrderItem() {
    APIRepository().cancelOrderItemApiCall(orderId: id).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          getOrderItemDetails();
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
