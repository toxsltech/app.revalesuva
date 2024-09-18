import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/export.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/gallery_controller.dart';

class GalleryScreen extends GetView<GalleryController> {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: backGroundWidget(
          child: Column(
            children: [
              customBackWidget().paddingOnly(bottom: margin_50),
              TextView(
                text: keyGallery.tr,
                textStyle:
                    textStyleBody1().copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height_10,
              ),
              Expanded(
                child: Obx(
                  () => controller.galleryList.value.isNotEmpty
                      ? GridView.builder(
                          itemCount: controller.galleryList.value.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.6 / 2,
                                  mainAxisSpacing: margin_10,
                                  crossAxisSpacing: margin_10),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    downloadAndShow(
                                        url: controller.galleryList.value[index]
                                            .thumbnailFile);
                                  },
                                  child: Container(
                                    // height: height_150,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(radius_15)),
                                    child: NetworkImageWidget(
                                      imageurl: controller.galleryList
                                          .value[index].thumbnailFile,
                                      imageFitType: BoxFit.fill,
                                      imageWidth: Get.width * 0.5,
                                      imageHeight: Get.height * 0.5,
                                      radiusAll: radius_15,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(radius_15),
                                      bottomRight: Radius.circular(radius_15),
                                    ),
                                  ),
                                  alignment: Alignment.bottomRight,
                                  width: Get.width,
                                  height: 50,
                                  child: TextView(
                                    maxLine: 2,
                                    text: controller
                                        .galleryList.value[index].title!,
                                    textStyle: textStyleBody1().copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ).paddingOnly(
                                      right: margin_5, left: margin_5),
                                ),
                              ],
                            );
                          },
                        ).marginSymmetric(vertical: margin_10)
                      : noDataToShow(),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: margin_12),
        ),
      ),
    );
  }

  Future<String?> downloadAndShow({String? url}) async {
    await Permission.storage.request();
    File file;
    String filePath = '';
    String myUrl = '';
    String dir = "/storage/emulated/0/Download";
    String fileName = "$dir/fitness-gallery-${url!.split("/").last}.png";
    if (await File('$fileName').exists()) {
      debugPrint("Exists");
      openFile(path: "$fileName");
    } else {
      try {
        customLoader.show(Get.overlayContext);
        myUrl = url;
        var response = await await http.get(Uri.parse(myUrl));
        debugPrint("Response========> ${response.statusCode}");
        if (response.statusCode == 200) {
          var bytes = response.bodyBytes;
          filePath = '$fileName';
          file = File(filePath);
          await file.writeAsBytes(bytes);
          customLoader.hide();
          // toast("File downloaded successfully");
          Future.delayed(Duration(seconds: 1)).then((value) {
            openFile(path: filePath);
            debugPrint("filePath========> $filePath");
          });
          debugPrint('File downloaded successfully $fileName');
        } else {
          customLoader.hide();
          // toast("Something went wrong");
          filePath = 'Error code: ' + response.statusCode.toString();
          debugPrint("else run======>");
        }
      } catch (ex) {
        customLoader.hide();
        // toast("Something went wrongs");
        filePath = 'Can not fetch url';
        debugPrint("catch run======>");
        debugPrint("ex ======>$ex");
      }
      return filePath;
    }
    return null;
  }

  Future<void> openFile({path, controller}) async {
    final filePath = path;
    final result = await OpenFilex.open(filePath);
    // controller.update();
    var openResult = "type= ${result.type}  message= ${result.message}";
    debugPrint('---- $openResult');
    if (result.type == ResultType.noAppToOpen) {
      // toast(message: strNoApp);
    }
  }
}
