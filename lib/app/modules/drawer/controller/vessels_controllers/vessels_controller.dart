import '../../../../../export.dart';

class VesselsScreenController extends GetxController {
  @override
  void onInit() {
    getPlanType();
    // TODO: implement onInit
    super.onInit();
  }

  RxString planType = ''.obs;

  getPlanType() async {
    planType.value = await PreferenceManger().getPlanType();
    planType.refresh();
    debugPrint("Plan Type::::: ${planType.value}");
  }
}
