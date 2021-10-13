import 'package:get/get.dart';

class ProductsList extends GetxController {
  // List<ListTile> prductsListTile.obs;
  var counter = 0.obs;

  void increment() {
    counter++;
    update();
  }

  void discrement() {
    if (counter > 0) counter--;
    update();
  }
}
