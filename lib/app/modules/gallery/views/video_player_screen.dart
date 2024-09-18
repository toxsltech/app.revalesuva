import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_fitness/app/core/utils/helper_widget.dart';
import 'package:health_fitness/app/core/values/dimens.dart';
import 'package:health_fitness/app/core/widgets/custom_appbar.dart';

import '../../drawer/controller/myPlanController/the_gate_controller.dart';
import '../controllers/video_player_controller.dart';

class VideoPlayerScreen extends GetView<VideoPlayerControllerr> {
  var controller = Get.put(
    VideoPlayerControllerr(),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.put(TheGateController()).onInit();
        if (controller.videoPlayerController!.value.position >=
            controller.videoPlayerController!.value.duration) {
          Get.delete<VideoPlayerControllerr>();
          Get.back();
        } else {
          debugPrint("Position : " +
              controller.videoPlayerController!.value.position.toString());
          debugPrint(
              controller.videoPlayerController!.value.duration.toString());
          controller.hitAddReviewApiCall(
            startTime: "0",
            endTime: controller.videoPlayerController!.value.position
                .toString()
                .split(".")
                .first,
            totalTime: controller.videoPlayerController!.value.duration
                .toString()
                .split(".")
                .first,
            stateId: controller.stateId == "1" ? "1" : "",
          );
          Get.back();
        }
        Get.delete<VideoPlayerControllerr>();
        controller.videoPlayerController!.dispose();
        controller.chewieController!.dispose();
        return Future.value(true);
      },
      child: Scaffold(
       /* appBar: CustomAppBar(

        ),*/
        body: Container(
          height: Get.height,
          child: Column(
            children: [
              customBackWidget(onTap: () {
                Get.put(TheGateController()).onInit();
                if (controller.videoPlayerController!.value.position >=
                    controller.videoPlayerController!.value.duration) {
                  Get.delete<VideoPlayerControllerr>();
                  Get.back();
                } else {
                  debugPrint("Position : " +
                      controller.videoPlayerController!.value.position.toString());
                  debugPrint(
                      controller.videoPlayerController!.value.duration.toString());
                  controller.hitAddReviewApiCall(
                    startTime: "0",
                    endTime: controller.videoPlayerController!.value.position
                        .toString()
                        .split(".")
                        .first,
                    totalTime: controller.videoPlayerController!.value.duration
                        .toString()
                        .split(".")
                        .first,
                    stateId: controller.stateId == "1" ? "1" : "",
                  );
                  Get.back();
                }
                Get.delete<VideoPlayerControllerr>();
                controller.videoPlayerController!.dispose();
                controller.chewieController!.dispose();
              },
              ).marginOnly(top: margin_20),
              Expanded(
                child: Center(
                  child: Chewie(
                    controller: controller.chewieController!,
                  ).paddingOnly(top: margin_10,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
