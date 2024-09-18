import 'package:get/get.dart';



class MyPlanController extends GetxController{
  String check = "";
@override
  void onInit() {
    // TODO: implement onInit
  if(Get.arguments!=null)
    {
      if(Get.arguments["check"]!=null)
        {
          check = Get.arguments["check"].toString();
          print(check);
        }

    }
    super.onInit();
  }

}