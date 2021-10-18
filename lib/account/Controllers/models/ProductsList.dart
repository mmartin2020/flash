import 'package:get/get.dart';

class ProductsList extends GetxController {
 
  var counter = 0.obs;
  var favorito = true.obs;

  void increment(String x,String doc) {


    counter++;

    update();
  }

  void discrement(String x,String doc) {
    if (counter > 0) counter--;
    print(x);
    update();
  }

  void favorite(){
if(favorito == true){favorito = false.obs;}else{favorito = true.obs;}
update();
  }


  

}
