import 'package:chewie/chewie.dart';

import '../../../../export.dart';
import '../controller/article_video_controller.dart';

class ArticleVideoPlayerScreen extends GetView<ArticleVideoPlayerController> {
  const ArticleVideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.back();
        controller.videoPlayerController!.dispose();
        controller.chewieController!.dispose();
        Get.delete<ArticleVideoPlayerController>();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: customBackWidget(onTap: (){
            Get.back();
            controller.videoPlayerController!.dispose();
            controller.chewieController!.dispose();
            Get.delete<ArticleVideoPlayerController>();
          }),
        ),
        body: Center(
          child: Center(
            child: Chewie(
              controller: controller.chewieController!,
            ),
          ),
        ),
      ),
    );
  }

  _backIcon() {
    return InkWell(
      child: AssetImageWidget(
        imageUrl: iconBack,
        imageWidth: height_20,
        imageHeight: height_20,
      ).paddingOnly(
        top: margin_15,
        bottom: margin_15,
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
