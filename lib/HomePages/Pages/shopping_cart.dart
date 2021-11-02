import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/models/ProductsList.dart';

class ShoppingCart extends StatelessWidget {
  final details = Get.put(ProductsList());

  final Stream<DocumentSnapshot> stream = FirebaseFirestore.instance
      .collection('cartshopping')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  final List<String> code = [
    "A01",
    "A02",
    "A03",
    "A04",
    "A05",
    "A06",
    "A07",
    "A08",
    "A09",
    "A010",
    "A012",
    "A013",
    "A014",
    "A015",
    "A016",
    "A017",
    "A018",
    "A019",
    "A020",
    "A021",
    "A022"
  ];
  final List<Map<String, dynamic>> supercero = [];

  @override
  Widget build(BuildContext context) {
    var total = 0;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed('/pay'),
          label: Text('Ir a pagar ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          icon: Icon(Icons.payment_outlined),
        ),
        body: Container(
          child: StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              bool state = true;
              if (snapshot.hasError)
                Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.connectionState == ConnectionState.waiting)
                Center(
                  child: CircularProgressIndicator(),
                );

              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                final service = snapshot.data;
                code.forEach((element) {
                  if (service[element][0] > 0) {
                    supercero.add({
                      'count': service[element][0],
                      'name': service[element][2],
                      'price': service[element][3],
                      'image': service[element][4],
                      'id': element,
                    });
                    state = false;
                  }
                });

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            'Carrito de compra',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18.0),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      state
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.info,
                                      size: 40, color: Colors.grey),
                                  Text(
                                      'No se ha encontrado información para mostrar',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.grey))
                                ],
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: supercero.length,
                                itemBuilder: (BuildContext context, int index) {
                                  total = (supercero[index]["count"] *
                                          supercero[index]["price"]) +
                                      total;
                                  return component(
                                      supercero[index]["id"],
                                      supercero[index]["name"],
                                      supercero[index]["price"],
                                      supercero[index]["image"],
                                      supercero[index]["count"]);
                                },
                              ),
                            ),
                    ],
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget component(
      String id, String title, String price, String image, int count) {
    return Center(
      child: Container(
        width: 340.0,
        height: 100.0,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage(image),
                errorBuilder: (_, e, s) => Icon(Icons.image),
                width: 50.0,
                height: 50.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '$count X    \$ $price ',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         details.discrement(id, image, title, price);
                      //       },
                      //       icon: Icon(
                      //         Icons.remove,
                      //         size: 19.0,
                      //       ),
                      //     ),
                      //     Text('$count',
                      //         style: TextStyle(
                      //             fontSize: 16.0, fontWeight: FontWeight.bold)),
                      //     IconButton(
                      //       onPressed: () {
                      //         details.increment(id, image, title, price);
                      //       },
                      //       icon: Icon(Icons.add, size: 19.0),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('cartshopping')
                        .doc('OIUlHx3qVZZa2TIcCJAbs3NFiRg1')
                        .update({
                      id: [0, false, title, price, image]
                    });
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    size: 16.0,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
