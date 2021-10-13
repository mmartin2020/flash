import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopView extends StatelessWidget {
  final Map<String, dynamic> map = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(map['name'].toString())),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  backgroundColor: Colors.deepOrange.withOpacity(0.5)),
              automaticallyImplyLeading: false,
              centerTitle: true,
              expandedHeight: 230,
              toolbarHeight: 180,
              flexibleSpace: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage((map['image'].toString())))),
          SliverList(
            delegate: SliverChildListDelegate([
              Spacer(),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae cursus metus. Praesent mollis auctor ornare. Praesent auctor rutrum sapien, at fermentum risus faucibus eget. Sed mattis nisl sed elementum ullamcorper. Integer ante sem, ultrices at quam non, finibus vestibulum ex. Praesent vulputate mi et augue rhoncus, a interdum odio porttitor. Sed mollis condimentum eros quis bibendum.')
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Center(
                        child: Text(
                      'Producto',
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    )),
                    Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.deepOrange.withOpacity(0.2),
                    ),
                  ]),
                ),
              ),
              childCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
