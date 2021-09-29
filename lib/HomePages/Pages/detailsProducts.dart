import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:log/Data/data.dart';

class Detailsproducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _txtDescripcionPoroductos = Get.arguments['subtitulo'];
    final _txtfieldcontroler = TextEditingController(text: '1');

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed('/home');
              },
              icon: Icon(Icons.close)),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Card(
                          elevation: 0.2,
                          child: Image(
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 150.0,
                                    color: Colors.grey[100],
                                  ),
                              width: 150,
                              height: 200,
                              fit: BoxFit.contain,
                              image: AssetImage(Get.arguments['image'])),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(Get.arguments['titulo'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.0)),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text(
                              _txtDescripcionPoroductos.length > 40
                                  ? _txtDescripcionPoroductos.substring(0, 37) +
                                      '...'
                                  : _txtDescripcionPoroductos,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 14.0)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 15.0),
                          Text(Get.arguments['calif'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500)),
                          Text('(${Get.arguments['califtotal']} Clasificación)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    child: IconButton(
                                        constraints:
                                            BoxConstraints(maxHeight: 30.0),
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove,
                                        ))),
                                VerticalDivider(
                                  color: Colors.grey,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 20.0, maxHeight: 5.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: _txtfieldcontroler,
                                    decoration: InputDecoration(

                                        // constraints: BoxConstraints(
                                        //     maxWidth: 20.0, maxHeight: 5.0),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey))),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Colors.grey,
                                ),
                                Container(
                                    child: IconButton(
                                        constraints:
                                            BoxConstraints(maxHeight: 30.0),
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add,
                                        ))),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Text(
                              '\$${Get.arguments['precio'] + ' ' + Get.arguments['medida']}',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton.icon(
                        icon: Row(
                          children: [Icon(Icons.shopping_cart_outlined)],
                        ),
                        label: Text('Ir al carro'),
                        onPressed: () => Get.offAllNamed('/home'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('Recomendado para ti',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),

                //lista de recomendaciones
                listRecomendado(),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ));
  }
}

// list recomendado
Widget listRecomendado() {
  List recomendado = productos["recomendado"].toList();
  var long;
  if (recomendado.length < 5 && recomendado.length > 0) {
    long = recomendado.length;
  } else if (recomendado.length == 0) {
    long = 0;
  } else {
    long = 5;
  }
  final rando = aletorio(long);
  return Flexible(
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) {
        String image = recomendado[rando[index]]["image"];
        String titulo = recomendado[rando[index]]["titulo"];
        String subtitulo = recomendado[rando[index]]["subtitulo"];
        String calif = recomendado[rando[index]]["calificacion"];
        String precio = recomendado[rando[index]]["precio"];
        String califtotal = recomendado[rando[index]]["clasificacion_total"];
        String medida = recomendado[rando[index]]["medida"];

        return GestureDetector(
          onTap: () {
            // Navigator.pushReplacementNamed(_, '/Detailsproducts', arguments: {
            //   'image': image,
            //   'titulo': titulo,
            //   'subtitulo': subtitulo,
            //   'calif': calif,
            //   'precio': precio,
            //   'califtotal': califtotal,
            //   'medida': medida
            // });
            Get.appUpdate();
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 130.0, top: 10.0, left: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(children: [
                  Image(
                      errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.image_not_supported_outlined,
                            size: 50.0,
                            color: Colors.grey[100],
                          ),
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      image: AssetImage(image)),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(titulo,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 11.0)),
                  ),
                  Container(
                    child: Text(
                        subtitulo.length > 40
                            ? subtitulo.substring(0, 37) + '...'
                            : subtitulo,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 11.0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 11.0),
                      Text(calif,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500)),
                      Text('($califtotal Clasificación)',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text(precio + ' ' + medida,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
    ),
  );
}

aletorio(int longitud) {
  var random = new Random.secure();
  var i = 0;
  List<int> lista = List.filled(longitud, 0);
  lista[0] = random.nextInt(longitud);
  while (i < longitud - 1) {
    var na = random.nextInt(longitud);
    var j = 0;
    var r = 0;
    while (j <= i) {
      if (lista[j] == na) {
        r++;
      }
      j++;
    }
    if (r == 0) {
      i++;
      lista[i] = na;
    }
  }
  return lista;
}
