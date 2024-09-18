import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../../../export.dart';

openAndZoomVideo(String? videoUrl) async {
  final videoPlayerController = VideoPlayerController.networkUrl(
    Uri.parse(videoUrl!),
  );
  await videoPlayerController.initialize();
  if (Get.isDialogOpen!) {
  } else {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        content: Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.none,
          children: [
            Container(
                margin: EdgeInsets.only(top: margin_20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: width_2),
                    borderRadius: BorderRadius.circular(radius_10)),
                height: Get.height * 0.5,
                width: Get.width,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius_10),
                    child: Chewie(
                      controller: ChewieController(
                        allowPlaybackSpeedChanging: false,
                        videoPlayerController: videoPlayerController,
                        allowFullScreen: false,
                        materialProgressColors: ChewieProgressColors(
                            playedColor: appColor,
                            handleColor: Colors.white,
                            backgroundColor: Colors.grey,
                            bufferedColor: Colors.grey.shade300),
                        cupertinoProgressColors: ChewieProgressColors(
                            playedColor: appColor,
                            handleColor: Colors.white,
                            backgroundColor: Colors.grey,
                            bufferedColor: Colors.grey.shade300),
                        autoPlay: true,
                        looping: true,
                      ),
                    ))),
            InkWell(
              onTap: () {
                Get.back();
                videoPlayerController.dispose();
              },
              child: Container(
                height: height_25,
                width: height_25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: width_2)),
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                    size: height_20,
                  ),
                ),
              ),
            ).paddingOnly(right: margin_5, top: margin_4)
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}