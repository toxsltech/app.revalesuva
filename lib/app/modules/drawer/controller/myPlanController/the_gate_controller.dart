import 'package:health_fitness/app/modules/drawer/models/response_model/video_list_response.dart';
import 'package:video_player/video_player.dart';

import '../../../../../export.dart';

class TheGateController extends GetxController {
  RxList<LessonModel> lessonVideos = <LessonModel>[].obs;
  late VideoPlayerController videoPlayerController;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 0;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    addData();
    videoList.clear();
    getVideoLesson("");
    // paginateItemsList(page);
    // TODO: implement onInit
    super.onInit();
  }

  VideoListResponseModel videoListResponseModel = VideoListResponseModel();
  RxList<VideoList> videoList = <VideoList>[].obs;

  getVideoLesson(searchText) async {
    isLoading.value = true;
    await Future.delayed(
      Duration(milliseconds: 500),
    );
    APIRepository().getVideoListApiCall(page: page, search: searchText).then(
      (value) {
        isLoading.value = false;
        if (value != null) {
          videoList.clear();
          videoListResponseModel = value;
          videoList.value.addAll(
            videoListResponseModel.list ?? [],
          );
          isLoading.value = false;
          videoList.refresh();
          update();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        isLoading.value = false;
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }

  // paginateItemsList(int page) {
  //   scrollController.addListener(() async {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       if (page < videoListResponseModel.meta!.pageCount! - 1) {
  //         page++;
  //         // getVideoLesson();
  //       }
  //     }
  //   });
  // }

  /*
  * Status == 0 -> Locked
  * Status == 1 -> Unlocked
  * Status == 2 -> In-Progress
  * Status == 3 -> Completed
  */

  addData() {
    lessonVideos.add(
      LessonModel(
        title: "Lesson 1: Vegetables and Proteins Sources",
        description: '',
        image: demoImg,
        video:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        status: 3,
        summary:
            "Vegetables are parts of plants that are consumed by humans or other animals as food. The original meaning is still commonly used and is applied to plants collectively to refer to all edible plant matter, including the flowers, fruits, stems, leaves, roots, and seeds.",
        expanded: false,
        summaryImage: summaryImage,
      ),
    );
    lessonVideos.add(
      LessonModel(
        title: "Lesson 2: Vegetables and Proteins Sources",
        description: 'Remaining time 6:20 min',
        image: demoImg,
        video:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        status: 1,
        expanded: false,
        summary:
            "Vegetables are parts of plants that are consumed by humans or other animals as food. The original meaning is still commonly used and is applied to plants collectively to refer to all edible plant matter, including the flowers, fruits, stems, leaves, roots, and seeds.",
        summaryImage: summaryImage,
      ),
    );
    lessonVideos.add(
      LessonModel(
        title: "Lesson 3: Vegetables and Proteins Sources",
        description:
            'To watch the video, you need to complete a viewing of the previous video.',
        image: demoImg,
        video:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        status: 0,
        expanded: false,
        summary:
            "Vegetables are parts of plants that are consumed by humans or other animals as food. The original meaning is still commonly used and is applied to plants collectively to refer to all edible plant matter, including the flowers, fruits, stems, leaves, roots, and seeds.",
        summaryImage: summaryImage,
      ),
    );
    lessonVideos.refresh();
  }
}

class LessonModel {
  var image;
  var title;
  var description;
  var status;
  var video;
  var summary;
  var summaryImage;
  var expanded;

  LessonModel({
    this.title,
    this.description,
    this.image,
    this.video,
    this.status,
    this.summary,
    this.summaryImage,
    this.expanded,
  });
}
