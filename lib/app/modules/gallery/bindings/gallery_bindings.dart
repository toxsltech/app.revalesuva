import 'package:get/get.dart';
import 'package:health_fitness/app/modules/gallery/controllers/video_player_controller.dart';

import '../controllers/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(() => GalleryController());
    Get.lazyPut<VideoPlayerControllerr>(() => VideoPlayerControllerr());
  }
}
