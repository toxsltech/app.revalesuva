/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/app/core/widgets/double_back_press.dart';
import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/data/under_dev.dart';
import 'package:health_fitness/app/modules/about/views/about_us_screen.dart';
import 'package:health_fitness/app/modules/hadas_reinforcement/views/hadas_reinforcement.dart';
import 'package:health_fitness/app/modules/healthConsumerism/view/health_consumerism_home.dart';
import 'package:health_fitness/app/modules/home/views/home_screen.dart';
import 'package:health_fitness/app/modules/torah_portion/views/torah_portion_screen.dart';

import '../../../../../export.dart';
import '../../drawer/views/my_plan/my_plan_screen.dart';

class MainScreen extends GetView<HomeController> {
  // final StaticPageController staticPageController =
  //     Get.put(StaticPageController());
  final LoginController loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();
  final MyAccountModel? myAccountModel = MyAccountModel();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: greenColor,
    ));
    return DoubleBack(
      child: SafeArea(
        child: GetBuilder<HomeController>(
          builder: (controllers) {
            return Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(100.0), // here the desired height
                child: CustomAppBar(
                  bgColor: greenColor,
                  // leadingIcon: getInkWell(
                  //     onTap: () {
                  //       scaffoldKey!.currentState!.openDrawer();
                  //     },
                  //     child: AssetImageWidget(
                  //       imageUrl: iconMenu,
                  //     ).paddingAll(height_10)),
                  leadingIcon: GestureDetector(
                    onTap: () {
                      scaffoldKey!.currentState!.openDrawer();
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                        5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(radius_5),
                        ),
                      ),
                      child: Icon(
                        Icons.menu,
                      ),
                    ),
                  ).paddingOnly(
                    top: margin_20,
                    left: margin_10,
                    right: margin_10,
                  ),
                  // appBarTitleText: "A quarter to\na quarter",
                  appBarTitleText: keyAppName.tr,
                  titleTextStyle: textStyleHeadlineMedium().copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: font_13,
                    color: Colors.white,
                  ),
                  actionWidget: [
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse('tel:+972544485905'));
                      },
                      child: Container(
                          height: height_35,
                          width: height_35,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: AssetImageWidget(
                            imageUrl: iconPhone2,
                            imageWidth: 40.0,
                            imageHeight: 40.0,
                          )).marginOnly(
                        left: margin_10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.toNamed(AppRoutes.chatCoach);
                      },
                      child: Container(
                          height: height_35,
                          width: height_35,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: AssetImageWidget(
                            imageUrl: iconMessage,
                            imageWidth: 40.0,
                            imageHeight: 40.0,
                          )).marginOnly(
                        left: margin_10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.contactDataScreen);
                      },
                      child: Container(
                        height: height_35,
                        width: height_35,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              radius_5,
                            ),
                          ),
                        ),
                        child: NetworkImageWidget(
                          imageurl: controller.profilePic,
                          imageWidth: 50,
                          imageHeight: 50,
                          radiusAll: radius_50,
                        ),
                      ).marginOnly(
                        left: margin_10,
                      ),
                    ),
                  ],
                ),
              ),
              drawer: customDrawer(),
              body: controller.bottomNavIndex == 0
                  ? HomeScreen()
                  : controller.bottomNavIndex == 1
                      ? TorahBookScreen()
                      : controller.bottomNavIndex == 2
                          ? MyPlanScreen()
                          : controller.bottomNavIndex == 3
                              ? HealthConsumerismHomePage()
                              : HadasScreen(),
              bottomNavigationBar: controller.currentViewType ==
                      ViewType.bottomNav
                  ? Container(
                      color: (controller.bottomNavIndex == 3)
                          ? appBackgroundColor
                          : Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            radius_30,
                          ),
                        ),
                        child: BottomNavigationBar(
                          elevation: 0,
                          onTap: (value) {
                            controller.updateBottomNavIndex(value);
                          },
                          backgroundColor: appGreenColor,
                          type: BottomNavigationBarType.fixed,
                          currentIndex: controller.bottomNavIndex,
                          selectedItemColor: Colors.black87,
                          unselectedItemColor: Colors.white,
                          items: [
                            BottomNavigationBarItem(
                              label: keyHome.tr,
                              icon: Icon(
                                Icons.home,
                              ),
                            ),
                            // BottomNavigationBarItem(
                            //     label: 'Profile', icon: Icon(Icons.person)),
                            BottomNavigationBarItem(
                              // label: "This week's\nTorah portion",
                              label: keyTorahBook.tr,
                              icon: Icon(Icons.note_alt_sharp),
                            ),
                            BottomNavigationBarItem(
                              label: keyMyPlan.tr,
                              icon: Icon(Icons.next_plan_outlined),
                            ),
                            // BottomNavigationBarItem(
                            //     label: 'Healthy consumerism',
                            //     icon: Icon(Icons.energy_savings_leaf_outlined)),
                            BottomNavigationBarItem(
                              label: keyShop.tr,
                              icon: Icon(Icons.store_mall_directory_outlined),
                            ),
                            BottomNavigationBarItem(
                              label: keyHadas.tr,
                              icon: Icon(Icons.insert_emoticon_sharp),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }

  customDrawer() => Drawer(
        child: ListView(
          children: [
            Container(
              height: height_150,
              color: greenColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AssetImageWidget(
                    imageUrl: iconLogo,
                    imageHeight: height_100,
                  ).marginOnly(right: margin_10, top: margin_10),
                ],
              ),
            ),
            listTile(
                icon: iconProfileFill,
                text: keyPersonalArea.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(AppRoutes.profile);
                  // Get.toNamed(AppRoutes.personalProfile);
                }),
            listTile(
                icon: iconWeightMachine,
                text: keyWeight.tr,
                dropdown: true,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(AppRoutes.weighingAndPerimeterScreen);
                }),
            listTile(
                icon: iconNutrition,
                text: keyNutritionPlan.tr,
                dropdown: true,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(AppRoutes.dailyNutritionScreen);
                }),
            listTile(
                icon: iconArticle,
                text: keyArticles.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.theArticleScreen,
                  );
                }),
            listTile(
                icon: iconPodcast,
                text: keyPodcasts.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.podcastScreen,
                  );
                }),
            listTile(
                icon: iconLogo,
                text: keyInformation.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.theGateRoute,
                  );
                }),
            listTile(
                icon: iconWorkShopFill,
                text: keyWorkshopEvents.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.shopScreen,
                  );
                }),
            listTile(
                icon: iconShop,
                text: keyShop.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.healthConsumerism,
                  );
                }),
            listTile(
                check: true,
                icon: Icons.notifications,
                text: keyNotification.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.notificationScreen,
                  );
                }),
            listTile(
                icon: iconTorah,
                text: keyTorahPortion.tr,
                onTap: () {
                  // loginController.hitMyAccountAPI();
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.torahBookScreen,
                  );
                }),
            /*listTile(
                icon: iconShop,
                text: keyShop.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  // Get.toNamed(AppRoutes.profile);
                }),*/
            listTile(
                icon: iconGallery,
                text: keyGallery.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  // Get.toNamed(AppRoutes.profile);
                  Get.toNamed(
                    AppRoutes.galleryScreen,
                  );
                }),
            listTile(
                icon: iconContact2,
                text: keyContact.tr,
                onTap: () {
                  scaffoldKey!.currentState!.openEndDrawer();
                  Get.toNamed(
                    AppRoutes.contactRoute,
                  );
                }),
            listTile(
                icon: iconRadioFill,
                text: keyRegulation.tr,
                color: greenColor,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.regulationScreen,
                  );
                }),
            listTile(
                icon: iconAbout,
                text: keyAboutUs.tr,
                color: greenColor,
                onTap: () {
                  Get.to(AboutUsScreen());
                }),
            listTile(
                icon: iconLogoutFill,
                text: keyLogOut.tr,
                onTap: () {
                  logoutDialog();
                }),
          ],
        ),
      );

  listTile({text, icon, onTap, color, dropdown = false, check}) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              check != null
                  ? Icon(
                      icon,
                      color: greenColor,
                    ).marginSymmetric(horizontal: margin_8)
                  : AssetImageWidget(
                          imageUrl: icon,
                          color: color != null ? color : null,
                          imageHeight: height_25,
                          imageWidth: height_25,
                          imageFitType: BoxFit.contain)
                      .marginSymmetric(horizontal: margin_8),
              TextView(
                text: text,
                textStyle: textStyleBody2(),
              ),
              dropdown == true
                  ? Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: font_20,
                    ).marginSymmetric(horizontal: margin_10)
                  : emptySizeBox()
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  Widget actionItem({icon, stackText, onTap}) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: radius_18,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
        ),
        if (stackText != null)
          Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: radius_9,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: radius_7,
                  child: TextView(
                    text: stackText,
                    textStyle: textStyleHeading()
                        .copyWith(fontSize: font_12, color: Colors.white),
                  ),
                ),
              ))
      ],
    );
  }
//
// Widget _body() {
//   return Padding(
//       padding:
//           EdgeInsets.only(left: margin_22, right: margin_22, top: margin_16),
//       child: Column(
//         children: [
//           Card(
//             shadowColor: Colors.grey.withOpacity(0.4),
//             elevation: 3,
//             child: TextFieldWidget(
//                 hint: 'search',
//                 onChange: (val) {
//                   controller.search(val);
//                 },
//                 inputAction: TextInputAction.search,
//                 prefixIcon: Container(
//                   child: AssetImageWidget(
//                       imageUrl: iconSearch, imageHeight: 8, imageWidth: 8),
//                   padding: EdgeInsets.only(left: margin_15, right: margin_15),
//                 ),
//                 focusNode: controller.searchFocusNode,
//                 textController: controller.searchController),
//           ).marginOnly(bottom: margin_25),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: MaterialButtonWidget(
//                     onPressed: () {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                       controller.onMyBookTap();
//                       // controller.hitMyBookAPI();
//                       controller.searchController.clear();
//                     },
//                     buttonText: 'My Books',
//                     textColor: controller.isMyBook.value
//                         ? Colors.white
//                         : colorLightGray,
//                     buttonColor: controller.isMyBook.value
//                         ? colorVioletM
//                         : Colors.transparent),
//               ).marginOnly(right: margin_15),
//               Expanded(
//                 child: MaterialButtonWidget(
//                     onPressed: () {
//                       // controller.hitMyBookAPI();
//                       FocusManager.instance.primaryFocus?.unfocus();
//                       controller.onLentBookTap();
//                       controller.searchController.clear();
//                     },
//                     buttonText: 'Books I lent',
//                     textColor: !controller.isMyBook.value
//                         ? Colors.white
//                         : colorLightGray,
//                     buttonColor: !controller.isMyBook.value
//                         ? colorVioletM
//                         : Colors.transparent),
//               ),
//             ],
//           ).marginOnly(bottom: margin_15),
//           controller.homeLoader.value
//               ? Expanded(
//                   child: Center(
//                       child: CircularProgressIndicator(
//                   backgroundColor: colorRussianViolet,
//                   color: colorMistyRose,
//                 )))
//               : Expanded(
//                   child: ListView.separated(
//                       itemCount: 5,
//                       separatorBuilder: (context, index) =>
//                           SizedBox(height: height_10),
//                       itemBuilder: (context, index) {
//                         return Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: Get.width,
//                                 height: height_200,
//                                 decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.circular(radius_15),
//                                     color: Colors.black),
//                                 child: ClipRRect(
//                                     borderRadius:
//                                         BorderRadius.circular(radius_15),
//                                     child: Image.asset(
//                                       iconImg1,
//                                       fit: BoxFit.cover,
//                                     )),
//                               ).marginOnly(bottom: height_10),
//                               TextView(
//                                 text: stringTitle,
//                                 maxLine: 2,
//                                 textStyle: textStyleTitle(),
//                               ).marginOnly(bottom: height_10),
//                               ReadMoreTextWidget(
//                                 stringDummyText,
//                                 moreStyle: TextStyle(
//                                     color: colorVioletM,
//                                     fontWeight: FontWeight.bold),
//                                 lessStyle: TextStyle(
//                                     color: colorVioletM,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                 )
//         ],
//       ));
// }
}

Widget _profileHeader(loginController, homeController) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              TextView(
                text: 'Username',
                textStyle: textStyleTitle(),
              ),
              TextView(
                text: loginController.myAccountModel?.email ?? '',
                textStyle: textStyleTitle(),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
    );

Future<void> _readBook({path, id, bookController}) async {
  var data;
  data = {
    "bookId": "",
    "href": "",
    "created": 0,
    "locations": {"cfi": ""}
  };
  var datax = storage.read('$id');
  if (datax != null) {
    data = json.decode(datax);
  }
  Map locations = data != null ? data['locations'] : Map();
  try {
    if (await File(path).exists())
      await bookController.openBook(
        path,
        // controllers
        //     .fullPath.value,
        // 'assets/book/book.epub',
        '$id',
        cfi: locations['cfi'],
        created: data['created'],
        href: data['href'],
      );
  } catch (e) {
    toast(e);
  }
}
