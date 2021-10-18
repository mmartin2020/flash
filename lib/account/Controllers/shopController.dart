
import 'package:get/get.dart';

class ShopController extends  GetxController{

  ShopController({
   this.name,
   this.image,
  });

  ShopController.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          image: json['image']! as String,
          
        );

  final String? name;
  final String? image;


  Map<String, Object?> toJson() {
    return {
      'name': name,
      'image': image,
    
    };



   
  }


  

 

}

