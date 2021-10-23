import 'package:get/get.dart';

class ShopController extends GetxController {
  ShopController({
    this.name,
    this.image,
    this.categoria,
    this.id,
    this.hra,
    this.outstanding,

  });

  ShopController.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          image: json['image']! as String,
          categoria: json['categoria']! as String,
          id: json['id']! as String,
          hra: json['hra']! as String,
          outstanding: json['outstanding']! as bool,
        );

  final String? name;
  final String? image;
  final String? categoria;
  final String? id;
  final String? hra;
  final bool? outstanding;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'image': image,
      'categoria': categoria,
      'id': id,
      'hra': hra,
      'outstanding': outstanding,
    };
  }
}
