/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/app/modules/splash/controllers/splash_controller.dart';

import '../../../../../export.dart';
import '../../../core/widgets/annotated_region_widget.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: greenColor,
    // ));
    return AnnotatedRegionWidget(
      statusBarColor: greenColor,
      statusBarBrightness: Brightness.light,
      child: Scaffold(
        backgroundColor: greenColor,
        body: Center(
          child: AssetImageWidget(
            imageUrl: iconLogo,
            imageHeight: 100,
          ),
        ),
      ),
    );
  }
}
