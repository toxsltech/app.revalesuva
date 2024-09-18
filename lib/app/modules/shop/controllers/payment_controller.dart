import '../../../../export.dart';
import '../models/response_models/item_cart_response.dart';

class PaymentController extends GetxController {
  final billingFormGlobalKey = GlobalKey<FormState>();
  TextEditingController nameTxtController = TextEditingController();
  TextEditingController phoneTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController addressTxtController = TextEditingController();
  TextEditingController zipTxtController = TextEditingController();
  TextEditingController couponTxtController = TextEditingController();

  ItemCartListResponseModel itemCartListResponseModel =
      ItemCartListResponseModel();
  RxList<ItemCartList> cartList = <ItemCartList>[].obs;
  RxInt shipmentType = TYPE_HOME_DELIVERY.obs;

  @override
  void onInit() {
    getItemCartList();
    // TODO: implement onInit
    super.onInit();
  }

  hitAddDetailsApiCall() async {
    debugPrint("Clicked");
    var reqBody = AuthRequestModel.billDetailsReq(
      fullName: nameTxtController.text.trim(),
      email: emailTxtController.text.trim(),
      contactNumber: phoneTxtController.text.trim(),
      zipCode: zipTxtController.text.trim(),
      address: addressTxtController.text.trim(),
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().addBillingDetailsApiCall(dataBody: reqBody).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          toast(messageResponseModel.message);
          update();
        }
        // customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        toast(error.toString());
        // customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      },
    );
  }

  hitUpdateDetailsApiCall() async {
    debugPrint("Clicked");
    var reqBody = AuthRequestModel.billDetailsReq(
      fullName: nameTxtController.text.trim(),
      email: emailTxtController.text.trim(),
      contactNumber: phoneTxtController.text.trim(),
      zipCode: zipTxtController.text.trim(),
      address: addressTxtController.text.trim(),
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().updateBillingDetailsApiCall(dataBody: reqBody).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          toast(messageResponseModel.message);
          update();
        }
        // customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        toast(error.toString());
        // customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      },
    );
  }

  hitPlaceOrderApiCall() async {
    var reqBody = AuthRequestModel.placeOrderReq(
      // id: 1,
      typeId: shipmentType.value,
      price: itemCartListResponseModel.totalPrice,
      totalPrice: itemCartListResponseModel.totalPrice,
      fullName: nameTxtController.text.trim(),
      email: emailTxtController.text.trim(),
      contactNumber: phoneTxtController.text.trim(),
      zipCode: zipTxtController.text.trim(),
      address: addressTxtController.text.trim(),
      // itemDetails: [],
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().placeOrderApiCall(dataBody: reqBody).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          toast(messageResponseModel.message);
          Get.back();
          update();
        }
        // customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        toast(error.toString());
        // customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      },
    );
  }

  getItemCartList() {
    cartList.clear();
    APIRepository().cartItemListApiCall().then(
      (value) {
        if (value != null) {
          itemCartListResponseModel = value;
          cartList.value.addAll(
            itemCartListResponseModel.list ?? [],
          );
          cartList.refresh();
          if (cartList.value.isEmpty) {
            Get.back();
            toast("עגלת הקניות ריקה");
            // toast("Cart is empty");
            // Get.find<ShopDetailController>().getShopDetailsApi();
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

  hitDeleteCartItem(id) {
    APIRepository().deleteCartItemApiCall(productId: id).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          getItemCartList();
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
        isActive: true, title: "משלוח עד הבית (עד 8 ימי עסקים)"),
        // isActive: true, title: "Home delivery(up to 8 business days)"),
    shipmentModel(isActive: false, title: "איסוף עצמי")
    // shipmentModel(isActive: false, title: "Self-pickup")
  ];

  List<paymentModel> paymentOption = [
    paymentModel(isActive: true, title: "תשלום מאובטח בכרטיס אשראי"),
    // paymentModel(isActive: true, title: "Secure credit card payment"),
    paymentModel(isActive: false, title: "תשלום מאובטח באמצעות PayPal")
    // paymentModel(isActive: false, title: "Secure payment via paypal")
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
