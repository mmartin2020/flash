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
  final RxList<Widget> supercero = RxList();

  @override
  Widget build(BuildContext context) {
    var total = 0.0.obs;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              bool state = true;
             var  totales = 0.0;
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

                     int count = service[element][0];
                      String title= service[element][2];
                      String price = service[element][3];
                      String image= service[element][4];
                      String id = element;

                      //toInt price
                   final  priceInt = int.parse(price);
                 
                    totales = ( priceInt * count.toDouble() ) + totales   ;

total=totales.obs;


                    supercero.add( component(
      id,  title,  price,  image,  count) );
                    state = false;
                  }
                });

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.0,
                      ),
                    
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                            'Carrito de compra',
                            style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20.0),
                          ),

                          IconButton(onPressed: (){
                            Get.dialog(
                              Stack(children: [Positioned(top: 45.0,right: 10.0,
                                child:   GestureDetector(onTap: (){
                                 supercero.clear();
                                      Get.back();
                                     


                                    }, child:Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(width: 100.0,height: 30.0,child: 
                             
                                     Row(children: [Text('Vaciar carro'),Spacer(),Icon(Icons.delete_outline_outlined,color: Colors.grey,),]),
                                      
                                      ),
                                    
                                    ),
                                  ),
                                ),
                              )
                              
                              ],
                              
                              ),
                             barrierColor: Colors.transparent.withOpacity(0.0),
                              );
                          }, icon: Icon(Icons.more_vert_rounded))
                                ],
                              )),
                        
                      SizedBox(
                        height: 40.0,
                      ),
                      state
                          ? Column(
                              children: [
                                Icon(Icons.info, size: 100, color: Colors.grey),
                                Text(
                                    'No se ha encontrado información para mostrar',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey))
                              ],
                            )
                          : Expanded(
                              child: Stack(
                                children: [
                                
                                  GetX<ProductsList>(
                                    builder: (context) {
                                      return ListView(children: supercero,);
                                    }
                                  ),

                                  // floating button
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      child: FloatingActionButton.extended(
                                        onPressed: () => Get.toNamed('/pay',arguments: total),
                                        label: Row(
                                          children: [
                                            Text('Ir a pagar ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.arrow_forward_ios_sharp,
                                                size: 12.0,
                                                color: Colors.white54),
                                            GetX<ProductsList>(
                                              builder: (context) {
                                                return Text('Total: \$${details.numberFormat(total) }',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold));
                                              }
                                            ),
                                          ],
                                        ),
                                        icon: Icon(Icons.payment_outlined),
                                      ),
                                    ),
                                  ),
                                ],
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
return GestureDetector(
      onTap: () {
         details.InitialState(count.obs);
        Get.defaultDialog(
          title: '',
          content:  
           Container(
                width: 250,
                height: 170,
                child: Column(children: [
                 Image(
                        image: AssetImage(image),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20.0,),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                      SizedBox(height: 20.0,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          details.discrement(id, image, title, price);
                         supercero.clear();

                        },
                        icon: Icon(
                          Icons.remove,
                          size: 19.0,
                        ),
                      ),
                      SizedBox(height: 20.0,),

                        GetX<ProductsList>(
                          builder:(context) {
                                 return Text('${details.counter}',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)
                                );}
                      ),
                      SizedBox(height: 20.0,),
                      IconButton(
                        onPressed: () {
                          details.increment(id, image, title, price);
                           supercero.clear();
                        },
                        icon: Icon(Icons.add, size: 19.0),
                      ),
                    ],
                  ),
                ]),
                decoration: BoxDecoration(color: Colors.white,),
              ),

             
        
     );
      },
      child: Center(
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
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '$count X    \$ ${details.numberFormat(price) } ',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                  details.cart_delete(id, false, title, price, image);
                  supercero.clear();
                    },
                    icon: Icon(
                      Icons.close_outlined,
                      size: 16.0,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

