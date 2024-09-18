/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';

class ItemController extends GetxController {
  late Dio dio;
  RxBool isfaq = true.obs;
  RxBool isMyBook = true.obs;
  int backPressCounter = 0;
  var downloadPercent = 0.0.obs;
  CustomLoader customLoader = CustomLoader();
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  List myBookModelList = [];
  List myBookModelListCopy = [];
  RxString fullPath = ''.obs;
  RxBool homeLoader = false.obs;
  MyAccountModel? myAccountModel;
  String? directoryPath;
  String? extension;
  String? fileName;
  bool loadingPath = false;
  List<PlatformFile>? paths;
  int bottomNavIndex = 0;
  Item? imageArg;

  @override
  void onInit() {
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    dio = Dio();
    imageArg = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  var currentViewType = ViewType.drawer;

  updateViewType(ViewType viewType) {
    currentViewType = viewType;
    update();
  }

  updateBottomNavIndex(int index) {
    bottomNavIndex = index;
    update();
  }

  Future<String> openFileExplorer() async {
    loadingPath = true;
    update();
    try {
      directoryPath = null;
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => debugPrint(status.toString()),
      ))
          ?.files;
    } on PlatformException catch (e) {
      debugPrint("Unsupported operation" + e.toString());
    } catch (ex) {
      debugPrint(ex.toString());
    }
    update();
    loadingPath = false;
    fileName = paths != null ? paths?.single.path : '';
    return fileName!;
  }

  search(val) {
    if (val == null || val.toString().isEmpty || val.toString().length == 0) {
      update();
      return myBookModelListCopy = myBookModelList;
    } else
      myBookModelListCopy = myBookModelList.where((element) {
        if (element.book.title.toLowerCase().contains(searchController.text.trim().toLowerCase())) {
          update();
          return element.book.title.toLowerCase().contains(searchController.text.trim().toLowerCase());
        } else {
          update();
          return element.book.author.toLowerCase().contains(searchController.text.trim().toLowerCase());
        }
      }).toList();
  }

  onMyBookTap() {
    isMyBook.value = true;
    update();
  }

  onLentBookTap() {
    isMyBook.value = false;
    update();
  }

  Future download(context, String url, String savePath) async {
    File file = File(savePath);
    var value = 0.0;
    try {
      EasyLoading.showProgress(value, status: stringDownloading);
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close().whenComplete(() {
        EasyLoading.dismiss();
        return file.path;
      });
    } catch (e) {
      EasyLoading.dismiss();
      toast(e.toString());
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      downloadPercent.value = received / total;
      showProgress(downloadPercent.value);
      log.d(downloadPercent.value);
    }
  }

  showProgress(val) => EasyLoading.showProgress(val, status: stringDownloading);

  Future<bool> onWillPop() {
    debugPrint(backPressCounter.toString());
    if (backPressCounter < 1) {
      Get.snackbar(
        stringAppName,
        stringExitWarning,
        borderRadius: 6.0,
        backgroundColor: colorMistyRose,
        margin: EdgeInsets.zero,
        colorText: colorVioletM,
      );
      backPressCounter++;
      Future.delayed(Duration(milliseconds: 1500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      if (GetPlatform.isAndroid) {
        SystemNavigator.pop();
      }
      return Future.value(true);
    }
  }

  hitMyBookAPI() async {
    homeLoader.value = true;
    APIRepository.homeListApiCall().then((value) {
      myBookModelList = value;
      myBookModelListCopy = myBookModelList;
      homeLoader.value = false;
      update();
    }).onError((error, stackTrace) {
      homeLoader.value = false;
      update();
      toast(error);
    });
  }
}
