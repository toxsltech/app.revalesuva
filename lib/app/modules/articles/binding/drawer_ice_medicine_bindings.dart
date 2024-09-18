import 'package:get/get.dart';
import 'package:health_fitness/app/modules/articles/controller/article_list_controller.dart';

import '../controller/article_video_controller.dart';
import '../controller/drawer_ice_medicine_controller.dart';

class SideDrawerIceMedicineBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SideDrawerIceMedicineController>(
        () => SideDrawerIceMedicineController());
    Get.lazyPut<TheArticleController>(() => TheArticleController());
    Get.lazyPut<ArticleVideoPlayerController>(
        () => ArticleVideoPlayerController());
  }
}
