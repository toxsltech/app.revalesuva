/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';
import '../../language/views/select_language_screen.dart';
import '../entity/pageview_model.dart';
import '../widget/on_boarding_widget.dart';

class OnboardingController extends GetxController {
  var introKey = GlobalKey<IntroductionScreenState>();

  var page = pages;
  int currentIndex = 0;

  onSkip() {
    storage.write(LOCALKEY_onboarding, true);
    Get.offAllNamed(AppRoutes.logIn);
  }

  onSlide(index) {
    currentIndex = index;
    // update();
  }

  RxInt selectedPageIndex = 0.obs;

  List<OnBoardingWidget> listOfScreens = [];
  PageController controller = PageController();

  @override
  void onInit() {
    addData();
    super.onInit();
  }

  addData() {
    listOfScreens.clear();
    listOfScreens.add(OnBoardingWidget(
      imageUrl: iconImg1,
      headingText: 'strOnboardingHeading',
      bodyText: 'strOnboardingBodyText',
    ));
    listOfScreens.add(OnBoardingWidget(
      imageUrl: iconImg2,
      headingText: 'strOnboardingHeading1',
      bodyText: 'strOnboardingBodyText',
    ));
    listOfScreens.add(OnBoardingWidget(
      imageUrl: iconImg3,
      headingText: 'strOnboardingHeading2',
      bodyText: 'strOnboardingBodyText',
    ));
  }

  movePageAction() {
    if (selectedPageIndex.value < listOfScreens.length - 1) {
      selectedPageIndex.value++;
      controller.animateToPage(
        selectedPageIndex.value,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 10),
      );
    } else {
      moveToLoginRoute();
    }
  }

  moveToLoginRoute() {
    preferenceManger.firstLaunch(true);
    Get.offAll(() => SelectLanguageScreen());
    // Get.offAllNamed(AppRoutes.logIn, arguments: {"fromSplash": false});
    update();
  }

  onSwipePage(index) {
    selectedPageIndex.value = index;
    //update();
  }

  @override
  void refresh() {
    addData();
    super.refresh();
  }
}
