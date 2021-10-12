import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:log/Data/data.dart';
import 'package:log/account/Controllers/models/productModels.dart';

class Explore extends StatelessWidget {
  final productsRefs = FirebaseFirestore.instance
      .collection("Products")
      .withConverter<Products>(
          fromFirestore: (snap, _) => Products.fromWebServices(snap.data()!),
          toFirestore: (map, _) => map.mapToWebservices());
  List<ListTile> productslist = [];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          GestureDetector(
            onTap: () => Get.toNamed('/search'),
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.0, right: 150.0, bottom: 7.0, top: 7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.grey.withOpacity(0.2)),
              child: Row(children: [
                Icon(Icons.search),
                Text('Buscar...'),
              ]),
            ),
          ),
          ListTile(
            onTap: () {
              Get.bottomSheet(BottomSheet(
                  onClosing: () {
                    print('Closing');
                  },
                  builder: (_) => Container()));
            },
            dense: true,
            leading: Icon(Icons.add_location_alt),
            trailing: Icon(Icons.add),
            subtitle: Text('Dirección de despacho'),
            title: Text('Americo vespucio #0484'),
          ),
          SizedBox(height: 10.0),
          Flexible(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    // descubrir nuevas cosas
                    _textTitle(
                      'Descubrir cosas nuevas',
                      17.0,
                    ),
                    SizedBox(height: 20.0),
                    _listNuevasCosas(),
                    SizedBox(height: 10.0),
                    // Mas vendidos
                    _textTitle(
                        'Productos más vendidos', 17.0, fila('masVendido')),
                    SizedBox(height: 20.0),
                    _listMasVendidos(),

                    //  Variedad de productos
                    _textTitle(
                        'Variedades de productos', 17.0, fila('categoria')),
                    SizedBox(height: 20.0),
                    _listVariedades(),
                  ]),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  Widget _textTitle(String text, double _fontSize, [Widget? _showAll]) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text,
          style: TextStyle(
              color: Colors.black,
              fontSize: _fontSize,
              fontWeight: FontWeight.bold)),
      _showAll ?? Spacer(),
    ]);
  }

//lista nuevas cosas
  Widget _listNuevasCosas() {
    List descubrir = productos["descubrir"].toList();
    final long = descubrir.length;
    final rando = aletorio(long);
    Stream<QuerySnapshot> snap = productsRefs.snapshots();

    return Container(
      height: 240,
      child: //
          StreamBuilder(
              stream: snap,
              builder: (context, snapshot) {
                if (snapshot.hasData) print('Hay data en el snapshots');
                if (snapshot.hasError) print('Ha ocurido un error');
                if (snapshot.connectionState == ConnectionState.waiting)
                  print('cargando...');
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: descubrir.length,
                  itemBuilder: (BuildContext context, int index) {
                    String _txtDescripcionPoroductos =
                        descubrir[rando[index]]["subtitulo"];
                    String price = descubrir[rando[index]]["precio"];
                    String unidad = descubrir[rando[index]]["medida"];
                    String image = descubrir[rando[index]]["image"];
                    String titulo = descubrir[rando[index]]["titulo"];
                    String calif = descubrir[rando[index]]["calificacion"];
                    String califtotal =
                        descubrir[rando[index]]["clasificacion_total"];

                    return GestureDetector(
                        onTap: () {
                          Get.toNamed('/detailsproducts', arguments: {
                            'image': image,
                            'titulo': titulo,
                            'subtitulo': _txtDescripcionPoroductos,
                            'calif': calif,
                            'precio': price,
                            'califtotal': califtotal,
                            'medida': unidad
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Icon(
                                            Icons.image_not_supported_outlined,
                                            size: 150.0,
                                            color: Colors.grey[100],
                                          ),
                                      width: 130,
                                      height: 150,
                                      fit: BoxFit.contain,
                                      image: AssetImage(image)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(titulo,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13.0)),
                                ),
                                Container(
                                  child: Text(
                                      _txtDescripcionPoroductos.length > 40
                                          ? _txtDescripcionPoroductos.substring(
                                                  0, 37) +
                                              '...'
                                          : _txtDescripcionPoroductos,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          fontSize: 13.0)),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 15.0),
                                    Text(calif,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500)),
                                    Text('($califtotal Clasificación)',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Add to shoppingcart
                                    GestureDetector(
                                        onTap: () {
                                          productslist.add(ListTile(
                                              leading: Image.asset('$image'),
                                              title: Row(
                                                children: [
                                                  Text('$titulo'),
                                                  Text('$price')
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                      '$_txtDescripcionPoroductos'),
                                                  Text('$unidad')
                                                ],
                                              ),
                                              trailing: Icon(Icons
                                                  .closed_caption_disabled)));
                                          Get.snackbar(
                                              '', 'Agregado al carrito',
                                              backgroundColor: Colors.black,
                                              colorText: Colors.white,
                                              icon: Icon(Icons.verified_user,
                                                  color: Colors.green));

                                          print(productslist.length);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                bottom: 3.0,
                                                top: 3.0),
                                            child: Text(
                                              'Agregar al carro',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.0),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                    Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        '\$${price + ' ' + unidad}',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                );
              }),
    );
  }

// lista mas vendido
  Widget _listMasVendidos() {
    List masvendido = productos["masvendido"].toList();
    final long = 3;
    final rando = aletorio(long);

    return Container(
      height: 350,
      child: //
          ListView.separated(
        separatorBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          String image = masvendido[rando[index]]["image"];
          String titulo = masvendido[rando[index]]["titulo"];
          String subtitulo = masvendido[rando[index]]["subtitulo"];
          String calif = masvendido[rando[index]]["calificacion"];
          String precio = masvendido[rando[index]]["precio"];
          String califtotal = masvendido[rando[index]]["clasificacion_total"];
          String medida = masvendido[rando[index]]["medida"];

          return Container(
              child: ListTile(
                  onTap: () {
                    Get.toNamed('/detailsproducts', arguments: {
                      'image': image,
                      'titulo': titulo,
                      'subtitulo': subtitulo,
                      'calif': calif,
                      'precio': precio,
                      'califtotal': califtotal,
                      'medida': medida
                    });
                  },
                  contentPadding: EdgeInsets.all(15),
                  isThreeLine: true,
                  title: Text(titulo),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subtitulo),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 15.0),
                            Text(calif,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500)),
                            Text(' ($califtotal Clasificación)',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                '\$${precio + ' ' + medida}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  margin: EdgeInsets.only(left: 12.0),
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 3.0,
                                      top: 3.0),
                                  child: Text(
                                    'Agregar al carro',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11.0),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                      ]),
                  leading: Container(
                    child: Card(
                        elevation: 10.0,
                        child: Image.asset(
                          image,
                          width: 70,
                          height: 80,
                        )),
                  )));
        },
      ),
    );
  }

//fila mostrar todos
  Widget fila(String indicador) {
    return GestureDetector(
        onTap: () {
          Get.toNamed('/details/$indicador');
        },
        child: Row(
          children: [
            Text('Mostrar todos', style: TextStyle(fontSize: 12.0)),
            Icon(
              Icons.play_arrow_rounded,
              size: 12.0,
            )
          ],
        ));
  }

// variedad de productos
  Widget _listVariedades() {
    List abarrotes = productos["variedades"].toList();
    final long = abarrotes.length;
    final rando = aletorio(long);
    return Container(
      height: 120,
      child: //
          ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: abarrotes.length,
        itemBuilder: (BuildContext context, int index) {
          String image = abarrotes[rando[index]]["image"];
          String titulo = abarrotes[rando[index]]["titulo"];
          return Stack(alignment: Alignment.center, children: [
            Container(
              width: 250,
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                ),
              ),
            ),
            Container(
              child: Text(titulo,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
            ),
          ]);
        },
      ),
    );
  }

//aleatorio
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
}
