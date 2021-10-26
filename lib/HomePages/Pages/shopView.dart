import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/HomePages/Pages/home.dart';

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
          price: '\$1.000 c/u',
          name: 'Coca Cola 1 Litro'),
      Products(
          image: 'lib/assets/images/fanta.jpeg',
          price: '\$2.000 c/u',
          name: 'Fanta 2 Litro'),
      Products(
          image: 'lib/assets/images/pepsi.jpeg',
          price: '\$1.500 c/u',
          name: 'Pepsi 1.5 L'),
      Products(
          image: 'lib/assets/images/agua1.jpeg',
          price: '\$1.000 c/u',
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
        (i) => GestureDetector(
              onTap: () => _bottomsheet(context),
              child: Container(
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
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700)),
                    ],
                  ))),
            ));
    List<Widget> productVerduras = List.generate(
        verduras!.length,
        (i) => GestureDetector(
              onTap: () => _bottomsheet(context),
              child: Container(
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
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700)),
                    ],
                  ))),
            ));
    List<Widget> productBebidas = List.generate(
        bebidas!.length,
        (i) => GestureDetector(
              onTap: () => _bottomsheet(context),
              child: Container(
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
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700)),
                    ],
                  ))),
            ));
    if (_shop['name'] == "GFood Tio Jack")
      return SafeArea(
        child: Scaffold(
         
          appBar: AppBar(
            actions: [
              Stack(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
                  Positioned(
                      top: 5.0,
                      right: 5.0,
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              )
            ],
            elevation: 0.0,
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
    else
      return Container(color: Colors.white);
  }

  Future _bottomsheet(BuildContext context) {
    return Get.bottomSheet(
      Stack(
        children: [
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
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'parent_img',
                      child: Image(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        image: AssetImage(''),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100.0,
                        height: 120.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // titulo
                              Text(
                                'Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // descripcion
                              Text('Description'),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'price',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,
                                  size: 16.0, color: Colors.yellow),
                              Text(
                                'r',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // details.discrement(idProducts);
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: 19.0,
                                ),
                              ),
                              Text('count',
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: () {
                                  // details.increment(idProducts, image, titulo);
                                },
                                icon: Icon(Icons.add, size: 19.0),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home(2)));
                    },
                    child: Container(
                      width: 300.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 30,
                                  color: Colors.white38,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
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
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_forward_ios_sharp,
                                    size: 12.0, color: Colors.white54)
                              ],
                            ),
                            Text(
                              'Total: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            )
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
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {},
                ),
              ))
        ],
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
