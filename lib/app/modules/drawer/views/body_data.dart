import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../export.dart';
import '../../../core/values/validator.dart';
import '../controller/body_and_meedical_details_controller.dart';

class BodyAndMedicalScreen extends GetView<BodyAndMedicalDetailController> {
  final bodyFormGlobalKey = GlobalKey<FormState>();

  BodyAndMedicalScreen({super.key});

  final controller = Get.put(BodyAndMedicalDetailController());

  // PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BodyAndMedicalDetailController(),
        builder: (controllers) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: backGroundColor,
              body: Container(
                // height: Get.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          iconBackGround1,
                        ),
                        fit: BoxFit.fill)),
                child: loginDataModel != null
                    ? SingleChildScrollView(
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
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(radius_5))),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: height_22,
                                    ),
                                  ).marginOnly(left: margin_10),
                                ),
                                TextView(
                                  text: keyBackToPersonalProfile.tr,
                                  textStyle: textStyleBodyMedium().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: font_12),
                                ).marginOnly(right: margin_10),
                              ],
                            ).marginOnly(bottom: margin_10),
                            TextView(
                              text: keyBodyDataAndMedialInformation.tr,
                              textStyle: textStyleBody1()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height_70,
                            ),
                            controller.planType.toString() ==
                                    userTypeIced.toString()
                                ? emptySizeBox()
                                : TextView(
                                    text: KeyPicturesBefore.tr,
                                    textStyle: textStyleBody1()
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ).marginSymmetric(vertical: margin_10),
                            Row(
                              children: [
                                loginDataModel!.frontImage!.isNotEmpty
                                    ? _containerDesign(
                                        image: loginDataModel!
                                                .frontImage!.first.url ??
                                            "",
                                        title: keyFront.tr)
                                    : emptySizeBox(),
                                loginDataModel!.sideImage!.isNotEmpty
                                    ? _containerDesign(
                                        image: loginDataModel!
                                                .sideImage!.first.url ??
                                            "",
                                        title: keySide.tr)
                                    : emptySizeBox(),
                                loginDataModel!.backImage!.isNotEmpty
                                    ? _containerDesign(
                                        image: loginDataModel!
                                                .backImage!.first.url ??
                                            "",
                                        title: keyBack.tr)
                                    : emptySizeBox(),
                              ],
                            ),
                            Container(
                              // padding: EdgeInsets.all(margin_10),
                              margin: EdgeInsets.symmetric(
                                vertical: margin_6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    radius_25,
                                  ),
                                  bottomRight: Radius.circular(
                                    radius_18,
                                  ),
                                ),
                              ),
                              child: _bodyDetail(),
                            ),
                            Container(
                              // padding: EdgeInsets.all(margin_10),
                              margin: EdgeInsets.symmetric(
                                vertical: margin_6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    radius_25,
                                  ),
                                  bottomRight: Radius.circular(
                                    radius_18,
                                  ),
                                ),
                              ),
                              child: _medicalQuestion(),
                            ),
                          ],
                        )
                            .paddingAll(
                              margin_12,
                            )
                            .marginOnly(
                              top: margin_20,
                            ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          );
        });
  }

  _bodyDetail() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleAndEdit(keyBodyData, typeBody),
          _customText(
              title: keyWeight.tr,
              subTitle: controller.weightController.text,
              icon: iconWeight),
          _customText(
              title: keyHeight.tr,
              subTitle: controller.heightController.text,
              icon: iconHeight),
          _customText(
              title: keyAge.tr,
              subTitle: controller.ageController.text,
              icon: iconAge),
          /*Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                color: greenColor,
                size: font_20,
              ).marginOnly(left: margin_10, right: margin_10),
              GestureDetector(
                onTap: () async {
                  debugPrint(loginDataModel!.bloodTestImage!.first.url);
                  await downloadAndShow(
                      url: "${loginDataModel!.bloodTestImage!.first.url}");
                  // pdfViewDialog();
                },
                child: TextView(
                    text: keyViewBloodTestForm.tr,
                    textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: font_13,
                        decoration: TextDecoration.underline,
                        color: greenColor)),
              ),
            ],
          ).marginSymmetric(vertical: margin_10)*/
        ],
      );

  _medicalQuestion() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleAndEdit(keyMedicalQuestionnaire, typeMedical),
          _medicalQuestionnairesList()
        ],
      );

  _medicalQuestionnairesList() {
    return GetBuilder<BodyAndMedicalDetailController>(
      builder: (BodyAndMedicalDetailController controller) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: loginDataModel!.quetionDetails!.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                        text: '${index + 1}. ', textStyle: textStyleBody2()),
                    Expanded(
                      child: TextView(
                          textAlign: TextAlign.start,
                          text:
                              loginDataModel!.quetionDetails![index].question ??
                                  '',
                          textStyle:
                              textStyleBody2().copyWith(fontSize: font_13)),
                    ),
                  ],
                ),
                TextView(
                        text: loginDataModel!.quetionDetails![index].typeId == 0
                            ? "${keyNo.tr} "
                            : "${keyYes.tr}, " +
                                loginDataModel!.quetionDetails![index].title
                                    .toString(),
                        textStyle: textStyleBodySmall().copyWith(
                            fontSize: font_11, fontWeight: FontWeight.w400))
                    .marginSymmetric(horizontal: margin_15),
              ],
            ).paddingOnly(left: margin_10, right: margin_10);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey.shade400,
              thickness: 1.3,
            ).marginSymmetric(vertical: margin_10);
          },
        ).marginSymmetric(vertical: margin_10);
      },
    );
  }

  _detailForm(index) {
    return EditRow(
      title: keyDetail.tr,
      texField: TextFieldWidget(
        radius: radius_10,
        hint: 'יש לי בעיית לחץ דם.',
        // hint: 'יI have blood pressure problem.',
        decoration: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius_10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        isOutlined: true,
        hintStyle: textStyleBodyMedium()
            .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
        contentPadding:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
        textController: controller.textControllers[index],
        inputAction: TextInputAction.done,
        inputType: TextInputType.text,
        validate: (value) =>
            Validator.ValidateFields(value, message: keyDetail.tr),
        onChange: (value) {
          debugPrint(value);
          controller.dataList.removeWhere((element) =>
              element.id.toString() ==
              controller.dataList[index].id.toString());
          controller.dataList.add(TeamMember(
            loginDataModel!.quetionDetails![index].id,
            loginDataModel!.quetionDetails![index].questionId.toString(),
            value.trim(),
            loginDataModel!.quetionDetails![index].typeId.toString(),
          ));
        },
      ),
    );
  }

  Widget EditRow({required String title, required Widget texField}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: TextView(
                    textAlign: TextAlign.start,
                    text: title + " :",
                    textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.bold, fontSize: font_12))
                .paddingOnly(top: margin_11, right: margin_5),
          ),
          Expanded(flex: 5, child: texField),
        ],
      ).paddingOnly(bottom: margin_10);

  _customText({title, icon, subTitle}) => Row(
        children: [
          AssetImageWidget(
            imageUrl: icon,
            imageHeight: height_30,
          ).marginOnly(right: margin_10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                  text: title, textStyle: textStyleBodyMedium().copyWith()),
              TextView(
                  text: subTitle,
                  textStyle: textStyleBody1()
                      .copyWith(fontSize: font_12, color: Colors.black54))
            ],
          )
        ],
      ).paddingOnly(left: margin_10, right: margin_10, bottom: margin_10);

  _titleAndEdit(String? text, int? type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(radius_12)),
          color: greenColor),
      height: height_40,
      child: Row(
        children: [
          TextView(
              text: text!.tr,
              textStyle: textStyleBody2()
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          Spacer(),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(_bottomSheet(type));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(radius_5))),
              child: Icon(
                Icons.mode,
                size: height_15,
              ),
            ),
          )
        ],
      ),
    ).marginOnly(bottom: margin_15);
  }

  _bottomSheet(int? from) {
    return GetBuilder<BodyAndMedicalDetailController>(builder: (controller) {
      return Container(
        // height: Get.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius_10),
                topRight: Radius.circular(radius_10))),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: margin_10, vertical: margin_10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius_10),
                      topRight: Radius.circular(radius_10)),
                  color: greenColor),
              child: Row(
                children: [
                  TextView(
                      text: from == typeBody
                          ? keyEditBodyData.tr
                          : keyEditMedicalQuestionnaire.tr,
                      textStyle: textStyleBody2().copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: height_18,
                    ),
                  )
                ],
              ),
            ),
            from == typeBody
                ? Expanded(
                    child: ListView(
                      // physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        _editBodyForm(),
                      ],
                    ).marginOnly(top: margin_15),
                  )
                : Expanded(
                    // height: height_100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: loginDataModel!.quetionDetails!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                    text: '${index + 1}. ',
                                    textStyle: textStyleBody2()),
                                Expanded(
                                  child: TextView(
                                    textAlign: TextAlign.start,
                                    text: loginDataModel!
                                            .quetionDetails![index].question ??
                                        '',
                                    textStyle: textStyleBody2()
                                        .copyWith(fontSize: font_13),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      activeColor: Colors.black,
                                      // groupValue: controller.groupValue[index],
                                      groupValue: loginDataModel!
                                          .quetionDetails![index].groupValue,
                                      value: !loginDataModel!
                                          .quetionDetails![index].isSelected,
                                      onChanged: (val) {
                                        controller.dataList.removeWhere(
                                            (element) =>
                                                element.id.toString() ==
                                                controller.dataList[index].id
                                                    .toString());
                                        controller.dataList.add(TeamMember(
                                          loginDataModel!
                                              .quetionDetails![index].id,
                                          loginDataModel!
                                              .quetionDetails![index].questionId
                                              .toString(),
                                          controller.textControllers[index].text
                                              .trim(),
                                          val == true ? "1" : "0",
                                        ));
                                        loginDataModel!.quetionDetails![index]
                                                .isSelected =
                                            !loginDataModel!
                                                .quetionDetails![index]
                                                .isSelected;
                                        debugPrint(controller.dataList.length
                                            .toString());
                                        print(val);
                                        controller.update();
                                      },
                                    ),
                                    TextView(
                                        text: keyYes.tr,
                                        textStyle: textStyleBody2()),
                                    Radio(
                                      activeColor: Colors.black,
                                      // groupValue: controller.groupValue[index],
                                      groupValue: !loginDataModel!
                                          .quetionDetails![index].groupValue,
                                      value: !loginDataModel!
                                          .quetionDetails![index].isSelected,
                                      onChanged: (val) {
                                        controller.dataList.removeWhere(
                                            (element) =>
                                                element.id.toString() ==
                                                loginDataModel!
                                                    .quetionDetails![index].id
                                                    .toString());
                                        print(val);
                                        controller.dataList.add(TeamMember(
                                          loginDataModel!
                                              .quetionDetails![index].id,
                                          loginDataModel!
                                              .quetionDetails![index].questionId
                                              .toString(),
                                          controller.textControllers[index].text
                                              .trim(),
                                          val == true ? "1" : "0",
                                        ));
                                        loginDataModel!.quetionDetails![index]
                                                .isSelected =
                                            !loginDataModel!
                                                .quetionDetails![index]
                                                .isSelected;
                                        debugPrint(controller
                                            .dataList.first.title
                                            .toString());

                                        debugPrint(controller.dataList.length
                                            .toString());
                                        controller.update();
                                        // controller.medicalQuestionList.refresh();
                                      },
                                    ),
                                    TextView(
                                        text: keyNo.tr,
                                        textStyle: textStyleBody2()),
                                  ],
                                ),
                                if (loginDataModel!
                                    .quetionDetails![index].isSelected)
                                  _detailForm(index),
                              ],
                            )
                          ],
                        ).paddingOnly(left: margin_10, right: margin_10);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          color: Colors.grey.shade400,
                          thickness: 1.3,
                        ).marginSymmetric(vertical: margin_10);
                      },
                    )
                        .marginSymmetric(vertical: margin_10)
                        .marginOnly(top: margin_15),
                  ),
            from == typeBody ? _updateButton() : _medicalUpdateButton()
          ],
        ).marginOnly(bottom: margin_15),
      );
    });
  }

  _editBodyForm() {
    return Form(
      key: bodyFormGlobalKey,
      child: Column(
        children: [
          TextFieldWidget(
            labelText: keyWeight.tr,
            labelMargin: margin_3,
            hint: '60 kg',
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            maxLength: 3,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.digitsOnly,
            ],
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black26, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.weightController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyWeight.tr),
          ),
          TextFieldWidget(
            labelMargin: margin_3,
            labelText: keyHeight.tr,
            radius: radius_10,
            hint: '170 cm',
            maxLength: 3,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.digitsOnly,
            ],
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black26, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.heightController,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyHeight.tr),
          ).marginSymmetric(vertical: margin_8),
          TextFieldWidget(
            radius: radius_10,
            labelText: keyAge.tr,
            labelMargin: margin_3,
            hint: '24',
            maxLength: 3,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                RegExp(r'^0+'),
              ),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius_20),
                borderSide: BorderSide(color: Colors.grey.shade400)),
            isOutlined: true,
            hintStyle: textStyleBodyMedium()
                .copyWith(color: Colors.black26, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            textController: controller.ageController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            validate: (value) =>
                Validator.ValidateFields(value, message: keyAge.tr),
          ),
        ],
      ).marginSymmetric(horizontal: margin_10),
    );
  }

  _containerDesign({image, title}) {
    return Column(
      children: [
        Container(
          height: Get.width * 0.28,
          width: Get.width * 0.28,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_10),
              border: Border.all(color: Colors.black)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(radius_10),
              child: NetworkImageWidget(
                placeHolder: iconProfile,
                imageurl: image,
                imageFitType: BoxFit.fill,
              )),
        ),
        TextView(
                text: title,
                textStyle: textStyleBodyMedium().copyWith(fontSize: font_14))
            .marginSymmetric(vertical: margin_5),
      ],
    ).marginOnly(
      left: margin_5,
      right: margin_5,
    );
  }

  Widget _updateButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyUpdate.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          if (bodyFormGlobalKey.currentState!.validate()) {
            controller.hitProfileSetUpApi();
            controller.update();
          }
        },
      ),
    ).marginSymmetric(
      horizontal: margin_10,
      vertical: margin_10,
    );
  }

  Widget _medicalUpdateButton() {
    return Align(
      alignment: Alignment.topRight,
      child: MaterialButtonWidget(
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        buttonText: keyUpdate.tr,
        buttonColor: Colors.grey.shade800,
        onPressed: () {
          controller.hitUpdateAnswerApi();
        },
      ),
    ).marginSymmetric(
      horizontal: margin_10,
      vertical: margin_10,
    );
  }

  Future<String?> downloadAndShow({String? url}) async {
    await Permission.storage.request();
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    String dir = '/storage/emulated/0/Download/';
    String fileName =
        "${loginDataModel!.bloodTestImage!.first.url!.split("/").last}.pdf";
    if (await File('$dir$fileName').exists()) {
      debugPrint("Exists");
      openFile(path: "$dir$fileName");
    } else {
      try {
        customLoader.show(Get.overlayContext);
        myUrl = url!;
        var request = await httpClient.getUrl(Uri.parse(myUrl));
        var response = await request.close();
        debugPrint("Response========> ${response.statusCode}");
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          filePath = '$dir$fileName';
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
          toast("Something went wrong");
          filePath = 'Error code: ' + response.statusCode.toString();
          debugPrint("else run======>");
        }
      } catch (ex) {
        customLoader.hide();
        toast("Something went wrongs");
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

  pdfViewDialog(filePath) {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white10,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getInkWell(
                onTap: () {
                  Get.back();
                },
                child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ),
              Expanded(
                child: PDFView(
                  filePath: loginDataModel!.bloodTestImage!.first.url,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  // autoSpacing: false,
                  // pageFling: true,
                  // pageSnap: true,
                  // defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,
                  onError: (error) {
                    debugPrint(error);
                  },
                  onRender: (pages) {
                    debugPrint('Pages: $pages');
                  },
                  onViewCreated: (PDFViewController controller) {
                    // You can use the controller to perform actions
                    // such as zooming, scrolling, etc.
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
