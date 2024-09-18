import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../../../export.dart';

class VideoPlayerControllerr extends GetxController {
  String? videoLink;
  String? videoId;
  String? endTime;
  String? stateId;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  @override
  void onInit() async {
    getArgument();
    // final String encodedHash = Uri.encodeFull('$baseUrl${videoLink.toString()}');
    super.onInit();
  }

  void getArgument() {
    int count = 0;
    if (Get.arguments != null) {
      videoLink = Get.arguments["videoLink"].toString();
      debugPrint(
        "videoLink: " + videoLink.toString(),
      );
      if (Get.arguments["videoId"] != null) {
        videoId = Get.arguments["videoId"].toString();
        endTime = Get.arguments["endTime"].toString();
        stateId = Get.arguments["stateId"].toString();
        debugPrint(
          "stateId: " + stateId.toString(),
        );
      }
      try {
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(
            videoLink.toString(),
          ),
        )..initialize().then(
            (_) {
              videoPlayerController!.seekTo(
                videoPlayerController!.value.position +
                    Duration(seconds: int.tryParse(endTime!)!),
              );
              videoPlayerController!.play();
              videoPlayerController!.addListener(
                () {
                  if (videoPlayerController!.value.position >=
                      videoPlayerController!.value.duration) {
                    // Video playback has reached its end
                    if (++count == 1) {
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
                    }
                    // toast(++count);
                  }
                },
              );
            },
          );
      } catch (e) {
        debugPrint("Errorrrs : " + e.toString());
      }

      chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          draggableProgressBar: false,
          autoPlay: true,
          controlsSafeAreaMinimum: EdgeInsets.only(right: margin_10),
          looping: false,
          showControls: true);
    }
  }

  calculateRemainingTime(totalTime, endTime) {
    var remainingSeconds =
        int.tryParse(totalTime.toString())! - int.tryParse(endTime.toString())!;
    return remainingSeconds.toString();
  }

  convertIntoSeconds(hours, minutes, seconds) {
    var totalSeconds = (int.tryParse(hours)! * 3600) +
        (int.tryParse(minutes)! * 60) +
        int.tryParse(seconds)!;
    return totalSeconds.toString();
  }

  hitAddReviewApiCall({startTime, endTime, stateId, totalTime}) {
    var reqBody = AuthRequestModel.addReviewReq(
      stateId: stateId,
      videoId: videoId,
      endTime: convertIntoSeconds(
        endTime.toString().split(":").first,
        endTime.toString().split(":")[1],
        endTime.toString().split(":").last,
      ),
      startTime: startTime,
      remainingTime: calculateRemainingTime(
        convertIntoSeconds(
          totalTime.toString().split(":").first,
          totalTime.toString().split(":")[1],
          totalTime.toString().split(":").last,
        ),
        convertIntoSeconds(
          endTime.toString().split(":").first,
          endTime.toString().split(":")[1],
          endTime.toString().split(":").last,
        ),
      ),
      totalTime: convertIntoSeconds(
        totalTime.toString().split(":").first,
        totalTime.toString().split(":")[1],
        totalTime.toString().split(":").last,
      ),
    );
    // customLoader.show(Get.overlayContext);
    APIRepository().addReviewApiCall(dataBody: reqBody).then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        // toast(messageResponseModel.message);

        // convertTimeToSeconds(time?.hour, time?.minute);
        update();
        // customLoader.hide();
      }
      // customLoader.hide();
    }).onError((error, stackTrace) {
      toast(error.toString());
      // customLoader.hide();
      debugPrint("Error:::::${error.toString()}");
      debugPrint("Stack:::::$stackTrace");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chewieController!.dispose();
    videoPlayerController!.dispose();
    super.dispose();
  }
}
