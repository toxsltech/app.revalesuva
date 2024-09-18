/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:

import 'package:health_fitness/model/error_response_model.dart';

import '../../../../export.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    reportCrash(error.toString());
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return messageData = stringRequestCancelled;
            case DioExceptionType.connectionTimeout:
              return messageData = stringConnectionTimeout;
            case DioExceptionType.unknown:
              List<String> dateParts = error.message!.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == stringConnectionRefused) {
                return messageData = stringServerMaintenance;
              } else if (message[0].trim() == stringNetworkUnreachable) {
                return messageData = stringNetworkUnreachable;
              } else if (dateParts[1].trim() == stringFailedToConnect) {
                return messageData = stringInternetConnection;
              } else {
                return messageData = dateParts[1];
              }
            case DioExceptionType.receiveTimeout:
              return messageData = stringTimeOut;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response?.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response?.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = stringUnAuthRequest;
                      } else {
                        return messageData = dataValue;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                case 401:
                  PreferenceManger().clearLoginData();
                  Get.offAllNamed(AppRoutes.logIn);
                  // TODO: remove LocalKey_token
                  storage.remove(LOCALKEY_token);
                  return messageData = "Session expired";
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 403:
                  PreferenceManger().clearLoginData();
                  Get.offAllNamed(AppRoutes.logIn);
                  // TODO: remove LocalKey_token
                  storage.remove(LOCALKEY_token);
                  return messageData = "Session expired";
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 404:
                  return messageData = stringNotFound;
                case 408:
                  return messageData = stringRequestTimeOut;
                case 500:
                  return messageData = stringInternalServerError;
                case 503:
                  return messageData = stringInternetServiceUnavailable;
                default:
                  return messageData = stringSomethingsIsWrong;
              }
            case DioExceptionType.sendTimeout:
              return messageData = stringTimeOut;
            case DioExceptionType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioExceptionType.badResponse:
              // TODO: Handle this case.
              break;
            case DioExceptionType.connectionError:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          return messageData = socketExceptions;
        } else {
          return messageData = stringUnexpectedException;
        }
      } on FormatException catch (_) {
        return messageData = stringFormatException;
      } catch (_) {
        return messageData = stringUnexpectedException;
      }
    } else {
      if (error.toString().contains(stringNotSubType)) {
        return messageData = stringUnableToProcessData;
      } else {
        return messageData = stringUnexpectedException;
      }
    }
  }
}
