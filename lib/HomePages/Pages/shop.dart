import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/models/shopController.dart';

class Shop extends StatelessWidget {
  final shopRef = FirebaseFirestore.instance
      .collection('shop')
      .withConverter<ShopController>(
        fromFirestore: (snapshots, _) =>
            ShopController.fromJson(snapshots.data()!),
        toFirestore: (shop, _) => shop.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> shop = shopRef.snapshots();

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: shop,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(child: Text('Error para cargar información'));
              if (snapshot.connectionState == ConnectionState.waiting)
                Center(child: CircularProgressIndicator());

              final data = snapshot.requireData;

              return GridView.builder(
                  itemCount: data.size,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, i) {
                    final name = data.docs[i]['name'];
                    final image = data.docs[i]['image'];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/shopview', arguments: {
                          'name': data.docs[i]["name"],
                          'image': data.docs[i]["image"]
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                            child: Container(
                                color: Colors.deepOrange.withOpacity(0.5),
                                child: Text(
                                  '$name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ))),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  '$image',
                                )),
                            border: Border.all(
                              color: Colors.deepOrange,
                            )),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
