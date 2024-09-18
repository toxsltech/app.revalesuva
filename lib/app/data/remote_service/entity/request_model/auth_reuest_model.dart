/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';

class AuthRequestModel {
  static loginReq(
      {String? email, String? password, deviceToken, deviceType, deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginForm[username]'] = email;
    data['LoginForm[password]'] = password;
    data['LoginForm[device_token]'] = APIRepository.deviceID ?? "";
    data['LoginForm[device_type]'] = APIRepository.deviceType ?? 1;
    data['LoginForm[device_name]'] = /*APIRepository.deviceName ??*/ "Android";
    return data;
  }

  static addIntuitiveWriting({
    String? title,
    String? description,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IntuitiveWriting[title]'] = title;
    data['IntuitiveWriting[description]'] = description;
    return data;
  }

  static addFastTimings({
    String? startTime,
    String? totalTime,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fasting[start_time]'] = startTime;
    data['Fasting[total_time]'] = totalTime;
    return data;
  }

  static endFastTimings({
    String? endTime,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fasting[end_time]'] = endTime;
    debugPrint(data.toString());
    return data;
  }

  static addOvulationTimings({
    String? ovulationCycleDate,
    String? ovulationAvgCycleDay,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OvalutionCycle[date]'] = ovulationCycleDate;
    data['OvalutionCycle[avg_cycle]'] = ovulationAvgCycleDay;
    debugPrint(data.toString());
    return data;
  }

  static addReviewReq({
    String? videoId,
    String? stateId,
    String? startTime,
    String? endTime,
    String? remainingTime,
    String? totalTime,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VideoReview[video_id]'] = videoId;
    data['VideoReview[state_id]'] = stateId;
    data['VideoReview[start_time]'] = startTime;
    data['VideoReview[end_time]'] = endTime;
    data['VideoReview[remaining_time]'] = remainingTime;
    data['VideoReview[total_time]'] = totalTime;
    return data;
  }

  static addHelpSupport({
    int? optionId,
    int? typeId,
    String? message,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Support[option_id]'] = optionId;
    data['Support[type_id]'] = typeId;
    data['Support[message]'] = message;
    return data;
  }

  static addToCart({
    int? productId,
    int? quantity,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CartItem[product_id]'] = productId;
    data['CartItem[quantity]'] = quantity;
    return data;
  }

  // static sendMessage({
  //   String? message,
  //   MultipartFile? messageFile,
  //   int? type,
  // })

  static sendMessage({
    String? message,
    MultipartFile? messageFile,
    int? type,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Chat[message]'] = type == 0 ? message : messageFile;
    data['Chat[type_id]'] = type;
    debugPrint("Request Data : $data");
    return data;
  }

  static addDailyNutritionReq({
    var dailyNutrition,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserDailyNutrition[json_data]'] = jsonEncode(dailyNutrition);
    print(data.toString());
    return data;
  }

  static forgetReq({String? email}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[email]'] = email;
    return data;
  }

  static imageUploadReq({MultipartFile? image, int? type}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (type == 0) {
      data['User[profile_file]'] = image;
    } else if (type == 1) {
      data['File[front]'] = image;
    } else if (type == 2) {
      data['File[side]'] = image;
    } else if (type == 3) {
      data['File[back]'] = image;
    } else {
      data['File[blood_test]'] = image;
    }
    return data;
  }

  static billDetailsReq({
    var fullName,
    var email,
    var contactNumber,
    var zipCode,
    var address,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Billing[full_name]'] = fullName;
    data['Billing[email]'] = email;
    data['Billing[contact_no]'] = contactNumber;
    data['Billing[zip_code]'] = zipCode;
    data['Billing[address]'] = address;
    return data;
  }

  static placeOrderReq({
    var id,
    var totalPrice,
    var price,
    var typeId,
    var fullName,
    var email,
    var contactNumber,
    var zipCode,
    var address,
    // required List<dynamic> itemDetails,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['Order[billing_address_id]'] = id;
    data['Order[total_price]'] = totalPrice;
    data['Order[price]'] = price;
    /*data['Order[type_id]'] = typeId;*/
    // data['itemJson'] = itemDetails.toString();
    data['Billing[full_name]'] = fullName;
    data['Billing[email]'] = email;
    data['Billing[contact_no]'] = contactNumber;
    data['Billing[zip_code]'] = zipCode;
    data['Billing[address]'] = address;
    return data;
  }

  static socialLoginReq(
      {var userId,
      var email,
      var fullName,
      var username,
      var provider,
      var img_url,
      var deviceToken,
      var deviceType,
      var deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[userId]'] = userId;
    data['User[email]'] = email;
    data['User[full_name]'] = fullName;
    data['LoginForm[username]'] = username;
    data['LoginForm[provider]'] = provider;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    data['img_url'] = img_url;
    return data;
  }

  static profileSetUpReq({
    var fullName,
    var email,
    var countryCode,
    var contactNo,
    var gender,
    var address,
    var city,
    var apartmentNumber,
    var floor,
    var age,
    var weight,
    var height,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User[full_name]'] = fullName;
    data['User[email]'] = email;
    data['User[country_code]'] = countryCode;
    data['User[contact_no]'] = contactNo;
    data['User[gender]'] = gender;
    data['User[address]'] = address;
    data['User[floor]'] = floor;
    data['User[apartment_number]'] = apartmentNumber;
    data['User[city]'] = city;
    data['User[age]'] = age;
    data['User[weight]'] = weight;
    data['User[height]'] = height;
    return data;
  }

  static answerReq({
    String? quesId,
    int? typeId,
    String? answer,
    int? profileCompleted,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answer[question_id]'] = quesId;
    data['Answer[type_id]'] = typeId;
    data['Answer[title]'] = answer;
    data['User[profile_completed]'] = profileCompleted;
    return data;
  }

  static updateAnswerReq({
    String? jsonAnswer,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answer[json_data]'] = jsonAnswer;
    return data;
  }

  static addWeightReq({
    String? weight,
    String? date,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Weight[title]'] = weight;
    data['Weight[date]'] = date;
    return data;
  }

  static addDataEntryReq({
    int? measurementId,
    String? chest,
    String? hip,
    String? belly,
    String? date,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DataEntry[measurement_id]'] = measurementId;
    data['DataEntry[chestine]'] = chest;
    data['DataEntry[hipline]'] = hip;
    data['DataEntry[bellyline]'] = belly;
    data['DataEntry[date]'] = date;
    return data;
  }

  static addProductReq({
    int? quantity,
    int? productId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserProduct[quantity]'] = quantity;
    data['UserProduct[product_id]'] = productId;
    return data;
  }
  static addProductRecipesReq({
    int? quantity,
    int? productId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CartItem[product_id]'] = productId;
    data['CartItem[quantity]'] = quantity;
    return data;
  }
  static logCrashErrorReq({
    error,
    packageVersion,
    phoneModel,
    ip,
    stackTrace,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }

  static dailyNutritionReqModel({
    categoryId,
    typeId,
    // List<DailyNutritionSubCategoryDataModel>? subCategoryItemsId,
    subCategoryItemsId,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = categoryId;
    data['type_id'] = typeId;
    data['nutrition_id'] = subCategoryItemsId;
    return data;
  }
}
