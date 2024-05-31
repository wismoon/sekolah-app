import 'package:get/get.dart';

class TagihanController extends GetxController {
  var showAdditionalButtons = false.obs;

  // Method to toggle the visibility
  void toggleButtons() {
    showAdditionalButtons.value = !showAdditionalButtons.value;
  }
  
  void hideButtons() {
    showAdditionalButtons.value = false;
  }
}
