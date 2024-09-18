import 'package:get/get.dart';
import 'package:health_fitness/app/modules/podcast/controllers/podcast_controller.dart';

import '../controllers/podcast_detail_controller.dart';

class PodcastBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodcastController>(() => PodcastController());
    Get.lazyPut<PodcastDetailController>(() => PodcastDetailController());
  }
}
