/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:fluttertoast/fluttertoast.dart';

import '../../../export.dart';

// toast(message, {int seconds = 1}) => Get.snackbar(
//       snackPosition: SnackPosition.BOTTOM,
//       'Fitness Planner',
//       '$message',
//       borderRadius: 6.0,
//       animationDuration: Duration(milliseconds: seconds),
//       backgroundColor: appColor,
//       backgroundGradient: LinearGradient(colors: [
//         greenColor,
//         pinkColor,
//       ]),
//       margin: EdgeInsets.only(
//         bottom: margin_20,
//         left: margin_20,
//         right: margin_20,
//       ),
//       colorText: Colors.white,
//       // forwardAnimationCurve: Curves.elasticInOut,
//       // reverseAnimationCurve: Curves.easeOut,
//     );

toast(message, {int seconds = 1}) => Fluttertoast.showToast(
    msg: "$message",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Color(0xFF7CA983),
    textColor: Colors.white,
    fontSize: font_13);
