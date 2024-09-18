/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

/*========================Email Validator==============================================*/

import 'package:get/get.dart';

import '../translations/local_keys.dart';

class Validator {
  static String? ValidateFields(String value, {message}) {
    if (value.startsWith(" ")) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    }
    if (value.isEmpty) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    } else if (value == null) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    }
    return null;
  }

  static String? validateOvulationDayFields(String value, {message}) {
    if (value.startsWith(" ")) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    }
    if (value.isEmpty) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    } else if (value == null) {
      return message.toString() + " ${keyFieldIsNotEmpty.tr}";
    }
    if (value.isNotEmpty && int.tryParse(value.toString())! > 31) {
      return "Day should be lesser than 31";
    }
    return null;
  }

  static String? ValidateName(String value) {
    if (value.toString().isEmpty) {
      return keyNameIsNotEmpty.tr;
    } else if (value == null) {
      return keyNameIsNotEmpty.tr;
    }
    return null;
  }

  /*static String? ValidateLastName(String value) {
    if (value.isEmpty) {
      return keyLastNameIsNotEmpty.tr;
    } else if (value == null) {
      return keyLastNameIsNotEmpty.tr;
    }
    return null;
  }*/

  /* static String? ValidateSurname(String value) {
    if (value.isEmpty) {
      return keySurnameIsNotEmpty.tr;
    } else if (value == null) {
      return keySurnameIsNotEmpty.tr;
    }
    return null;
  }*/

  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return keyPhoneCannotEmpty.tr;
    } else if (value.length < 8 || value.length > 15) {
      return keyPhoneNumberInvalid.tr;
    } else if (!validateNumber(value)) {
      return keySpecialCharacter.tr;
    }
    return null;
  }

  static bool validateNumber(String value) {
    var pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  /* static String? ValidateAddress(String value) {
    if (value.isEmpty) {
      return keyAddressIsNotEmpty.tr;
    } else if (value == null) {
      return keyAddressIsNotEmpty.tr;
    }
    return null;
  }*/

  static String? validateEmail(String value) {
    if (value.toString().trim().isEmpty) {
      return keyEmailIsNotEmpty.tr;
    } else if (value.isEmpty) {
      return keyEmailIsNotEmpty.tr;
    } else if (!GetUtils.isEmail(value.trim())) {
      return keyInvalidEmail.tr;
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return keyPasswordCantEmpty.tr;
    } else if (validateStrongPassword(value)) {
      return keyStrongPassword.tr;
    }
    return null;
  }

  static String? validateConfirmPasswordMatch(
      {String? value, String? password}) {
    if (value!.isEmpty) {
      return keyConfPasswordCantEmpty.tr;
    } else if (value != password) {
      return keyConfPasswordCantMatch.tr;
    } else if (validateStrongPassword(value)) {
      return keyInvalidPassword;
    }
    return null;
  }

  static bool validateStrongPassword(value) {
    var pattern =
        "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$";
    RegExp regex = RegExp(pattern);
    return (regex.hasMatch(value)) ? false : true;
  }
}

bool validateNumber(String value) {
  var pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

class PhoneNumberValidate {
  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return keyPhoneCannotEmpty.tr;
    } else if (value.length < 8 || value.length > 15) {
      return keyPhoneNumberInvalid.tr;
    } else if (!validateNumber(value)) {
      return keySpecialCharacter.tr;
    }
    return null;
  }

  /*static String? validatePhoneNumber(String value, Country? selectedCountry) {
    if (value == '') {
      return keyPhoneNumber.tr;
    } else if (selectedCountry != null) {
      if (value.length < selectedCountry.minLength) {
        return keyPhoneNumberInvalid.tr;
      }
    } else if (!GetUtils.isPhoneNumber(value.trim())) {
      return keyPhoneNumberInvalid.tr;
    }
    return null;
  }*/
}
