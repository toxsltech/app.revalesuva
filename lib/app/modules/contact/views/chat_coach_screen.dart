import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../export.dart';
import '../../../core/utils/image_picker_and_cropper.dart';
import '../controllers/chat_coach_controller.dart';

class ChatCoachScreen extends GetView<ChatCoachController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return Container(
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              iconBG,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      margin_2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius_5),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: height_22,
                    ),
                  ).marginOnly(right: margin_10, left: margin_10),
                ),
                TextView(
                  text: keyBack.tr,
                  textStyle: textStyleBodyMedium().copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ).marginOnly(bottom: margin_10),
            TextView(
              text: keyChatCoach.tr,
              textStyle: textStyleBody1()
                  .copyWith(fontWeight: FontWeight.w500, fontSize: font_17),
            ).paddingOnly(top: margin_70, right: margin_10),
            customListView(),
            button(),
          ],
        ));
  }

  customListView() {
    return Obx(
      () => Expanded(
        child: controller.chatList.isNotEmpty
            ? ListView.separated(
                controller: controller.scrollController,
                itemCount: controller.chatList.value.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: margin_30),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height_0,
                  );
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      controller.chatList.value[index].toId.toString() != "1"
                          ? receiverMsgList(index)
                          : senderMsgList(index),
                    ],
                  );
                },
              )
            : noDataToShow(inputText: "עדיין אין שיחה!"),
        // : noDataToShow(inputText: "No conversation yet!"),
      ),
    );
  }

  receiverMsgList(index) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(margin_15),
        padding: EdgeInsets.all(margin_10),
        // width: Get.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius_8),
              bottomLeft: Radius.circular(radius_8),
              bottomRight: Radius.circular(radius_8)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextView(
                textStyle: textStyleBodyLarge()
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
                text: controller.chatList.value[index].fromName,
              ),
            ),
            controller.chatList.value[index].message.toString().contains(".pdf")
                ? GestureDetector(
                    onTap: () async {
                      // final String filePath =
                      //     controller.chatList.value[index].message.toString();
                      // if (!await launchUrl(Uri.parse(filePath))) {
                      //   throw Exception('Could not launch $filePath');
                      // }
                      // downloadFile(
                      //   url:
                      //       controller.chatList.value[index].message.toString(),
                      // );

                      downloadAndShow(
                          url: controller.chatList.value[index].message
                              .toString());
                    },
                    child: AssetImageWidget(
                      // radiusAll: radius_8,
                      // imageHeight: height_100,
                      // imageWidth: height_80,
                      imageUrl: pdfIcon2,
                    ),
                  )
                : controller.chatList.value[index].message
                            .toString()
                            .contains(".jpg") ||
                        controller.chatList.value[index].message
                            .toString()
                            .contains(".jpeg") ||
                        controller.chatList.value[index].message
                            .toString()
                            .contains(".png")
                    ? GestureDetector(
                        onTap: () async {
                          // final String filePath = controller
                          //     .chatList.value[index].message
                          //     .toString();
                          // if (!await launchUrl(Uri.parse(filePath))) {
                          //   throw Exception('Could not launch $filePath');
                          // }
                          downloadAndShow(
                              url: controller.chatList.value[index].message
                                  .toString());
                        },
                        child: NetworkImageWidget(
                          radiusAll: radius_8,
                          imageurl: controller.chatList.value[index].message
                              .toString(),
                          imageFitType: BoxFit.fill,
                          // imageWidth: width_40,
                          imageHeight: height_120,
                        ),
                      )
                    : TextView(
                        textStyle: textStyleBodyLarge().copyWith(
                            fontWeight: FontWeight.w500, color: msgTextColor),
                        textAlign: TextAlign.start,
                        text: controller.chatList.value[index].message,
                      ),
            TextView(
              textStyle: textStyleBodyMedium().copyWith(
                  fontSize: font_10,
                  fontWeight: FontWeight.w700,
                  color: msgTextColor),
              text: controller.chatList.value[index].createdOn.toString()
              /*.split(" ")
                  .first*/
              ,
              textAlign: TextAlign.end,
            ).marginOnly(top: margin_5),
          ],
        ),
      ).paddingOnly(right: margin_150),
    );
  }

  senderMsgList(index) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        // width: Get.width * 0.7,
        margin: EdgeInsets.all(margin_15),
        padding: EdgeInsets.all(margin_10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius_8),
            bottomLeft: Radius.circular(radius_8),
            bottomRight: Radius.circular(radius_8),
          ),
          color: senderContainerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            controller.chatList.value[index].message.toString().contains(".pdf")
                ? GestureDetector(
                    onTap: () async {
                      final String filePath =
                          controller.chatList.value[index].message.toString();
                      // if (!await launchUrl(Uri.parse(filePath))) {
                      //   throw Exception('Could not launch $filePath');
                      // }
                      // downloadFile(
                      //   url:
                      //       controller.chatList.value[index].message.toString(),
                      // );
                      downloadAndShow(
                          url: controller.chatList.value[index].message
                              .toString());
                    },
                    child: AssetImageWidget(
                      // radiusAll: radius_8,
                      // imageHeight: height_80,
                      // imageWidth: height_80,
                      imageUrl: pdfIcon2,
                    ),
                  )
                : controller.chatList.value[index].message
                            .toString()
                            .contains(".jpg") ||
                        controller.chatList.value[index].message
                            .toString()
                            .contains(".jpeg") ||
                        controller.chatList.value[index].message
                            .toString()
                            .contains(".png")
                    ? GestureDetector(
                        onTap: () async {
                          final String filePath = controller
                              .chatList.value[index].message
                              .toString();
                          // if (!await launchUrl(Uri.parse(filePath))) {
                          //   throw Exception('Could not launch $filePath');
                          // }
                          downloadAndShow(
                              url: controller.chatList.value[index].message
                                  .toString());
                        },
                        child: NetworkImageWidget(
                          radiusAll: radius_8,
                          imageurl: controller.chatList.value[index].message
                              .toString(),
                          imageFitType: BoxFit.fill,
                          imageWidth: width_150,
                          imageHeight: height_150,
                        ),
                      )
                    : TextView(
                        textStyle: textStyleBodyLarge().copyWith(
                            fontWeight: FontWeight.w500, color: msgTextColor),
                        textAlign: TextAlign.start,
                        text: controller.chatList.value[index].message,
                      ),
            /*TextView(
              // textAlign: TextAlign.end,
              textStyle: textStyleBodyLarge()
                  .copyWith(fontWeight: FontWeight.w500, color: msgTextColor),
              text: controller.chatList.value[index].message,
            ).marginOnly(right: margin_50),*/
            TextView(
              textStyle: textStyleBodyMedium().copyWith(
                  fontSize: font_10,
                  fontWeight: FontWeight.w700,
                  color: msgTextColor),
              text: controller.chatList.value[index].createdOn.toString()
              /*.split(" ")
                  .first*/
              ,
            )
          ],
        ),
      ),
    );
  }

  Future downloadFiles(
      {url,
      name,
      extension,
      required Function(String) path,
      Function(String)? openFileFunctionCall,
      Function? afterComplete}) async {
    var dir;
    dir = await getApplicationDocumentsDirectory();
    await File("${dir?.path}/$name.$extension").exists().then((value) async {
      if (value) {
        if (openFileFunctionCall != null) {
          openFileFunctionCall("${dir?.path}/$name");
        }
      } else {
        downloadFunction(
            dir: dir,
            url: url,
            name: name,
            extension: extension,
            openFileFunction: path,
            afterComplete: afterComplete,
            openPath: openFileFunctionCall);
      }
    }).onError((error, stackTrace) {
      downloadFunction(
          dir: dir,
          url: url,
          name: name,
          openFileFunction: path,
          afterComplete: afterComplete);
    });
  }

  Future<String?> downloadAndShow({String? url}) async {
    await Permission.storage.request();
    File file;
    String filePath = '';
    String myUrl = '';
    // final dir = await getTemporaryDirectory();
    String dir = "/storage/emulated/0/Download";
    String fileName = "$dir/fitness-${url!.split("=").last}";
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
          debugPrint('file downloaded successfully $fileName');
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

  downloadFile({url, ctx}) async {
    try {
      Directory? directory = await getApplicationDocumentsDirectory();
      String filePath = (directory.path + url.toString().split('/').last)
          .replaceAll(":", "_");
      toast(filePath);
      debugPrint("filePath::::::$filePath");
      debugPrint("filePath::::::${await File(filePath).exists()}");
      if (await File(filePath).exists()) {
        openFile(
          path: filePath,
        );
      }
      downloadFiles(
        openFileFunctionCall: (String value) {
          debugPrint("Downloading::::::$value");
          openFile(
            path: filePath,
          );
        },
        url: url,
        name: url.toString().split("/").last,
        afterComplete: () {
          debugPrint("DownloadComplete:::::${url.toString().split("/").last}");
          openFile(
            path: filePath,
          );
        },
        path: (String path) {
          filePath = path;
          debugPrint("filepath:::$filePath");
        },
        extension: url.toString().split('.').last,
      );
    } catch (e) {
      debugPrint("Error while creating directory${e.toString()}");
    }
  }

  downloadFunction({
    dir,
    url,
    name,
    extension,
    required Function(String) openFileFunction,
    Function? afterComplete,
    Function(String)? openPath,
  }) async {
    ProgressDialog pd = ProgressDialog(context: Get.overlayContext);
    pd.show(
      max: 100,
      hideValue: false,
      valuePosition: ValuePosition.right,
      msg: "strPleaseWait",
      progressType: ProgressType.normal,
      progressValueColor: greenColor,
    );
    Dio dio = Dio();
    try {
      await dio.download(
        url,
        '${dir?.path}/$name.$extension',
        onReceiveProgress: (rec, total) {
          int progress = (((rec / total) * 100).toInt());
          openFileFunction('${dir?.path}/$name.$extension');
          pd.update(
            value: progress,
            msg: "strDownloading",
          );
          debugPrint('dir ${dir?.path}/$name.$extension}');
        },
        deleteOnError: true,
      ).then((response) {
        customLoader.hide();
        // pd.close();
        if (afterComplete != null) {
          afterComplete();
        }
        if (openPath != null) {
          openPath("${dir?.path}/$name.$extension");
        }
      }).onError((error, stackTrace) {
        // pd.close();
      });
    } catch (exp) {
      debugPrint("$exp");
    }
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

  button() {
    return Container(
      height: height_80,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius_20),
          topLeft: Radius.circular(radius_20),
        ),
        border: Border(
          top: BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFieldWidget(
              onChange: (value) {
                if (value == " ") {
                  controller.chatTextController.text = "";
                }
              },
              shadow: true,
              textController: controller.chatTextController,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.openFilePicker();
                    },
                    child: AssetImageWidget(
                      imageUrl: iconAttach,
                      imageHeight: height_20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.updateImageFile(
                        imageFromCamera(),
                      );
                    },
                    child: AssetImageWidget(
                      imageUrl: iconMessageCamera,
                      imageHeight: height_20,
                    ).marginSymmetric(horizontal: margin_15),
                  )
                ],
              ),
              // prefixIcon: GestureDetector(
              //   onTap: () {
              //     showModalBottomSheet(
              //       context: Get.overlayContext!,
              //       builder: (BuildContext context) {
              //         return SizedBox(
              //           height: height_270,
              //           child: EmojiSelector(
              //             onSelected: (emoji) {
              //               controller.emojiData = emoji;
              //
              //               // Navigator.of(context).pop(emoji);
              //             },
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   child: AssetImageWidget(
              //     imageUrl: iconSmile,
              //     imageHeight: height_10,
              //   ).marginAll(margin_10),
              // ),
              color: Colors.grey.shade200,
              isOutlined: false,
              hint: 'הוֹדָעָה.......',
              // hint: 'Message.......',
              hintStyle: textStyleBodyMedium().copyWith(fontSize: font_15),
              contentPadding: EdgeInsets.all(margin_15),
            ).marginOnly(right: margin_10),
          ),
          GestureDetector(
            onTap: () {
              if (controller.chatTextController.text.isNotEmpty) {
                controller.hitSendMessageApiCall(0);
                controller.chatList.refresh();
              } else {
                toast("ההודעה לא יכולה להיות ריקה");
                // toast("Message cannot be empty");
              }
            },
            child: AssetImageWidget(
              imageUrl: sendIcon,
              imageHeight: height_40,
            ),
          )
        ],
      ).marginAll(margin_15),
    );
  }
/*_contactServices() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.contactList.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              radius_10,
            ),
            color: Colors.white,
          ),
          child: GestureDetector(
            onTap: () {
              if (controller.contactList[index] == "Chat Coach") {
                Get.toNamed(AppRoutes.chatCoach);
              } else if (controller.contactList[index] == "Technical Help") {
                Get.toNamed(AppRoutes.technicalHelp);
              } else {
                Get.toNamed(AppRoutes.serviceEnquiry);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: controller.contactList[index].toString(),
                  textStyle: textStyleBodyLarge().copyWith(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: height_15,
                ).paddingOnly(
                  right: margin_10,
                ),
              ],
            ),
          ),
        ).paddingAll(
          margin_5,
        ),
      ),
    );
  }*/
}
