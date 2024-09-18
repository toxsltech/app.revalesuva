import 'package:health_fitness/app/modules/drawer/models/data_model/shopping_product_details.dart';

import '../../../../export.dart';
import '../../drawer/models/response_model/shopping_list_response.dart';
import '../../my_orders/controller/order_item_details_controller.dart';
import '../models/response_model/category_details_response.dart';
import '../models/response_model/category_list_response.dart';

class FeaturedProductController extends GetxController {
  TextEditingController searchController = TextEditingController();
  CategoryListResponse? categoryListResponse;
  ShoppingListResponse? shoppingListResponse;
  CategoryDetailsResponse? categoryDetailsResponse;
  List<CategoryList> categoryList = [];
  List<CategoryDetailList> categoryDetailsList = [];
  List<ProductDetails> productDetailsList = [];
  RxInt shipmentType = TYPE_HOME_DELIVERY.obs;
  final billingFormGlobalKey = GlobalKey<FormState>();
  RxBool isEdit = false.obs;
  TextEditingController nameTxtController = TextEditingController();
  TextEditingController phoneTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController addressTxtController = TextEditingController();
  TextEditingController zipTxtController = TextEditingController();
  TextEditingController couponTxtController = TextEditingController();

  RxInt selectedIndexCart = 0.obs;
  RxInt selectedPaymentOption = 0.obs;

  List<shipmentModel> shipment = [
    shipmentModel(isActive: true, title: "משלוח עד הבית (עד 8 ימי עסקים)"),
    // isActive: true, title: "Home delivery(up to 8 business days)"),
    shipmentModel(isActive: false, title: "איסוף עצמי")
    // shipmentModel(isActive: false, title: "Self-pickup")
  ];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() {
    getCategoryListAPI();
    getShoppingListAPI();
  }

  RxInt n = 0.obs;

  void add() {
    n.value++;
    refresh();
  }

  void minus() {
    if (n.value != 0) n--;
    refresh();
  }

  hitPlaceOrderApiCall() async {
    var reqBody = AuthRequestModel.placeOrderReq(
      // id: 1,
      // typeId: shipmentType.value,
      price: shoppingListResponse!.totalPrice,
      totalPrice: shoppingListResponse!.totalPrice,
      fullName: nameTxtController.text.trim(),
      email: emailTxtController.text.trim(),
      contactNumber: phoneTxtController.text.trim(),
      zipCode: zipTxtController.text.trim(),
      address: addressTxtController.text.trim(),
      // itemDetails: [],
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().myShoppingPlaceOrderApiCall(dataBody: reqBody).then(
      (value) {
        if (value != null) {
          MessageResponseModel messageResponseModel = value;
          Get.back();
          toast(messageResponseModel.message);
          getCategoryDetailsAPI(id: selectedCategoryId, search: "");
          getShoppingListAPI();
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

  RxInt selectedIndex = 0.obs;
  int? selectedCategoryId;
  String searchString = "";
  List products = [
    {"icon": iconUserProfile, "name": keySuperFood},
    {"icon": iconUserProfile, "name": keyProteins},
    {"icon": iconUserProfile, "name": keyOils},
    {"icon": iconUserProfile, "name": keyLegumes},
    {"icon": iconUserProfile, "name": keyRecommended},
  ];

  List scheduleItemList = [
    {"icon": iconUserProfile, "title": keyFreshPeaches},
    {"icon": iconUserProfile, "title": keyFreshAvocado},
    {"icon": iconUserProfile, "title": keyFreshPineapple},
    {"icon": iconUserProfile, "title": keyFreshApple},
    {"icon": iconUserProfile, "title": keyFreshApple},
    {"icon": iconUserProfile, "title": keyFreshApple},
  ];

  List addItems = [
    {"image": iconImage, "title": keyFreshPeaches, "subtitle": keyListQuantity},
    {"image": iconImage, "title": keyFreshPeaches, "subtitle": keyListQuantity},
    {"image": iconImage, "title": keyFreshPeaches, "subtitle": keyListQuantity}
  ];

  getCategoryListAPI() {
    categoryList.clear();
    repository.getCategoryApiCall().then((value) async {
      if (value != null) {
        categoryListResponse = value;
        categoryList.addAll(categoryListResponse!.list!);
        if (categoryList.isNotEmpty) {
          selectedCategoryId = categoryList.first.id;
          getCategoryDetailsAPI(id: selectedCategoryId, search: "");
        }
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }

  getCategoryDetailsAPI({int? id, String? search}) {
    categoryDetailsList.clear();
    repository.getCategoryDetailsApiCall(id, search).then((value) async {
      if (value != null) {
        categoryDetailsResponse = value;
        categoryDetailsList.clear();

        categoryDetailsList.addAll(categoryDetailsResponse!.list!);
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(
        error.toString(),
      );
    });
  }

  getShoppingListAPI() {
    productDetailsList.clear();
    repository.getShoppingListApiCall().then((value) async {
      if (value != null) {
        shoppingListResponse = value;
        productDetailsList.addAll(shoppingListResponse!.list!);
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }

  addProductApi({quantity, productId}) async {
    // customLoader.show(Get.overlayContext);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var response = AuthRequestModel.addProductRecipesReq(
      quantity: quantity,
      productId: productId,
    );
    APIRepository().addProductApiCall(dataBody: response).then((value) async {
      customLoader.hide();
      ResponseModel responseModel = value;
      toast(responseModel.message);
      getCategoryDetailsAPI(id: selectedCategoryId, search: "");
      getShoppingListAPI();
      update();
      // callApi();
      // Get.back();
      // toast(value.message);
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  deleteProductAPI(id) {
    repository.deleteProductApiCall(id).then((value) async {
      if (value != null) {
        ResponseModel responseModel = value;
        toast(responseModel.message);
        // Get.back();
        getCategoryDetailsAPI(id: selectedCategoryId, search: "");
        getShoppingListAPI();
        // init();
      }
      update();
    }).onError((error, stackTrace) {
      debugPrint("error ::::::::: " + error.toString());
      debugPrint("stackTrace ::::::::: " + stackTrace.toString());
      toast(error.toString());
    });
  }
}
