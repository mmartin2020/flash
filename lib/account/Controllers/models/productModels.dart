import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Products extends GetxController {
  Products(
      {this.idproducts,
      this.titulo,
      this.subtitulo,
      this.image,
      this.calificacion,
      this.clasificacion_total,
      this.precio,
      this.medida,
      this.marca});

  Products.fromWebServices(Map<String, dynamic> json)
      : this(
            idproducts: json['idproducts'] as String,
            titulo: json['titulo'] as String,
            subtitulo: json['subtitulo'] as String,
            image: json['image'] as String,
            calificacion: json['calificacion'] as String,
            clasificacion_total: json['clasificacion_total'] as String,
            precio: json['precio'] as String,
            medida: json['medida'] as String,
            marca: json['marca'] as String);

  Map<String, dynamic> mapToWebservices() {
    return {
      'idproducts': idproducts,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'image': image,
      'calificacion': calificacion,
      'clasificacion_total': clasificacion_total,
      'precio': precio,
      'medida': medida,
      'marca': marca
    };
  }

  String? idproducts;
  String? titulo;
  String? subtitulo;
  String? image;
  String? calificacion;
  String? clasificacion_total;
  String? precio;
  String? medida;
  String? marca;
}
