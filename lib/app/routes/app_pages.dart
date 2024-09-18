/*
 * @copyright : Ozvid Technologies Pvt. Ltd. < www.ozvid.com >
 * @author     : Shiv Charan Panjeta < shiv@ozvid.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Ozvid Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:health_fitness/app/modules/authentication/views/forget_screen.dart';
import 'package:health_fitness/app/modules/authentication/views/profile_screen.dart';
import 'package:health_fitness/app/modules/authentication/views/register_screen.dart';
import 'package:health_fitness/app/modules/contact/bindings/chat_coach_bindings.dart';
import 'package:health_fitness/app/modules/contact/bindings/contact_bindings.dart';
import 'package:health_fitness/app/modules/contact/bindings/technical_support_binding.dart';
import 'package:health_fitness/app/modules/contact/views/chat_coach_screen.dart';
import 'package:health_fitness/app/modules/contact/views/contact_screen.dart';
import 'package:health_fitness/app/modules/drawer/bindings/intuitive_detail_bindings.dart';
import 'package:health_fitness/app/modules/drawer/bindings/myPlanBindings.dart';
import 'package:health_fitness/app/modules/drawer/bindings/my_successes_bindings.dart';
import 'package:health_fitness/app/modules/drawer/bindings/the_gate_bindings.dart';
import 'package:health_fitness/app/modules/drawer/bindings/vessels_bindings.dart';
import 'package:health_fitness/app/modules/drawer/views/contact_data_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/my_plan/ice_medicine_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/my_plan/my_plan_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/my_plan/the_gate_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/daily_nutrition_planning_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/fasting_calculator_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/intuitive_writing_detail_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/my_successes_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/vessels/ovulation_calculator_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/weighing_and_perimeter/weighing_and_perimeter_screen.dart';
import 'package:health_fitness/app/modules/drawer/views/weighing_and_perimeter/weighing_detail_screen.dart';
import 'package:health_fitness/app/modules/gallery/bindings/gallery_bindings.dart';
import 'package:health_fitness/app/modules/gallery/views/gallery_screen.dart';
import 'package:health_fitness/app/modules/gallery/views/video_player_screen.dart';
import 'package:health_fitness/app/modules/hadas_reinforcement/views/meditation_video.dart';
import 'package:health_fitness/app/modules/hadas_reinforcement/views/strength_video.dart';
import 'package:health_fitness/app/modules/healthConsumerism/binding/featured_product_binding.dart';
import 'package:health_fitness/app/modules/healthConsumerism/binding/health_consumerism_binding.dart';
import 'package:health_fitness/app/modules/healthConsumerism/binding/recipe_binding.dart';
import 'package:health_fitness/app/modules/healthConsumerism/binding/recipe_details_binding.dart';
import 'package:health_fitness/app/modules/healthConsumerism/view/featured_product.dart';
import 'package:health_fitness/app/modules/healthConsumerism/view/health_consumerism_home.dart';
import 'package:health_fitness/app/modules/healthConsumerism/view/recipe_details.dart';
import 'package:health_fitness/app/modules/healthConsumerism/view/recipe_screen.dart';
import 'package:health_fitness/app/modules/home/views/home_screen.dart';
import 'package:health_fitness/app/modules/home/views/item_view.dart';
import 'package:health_fitness/app/modules/home/views/main_screen.dart';
import 'package:health_fitness/app/modules/my_orders/binding/order_binding.dart';
import 'package:health_fitness/app/modules/notification/views/notification_screen.dart';
import 'package:health_fitness/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:health_fitness/app/modules/podcast/bindings/podcast_bindings.dart';
import 'package:health_fitness/app/modules/podcast/views/podcast_detail_screen.dart';
import 'package:health_fitness/app/modules/podcast/views/podcast_screen.dart';
import 'package:health_fitness/app/modules/principles_so_far/binding/principle_binding.dart';
import 'package:health_fitness/app/modules/principles_so_far/views/principle_so_far.dart';
import 'package:health_fitness/app/modules/regulations/binding/regulation_binding.dart';
import 'package:health_fitness/app/modules/regulations/views/regulation_screen.dart';
import 'package:health_fitness/app/modules/shop/bindings/shop_bindings.dart';
import 'package:health_fitness/app/modules/shop/views/payment_screen.dart';
import 'package:health_fitness/app/modules/shop/views/shop_detail_screen.dart';
import 'package:health_fitness/app/modules/shop/views/shop_screen.dart';
import 'package:health_fitness/app/modules/splash/views/splash_screen.dart';
import 'package:health_fitness/app/modules/start/binding/star_binding.dart';
import 'package:health_fitness/app/modules/staticPages/binding/binding.dart';
import 'package:health_fitness/app/modules/staticPages/views/static_page_screen.dart';
import 'package:health_fitness/app/modules/torah_portion/binding/torah_binding.dart';
import 'package:health_fitness/app/modules/torah_portion/views/torah_portion_screen.dart';

import '../../export.dart';
import '../modules/articles/binding/drawer_ice_medicine_bindings.dart';
import '../modules/articles/view/artcle_list_screen.dart';
import '../modules/articles/view/drawe_ice_medicine_screen.dart';
import '../modules/articles/view/video_play.dart';
import '../modules/authentication/views/already_know_screen.dart';
import '../modules/authentication/views/general_details_screen.dart';
import '../modules/authentication/widgets/body_detail_screen.dart';
import '../modules/contact/views/technical_support_screen.dart';
import '../modules/drawer/bindings/Drawer_screens_bindings.dart';
import '../modules/drawer/views/body_data.dart';
import '../modules/drawer/views/personal_profile_screen.dart';
import '../modules/drawer/views/vessels/intuitive_writing.dart';
import '../modules/drawer/views/vessels/vessels_screen.dart';
import '../modules/fastingHistory/views/fasting_history_screen.dart';
import '../modules/hadas_reinforcement/binding/binding.dart';
import '../modules/hadas_reinforcement/views/hadas_reinforcement.dart';
import '../modules/language/bindings/select_language_binding.dart';
import '../modules/language/views/select_language_screen.dart';
import '../modules/my_orders/views/order_item_details.dart';
import '../modules/my_orders/views/order_item_list.dart';
import '../modules/my_orders/views/order_list.dart';
import '../modules/start/view/stars_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),
    GetPage(
        name: AppRoutes.selectLanguage,
        page: () => SelectLanguageScreen(),
        binding: SelectLanguageBinding()),
    GetPage(
        name: AppRoutes.onBoarding,
        page: () => OnboardingScreen(),
        binding: OnBoardingBinding()),
    GetPage(
      name: AppRoutes.logIn,
      page: () => LoginScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => RegisterScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgetScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => MainScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.itemView,
      page: () => ItemView(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => NotificationScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.alreadyKnowScreen,
      page: () => AlreadyKnowScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.generalDetailsScreen,
      page: () => GeneralDetailsScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.bodyDetailsScreen,
      page: () => BodyDetailsScreen(),
      bindings: [AuthenticationBinding()],
    ),

    /*------------Drawer screens----------------*/
    GetPage(
      name: AppRoutes.personalProfile,
      page: () => PersonalProfileScreen(),
      bindings: [DrawerScreenBinding()],
    ),

    GetPage(
      name: AppRoutes.contactDataScreen,
      page: () => ContactDataScreen(),
      bindings: [DrawerScreenBinding()],
    ),
    GetPage(
      name: AppRoutes.weighingAndPerimeterScreen,
      page: () => WeighingAndPerimeterScreen(),
      bindings: [DrawerScreenBinding()],
    ),
    GetPage(
      name: AppRoutes.weighingDetailScreen,
      page: () => WeighingDetailScreen(),
      bindings: [DrawerScreenBinding()],
    ),

    GetPage(
      name: AppRoutes.contactDataScreen,
      page: () => ContactDataScreen(),
      bindings: [DrawerScreenBinding()],
    ),
    GetPage(
      name: AppRoutes.bodyAndMedicalScreen,
      page: () => BodyAndMedicalScreen(),
      bindings: [DrawerScreenBinding()],
    ),
    // GetPage(
    //   name: AppRoutes.body,
    //   page: () => BodyAndMedicalScreen(),
    //   bindings: [DrawerScreenBinding()],
    // ),
    GetPage(
      name: AppRoutes.vesselsScreen,
      page: () => VesselsScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.intuitiveWritingScreen,
      page: () => IntuitiveWritingScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.intuitiveDetailScreen,
      page: () => IntuitiveWritingDetailScreen(),
      binding: IntuitiveDetailsBindings(),
    ),
    GetPage(
      name: AppRoutes.ovulationCalculatorScreen,
      page: () => OvulationCalculatorScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.fastingCalculatorScreen,
      page: () => FastingCalculatorScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.fastingHistoryScreen,
      page: () => FastingHistoryScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.dailyNutritionScreen,
      page: () => DailyNutritionPlanningScreen(),
      bindings: [VesselsBindings()],
    ),
    GetPage(
      name: AppRoutes.healthConsumerism,
      page: () => HealthConsumerismHomePage(),
      bindings: [HealthConsumerismBinding()],
    ),
    GetPage(
      name: AppRoutes.featuredProduct,
      page: () => FeaturedProduct(),
      bindings: [FeaturedProductBinding()],
    ),
    GetPage(
      name: AppRoutes.recipeScreen,
      page: () => RecipeScreen(),
      bindings: [RecipeBinding()],
    ),
    GetPage(
      name: AppRoutes.recipeDetails,
      page: () => RecipeDetails(),
      bindings: [RecipeDetailsBinding()],
    ),
    GetPage(
      name: AppRoutes.myPlanScreen,
      page: () => MyPlanScreen(),
      bindings: [MyPlanBindings()],
    ),
    GetPage(
      name: AppRoutes.iceMedicineScreen,
      page: () => IceMedicineScreen(),
      bindings: [MyPlanBindings()],
    ),

    GetPage(
      name: AppRoutes.shopScreen,
      page: () => ShopScreen(),
      bindings: [ShopBindings()],
    ),
    GetPage(
      name: AppRoutes.shopDetailScreen,
      page: () => ShopDetailScreen(),
      bindings: [ShopBindings()],
    ),
    GetPage(
      name: AppRoutes.paymentScreen,
      page: () => PaymentScreen(),
      bindings: [ShopBindings()],
    ),
    GetPage(
      name: AppRoutes.podcastScreen,
      page: () => PodcastScreen(),
      bindings: [PodcastBindings()],
    ),
    GetPage(
      name: AppRoutes.podcastDetailsScreen,
      page: () => PodcastDetailScreen(),
      bindings: [PodcastBindings()],
    ),
    GetPage(
      name: AppRoutes.galleryScreen,
      page: () => GalleryScreen(),
      bindings: [GalleryBinding()],
    ),
    GetPage(
      name: AppRoutes.videoPlayerScreen,
      page: () => VideoPlayerScreen(),
      bindings: [GalleryBinding()],
    ),
    GetPage(
      name: AppRoutes.mySuccessesRoute,
      page: () => MySuccessesScreen(),
      binding: MySuccessesBindings(),
    ),
    GetPage(
      name: AppRoutes.theGateRoute,
      page: () => TheGateScreen(),
      binding: TheGateBindings(),
    ),
    GetPage(
      name: AppRoutes.contactRoute,
      page: () => ContactScreen(),
      binding: ContactBindings(),
    ),
    GetPage(
      name: AppRoutes.chatCoach,
      page: () => ChatCoachScreen(),
      binding: ChatCoachBindings(),
    ),

    GetPage(
      name: AppRoutes.serviceEnquiry,
      page: () => ContactScreen(),
      binding: ContactBindings(),
    ),
    GetPage(
      name: AppRoutes.technicalSupportScreen,
      page: () => TechnicalSupportScreen(),
      binding: TechnicalSupportBinding(),
    ),
    GetPage(
      name: AppRoutes.starScreen,
      page: () => StarScreen(),
      binding: StarBindings(),
    ),
    GetPage(
      name: AppRoutes.sideDrawerIceMedicineScreen,
      page: () => SideDrawerIceMedicineScreen(),
      binding: SideDrawerIceMedicineBindings(),
    ),
    GetPage(
      name: AppRoutes.videoPlayScreen,
      page: () => VideoPlayerScreen(),
      binding: SideDrawerIceMedicineBindings(),
    ),
    GetPage(
      name: AppRoutes.orderListScreen,
      page: () => OrderListScreen(),
      binding: OrderBindings(),
    ),
    GetPage(
      name: AppRoutes.orderItemListScreen,
      page: () => OrderItemListScreen(),
      binding: OrderBindings(),
    ),
    GetPage(
      name: AppRoutes.orderItemDetailsScreen,
      page: () => OrderItemDetailsScreen(),
      binding: OrderBindings(),
    ),
    GetPage(
      name: AppRoutes.theArticleScreen,
      page: () => TheArticleScreen(),
      binding: SideDrawerIceMedicineBindings(),
    ),
    GetPage(
      name: AppRoutes.articleVideoPlayerScreen,
      page: () => ArticleVideoPlayerScreen(),
      binding: SideDrawerIceMedicineBindings(),
    ),
    GetPage(
      name: AppRoutes.torahBookScreen,
      page: () => TorahBookScreen(),
      binding: TorahBookBindings(),
    ),
    GetPage(
      name: AppRoutes.hadasScreen,
      page: () => HadasScreen(),
      binding: HadasBindings(),
    ),
    GetPage(
      name: AppRoutes.strengthScreen,
      page: () => StrengthScreen(),
      binding: HadasBindings(),
    ),
    GetPage(
      name: AppRoutes.meditationScreen,
      page: () => MeditationScreen(),
      binding: HadasBindings(),
    ),
    GetPage(
      name: AppRoutes.staticPageScreen,
      page: () => StaticPageScreen(),
      binding: WebViewBinding(),
    ),
    GetPage(
      name: AppRoutes.regulationScreen,
      page: () => RegulationScreen(),
      binding: RegulationBindings(),
    ),
    GetPage(
      name: AppRoutes.principleScreen,
      page: () => PrincipleScreen(),
      binding: PrincipleBindings(),
    ),
  ];
}
