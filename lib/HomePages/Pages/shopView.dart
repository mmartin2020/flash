import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopView extends StatelessWidget {
  final Map<String, dynamic> _shop = Get.arguments;
  final Map<String, List<Products>> _product = {
    'Frutas': [
      Products(
          image: 'lib/assets/images/cereza.jpeg',
          price: '\$2.000 / Kg',
          name: 'Cereza'),
      Products(
          image: 'lib/assets/images/naranja.jpeg',
          price: '\$500 / Kg',
          name: 'Naranja'),
      Products(
          image: 'lib/assets/images/kiwi.jpeg',
          price: '\$800 / Kg',
          name: 'Kiwi'),
      Products(
          image: 'lib/assets/images/limongreen.jpeg',
          price: '\$400 / Kg',
          name: 'Limon Verde'),
      Products(
          image: 'lib/assets/images/pina.jpeg',
          price: '\$1.500 / c/u',
          name: 'Piña'),
      Products(
          image: 'lib/assets/images/platano.jpeg',
          price: '\$1.700 / Kg',
          name: 'Platano'),
      Products(
          image: 'lib/assets/images/fresa.jpeg',
          price: '\$2.500 / Kg',
          name: 'Fresa'),
    ],
    'verduras': [
      Products(
          image: 'lib/assets/images/zanahoria.jpeg',
          price: '\$1.000 / Kg',
          name: 'Zanahoría'),
      Products(
          image: 'lib/assets/images/zapayo.jpeg',
          price: '\$8.000 / Kg',
          name: 'Zapayo'),
      Products(
          image: 'lib/assets/images/perejil.jpeg',
          price: '\$100 /g',
          name: 'Perejíl'),
      Products(
          image: 'lib/assets/images/papa.jpeg',
          price: '\$1.000 / Kg',
          name: 'Papa'),
      Products(
          image: 'lib/assets/images/ajo.jpeg', price: '\$200 c/u', name: 'Ajo'),
      Products(
          image: 'lib/assets/images/cebolla.jpeg',
          price: '\$1.000 / Kg',
          name: 'Cebolla'),
    ],
    'bebidas': [
      Products(
          image: 'lib/assets/images/cocacola.jpeg',
          price: '\$1.000 / Kg',
          name: 'Coca Cola 1 Litro'),
      Products(
          image: 'lib/assets/images/fanta.jpeg',
          price: '\$2.000 / Kg',
          name: 'Fanta 2 Litro'),
      Products(
          image: 'lib/assets/images/pepsi.jpeg',
          price: '\$1.500 ',
          name: 'Pepsi 1.5 L'),
      Products(
          image: 'lib/assets/images/agua1.jpeg',
          price: '\$1.000 / Kg',
          name: 'Agua 500cc'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final frutas = _product["Frutas"];
    final verduras = _product["verduras"];
    final bebidas = _product["bebidas"];

    List<Widget> productFruits = List.generate(
        frutas!.length,
        (i) => Container(
            width: 100.0,
            height: 100.0,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: 50.0,
                  height: 50.0,
                  image: AssetImage('${frutas[i].image}'),
                  errorBuilder: (_, e, s) => Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.deepOrange.withOpacity(0.1),
                  ),
                ),
                Text('${frutas[i].name}'),
                Text('${frutas[i].price}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
              ],
            ))));
    List<Widget> productVerduras = List.generate(
        verduras!.length,
        (i) => Container(
            width: 100.0,
            height: 100.0,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: 50.0,
                  height: 50.0,
                  image: AssetImage('${verduras[i].image}'),
                  errorBuilder: (_, e, s) => Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.deepOrange.withOpacity(0.1),
                  ),
                ),
                Text('${verduras[i].name}'),
                Text('${verduras[i].price}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
              ],
            ))));
    List<Widget> productBebidas = List.generate(
        bebidas!.length,
        (i) => Container(
            width: 100.0,
            height: 100.0,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: 50.0,
                  height: 50.0,
                  image: AssetImage('${bebidas[i].image}'),
                  errorBuilder: (_, e, s) => Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.deepOrange.withOpacity(0.1),
                  ),
                ),
                Text('${bebidas[i].name}'),
                Text('${bebidas[i].price}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700)),
              ],
            ))));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: Image(
            fit: BoxFit.cover,
            image: NetworkImage(_shop['image']),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(_shop['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0))),
              ),
              Flexible(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Text('Frutas',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16.0)),
                    ),
                    SliverGrid.count(
                      crossAxisCount: 3,
                      children: productFruits,
                    ),
                    SliverToBoxAdapter(
                      child: Text('Verduras',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16.0)),
                    ),
                    SliverGrid.count(
                      crossAxisCount: 3,
                      children: productVerduras,
                    ),
                    SliverToBoxAdapter(
                      child: Text('Bebidas',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16.0)),
                    ),
                    SliverGrid.count(
                      crossAxisCount: 3,
                      children: productBebidas,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Products {
  Products({this.image, this.price, this.name});

  String? image;
  String? price;
  String? name;
}
