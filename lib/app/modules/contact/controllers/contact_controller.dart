import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/translations/local_keys.dart';

class ContactController extends GetxController {
  EmojiData? emojiData;
  RxString selectedEmoji = ''.obs;
  RxList<String> contactList = <String>[].obs;
  TextEditingController emojiController = TextEditingController();

  @override
  void onInit() {
    addData();
    super.onInit();
  }

  RxString profileImage = "".obs;

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImage.value = file.path;
    }
  }

  addData() {
    contactList.add(keyChatCoach.tr);
    contactList.add(keyTechnicalHelp.tr);
    // contactList.add(keyServiceEnquiry.tr);
    contactList.refresh();
  }
}
