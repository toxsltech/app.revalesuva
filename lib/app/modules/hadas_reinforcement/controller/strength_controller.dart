import 'package:chewie/chewie.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:health_fitness/app/modules/hadas_reinforcement/model/data_model/video_list_data.dart';
import 'package:health_fitness/app/modules/hadas_reinforcement/model/response_model/strength_meditation_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../export.dart';

class StrengthController extends GetxController {
  EmojiData? emojiData;
  RxString selectedEmoji = ''.obs;
  RxList<String> contactList = <String>[].obs;
  TextEditingController emojiController = TextEditingController();

  String? videoLink;
  String? videoId;
  String? endTime;
  String? stateId;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {
    getVideoList();
    paginateItemsList(0);
    addData();
    super.onInit();
  }

  int page = 0;
  RxBool isLoading = false.obs;
  StrengthMeditationResponseModel strengthMeditationResponseModel =
      StrengthMeditationResponseModel();
  RxList<StMeVideoList> strengthVideoList = <StMeVideoList>[].obs;
  ScrollController scrollController = ScrollController();

  getVideoList() {
    isLoading.value = true;
    APIRepository().getStrengthListApiCall(page: page).then(
      (value) {
        if (value != null) {
          isLoading.value = false;
          strengthMeditationResponseModel = value;
          if (page == 0) {
            strengthVideoList.clear();
          }
          strengthVideoList.value.addAll(
            strengthMeditationResponseModel.list!,
          );
          strengthVideoList.refresh();
          isLoading.value = false;
          update();
        }
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

  paginateItemsList(int page) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < strengthMeditationResponseModel.meta!.pageCount! - 1) {
          page++;
          getVideoList();
        }
      }
    });
  }

  RxString profileImage = "".obs;

  initVideoPlayer(String videoLink) {
    customLoader.show(Get.overlayContext);
    print(videoLink);
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(
          // "https://mars.toxsl.in/fitness-platform-yii2-2048/base-file/152?inline=1",
          videoLink,
        ),
      )..initialize().then(
          (_) {
            customLoader.hide();
            videoDialog();
            videoPlayerController!.seekTo(
              Duration.zero
              /*videoPlayerController!.value.position +
                  Duration(seconds: int.tryParse(endTime!)!)*/
              ,
            );
            videoPlayerController!.play();
            /*videoPlayerController!.addListener(
              () {
                if (videoPlayerController!.value.position >=
                    videoPlayerController!.value.duration) {*/
            /// Video playback has reached its end
            /*if (++count == 1) {
                  // videoPlayerController!.dispose();
                  // chewieController!.dispose();
                  hitAddReviewApiCall(
                    startTime: "0",
                    endTime: videoPlayerController!.value.position
                        .toString()
                        .split(".")
                        .first,
                    totalTime: videoPlayerController!.value.duration
                        .toString()
                        .split(".")
                        .first,
                    stateId: "1",
                  );
                  // Get.back();
                }*/
            // toast(++count);
            /*  }
              },
            );*/
          },
        );
    } catch (e) {
      customLoader.hide();
      debugPrint("Errorrrs : " + e.toString());
    }
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        aspectRatio: 16 / 9,
        draggableProgressBar: false,
        autoPlay: true,
        looping: false,
        showControls: true);
  }

  videoDialog() {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white10,
          alignment: Alignment.center,
          child: Container(
            // padding: EdgeInsets.only(bottom: margin_10),
            margin: EdgeInsets.symmetric(horizontal: margin_10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(/*color: greenColor,*/ blurRadius: 4),
              ],
              border: Border.all(color: greenColor, width: width_4),
              borderRadius: BorderRadius.circular(margin_10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getInkWell(
                  onTap: () {
                    Get.back();
                    videoPlayerController!.dispose();
                    // controller.chewieController!.dispose();
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: margin_40),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      // boxShadow: [BoxShadow(color: greenColor, blurRadius: 4)],
                      // border: Border.all(color: greenColor, width: width_4),
                      borderRadius: BorderRadius.circular(margin_10)),
                  child: Container(
                    height: Get.height * 0.5,
                    child: Chewie(
                      controller: chewieController!,
                    ).paddingOnly(top: margin_0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /* videoDialog() {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white10,
          alignment: Alignment.center,
          child: Container(
            // padding: EdgeInsets.only(bottom: margin_10),
            margin: EdgeInsets.symmetric(horizontal: margin_10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: greenColor, blurRadius: 4),
                ],
                border: Border.all(color: greenColor, width: width_4),
                borderRadius: BorderRadius.circular(margin_10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getInkWell(
                  onTap: () {
                    Get.back();
                    videoPlayerController!.dispose();
                    // controller.chewieController!.dispose();
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: margin_40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // boxShadow: [BoxShadow(color: greenColor, blurRadius: 4)],
                      // border: Border.all(color: greenColor, width: width_4),
                      borderRadius: BorderRadius.circular(margin_10)),
                  child: Container(
                    height: Get.height * 0.5,
                    child: Chewie(
                      controller: chewieController!,
                    ).paddingOnly(top: margin_10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }*/

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImage.value = file.path;
    }
  }

  addData() {
    contactList.add(keyTorahPortion.tr);
    contactList.add("Strength Training");
    contactList.add("Meditations");
    contactList.refresh();
  }
}
