/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:device_info_plus/device_info_plus.dart';
import 'package:health_fitness/app/data/remote_service/network/network_exceptions.dart';
import 'package:health_fitness/app/modules/authentication/model/login_response_model.dart';
import 'package:health_fitness/app/modules/authentication/model/question_list_Response.dart';
import 'package:health_fitness/app/modules/contact/models/dropdown_response.dart';
import 'package:health_fitness/app/modules/drawer/models/category_api_response_model.dart';
import 'package:health_fitness/app/modules/drawer/models/my_successive_list_response_model.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/all_details_response.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/intuitive_writing_list_api_response_model.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/video_list_response.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/weight_details_response.dart';
import 'package:health_fitness/app/modules/drawer/models/sub_category_api_response_model.dart';
import 'package:health_fitness/app/modules/healthConsumerism/models/response_model/category_details_response.dart';
import 'package:health_fitness/app/modules/healthConsumerism/models/response_model/category_list_response.dart';
import 'package:health_fitness/app/modules/healthConsumerism/models/response_model/recipe_list_response.dart';
import 'package:health_fitness/app/modules/start/model/star_response.dart';
import 'package:health_fitness/model/error_response_model.dart';
import 'package:health_fitness/model/responseModal/home_model.dart';

import '../../../../export.dart';
import '../../../modules/articles/models/response_model/article_detail_response.dart';
import '../../../modules/articles/models/response_model/articles_response.dart';
import '../../../modules/contact/models/chat_response.dart';
import '../../../modules/contact/models/send_message_response.dart';
import '../../../modules/drawer/models/response_model/data_entry_response.dart';
import '../../../modules/drawer/models/response_model/get_track_time.dart';
import '../../../modules/drawer/models/response_model/measurement_model.dart';
import '../../../modules/drawer/models/response_model/my_plan_api_response_model.dart';
import '../../../modules/drawer/models/response_model/ovulation_cycle_response_model.dart';
import '../../../modules/drawer/models/response_model/shopping_list_response.dart';
import '../../../modules/fastingHistory/models/fasting_history_response_model.dart';
import '../../../modules/gallery/models/gallery_list_response.dart';
import '../../../modules/hadas_reinforcement/model/response_model/strength_meditation_model.dart';
import '../../../modules/healthConsumerism/models/response_model/recipe_details_response.dart';
import '../../../modules/my_orders/models/order_item_details_model.dart';
import '../../../modules/my_orders/models/order_item_list_model.dart';
import '../../../modules/my_orders/models/order_list_response.dart';
import '../../../modules/notification/models/notification_response_model.dart';
import '../../../modules/podcast/models/response_models/podcast_details_response.dart';
import '../../../modules/podcast/models/response_models/podcast_response.dart';
import '../../../modules/shop/models/response_models/category_response.dart';
import '../../../modules/shop/models/response_models/item_cart_response.dart';
import '../../../modules/shop/models/response_models/shop_details_response.dart';
import '../../../modules/shop/models/response_models/shop_list_by_category_response.dart';
import '../../../modules/staticPages/models/static_page_response_model.dart';
import '../../../modules/torah_portion/model/torah_book_model.dart';
import 'dio_client.dart';

class APIRepository {
  static late DioClient? dioClient;
  static var deviceName, deviceType, deviceID, deviceVersion;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(login, data: FormData.fromMap(dataBody!));
      debugPrint("Response loginApiCall:::::: $response");
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future forgetApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(forget, data: FormData.fromMap(dataBody!));
      return ResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future imageUploadApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(imageUpload, data: FormData.fromMap(dataBody!), skipAuth: false, isLoading: false);
      return ResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  Future logoutApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(logout, skipAuth: false);
      print("Response logoutApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  /*====================================================================== check user api ============================================*/

  Future checkApiCall() async {
    try {
      final response = await dioClient!.get(checkEndPoint, skipAuth: false);
      debugPrint(checkEndPoint);
      debugPrint("checkApiCall:::::::$response");
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future profileApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(profileSetup, data: FormData.fromMap(dataBody!), skipAuth: false, isLoading: false);
      print("Response profileApiCall:::::: $response");
      return LoginResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future addAnswerApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(addUpdateAnswer, data: FormData.fromMap(dataBody!), skipAuth: false, isLoading: false);
      print("Response addAnswerApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future updateAnswerApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(editAnswer, data: FormData.fromMap(dataBody!), skipAuth: false, isLoading: false);
      print("Response updateAnswerApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future getQuestionApiCall() async {
    try {
      final response = await dioClient!.get(getQuestionList, skipAuth: false);
      debugPrint("getQuestionApiCall::::::: $response");
      return QuestionListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  /* =========================== Weight and Perimeters ================================*/

  Future addDataEntryApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        addDataEntry,
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );
      print("Response addDataEntryApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future getMeasurementApiCall() async {
    try {
      final response = await dioClient!.get(weightMeasurement, skipAuth: false);
      debugPrint("getMeasurementApiCall::::::: $response");
      return MeasurementResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future getEntryDetailsApiCall() async {
    try {
      final response = await dioClient!.get(dataEntryDetails, skipAuth: false);
      debugPrint("getEntryDetailsApiCall::::::: $response");
      return DataEntryDetailsResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future addWeightApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        addWeight,
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );
      print("Response addWeightApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future getAllDetailsApiCall(typeId) async {
    try {
      final response = await dioClient!.get(weighingDetails, queryParameters: {"type_id": typeId}, skipAuth: false);
      debugPrint("getAllDetailsApiCall::::::: $response");
      return typeId == "1" ? WeightDetailsResponse.fromJson(response) : AllDetailsResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  /*===================================================================== Intuitive Writing Api Call  ==========================================================*/

  Future addIntuitiveWriting({data}) async {
    try {
      final response = await dioClient!.post(addIntuitiveWritingEndPoint, data: FormData.fromMap(data), skipAuth: false);
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future updateIntuitiveWriting({data, id}) async {
    try {
      final response = await dioClient!.post(updateIntuitiveWritingEndPoint, queryParameters: {'id': id}, data: FormData.fromMap(data), skipAuth: false);
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future deleteIntuitiveWriting({id}) async {
    try {
      final response = await dioClient!.get(deleteIntuitiveWritingEndPoint, queryParameters: {'id': id}, skipAuth: false);
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future getIntuitiveWritingList() async {
    try {
      final response = await dioClient!.get(
        getIntuitiveWritingListEndPoint,
        skipAuth: false,
      );
      return IntuitiveWritingListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Daily Nutrition Planning Api Call  ==========================================================*/

  Future getNutritionCategoryList(typeId) async {
    try {
      final response = await dioClient!.get(
        getNutritionCategoryListEndPoint,
        queryParameters: {
          "type_id": typeId,
        },
        skipAuth: false,
      );
      return DailyNutritionCategoryResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getNutritionSubCategoryList({typeId, id}) async {
    try {
      final response = await dioClient!.get(
        getNutritionSubCategoryListEndPoint,
        queryParameters: {
          'type_id': typeId,
          'category_id': id,
        },
        skipAuth: false,
      );
      return DailyNutritionSubCategoryResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addDailyNutritionApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addDailyNutritionEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future mySuccessiveListApiCall() async {
    try {
      final response = await dioClient!.get(
        mySuccessiveListEndPoint,
        skipAuth: false,
      );
      return MySuccessiveListApiResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future myPlanEventDetailApiCall({date, planId}) async {
    try {
      final response = await dioClient!.get(
        myPlanEventListEndPoint,
        queryParameters: {/*'plan_id': planId,*/ 'date': date},
        skipAuth: false,
      );
      return PlanListApiResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future startFastApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addFastDetailsEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future endFastApiCall({dataBody, typeId}) async {
    try {
      final response = await dioClient!.post(
        endFastEndPoint,
        queryParameters: {
          "type_id": typeId,
        },
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getFastingHistoryList({lang}) async {
    try {
      final response = await dioClient!.get(
        fastHistoryEndPoint,
        queryParameters: {},
        skipAuth: false,
      );
      return FastingHistoryListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getFastingTrackList({lang}) async {
    try {
      final response = await dioClient!.get(
        getTrackTimeEndPoint,
        queryParameters: {
          "fast_id": 0,
          "page": 0,
        },
        skipAuth: false,
      );
      return GetTrackTimeResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addOvulationApiCall({dataBody, typeId}) async {
    try {
      final response = await dioClient!.post(
        addOvulationEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addFastingTrackApiCall() async {
    try {
      final response = await dioClient!.post(
        addTrackEndPoint,
        // data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getOvulationCycleList({lang}) async {
    try {
      final response = await dioClient!.get(
        ovulationDetailsEndPoint,
        queryParameters: {},
        skipAuth: false,
      );
      return OvulationCycleListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future applyEventApiCall({planId, eventId}) async {
    try {
      final response = await dioClient!.get(
        applyEventEndPoint,
        queryParameters: {'plan_id': planId, "event_id": eventId},
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getVideoListApiCall({page, search}) async {
    try {
      final response = await dioClient!.get(
        videoListEndPoint,
        queryParameters: {
          'page': page,
          'search': search.toString(),
        },
        skipAuth: false,
      );
      return VideoListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("Error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addReviewApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addReviewEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Podcasts Api Call  ==========================================================*/

  Future podcastListApiCall({required int page, String? lang}) async {
    try {
      final response = await dioClient!.get(
        podCastListEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return PodcastListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future podcastDetailsListApiCall({
    required int page,
    required int productId,
    String? lang,
  }) async {
    try {
      final response = await dioClient!.get(
        podCastDetailsListEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
          'product_id': productId,
        },
        skipAuth: false,
      );
      return PodcastListDetailsResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Notification Api Call  ==========================================================*/

  Future getNotificationList({page}) async {
    try {
      final response = await dioClient!.get(
        notificationListEndPoint,
        skipAuth: false,
      );
      return NotificationListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future clearNotificationList() async {
    try {
      final response = await dioClient!.get(
        clearNotificationEndPoint,
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Contact Api Call  ==========================================================*/

  Future dropdownListApiCall({
    required int page,
    String? lang,
  }) async {
    try {
      final response = await dioClient!.get(
        dropdownListEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return DropdownListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addHelpApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addHelpSupportEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Shop/Events Api Call  ==========================================================*/

  Future shopCategoryListApiCall({required int page, String? lang}) async {
    try {
      final response = await dioClient!.get(
        shopCategoryListEndPoint,
        queryParameters: {
          'lang': '',
        },
        skipAuth: false,
      );
      return ShopCategoryListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future shopListByCategoryListApiCall({required int categoryId, String? lang, int? filter}) async {
    try {
      final response = await dioClient!.get(
        productListByCategoryEndPoint,
        queryParameters: {
          'lang': '',
          'category_id': categoryId,
          'filter_price': filter == 5 ? "" : filter,
        },
        skipAuth: false,
      );
      return ShopListByCategoryResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future shopDetailsApiCall({required int productId, String? lang}) async {
    try {
      final response = await dioClient!.get(
        shopProductDetailsEndPoint,
        queryParameters: {
          'lang': '',
          'id': productId,
        },
        skipAuth: false,
      );
      return ShopLDetailsResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addToCartShopProdApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addToCartShopProductEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future cartItemListApiCall() async {
    try {
      final response = await dioClient!.get(
        cartItemListEndPoint,
        skipAuth: false,
      );
      return ItemCartListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future deleteCartItemApiCall({required int productId, String? lang}) async {
    try {
      final response = await dioClient!.get(
        deleteCartItemEndPoint,
        queryParameters: {
          'lang': '',
          'id': productId,
        },
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future addBillingDetailsApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        addCustomerAddressEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future updateBillingDetailsApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        updateCustomerAddressEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future placeOrderApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        placeOrderEndPoint,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future myShoppingPlaceOrderApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        myShoppingPlaceOrder,
        data: FormData.fromMap(dataBody),
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future orderListApiCall() async {
    try {
      final response = await dioClient!.get(
        orderListEndPoint,
        skipAuth: false,
      );
      return OrderListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future orderItemListApiCall(orderId) async {
    try {
      final response = await dioClient!.get(
        orderItemListEndPoint,
        queryParameters: {
          "order_id": orderId,
        },
        skipAuth: false,
      );
      return OrderItemListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future orderItemDetailsApiCall(
    orderId,
    page,
  ) async {
    try {
      final response = await dioClient!.get(
        orderItemDetailsEndPoint,
        queryParameters: {"order_id": orderId, "page": page},
        skipAuth: false,
      );
      return OrderItemDetailsResponse.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  Future cancelOrderItemApiCall({var orderId, String? lang}) async {
    try {
      final response = await dioClient!.get(
        cancelOrderEndPoint,
        queryParameters: {
          'order_id': orderId,
        },
        skipAuth: false,
      );
      return MessageResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(
        NetworkExceptions.getDioException(e),
      );
    }
  }

  /*===================================================================== Chat Api Call  ==========================================================*/

  Future sendMessageApiCall({dataBody}) async {
    try {
      final response = await dioClient!.post(
        sendMessageEndPoint,
        data: FormData.fromMap(dataBody),
        isLoading: false,
        skipAuth: false,
      );
      return SendMessageResponse.fromJson(response);
    } catch (e, str) {
      debugPrint(
        "Error : " + e.toString(),
      );
      debugPrint(
        str.toString(),
      );
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future loadChatApiCall() async {
    try {
      final response = await dioClient!.get(
        loadChatEndPoint,
        skipAuth: false,
      );
      return ChatMessageResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future newMessageApiCall() async {
    try {
      final response = await dioClient!.get(
        newMessageEndPoint,
        skipAuth: false,
      );
      return ChatMessageResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Health Consumerism Api Call  ==========================================================*/

  Future getCategoryApiCall() async {
    try {
      final response = await dioClient!.get(categoryList, skipAuth: false);
      debugPrint("getCategoryApiCall::::::: $response");
      return CategoryListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getCategoryDetailsApiCall(id, search) async {
    try {
      final response = await dioClient!.get(categoryDetailsList, queryParameters: {"category_id": id, "search": search}, skipAuth: false);
      debugPrint("getCategoryDetailsApiCall::::::: $response");
      return CategoryDetailsResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getShoppingListApiCall() async {
    try {
      final response = await dioClient!.get(myShoppingList, skipAuth: false);
      debugPrint("getShoppingListApiCall::::::: $response");
      return ShoppingListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future deleteProductApiCall(id) async {
    try {
      final response = await dioClient!.get(deleteProduct, queryParameters: {"id": id}, skipAuth: false);
      debugPrint("deleteProductApiCall::::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addProductApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        addProduct,
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );
      print("Response addProductApiCall:::::: $response");
      return ResponseModel.fromJson(response);
    } catch (e, str) {
      print(str);
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getRecipeListApiCall(schedule, type, search) async {
    try {
      final response = await dioClient!.get(getRecipesByTime, queryParameters: {"schedule": schedule, /*if (type != 4) */ "type": type, "search": search}, skipAuth: false);
      debugPrint("getRecipeListApiCall::::::: $response");
      return RecipeListResponse.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getRecipeDetailsApiCall(id) async {
    try {
      final response = await dioClient!.get(getRecipesDetails,
          queryParameters: {
            "id": id,
          },
          skipAuth: false);
      debugPrint("getRecipeDetailsApiCall::::::: $response");
      return RecipeListDetails.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== article API Call  ==========================================================*/

  Future getArticlesListApiCall(page) async {
    try {
      final response = await dioClient!.get(articlesListEndPoint,
          queryParameters: {
            "page": page,
          },
          skipAuth: false);
      debugPrint("ArticlesListResponseModel::::::: $response");
      return ArticlesListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getArticlesDetailsApiCall(id) async {
    try {
      final response = await dioClient!.get(articlesDetailsEndPoint,
          queryParameters: {
            "id": id,
          },
          skipAuth: false);
      debugPrint("ArticlesDetailsResponseModel::::::: $response");
      return ArticlesDetailsResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== gallery API Call  ==========================================================*/

  Future getGalleryListApiCall(page) async {
    try {
      final response = await dioClient!.get(galleryListEndPoint,
          queryParameters: {
            "page": page,
          },
          skipAuth: false);
      debugPrint("GalleryListResponseModel::::::: $response");
      return GalleryListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Torah Book Api Call  ==========================================================*/

  Future getTorahBookListApiCall({required int page, String? lang}) async {
    try {
      var token = await storage.read(LOCALKEY_token);
      if (token == null) {
        return;
      }
      final response = await dioClient!.get(
        bookTorahPortionEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return TorahListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getStarListApiCall({required int page, String? lang}) async {
    try {
      final response = await dioClient!.get(
        starListEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return StarListResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getStrengthListApiCall({required int page, String? lang}) async {
    try {
      final response = await dioClient!.get(
        strengthVideoEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return StrengthMeditationResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getMeditationListApiCall({required int page, String? lang}) async {
    try {
      final response = await dioClient!.get(
        meditationVideoEndPoint,
        queryParameters: {
          'lang': '',
          'page': page,
        },
        skipAuth: false,
      );
      return StrengthMeditationResponseModel.fromJson(response);
    } catch (e, str) {
      debugPrint("error : " + e.toString());
      debugPrint(str.toString());
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future socialLoginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(socialLogin, data: dataBody);
      return LoginModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future myAccountApiCall() async {
    try {
      final response = await dioClient!.post(myAccount);
      return MyAccountModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future faqApiCall() async {
    try {
      final response = await dioClient!.post(myAccount);
      return MyAccountModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  static Future homeListApiCall() async {
    try {
      final response = await dioClient!.post(myBook);
      return (response as List).map((p) => HomeModel.fromJson(p)).toList();
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Subscription Plans list API Call  ==========================================================*/
  static Future subscriptionPlansListApiCall() async {
    try {
      final response = await dioClient!.get(
        plansListEndPt,
        skipAuth: false,
      );
      return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Buy Subscription API Call  ==========================================================*/
  static Future buySubscriptionPlanApiCall(id) async {
    try {
      final response = await dioClient!.get(buySubscriptionEndPt, skipAuth: false, queryParameters: {'id': id});
      return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== staticPages api call ============================================*/

  Future getPagesApiCall({type}) async {
    try {
      final response = await dioClient!.get(getPagesEndPoint, queryParameters: {"type": type}, skipAuth: false);
      print("getPagesApiCall........" + response.toString());
      return StaticPageResponseModel.fromJson(response);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  //*===================================================================== Report Any crashes or errors to logger API Call  ==========================================================*
  static Future<ErrorMessageResponseModel?> reportCrashLogApiCall({data}) async {
    try {
      final res = await Dio().post(crashBaseUrl + logCrashesExceptionsEndPoint, data: FormData.fromMap(data));
      var response = res.data;
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}

reportCrash(stackTrace) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  CustomLoader customLoader = CustomLoader();
  var req = AuthRequestModel.logCrashErrorReq(error: packageInfo.packageName, packageVersion: version, phoneModel: APIRepository.deviceName, ip: APIRepository.deviceVersion, stackTrace: stackTrace);
  debugPrint('Log req: $req', wrapWidth: 1000);
  await APIRepository.reportCrashLogApiCall(data: req).then((value) async {
    customLoader.hide();
    if (value != null) {}
  }).onError((error, stackTrace) {
    customLoader.hide();
    initApp();
    toast(error.toString());
  });
}
