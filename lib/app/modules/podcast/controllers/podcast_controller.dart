import '../../../../export.dart';
import '../models/response_models/podcast_response.dart';

class PodcastController extends GetxController {
  int page = 0;
  ScrollController scrollController = ScrollController();

  PodcastListResponseModel podcastListResponseModel =
      PodcastListResponseModel();

  RxList<PodcastList> podcastLists = <PodcastList>[].obs;

  List podcastList = [
    "Podcast Name_1",
    "Podcast Name_2",
    "Podcast Name_3",
    "Podcast Name_4",
    "Podcast Name_5",
  ];

  @override
  void onInit() {
    getPodCastList();
    super.onInit();
  }

  getPodCastList() {
    APIRepository().podcastListApiCall(page: page).then(
      (value) {
        if (value != null) {
          podcastListResponseModel = value;
          podcastLists.value.addAll(podcastListResponseModel.list ?? []);
          podcastLists.refresh();
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

  paginateItemsList(int page) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < podcastListResponseModel.meta!.pageCount! - 1) {
          page++;
          getPodCastList();
        }
      }
    });
  }
}
