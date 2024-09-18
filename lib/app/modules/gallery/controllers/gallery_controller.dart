import 'package:health_fitness/app/modules/gallery/models/gallery_list_response.dart';

import '../../../../export.dart';

class GalleryController extends GetxController {
  @override
  void onInit() {
    getGalleryList();
    // TODO: implement onInit
    super.onInit();
  }

  ScrollController scrollController = ScrollController();
  GalleryListResponseModel galleryListResponseModel =
      GalleryListResponseModel();
  RxList<GalleryList> galleryList = <GalleryList>[].obs;
  int page = 0;
  getGalleryList() {
    APIRepository().getGalleryListApiCall(page).then(
      (value) {
        if (value != null) {
          galleryListResponseModel = value;
          galleryList.value.addAll(galleryListResponseModel.list ?? []);
          galleryList.refresh();
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
        if (page < galleryListResponseModel.meta!.pageCount! - 1) {
          page++;
          getGalleryList();
        }
      }
    });
  }
}
