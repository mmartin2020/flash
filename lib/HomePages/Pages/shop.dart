import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/shopController.dart';

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
      child: DefaultTabController(
        length: 9,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Todos'),
                ),
                Tab(text: 'Abarrotes'),
                Tab(text: 'Carnicería'),
                Tab(text: 'Panadería'),
                Tab(text: 'Ferretería'),
                Tab(text: 'Florería'),
                Tab(text: 'Minimarket'),
                Tab(text: 'Cafetería'),
                Tab(text: 'Papelería'),
              ],
            ),
          ),
          body: StreamBuilder(
              stream: shop,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error para cargar información'));
                if (snapshot.connectionState == ConnectionState.waiting)
                  Center(child: CircularProgressIndicator());
                final data = snapshot.requireData;
                final j = aletorio(data.size);

                return TabBarView(
                  children: [
                    Todos(data: data, j: j),
                    Abarrotes(data: data),
                    Carniceria(data: data),
                    Panaderia(data: data),
                    Ferreteria(data: data),
                    Floreria(data: data),
                    Minimarket(data: data),
                    Cafeteria(data: data),
                    Papeleria(data: data),
                  ],
                );
              }),
        ),
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
}

// todos los shop
class Todos extends StatelessWidget {
  const Todos({
    Key? key,
    required this.data,
    required this.j,
  }) : super(key: key);

  final data;
  final j;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[j[i]]['name'];
            final image = data.docs[j[i]]['image'];
            final hra = data.docs[j[i]]['hra'];

            return GestureDetector(
                onTap: () {
                  Get.toNamed('/shopview', arguments: {
                    'name': data.docs[j[i]]["name"],
                    'image': data.docs[j[i]]["image"],
                    'id': data.docs[j[i]]["idShop"],
                    'hra': data.docs[j[i]]["hra"],
                    'categoria': data.docs[j[i]]["categoria"],
                    'outstanding': data.docs[j[i]]["outstanding"],
                  });
                },

                // return a stack with icon marker

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.brown[50],
                        border: Border.all(color: Color(0xffbcaaa4))),
                    child: Row(
                      children: [
                        Card(
                            child: Hero(
                          tag: 'shop',
                          child: Image(
                            fit: BoxFit.cover,
                            errorBuilder: (a, b, c) {
                              return Placeholder(
                                strokeWidth: 1.0,
                                fallbackHeight: 25,
                                fallbackWidth: 50,
                              );
                            },
                            width: 80,
                            height: 80,
                            image: NetworkImage(image),
                          ),
                        )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text('Lorem ipsum es cualquiera de estos canales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_clock_outlined,
                                    size: 10,
                                  ),
                                  Text(hra,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0)),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}

// Abarrotes
class Abarrotes extends StatelessWidget {
  const Abarrotes({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Carniceria
class Carniceria extends StatelessWidget {
  const Carniceria({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

//  Panaderia
class Panaderia extends StatelessWidget {
  const Panaderia({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Ferreteria

class Ferreteria extends StatelessWidget {
  const Ferreteria({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Floreria
class Floreria extends StatelessWidget {
  const Floreria({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Minimarket
class Minimarket extends StatelessWidget {
  const Minimarket({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Cafeteria
class Cafeteria extends StatelessWidget {
  const Cafeteria({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}

// Papeleria
class Papeleria extends StatelessWidget {
  const Papeleria({
    Key? key,
    required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.size,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, i) {
            final name = data.docs[i]['name'];
            final image = data.docs[i]['image'];
            final categoria = data.docs[i]['categoria'];
            final hra = data.docs[i]['hra'];

            if (categoria == 'Abarrotes')
              return GestureDetector(
                  onTap: () {
                    print('okokk');
                    Get.toNamed('/shopview', arguments: {
                      'name': data.docs[i]["name"],
                      'image': data.docs[i]["image"],
                      'id': data.docs[i]["idShop"],
                      'hra': data.docs[i]["hra"],
                      'categoria': data.docs[i]["categoria"],
                      'outstanding': data.docs[i]["outstanding"],
                    });
                  },

                  // return a stack with icon marker

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.brown[50],
                          border: Border.all(color: Color(0xffbcaaa4))),
                      child: Row(
                        children: [
                          Card(
                              child: Hero(
                            tag: 'shop',
                            child: Image(
                              fit: BoxFit.cover,
                              errorBuilder: (a, b, c) {
                                return Placeholder(
                                  strokeWidth: 1.0,
                                  fallbackHeight: 25,
                                  fallbackWidth: 50,
                                );
                              },
                              width: 80,
                              height: 80,
                              image: NetworkImage(image),
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                                Text(
                                    'Lorem ipsum es cualquiera de estos canales',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock_outlined,
                                      size: 10,
                                    ),
                                    Text(hra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0)),
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ));
            else
              return Text('');
          }),
    );
  }
}
