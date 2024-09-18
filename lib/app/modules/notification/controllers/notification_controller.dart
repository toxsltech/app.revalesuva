import '../../../../export.dart';
import '../../../core/values/app_global_values.dart';
import '../models/notification_response_model.dart';

class NotificationController extends GetxController {
  NotificationListResponseModel notificationListResponseModel =
      NotificationListResponseModel();
  RxList<NotificationList> notificationList2 = <NotificationList>[].obs;
  List<notificationModel> notificationList = [
    notificationModel(
        title: "Home delivery(up to 8 business days)",
        description: "This is notification description",
        date: "mar 20"),
    notificationModel(title: "Self-pickup", date: "mar 22")
  ];

  RxList dateList = ['Today, 25 May 2023', 'Yesterday, 24 May 2023'].obs;
  // RxList<ServiceListDataModel> notificationList = <ServiceListDataModel>[].obs;
  // ServiceListResponseModel serviceListResponseModel = ServiceListResponseModel();
  RxBool isLoading = false.obs;
  RxInt page = 0.obs;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    hitGetNotificationListApiCall(page: page.value);
    paginateList();
    super.onInit();
  }

  paginateList() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < notificationListResponseModel.meta!.pageCount! - 1) {
          page++;
          hitGetNotificationListApiCall(page: page.value);
          refresh();
        }
      }
    });
  }

  hitGetNotificationListApiCall({page}) async {
    isLoading.value = true;
    APIRepository().getNotificationList(page: page).then((value) async {
      if (value != null) {
        isLoading.value = false;
        notificationListResponseModel = value;
        notificationList2.addAll(notificationListResponseModel.list!);
        print("Notification List :::${notificationList2.length}");
      }
      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      // showInSnackBar(message: error.toString());
    });
  }

  hitClearNotificationListApiCall() async {
    isLoading.value = true;
    APIRepository().clearNotificationList().then((value) async {
      if (value != null) {
        isLoading.value = false;
        ResponseModel responseModel = value;
        showInSnackBar(message: responseModel.message ?? '');
      }
      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;
      // showInSnackBar(message: error.toString());
    });
  }
}

class notificationModel {
  String? title;
  String? description;
  String? date;
  int? activeMeterIndex;
  notificationModel(
      {this.title, this.description, this.date, this.activeMeterIndex});
}
