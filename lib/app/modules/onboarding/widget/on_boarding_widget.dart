import '../../../../../export.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingWidget extends GetView<OnboardingController> {
  final String? imageUrl;
  final String? headingText;
  final String? bodyText;
  final String? topImage;

  OnBoardingWidget({
    Key? key,
    required this.imageUrl,
    this.headingText,
    this.bodyText,
    this.topImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyWidget(),
    );
  }

  _bodyWidget() => Column(
    children: [_imageWidget(), _heading(), _title(), _indicatorWidget(), _nextMoveButton()],
  );

  Widget _imageWidget() => AssetImageWidget(
    imageUrl: imageUrl!,
    imageHeight: Get.height * 0.62,
    imageWidth: Get.width,
    imageFitType: BoxFit.fitWidth,
    radiusBottomLeft: radius_25,
    radiusBottomRight: radius_25,
  );

  Widget _heading() => TextView(
    text: headingText ?? 'Sell Gold & Sliver !!',
    textStyle: textStyleTitleLarge().copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 1.5,
    ),
  ).paddingSymmetric(
    vertical: margin_10,
  );

  Widget _title() => TextView(
    text: bodyText ?? "",
    textStyle: textStyleBodyMedium().copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade500,
      // fontSize: font_13,
    ),
    maxLine: 4,
  );

  _indicatorWidget() => SizedBox(
      height: height_12,
      child: ListView.builder(
        itemCount: controller.listOfScreens.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Obx(
              () => InkWell(
            onTap: () {
              controller.selectedPageIndex.value = index;
              controller.controller.animateToPage(
                controller.selectedPageIndex.value,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 10),
              );
            },
            child: Container(
              height: height_12,
              width: width_12,
              decoration: BoxDecoration(border: Border.all(color: index == controller.selectedPageIndex.value ? colorAppColor : Colors.transparent), borderRadius: BorderRadius.circular(radius_50)),
              child: Center(
                child: Container(
                  height: height_10,
                  width: width_10,
                  decoration: BoxDecoration(color: index == controller.selectedPageIndex.value ? colorAppColor : Colors.grey, borderRadius: BorderRadius.circular(radius_30)),
                ).marginAll(margin_1),
              ),
            ),
          ),
        ),
      )).marginOnly(top: margin_20);

  _nextMoveButton() => Obx(
        () => MaterialButtonWidget(
      elevation: 0.0,
      // width: width_100,
      onPressed: () {
        if (controller.selectedPageIndex < 2) {
          controller.controller.nextPage(duration: const Duration(milliseconds: 10), curve: Curves.ease);
          controller.selectedPageIndex.value++;
        } else {
          controller.moveToLoginRoute();
          // Get.toNamed(AppRoutes.signUp);
        }
      },
      buttonRadius: radius_30,
      // buttonColor: Colors.deepOrangeAccent,
      textColor: Colors.white, buttonColor: colorAppColor,
      buttonText: controller.selectedPageIndex < 2 ? 'Next' : "Start",
    ).marginSymmetric(horizontal: margin_20, vertical: margin_15),
  );
}
