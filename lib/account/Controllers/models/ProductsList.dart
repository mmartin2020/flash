import 'package:get/get.dart';
import 'package:log/account/Controllers/models/productModels.dart';

class ProductsList extends GetxController {
  ProductsList({this.productsList});

  ProductsList.formWebServices(Map<String, dynamic> toWS) : this();

  List<Products>? productsList;
}
