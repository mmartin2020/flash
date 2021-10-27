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
  final List<Widget> list = List.generate(
      100,
      (index) => Center(
            child: Container(
              width: 340.0,
              height: 100.0,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: NetworkImage(''),
                      errorBuilder: (_, e, s) => Icon(Icons.image),
                      width: 50.0,
                      height: 50.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Titulo productos',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text(
                              '\$ Precio ',
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //details.discrement(
                                    // 'idProducts');
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    size: 19.0,
                                  ),
                                ),
                                //{details.counter}
                                Text('0',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  onPressed: () {
                                    //details.increment(
                                    // 'idProducts');
                                  },
                                  icon: Icon(Icons.add, size: 19.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close_outlined,
                          size: 16.0,
                        ))
                  ],
                ),
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed('/pay'),
          label: Text('Ir a pagar - Total: \$23.999',
              style: TextStyle(fontWeight: FontWeight.bold)),
          icon: Icon(Icons.payment_outlined),
        ),
        body: StreamBuilder(
          stream: stream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError)
              Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              final list = snapshot.data;
              print(list!["A03"][0]);
            }
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
                  Flexible(
                      child: ListView(
                    addAutomaticKeepAlives: false,
                    children: list,
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
