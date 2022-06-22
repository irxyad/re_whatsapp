import 'package:get/state_manager.dart';

class BottomNavbar extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
