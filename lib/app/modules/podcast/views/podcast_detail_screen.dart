import 'package:audioplayers/audioplayers.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../export.dart';
import '../controllers/podcast_detail_controller.dart';

class PodcastDetailScreen extends GetView<PodcastDetailController> {
  PodcastDetailScreen({super.key});
  final controller = Get.put(PodcastDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        Get.delete<PodcastDetailController>();

        return Future.value(true);
      },
      child: GetBuilder<PodcastDetailController>(
        builder: (controllers) {
          return SafeArea(
            child: Scaffold(
              body: backGroundWidget(
                  child: Column(
                children: [
                  customBackWidget(
                      title: keyBack.tr,
                      onTap: () {
                        Get.back();
                        Get.delete<PodcastDetailController>();
                      }).paddingOnly(bottom: margin_50),
                  Expanded(
                      child: controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: greenColor,
                              ),
                            )
                          : controller.podcastDetails.value.isNotEmpty
                              ? ListView.separated(
                                  itemCount: controller.podcastDetails.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.all(margin_10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(radius_8)),
                                      child: Column(
                                        children: [
                                          Obx(
                                            () => Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (controller.audioPlayer
                                                            .value.state ==
                                                        PlayerState.playing) {
                                                      controller
                                                          .podcastDetails
                                                          .value[index]
                                                          .isPlaying = false;
                                                      debugPrint("if case" +
                                                          controller
                                                              .podcastDetails
                                                              .value[index]
                                                              .isPlaying
                                                              .toString());
                                                      await controller
                                                          .audioPlayer.value
                                                          .pause();

                                                      controller.podcastDetails
                                                          .refresh();
                                                      //controller.update();
                                                    } else {
                                                      try {
                                                        controller
                                                            .podcastDetails
                                                            .value[index]
                                                            .isPlaying = true;
                                                        debugPrint("else case" +
                                                            controller
                                                                .podcastDetails
                                                                .value[index]
                                                                .isPlaying
                                                                .toString());
                                                        await controller
                                                            .audioPlayer.value
                                                            .play(
                                                          UrlSource(
                                                            controller
                                                                .podcastDetails
                                                                .value[index]
                                                                .audioFile
                                                                .toString(),
                                                          ),
                                                          // UrlSource(
                                                          //   "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3",
                                                          // ),
                                                        );
                                                        controller
                                                            .initStreams(index);
                                                      } catch (e, str) {
                                                        debugPrint("Error : " +
                                                            e.toString());
                                                        debugPrint(
                                                            "Stack Trace : " +
                                                                str.toString());
                                                      }

                                                      controller.podcastDetails
                                                          .refresh();
                                                      // controller.update();
                                                    }
                                                  },
                                                  child: Obx(() =>
                                                      AssetImageWidget(
                                                        imageUrl: controller
                                                                    .audioPlayer
                                                                    .value
                                                                    .state ==
                                                                PlayerState
                                                                    .playing
                                                            ? iconPause
                                                            : iconPlay,
                                                        imageHeight: height_25,
                                                        imageWidth: height_25,
                                                      )),
                                                ),
                                                /*      MediaPlayer(
                                url: controller.episodeList[index].song ?? "",
                                title: controller.episodeList[index].title ?? "",
                                description:
                                    controller.episodeList[index].description ??
                                        ""),*/
                                                SizedBox(
                                                  width: width_10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextView(
                                                        text: controller
                                                                .podcastDetails[
                                                                    index]
                                                                .title ??
                                                            "",
                                                        textStyle: textStyleBody2()
                                                            .copyWith(
                                                                fontSize:
                                                                    font_13,
                                                                color:
                                                                    headingTextColor),
                                                      ),
                                                      RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: HTML.toTextSpan(
                                                          defaultTextStyle:
                                                              textStyleBody2()
                                                                  .copyWith(
                                                                      fontSize:
                                                                          font_11,
                                                                      color:
                                                                          headingTextColor),
                                                          context,
                                                          controller
                                                                  .podcastDetails[
                                                                      index]
                                                                  .description
                                                                  .toString()
                                                                  .trim() ??
                                                              "",
                                                          linksCallback:
                                                              (dynamic link) {
                                                            launchUrl(
                                                              Uri.parse(link),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // TextView(
                                                      //   text: controller
                                                      //           .podcastDetails[index]
                                                      //           .description ??
                                                      //       "",
                                                      //   textStyle: textStyleBody2()
                                                      //       .copyWith(
                                                      //           fontSize: font_11,
                                                      //           color:
                                                      //               headingTextColor),
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height_5,
                                          ),
                                          Slider(
                                            // value: controller.audioPlayer.value.balance,
                                            // min: 0,
                                            // max: controller.duration.toDouble() ?? 0.0,
                                            // onChanged: (value) async {
                                            //   await controller.audioPlayer.value
                                            //       .seek((value * 1000).milliseconds);
                                            // },
                                            onChanged: (value) {
                                              final duration =
                                                  controller.duration;
                                              if (duration == null) {
                                                return;
                                              }
                                              final position = value *
                                                  duration.inMilliseconds;
                                              controller.audioPlayer.value.seek(
                                                  Duration(
                                                      milliseconds:
                                                          position.round()));
                                            },
                                            value: (controller.audioPosition !=
                                                        null &&
                                                    controller.duration !=
                                                        null &&
                                                    controller.audioPosition!
                                                            .inMilliseconds >=
                                                        0 &&
                                                    controller.audioPosition!
                                                            .inMilliseconds <=
                                                        controller.duration!
                                                            .inMilliseconds)
                                                ? controller.audioPosition!
                                                        .inMilliseconds /
                                                    controller.duration!
                                                        .inMilliseconds
                                                : 0.0,
                                          )

                                          /*  ProgressBar(
                          progress: Duration(milliseconds: 1000),
                          buffered: Duration(milliseconds: 2000),
                          total: Duration(milliseconds: 5000),
                          baseBarColor: Colors.grey.shade400,
                          bufferedBarColor: Colors.grey.shade500,
                          thumbColor: Colors.black,
                          progressBarColor: Colors.black,
                          thumbRadius: radius_4,
                          thumbGlowRadius: radius_8,
                          barHeight: height_3,
                          timeLabelLocation: TimeLabelLocation.none,
                          onSeek: (duration) {
                            print('User selected a new time: $duration');
                          },
                        ),*/
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: height_10,
                                    );
                                  },
                                ).marginOnly(top: margin_35)
                              : noDataToShow(inputText: "No podcast available"))
                ],
              ).paddingSymmetric(horizontal: margin_12)),
            ),
          );
        },
      ),
    );
  }
}
