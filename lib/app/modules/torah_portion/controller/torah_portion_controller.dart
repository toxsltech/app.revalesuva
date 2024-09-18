import '../../../../export.dart';
import '../model/torah_book_model.dart';

class TorahBookController extends GetxController {
  RxList<TorahBookList> portionLists = <TorahBookList>[].obs;
  ScrollController scrollController = ScrollController();
  var productId;
  RxInt selectedQue = 0.obs;
  RxString selectedIndex = "".obs;
  bool isExpand = false;
  RxBool isLoading = false.obs;
  // int? selectedIndex;
  @override
  void onInit() {
    getTorahBookList();
    // paginateItemsList();
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
  }

  int page = 0;
  TorahListResponseModel portionListsResponseModel = TorahListResponseModel();

  getTorahBookList() {
    isLoading.value = true;
    portionLists.clear();
    APIRepository().getTorahBookListApiCall(page: page).then(
      (value) {
        isLoading.value = false;
        if (value != null) {
          portionListsResponseModel = value;
          portionLists.value.addAll(
            portionListsResponseModel.list ?? [],
          );
          portionLists.refresh();
          isLoading.value = false;
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

  // paginateItemsList() {
  //   scrollController.addListener(() async {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       if (page < portionListsResponseModel.meta!.pageCount! - 1) {
  //         page++;
  //         getTorahBookList();
  //       }
  //     }
  //   });
  // }

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
