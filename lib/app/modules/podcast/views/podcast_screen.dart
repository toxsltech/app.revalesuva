import 'package:health_fitness/export.dart';

class PodcastScreen extends GetView<PodcastController> {
  const PodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: backGroundWidget(
              child: Column(
            children: [
              customBackWidget(title: keyBackToHome.tr)
                  .paddingOnly(bottom: margin_50),
              Expanded(
                  child: ListView.separated(
                controller: controller.scrollController,
                itemCount: controller.podcastLists.value.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.podcastDetailsScreen,
                        arguments: {
                          "productId": controller.podcastLists.value[index].id
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(margin_10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radius_8)),
                      child: Row(
                        children: [
                          Icon(Icons.mic),
                          SizedBox(
                            width: width_10,
                          ),
                          TextView(
                              text: controller.podcastLists.value[index].title!,
                              textStyle: textStyleBody2()),
                          Spacer(),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height_10,
                  );
                },
              ).marginOnly(top: margin_35))
            ],
          ).paddingSymmetric(horizontal: margin_12)),
        ),
      ),
    );
  }
}
