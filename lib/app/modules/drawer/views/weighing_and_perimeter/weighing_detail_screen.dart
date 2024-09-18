import 'package:dotted_border/dotted_border.dart';
import 'package:health_fitness/app/core/widgets/network_image.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/all_details_response.dart';
import 'package:health_fitness/app/modules/drawer/models/response_model/weight_details_response.dart';
import 'package:health_fitness/export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/weighing_detail_controller.dart';

class WeighingDetailScreen extends GetView<WeighingDetailController> {
  WeighingDetailScreen({super.key});
  var controller = Get.put(WeighingDetailController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeighingDetailController>(builder: (controllers) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          body: Container(
            height: Get.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    iconBackGround2,
                  ),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customBackWidget(),
                  SizedBox(
                    height: height_50,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  controller.weightList2.isNotEmpty
                      ? wightList()
                      : noInfoFound(),
                  SizedBox(
                    height: height_10,
                  ),
                  controller.allDetailsList.isNotEmpty
                      ? chestList()
                      : noInfoFound(),
                  SizedBox(
                    height: height_10,
                  ),
                  controller.allDetailsList.isNotEmpty
                      ? bellyList()
                      : noInfoFound(),
                  SizedBox(
                    height: height_10,
                  ),
                  controller.allDetailsList.isNotEmpty
                      ? hipList()
                      : noInfoFound(),
                  _pictureList(),
                ],
              ).paddingSymmetric(vertical: margin_30, horizontal: margin_15),
            ),
          ),
        ),
      );
    });
  }

  Widget noInfoFound() {
    return SizedBox(
        // height: height_100,
        );
  }

  Widget wightList() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showWeightBottomSheet(controller.weightList2, keyWeight.tr);
          },
          child: Container(
            height: height_120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    graphBg1,
                  ),
                  fit: BoxFit.fill),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius_10),
            ),
            child: weightDetails(controller.weightList2)
                .paddingOnly(top: margin_10),
          ),
        ),
        Positioned(
          top: height_5,
          right: height_8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextView(
                  text: keyWeight.tr,
                  textStyle:
                      textStyleBody2().copyWith(fontWeight: FontWeight.bold)),
              TextView(
                  text: controller.weightList2.first.title!,
                  textStyle:
                      textStyleBody2().copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ],
    );
  }

  chestList() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showChestBottomSheet(controller.allDetailsList, keyChestLine.tr);
          },
          child: Container(
            height: height_120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    graphBg2,
                  ),
                  fit: BoxFit.fill),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius_10),
            ),
            child: chestDetails(controller.allDetailsList).paddingOnly(
              top: margin_10,
            ),
          ),
        ),
        Positioned(
            top: height_5,
            right: height_8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextView(
                    text: keyChestLine.tr +
                        "(in " +
                        controller.allDetailsList.first.measurementType! +
                        ")",
                    textStyle:
                        textStyleBody2().copyWith(fontWeight: FontWeight.bold)),
                TextView(
                    text: controller.allDetailsList.first.chestine!,
                    textStyle: textStyleBody2()
                        .copyWith(fontWeight: FontWeight.normal)),
              ],
            )),
      ],
    );
  }

  bellyList() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showBellyBottomSheet(controller.allDetailsList, keyBellyLine.tr);
          },
          child: Container(
            height: height_120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    graphBg3,
                  ),
                  fit: BoxFit.fill),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius_10),
            ),
            child: bellyDetails(controller.allDetailsList)
                .paddingOnly(top: margin_10),
          ),
        ),
        Positioned(
            top: height_5,
            right: height_8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextView(
                    text: keyBellyLine.tr +
                        "(in " +
                        controller.allDetailsList.first.measurementType! +
                        ")",
                    textStyle:
                        textStyleBody2().copyWith(fontWeight: FontWeight.bold)),
                TextView(
                    text: controller.allDetailsList.first.bellyline!,
                    textStyle: textStyleBody2()
                        .copyWith(fontWeight: FontWeight.normal)),
              ],
            )),
      ],
    );
  }

  hipList() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showHipLineBottomSheet(controller.allDetailsList, keyHipLine.tr);
          },
          child: Container(
            height: height_120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    graphBg4,
                  ),
                  fit: BoxFit.fill),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius_10),
            ),
            child: hipDetails(controller.allDetailsList)
                .paddingOnly(top: margin_10),
          ),
        ),
        Positioned(
            top: height_5,
            right: height_8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextView(
                  text: keyHipLine.tr +
                      "(in " +
                      controller.allDetailsList.first.measurementType! +
                      ")",
                  textStyle:
                      textStyleBody2().copyWith(fontWeight: FontWeight.bold),
                ),
                TextView(
                  text: controller.allDetailsList.first.hipline!,
                  textStyle:
                      textStyleBody2().copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            )),
      ],
    );
  }

  _graphList() {
    return GetBuilder<WeighingDetailController>(builder: (controllers) {
      return ListView.separated(
        itemCount: controller.allDetailsList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  // _showBottomSheet();
                },
                child: Container(
                  height: height_120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            [graphBg1, graphBg2, graphBg3, graphBg4][index]),
                        fit: BoxFit.fill),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(radius_10),
                  ),
                  child: bellyDetails(controller.allDetailsList),
                ),
              ),
              Positioned(
                  top: height_5,
                  right: height_8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextView(
                          text: keyWeight.tr,
                          textStyle: textStyleBody2()
                              .copyWith(fontWeight: FontWeight.bold)),
                      TextView(
                          text: controller.weightList2.first.title!,
                          textStyle: textStyleBody2()
                              .copyWith(fontWeight: FontWeight.normal)),
                    ],
                  )),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: height_10,
          );
        },
      );
    });
  }

  _showWeightBottomSheet(list, text) {
    return Get.bottomSheet(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                // height: height_30,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius_20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                        text: text,
                        textStyle:
                            textStyleBody2().copyWith(color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: height_20,
                        ))
                  ],
                ).paddingOnly(left: margin_15),
              ),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_15),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      _customColumn(
                          title: text,
                          value: list[index].title!.toString() + " KG",
                          alignment: CrossAxisAlignment.start),
                      SizedBox(
                        width: width_20,
                      ),
                      _customColumn(
                          title: "Date",
                          value: list[index].date.toString().split(" ").first,
                          alignment: CrossAxisAlignment.start),
                      Spacer(),
                      /*AssetImageWidget(
                        imageUrl: iconEdit,
                        imageWidth: height_35,
                        imageHeight: height_35,
                      )*/
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: height_20,
                    color: Colors.grey.shade300,
                  );
                },
              ))
            ],
          ),
        ));
  }

  _showChestBottomSheet(List<AllDetailsList> list, text) {
    return Get.bottomSheet(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                // height: height_30,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius_20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                        text: text,
                        textStyle:
                            textStyleBody2().copyWith(color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: height_20,
                        ))
                  ],
                ).paddingOnly(left: margin_15),
              ),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_15),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      _customColumn(
                          title: text,
                          value: list[index].chestine!,
                          alignment: CrossAxisAlignment.start),
                      SizedBox(
                        width: width_20,
                      ),
                      _customColumn(
                          title: "Date",
                          value: list[index]
                              .dataEntryDate
                              .toString()
                              .split(" ")
                              .first,
                          alignment: CrossAxisAlignment.start),
                      Spacer(),
                      /*AssetImageWidget(
                        imageUrl: iconEdit,
                        imageWidth: height_35,
                        imageHeight: height_35,
                      )*/
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: height_20,
                    color: Colors.grey.shade300,
                  );
                },
              ))
            ],
          ),
        ));
  }

  _showBellyBottomSheet(List<AllDetailsList> list, text) {
    return Get.bottomSheet(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                // height: height_30,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius_20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                        text: text,
                        textStyle:
                            textStyleBody2().copyWith(color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: height_20,
                        ))
                  ],
                ).paddingOnly(left: margin_15),
              ),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_15),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      _customColumn(
                          title: text,
                          value: list[index].bellyline!,
                          alignment: CrossAxisAlignment.start),
                      SizedBox(
                        width: width_20,
                      ),
                      _customColumn(
                          title: "Date",
                          value: list[index]
                              .dataEntryDate
                              .toString()
                              .split(" ")
                              .first,
                          alignment: CrossAxisAlignment.start),
                      Spacer(),
                      /*AssetImageWidget(
                        imageUrl: iconEdit,
                        imageWidth: height_35,
                        imageHeight: height_35,
                      )*/
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: height_20,
                    color: Colors.grey.shade300,
                  );
                },
              ))
            ],
          ),
        ));
  }

  _showHipLineBottomSheet(List<AllDetailsList> list, text) {
    return Get.bottomSheet(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Container(
                // height: height_30,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(radius_20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                        text: text,
                        textStyle:
                            textStyleBody2().copyWith(color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: height_20,
                        ))
                  ],
                ).paddingOnly(left: margin_15),
              ),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_15, vertical: margin_15),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      _customColumn(
                          title: text,
                          value: list[index].hipline!,
                          alignment: CrossAxisAlignment.start),
                      SizedBox(
                        width: width_20,
                      ),
                      _customColumn(
                          title: "Date",
                          value: list[index]
                              .dataEntryDate
                              .toString()
                              .split(" ")
                              .first,
                          alignment: CrossAxisAlignment.start),
                      Spacer(),
                      /*AssetImageWidget(
                        imageUrl: iconEdit,
                        imageWidth: height_35,
                        imageHeight: height_35,
                      )*/
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: height_20,
                    color: Colors.grey.shade300,
                  );
                },
              ))
            ],
          ),
        ));
  }

  _customColumn({title, value, alignment}) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetImageWidget(
            imageUrl: title == "Weight" ? iconWeightMachine : iconCalender,
            imageHeight: height_25,
            imageWidth: height_25,
          ),
          SizedBox(
            width: width_5,
          ),
          Column(
            crossAxisAlignment: alignment,
            children: [
              TextView(text: title, textStyle: textStyleBody2()),
              TextView(
                  text: value,
                  textStyle: textStyleBody2().copyWith(
                      color: Colors.grey.shade600,
                      fontSize: font_12,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ],
      );

  _pictureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(text: keyPictureBefore.tr, textStyle: textStyleBody2())
            .paddingSymmetric(vertical: margin_10),
        loginDataModel != null
            ? SizedBox(
                height: height_80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imgWidget(
                      title: keyBack.tr,
                      networkImg: loginDataModel!.backImage!.first.url,
                    ),
                    loginDataModel!.sideImage!.isEmpty?emptySizeBox():
                    imgWidget(
                      title: keySide.tr,
                      networkImg: loginDataModel!.sideImage!.first.url,
                    ),
                    imgWidget(
                      title: keyBack.tr,
                      networkImg: loginDataModel!.frontImage!.first.url,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              ),
      ],
    );
  }
}

Widget imgWidget({networkImg, title}) {
  return DottedBorder(
    color: Colors.grey.shade400,
    strokeWidth: 1.5,
    dashPattern: [3, 3],
    radius: Radius.circular(radius_12),
    borderType: BorderType.RRect,
    child: GestureDetector(
      onTap: () {},
      child: Container(
        height: height_80,
        width: height_80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_12)),
        child: NetworkImageWidget(
          radiusAll: radius_12,
          imageFitType: BoxFit.contain,
          imageurl: networkImg ?? "",
          // placeHolder: iconUploadImg,
          placeHolderWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetImageWidget(
                imageUrl: iconUploadImg,
                imageHeight: height_25,
                imageWidth: height_25,
              ),
              SizedBox(
                height: height_4,
              ),
              TextView(
                  text: title ?? "",
                  textStyle: textStyleBody1()
                      .copyWith(color: Colors.black87, fontSize: font_12))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget weightDetails(List<WeightList> list) {
  List<_SalesData> data = [];
  // for (int i = 0; i < list.length; i++) {
  //   data.add(
  //     _SalesData(i, double.parse(list[i].title!)),
  //   );
  // }

  for (int i = list.length - 1; i >= 0; i--) {
    data.add(
      _SalesData(i, double.parse(list[i].title!)),
    );
  }

  return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false), // Hide X-axis
      primaryYAxis: NumericAxis(isVisible: false), // Hide Y-axis
      // backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      plotAreaBorderColor: Colors.transparent,
      series: <CartesianSeries>[
        SplineSeries<_SalesData, int>(
            dataSource: data,
            color: Colors.white,
            xValueMapper: (_SalesData data, _) => data.year,
            yValueMapper: (_SalesData data, _) => data.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ]);
}

Widget chestDetails(List<AllDetailsList> list) {
  List<_SalesData> data = [];
  // for (int i = 0; i < list.length; i++) {
  //   data.add(
  //     _SalesData(i, double.parse(list[i].title!)),
  //   );
  // }

  for (int i = list.length - 1; i >= 0; i--) {
    data.add(
      _SalesData(i, double.parse(list[i].chestine!)),
    );
  }

  return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false), // Hide X-axis
      primaryYAxis: NumericAxis(isVisible: false), // Hide Y-axis
      // backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      plotAreaBorderColor: Colors.transparent,
      series: <CartesianSeries>[
        SplineSeries<_SalesData, int>(
            dataSource: data,
            color: Colors.white,
            xValueMapper: (_SalesData data, _) => data.year,
            yValueMapper: (_SalesData data, _) => data.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ]);
}

Widget bellyDetails(List<AllDetailsList> list) {
  List<_SalesData> data = [];
  // for (int i = 0; i < list.length; i++) {
  //   data.add(
  //     _SalesData(i, double.parse(list[i].title!)),
  //   );
  // }

  for (int i = list.length - 1; i >= 0; i--) {
    data.add(
      _SalesData(i, double.parse(list[i].bellyline!)),
    );
  }

  return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false), // Hide X-axis
      primaryYAxis: NumericAxis(isVisible: false), // Hide Y-axis
      // backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      plotAreaBorderColor: Colors.transparent,
      series: <CartesianSeries>[
        SplineSeries<_SalesData, int>(
            dataSource: data,
            color: Colors.white,
            xValueMapper: (_SalesData data, _) => data.year,
            yValueMapper: (_SalesData data, _) => data.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ]);
}

Widget hipDetails(List<AllDetailsList> list) {
  List<_SalesData> data = [];
  // for (int i = 0; i < list.length; i++) {
  //   data.add(
  //     _SalesData(i, double.parse(list[i].title!)),
  //   );
  // }

  for (int i = list.length - 1; i >= 0; i--) {
    data.add(
      _SalesData(i, double.parse(list[i].hipline!)),
    );
  }

  return SfCartesianChart(
      primaryXAxis: CategoryAxis(isVisible: false), // Hide X-axis
      primaryYAxis: NumericAxis(isVisible: false), // Hide Y-axis
      // backgroundColor: Colors.transparent,
      // borderColor: Colors.transparent,
      plotAreaBorderColor: Colors.transparent,
      series: <CartesianSeries>[
        SplineSeries<_SalesData, int>(
            dataSource: data,
            color: Colors.white,
            xValueMapper: (_SalesData data, _) => data.year,
            yValueMapper: (_SalesData data, _) => data.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true))
      ]);
}

class CustomChart extends StatefulWidget {
  CustomChart({Key? key}) : super(key: key);

  @override
  CustomChartState createState() => CustomChartState();
}

class CustomChartState extends State<CustomChart> {
  List<_SalesData> data = [
    _SalesData(0, 65),
    _SalesData(1, 60),
    _SalesData(3, 20),
    _SalesData(4, 12),
    _SalesData(5, 20),
    _SalesData(7, 15),
  ];
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(isVisible: false), // Hide X-axis
        primaryYAxis: NumericAxis(isVisible: false), // Hide Y-axis
        // backgroundColor: Colors.transparent,
        // borderColor: Colors.transparent,
        plotAreaBorderColor: Colors.transparent,
        series: <CartesianSeries>[
          SplineSeries<_SalesData, int>(
              dataSource: data,
              color: Colors.white,
              xValueMapper: (_SalesData data, _) => data.year,
              yValueMapper: (_SalesData data, _) => data.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final int year;
  final double sales;
}
