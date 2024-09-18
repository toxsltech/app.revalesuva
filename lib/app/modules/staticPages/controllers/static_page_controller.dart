/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';
import '../models/static_page_response_model.dart';

class StaticPageController extends GetxController {
  List? faqList = [];
  RxBool isLoading = false.obs;
  String? title;
  var pageType;

  @override
  void onInit() {
    getArgs();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getArgs() async {
    if (Get.arguments != null) {
      title = Get.arguments["title"];
      pageType = Get.arguments["pageType"];
      print("Pagetype : $pageType");
      hitGetPagesApiCall(pageType: pageType);
    }
  }

  hitFaqAPI() {
    isLoading.value = true;
    APIRepository.faqApiCall().then((value) {
      faqList = value;
      isLoading.value = false;
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      toast(error);
    });
  }

  APIRepository apiRepository = APIRepository();

  bool isLoadingPage = false;

  StaticPageResponseModel staticPageResponseModel = StaticPageResponseModel();
  hitGetPagesApiCall({pageType}) async {
    isLoadingPage = true;
    // update();
    APIRepository().getPagesApiCall(type: pageType).then((value) async {
      if (value != null) {
        staticPageResponseModel = value;
        print("here");
        // print(staticPageResponseModel.detail!);
        isLoadingPage = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoadingPage = false;
      update();
      // toast(error.toString());
      print(stackTrace);
    });
  }
}
