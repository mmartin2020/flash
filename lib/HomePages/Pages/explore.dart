import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/HomePages/Pages/home.dart';
import 'package:log/account/Controllers/models/ProductsList.dart';

class Explore extends GetWidget<ProductsList> {
  final User? user = FirebaseAuth.instance.currentUser;

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
            trailing: Icon(Icons.arrow_drop_down_outlined),
            subtitle: Text('Dirección de despacho'),
            title: Text('Americo vespucio #0484'),
          ),
          SizedBox(height: 10.0),
          Flexible(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 8.0),
                    _listVariedades(),
                    SizedBox(height: 8.0),
                    // descubrir nuevas cosas
                    _textTitle(
                      'Productos destacados',
                      17.0,
                    ),
                    SizedBox(height: 20.0),
                    _listNuevasCosas(),
                    SizedBox(height: 10.0),
                    // Mas vendidos
                    _textTitle('Más productos', 17.0),
                    SizedBox(height: 20.0),
                    _listMasVendidos(),
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
      height: 270,
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
                      String calif = elements[rando[index]]["calificacion"];
                      String califtotal =
                          elements[rando[index]]["clasificacion_total"];
                      String idProducts = elements[rando[index]]["idproducts"];

                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("cartshopping")
                              .doc(user!.uid)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snap) {
                            if (snap.hasError) {
                              return Container(
                                  child: Center(
                                      child: Text('Se produjo un error')));
                            }
                            if (snap.connectionState == ConnectionState.waiting)
                              Container(
                                  child: Center(child: Text('Cargando...')));
                            if (snap.connectionState ==
                                ConnectionState.active) {
                              if (snap.hasData) {
                                final result = snap.requireData;
                                int count = result[idProducts][0];

                                return GestureDetector(
                                    onTap: () {
                                      details.InitialState(count.obs);
                                      Get.bottomSheet(
                                        Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .only(
                                                              topStart: Radius
                                                                  .circular(20),
                                                              topEnd: Radius
                                                                  .circular(
                                                                      20))),
                                              height: 400.0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Hero(
                                                        transitionOnUserGestures:
                                                            true,
                                                        tag: 'parent_img',
                                                        child: Image(
                                                          width: 200,
                                                          height: 200,
                                                          alignment:
                                                              Alignment.center,
                                                          image: AssetImage(
                                                              '$image'),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 100.0,
                                                          height: 120.0,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  '$titulo',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(Icons.star,
                                                                    size: 16.0,
                                                                    color: Colors
                                                                        .yellow),
                                                                Text(
                                                                  '$calif Calificaciones',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    details.discrement(
                                                                        idProducts,image,titulo);
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 19.0,
                                                                  ),
                                                                ),
                                                                GetX<ProductsList>(
                                                                    builder:
                                                                        (context) {
                                                                  return Text(
                                                                      '${details.counter}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19.0,
                                                                          fontWeight:
                                                                              FontWeight.bold));
                                                                }),
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    details.increment(
                                                                        idProducts,image,titulo);
                                                                  },
                                                                  icon: Icon(
                                                                      Icons.add,
                                                                      size:
                                                                          19.0),
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
                                                                builder:
                                                                    (context) =>
                                                                        Home(
                                                                            2)));
                                                      },
                                                      child: Container(
                                                        width: 300.0,
                                                        height: 55.0,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .shopping_bag,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .white38,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10.0),
                                                                    child:
                                                                        VerticalDivider(
                                                                      color: Colors
                                                                          .white38,
                                                                      width:
                                                                          10.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Agregar y ir al carrito',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_sharp,
                                                                      size:
                                                                          12.0,
                                                                      color: Colors
                                                                          .white54)
                                                                ],
                                                              ),
                                                              GetX<ProductsList>(
                                                                  builder:
                                                                      (context) {
                                                                return Text(
                                                                  'Total: ${numberFormat(details.counter * double.parse(elements[rando[index]]["precio"]))}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                            //favorito
                                            Positioned(
                                                top: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  child: IconButton(
                                                    icon: result[idProducts][1]
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color: Colors
                                                                .deepOrange,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_outline_outlined,
                                                          ),
                                                    onPressed: () {
                                                      details.favorite(
                                                        idProducts,
                                                      );
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // image productos

                                                Container(
                                                  child: Hero(
                                                    transitionOnUserGestures:
                                                        true,
                                                    tag: 'parent_img',
                                                    child: Image(
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Icon(
                                                              Icons
                                                                  .image_not_supported_outlined,
                                                              size: 150.0,
                                                              color: Colors
                                                                  .grey[100],
                                                            ),
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.contain,
                                                        image:
                                                            AssetImage(image)),
                                                  ),
                                                ),

                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Text(titulo,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 13.0)),
                                                ),
                                                Container(
                                                  child: Text(
                                                      _txtDescripcionPoroductos
                                                                  .length >
                                                              40
                                                          ? _txtDescripcionPoroductos
                                                                  .substring(
                                                                      0, 25) +
                                                              '...'
                                                          : _txtDescripcionPoroductos,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey,
                                                          fontSize: 13.0)),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.yellow,
                                                        size: 15.0),
                                                    Text(calif,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                        '($califtotal Clasificación)',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                // Price
                                                SizedBox(height: 8.0),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Text(
                                                    '\$${price + ' ' + unidad}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(height: 8.0),
                                                // Add to shoppingcart
                                                GestureDetector(
                                                    onTap: () {
                                                      details.increment(
                                                          idProducts,image,titulo);
                                                      Get.snackbar('Carrito ',
                                                          'Producto agregado al carrito',
                                                          backgroundColor:
                                                              Colors.grey[700],
                                                          colorText:
                                                              Colors.white,
                                                          icon: Icon(
                                                              Icons
                                                                  .verified_user,
                                                              color: Colors
                                                                  .green));
                                                    },
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                bottom: 3.0,
                                                                top: 3.0),
                                                        child: Text(
                                                          'Agregar al carro',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11.0),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (result[idProducts][0] > 0)
                                          Positioned(
                                              top: 0.0,
                                              right: 0.0,
                                              child: Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                child: Text(
                                                  '${result[idProducts][0]}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                      ],
                                    ));
                              } else {
                                return Text('');
                              }
                            } else {
                              return Center(child: Text(''));
                            }
                          });
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
                  String idProducts = elements[rando[index]]["idproducts"];
                  final fbsCartShopping = FirebaseFirestore.instance
                      .collection("cartshopping")
                      .doc(user!.uid);

                  return Container(
                      child: ListTile(
                          onTap: () {
                            Get.bottomSheet(
                              StreamBuilder(
                                  stream: fbsCartShopping.snapshots(),
                                  builder: (context, AsyncSnapshot snp) {
                                    if (snp.hasData) {
                                      final result = snp.requireData;
                                      int count = result[idProducts][0];
                                      details.InitialState(count.obs);

                                      return Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                            topStart:
                                                                Radius.circular(
                                                                    20),
                                                            topEnd:
                                                                Radius.circular(
                                                                    20))),
                                            height: 400.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Image(
                                                      width: 200,
                                                      height: 200,
                                                      alignment:
                                                          Alignment.center,
                                                      image:
                                                          AssetImage('$image'),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 100.0,
                                                        height: 120.0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                '$titulo',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                  '$subtitulo'),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$$price',
                                                        style: TextStyle(
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(Icons.star,
                                                                  size: 16.0,
                                                                  color: Colors
                                                                      .yellow),
                                                              Text(
                                                                '$calif Calificaciones',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                                  details.discrement(
                                                                      idProducts,image,titulo);
                                                                },
                                                                icon: Icon(
                                                                  Icons.remove,
                                                                  size: 19.0,
                                                                ),
                                                              ),
                                                              GetX<ProductsList>(
                                                                  builder:
                                                                      (context) {
                                                                return Text(
                                                                    '${details.counter}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            19.0,
                                                                        fontWeight:
                                                                            FontWeight.bold));
                                                              }),
                                                              IconButton(
                                                                onPressed: () {
                                                                  details.increment(
                                                                      idProducts,image,titulo);
                                                                },
                                                                icon: Icon(
                                                                    Icons.add,
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
                                                              builder:
                                                                  (context) =>
                                                                      Home(2)));
                                                    },
                                                    child: Container(
                                                      width: 300.0,
                                                      height: 55.0,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .shopping_bag,
                                                                  size: 30,
                                                                  color: Colors
                                                                      .white38,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10.0),
                                                                  child:
                                                                      VerticalDivider(
                                                                    color: Colors
                                                                        .white38,
                                                                    width: 10.0,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Agregar y ir al carrito',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Icon(
                                                                    Icons
                                                                        .arrow_forward_ios_sharp,
                                                                    size: 12.0,
                                                                    color: Colors
                                                                        .white54)
                                                              ],
                                                            ),
                                                            GetX<ProductsList>(
                                                                builder:
                                                                    (context) {
                                                              return Text(
                                                                'Total: ${numberFormat(details.counter * double.parse(elements[rando[index]]["precio"]))}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                          Positioned(
                                            top: 1.0,
                                            right: 1.0,
                                            child: Container(
                                              child: GetBuilder<ProductsList>(
                                                  builder: (con) {
                                                return IconButton(
                                                    onPressed: () {
                                                      con.favorito.toggle();
                                                    },
                                                    icon: con.favorito == true
                                                        ? Icon(Icons
                                                            .favorite_border)
                                                        : Icon(Icons
                                                            .favorite_border));
                                              }),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else
                                      return CircularProgressIndicator();
                                  }),
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
                                      onTap: () {
                                        details.increment(idProducts,image,titulo);
                                        Get.snackbar('Carrito ',
                                            'Producto agregado al carrito',
                                            backgroundColor: Colors.grey[700],
                                            colorText: Colors.white,
                                            icon: Icon(Icons.verified_user,
                                                color: Colors.green));
                                      },
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
                          leading:  Card(
                                elevation: 0.0,
                                child: Image.asset(
                                  image,
                                  width: 70,
                                  height: 80,
                                )),
                          ));
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
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
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
