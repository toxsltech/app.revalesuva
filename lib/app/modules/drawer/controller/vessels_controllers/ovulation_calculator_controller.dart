import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../export.dart';
import '../../../../core/values/validator.dart';
import '../../models/response_model/ovulation_cycle_response_model.dart';

class OvulationCalculatorController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    // hitGetOvulationDetailsApiCall();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    hitGetOvulationDetailsApiCall();
    super.onReady();
  }

  final formGlobalKey = GlobalKey<FormState>();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxBool dateSelected = false.obs;

  TextEditingController ovulationCycleDateController = TextEditingController();
  TextEditingController ovulationCycleController = TextEditingController();
  DateRangePickerController dateController = DateRangePickerController();
  DateRangePickerController ovulationDateController =
      DateRangePickerController();

  Widget bottomSheet() {
    return GetBuilder<OvulationCalculatorController>(
      builder: (controller) {
        return Container(
          height: Get.height,
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
                        text: keyAddOvulation.tr,
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
              Form(
                key: formGlobalKey,
                child: Expanded(
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: margin_10),
                    children: [
                      TextFieldWidget(
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                        labelText: keyOvulationCycle.tr,
                        labelMargin: margin_3,
                        hint: keySelectDate.tr,
                        decoration: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius_20),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        isOutlined: true,
                        // maxLength: 3,
                        inputFormatter: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^0+'),
                          ),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black26, fontWeight: FontWeight.w500),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: margin_10, horizontal: margin_15),
                        textController: ovulationCycleDateController,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        validate: (value) => Validator.ValidateFields(value,
                        message: keyOvulationCycle.tr),
                      ),
                      TextFieldWidget(
                        labelText: keyOvulationAverage.tr,
                        // labelText: "ביוץ ביום מחזור ממוצע".tr,
                        labelMargin: margin_3,
                        hint: '12',
                        decoration: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius_20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        isOutlined: true,
                        maxLength: 2,
                        inputFormatter: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r'^0+'),
                          ),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintStyle: textStyleBodyMedium().copyWith(
                            color: Colors.black26, fontWeight: FontWeight.w500),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: margin_10, horizontal: margin_15),
                        textController: ovulationCycleController,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        validate: (value) =>
                            Validator.validateOvulationDayFields(value,
                                message: keyOvulationAverage.tr),
                                // message: "ביוץ ביום מחזור ממוצע".tr),
                      ),
                      _addButton().marginOnly(top: margin_10)
                    ],
                  ).marginAll(margin_20),
                ),
              ),
            ],
          ).marginOnly(bottom: margin_15),
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.overlayContext!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      debugPrint(selectedDate.value.toString());
      ovulationCycleDateController.text =
          selectedDate.value.toString().split(" ").first;
      dateSelected.value = true;
      update();
    }
  }

  Widget _addButton({onTap, title}) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButtonWidget(
        onPressed: onTap ??
            () {
              if (formGlobalKey.currentState!.validate()) {
                hitAddOvulationApiCall();
              }
            },
        //buttonRadius: radius_20,
        minWidth: Get.width * 0.25,
        padding: margin_8,
        minHeight: 50,
        buttonText: title ?? keyAdd.tr,
        buttonColor: Colors.grey.shade800,
      ),
    );
  }

  List weekDay = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  OvulationCycleListResponseModel ovulationResponseModel =
      OvulationCycleListResponseModel();
  RxList<ListElement> ovulationCycleList = <ListElement>[].obs;
  List<DateTime> selectedDates = [];
  List<DateTime> ovulationSelectedDates = [];

  hitAddOvulationApiCall() {
    var reqBody = AuthRequestModel.addOvulationTimings(
      ovulationCycleDate: ovulationCycleDateController.text,
      ovulationAvgCycleDay: ovulationCycleController.text,
    );
    // customLoader.show(Get.overlayContext);
    APIRepository()
        .addOvulationApiCall(dataBody: reqBody, typeId: 1)
        .then((value) {
      if (value != null) {
        MessageResponseModel messageResponseModel = MessageResponseModel();
        messageResponseModel = value;
        hitGetOvulationDetailsApiCall();
        ovulationCycleController.clear();
        ovulationCycleDateController.clear();
        Get.back();
        // toast(messageResponseModel.message);
        update();
        // customLoader.hide();
      }
      // customLoader.hide();
    }).onError((error, stackTrace) {
      toast(error.toString());
      // customLoader.hide();
      debugPrint(
        "Error:::::${error.toString()}",
      );
      debugPrint(
        "Stack:::::$stackTrace",
      );
    });
  }

  hitGetOvulationDetailsApiCall() {
    selectedDates.clear();
    ovulationCycleList.clear();
    APIRepository().getOvulationCycleList().then(
      (value) {
        if (value != null) {
          ovulationResponseModel = value;
          ovulationCycleList.value.addAll(ovulationResponseModel.list!);
          for (int i = 0; i < ovulationCycleList.value.length; i++) {
            selectedDates.add(ovulationCycleList.value[i].nextDate!);
            ovulationSelectedDates
                .add(ovulationCycleList.value[i].ovalutionDate!);
          }
          debugPrint(selectedDates.toString());
          if (ovulationCycleList.value.isEmpty) {
            Get.bottomSheet(bottomSheet());
          }
          dateController.selectedDate = DateTime.now();

          dateController.notifyPropertyChangedListeners('selectedDate');
          update();
        }
      },
    ).onError(
      (error, stackTrace) {
        customLoader.hide();
        debugPrint("Error::::: $error");
        debugPrint("Stacktrace::::: $stackTrace");
      },
    );
  }
}
