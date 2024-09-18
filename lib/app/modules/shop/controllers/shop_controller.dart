import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../core/translations/local_keys.dart';
import '../../../data/remote_service/network/api_provider.dart';
import '../models/response_models/category_response.dart';
import '../models/response_models/shop_list_by_category_response.dart';

class ShopController extends GetxController {
  List categoryList = [
    "Equipment",
    "Gift Packages",
    "Health Products",
    "Workshop",
    "Medical"
  ];
  RxInt selectedIndex = 0.obs;
  RxString selectedId= "".obs;


  RxInt foodSelectedIndex = 0.obs;
  bool foodTypeVisible = false;

  List foodType = [
    {"name": keyAll.tr},
    {"name": keyLowToHigh.tr},
    {"name": keyHighToLow.tr},
  ];

  int scheduledTime = 2;
  int type = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    getCategoryList();
    super.onInit();
  }

  int page = 0;
  ShopCategoryListResponseModel categoryListResponseModel =
      ShopCategoryListResponseModel();
  ShopListByCategoryResponseModel shopListByCategoryResponseModel =
      ShopListByCategoryResponseModel();
  RxList<CategoryList> categoryLists = <CategoryList>[].obs;
  RxList<WorkshopList> workshopList = <WorkshopList>[].obs;

  getCategoryList() {
    categoryLists.clear();
    APIRepository().shopCategoryListApiCall(page: page).then(
      (value) {
        if (value != null) {
          categoryListResponseModel = value;
          categoryLists.value.addAll(
            categoryListResponseModel.list ?? [],
          );
          if (categoryLists.value.isNotEmpty) {
            getShopListByCategory(categoryLists.value.first.id,5);
          }
          categoryLists.refresh();
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

  getShopListByCategory(categoryId,type) {
    workshopList.clear();
    APIRepository().shopListByCategoryListApiCall(categoryId: int.parse(categoryId.toString()),filter: type).then(
      (value) {
        if (value != null) {
          shopListByCategoryResponseModel = value;
          workshopList.clear();
          workshopList.value.addAll(
            shopListByCategoryResponseModel.list ?? [],
          );
          workshopList.refresh();
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

  List<ProductModel> productList = [
    ProductModel(
        title: "Ice Dipping Workshop",
        description:
            "About the workshop: Exposure to extreme temperatures is known to be a major stressor.",
        price: "350",
        isLocked: false),
    ProductModel(
        title: "Ice Dipping Tab",
        description:
            "To purchase a pass, you must take an ice dipping workshop",
        price: "350",
        isLocked: true),
  ];
}

class ProductModel {
  String? title;
  String? description;
  String? price;
  bool? isLocked;
  ProductModel({this.title, this.description, this.price, this.isLocked});
}
