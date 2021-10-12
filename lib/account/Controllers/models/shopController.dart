import 'package:cloud_firestore/cloud_firestore.dart';
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


  

Future<List?> getShop() async {
final shopRef = FirebaseFirestore.instance
    .collection('shop')
    .withConverter<ShopController>(
      fromFirestore: (snapshots, _) => ShopController.fromJson(snapshots.data()!),
      toFirestore: (shop, _) => shop.toJson(),
    );

    shopRef.snapshots().listen((event) {
      
     
     
    });
}
 

}

