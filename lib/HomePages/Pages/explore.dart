import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/HomePages/Pages/home.dart';
import 'package:log/account/Controllers/models/ProductsList.dart';

class Explore extends GetWidget<ProductsList> {
  final List<ListTile> productslist = [];

  final indexo = 3;
  final details = Get.put(ProductsList());
  @override
  Widget build(BuildContext context) {
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
              Get.bottomSheet(Container());
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
    return Container(
      height: 240,
      child: //
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) Text('Ha ocurido un error');
                if (snapshot.connectionState == ConnectionState.waiting)
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  );

                if (snapshot.hasData) {
                  final data = snapshot.requireData;
                  List elements = data.docs.elementAt(0)["descubrir"].toList();
                  final long = elements.length;
                  final rando = aletorio(long);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: elements.length,
                    itemBuilder: (BuildContext context, int index) {
                      String _txtDescripcionPoroductos =
                          elements[index]["subtitulo"];
                      String price =
                          numberFormat(elements[rando[index]]["precio"]);
                      String unidad = elements[rando[index]]["medida"];
                      String image = elements[rando[index]]["image"];
                      String titulo = elements[rando[index]]["titulo"];
                      String calif =
                          elements[rando[index]]["calificacion"].trim();
                      String califtotal =
                          elements[index]["clasificacion_total"].trim();

                      return GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(20),
                                        topEnd: Radius.circular(20))),
                                height: 400.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image(
                                          width: 200,
                                          height: 200,
                                          alignment: Alignment.center,
                                          image: AssetImage('$image'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100.0,
                                            height: 120.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '$titulo',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      '$_txtDescripcionPoroductos'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '\$$price',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      size: 16.0,
                                                      color: Colors.yellow),
                                                  Text(
                                                    '$calif Calificaciones',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      details.discrement();
                                                      print(details.counter);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                  GetX<ProductsList>(
                                                      builder: (context) {
                                                    return Text(
                                                        '${details.counter}',
                                                        style: TextStyle(
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold));
                                                  }),
                                                  IconButton(
                                                    onPressed: () {
                                                      details.increment();
                                                      print(details.counter);
                                                    },
                                                    icon: Icon(Icons.add,
                                                        size: 19.0),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home(2)));
                                        },
                                        child: Container(
                                          width: 300.0,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 30,
                                                      color: Colors.white38,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: VerticalDivider(
                                                        color: Colors.white38,
                                                        width: 10.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Agregar y ir al carrito',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        size: 12.0,
                                                        color: Colors.white54)
                                                  ],
                                                ),
                                                GetX<ProductsList>(
                                                    builder: (context) {
                                                  return Text(
                                                    'Total: ${numberFormat(details.counter * double.parse(elements[rando[index]]["precio"]))}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
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
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                                  Icons
                                                      .image_not_supported_outlined,
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
                                            ? _txtDescripcionPoroductos
                                                    .substring(0, 37) +
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
                                                      BorderRadius.circular(
                                                          20.0),
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
                } else {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              }),
    );
  }

// lista mas vendido
  Widget _listMasVendidos() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) Text('Ha ocurido un error');
          if (snapshot.connectionState == ConnectionState.waiting)
            Center(
              child: CircularProgressIndicator.adaptive(),
            );
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            List elements = data.docs.elementAt(0)["masvendido"].toList();
            final long = elements.length;
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
                  String image = elements[rando[index]]["image"];
                  String titulo = elements[rando[index]]["titulo"];
                  String subtitulo = elements[rando[index]]["subtitulo"];
                  String calif = elements[rando[index]]["calificacion"];
                  String price = numberFormat(elements[rando[index]]["precio"]);
                  String califtotal =
                      elements[rando[index]]["clasificacion_total"];
                  String medida = elements[rando[index]]["medida"];

                  return Container(
                      child: ListTile(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(20),
                                        topEnd: Radius.circular(20))),
                                height: 400.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image(
                                          width: 200,
                                          height: 200,
                                          alignment: Alignment.center,
                                          image: AssetImage('$image'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100.0,
                                            height: 120.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '$titulo',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text('$subtitulo'),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '\$$price',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      size: 16.0,
                                                      color: Colors.yellow),
                                                  Text(
                                                    '$calif Calificaciones',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      details.discrement();
                                                      print(details.counter);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      size: 19.0,
                                                    ),
                                                  ),
                                                  GetX<ProductsList>(
                                                      builder: (context) {
                                                    return Text(
                                                        '${details.counter}',
                                                        style: TextStyle(
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold));
                                                  }),
                                                  IconButton(
                                                    onPressed: () {
                                                      details.increment();
                                                      print(details.counter);
                                                    },
                                                    icon: Icon(Icons.add,
                                                        size: 19.0),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home(2)));
                                        },
                                        child: Container(
                                          width: 300.0,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      size: 30,
                                                      color: Colors.white38,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: VerticalDivider(
                                                        color: Colors.white38,
                                                        width: 10.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Agregar y ir al carrito',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .arrow_forward_ios_sharp,
                                                        size: 12.0,
                                                        color: Colors.white54)
                                                  ],
                                                ),
                                                GetX<ProductsList>(
                                                    builder: (context) {
                                                  return Text(
                                                    'Total: ${numberFormat(details.counter * double.parse(elements[rando[index]]["precio"]))}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
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
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 15.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        '\$${price + ' ' + medida}',
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
                                                color: Colors.white,
                                                fontSize: 11.0),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Theme.of(context)
                                                  .primaryColor)),
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
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) Text('Ha ocurido un error');
          if (snapshot.connectionState == ConnectionState.waiting)
            Center(
              child: CircularProgressIndicator.adaptive(),
            );
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            List elements = data.docs.elementAt(0)["variedades"].toList();
            final long = elements.length;
            final rando = aletorio(long);
            return Container(
              height: 120,
              child: //
                  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: elements.length,
                itemBuilder: (BuildContext context, int index) {
                  String image = elements[rando[index]]["image"];
                  String titulo = elements[rando[index]]["titulo"];
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
          } else {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
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

  String numberFormat(x) {
    List<String> parts = x.toString().split('.');
    RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(re, '.');
    if (parts.length == 1) {
      parts.add('00');
    } else {
      parts[1] = parts[1].padRight(2, '0').substring(0, 2);
    }
    return parts.join(',');
  }
}
