import '../../../../export.dart';
import '../models/response_models/shop_details_response.dart';

class ShopDetailController extends GetxController {
  ShopLDetailsResponseModel shopLDetailsResponseModel =
      ShopLDetailsResponseModel();
  var productId;
  @override
  void onInit() {
    if (Get.arguments != null) {
      productId = Get.arguments["id"];
    }
    super.onInit();
  }

  @override
  onReady() {
    getShopDetailsApi();
    // getItemCartList();
    super.onReady();
  }

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxBool dateSelected = false.obs;

  List<queAnsModel> detailList = [
    queAnsModel(que: "פרטים כלליים", ans: "זה פרטים כלליים"),
    // queAnsModel(que: "General Details", ans: "This is general details"),
    queAnsModel(que: "על הסדנה", ans: "הכל על סדנה")
    // queAnsModel(que: "About the workshop", ans: "all about workshop")
  ];

  getShopDetailsApi() {
    // customLoader.show(Get.overlayContext!);
    APIRepository().shopDetailsApiCall(productId: productId).then(
      (value) {
        if (value != null) {
          shopLDetailsResponseModel = value;
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

  hitAddToCartApiCall() {
    var reqBody = AuthRequestModel.addToCart(
      productId: shopLDetailsResponseModel.product!.id,
      quantity: count.value,
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().addToCartShopProdApiCall(dataBody: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        count.value = 0;
        getShopDetailsApi();
        toast(messageResponseModel.message);
        update();
      }
      // customLoader.hide();
    }).onError(
      (error, stackTrace) {
        toast(error.toString());
        // customLoader.hide();
        debugPrint("Error:::::${error.toString()}");
        debugPrint("Stack:::::$stackTrace");
      },
    );
  }

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

class queAnsModel {
  String? que;
  String? ans;
  bool? isCheck;
  int? activeMeterIndex;

  queAnsModel(
      {this.que, this.ans, this.isCheck = false, this.activeMeterIndex});
}
