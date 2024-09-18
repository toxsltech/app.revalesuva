import '../../../../../export.dart';
import '../models/data_model/articles_data.dart';
import '../models/response_model/articles_response.dart';

class TheArticleController extends GetxController {
  RxList<LessonModel> lessonVideos = <LessonModel>[].obs;
  void onInit() {
    getArticleList();
    paginateItemsList();
    super.onInit();
  }

  var id;

  int page = 0;

  ScrollController scrollController = ScrollController();
  ArticlesListResponseModel articlesListResponseModel =
      ArticlesListResponseModel();
  RxList<ArticleDataModel> articleList = <ArticleDataModel>[].obs;

  getArticleList() {
    APIRepository().getArticlesListApiCall(page).then(
      (value) {
        if (value != null) {
          articlesListResponseModel = value;
          articleList.value.addAll(articlesListResponseModel.list ?? []);
          articleList.refresh();
          update();
        }
        customLoader.hide();
      },
    ).onError(
      (error, stackTrace) {
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }

  paginateItemsList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < articlesListResponseModel.meta!.pageCount! - 1) {
          page++;
          getArticleList();
        }
      }
    });
  }

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
