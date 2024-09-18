import '../../../../export.dart';
import '../model/star_response.dart';

class StarController extends GetxController {
  RxList<StarList> starList = <StarList>[].obs;
  ScrollController scrollController = ScrollController();
  var productId;
  @override
  void onInit() {
    getStarList();
    paginateItemsList();
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
  }

  int page = 0;
  StarListResponseModel starListsResponseModel = StarListResponseModel();

  getStarList() {
    starList.clear();
    APIRepository().getStarListApiCall(page: page).then(
      (value) {
        if (value != null) {
          starListsResponseModel = value;
          starList.value.addAll(
            starListsResponseModel.list ?? [],
          );
          starList.refresh();
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
        if (page < starListsResponseModel.meta!.pageCount! - 1) {
          page++;
          getStarList();
        }
      }
    });
  }

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxBool dateSelected = false.obs;

  List<queAnsModel> detailList = [
    queAnsModel(que: "General Details", ans: "This is general details"),
    queAnsModel(que: "About the workshop", ans: "all about workshop")
  ];

  RxInt count = 0.obs;

  decreaseCount() {
    if (count.value > 0) {
      count--;
      count.refresh();
    }
  }

  increaseCount() {
    if (count.value >= 0) {
      count++;
      count.refresh();
    }
  }
}

class queAnsModel {
  String? que;
  String? ans;
  bool? isCheck;
  int? activeMeterIndex;

  queAnsModel(
      {this.que, this.ans, this.isCheck = false, this.activeMeterIndex});
}
