import 'package:get/get.dart';

import 'package:log/HomePages/Pages/shopView.dart';
import 'HomePages/Pages/categoria.dart';
import 'HomePages/Pages/condiciones.dart';
import 'HomePages/Pages/home.dart';
import 'HomePages/Pages/masVendido.dart';
import 'HomePages/Pages/mispedidos.dart';
import 'HomePages/Pages/myfavorites.dart';
import 'HomePages/Pages/offer.dart';
import 'HomePages/Pages/pay.dart';
import 'HomePages/Pages/shopView.dart';
import 'HomePages/Pages/search.dart';
import 'HomePages/Pages/shopping_cart.dart';
import 'account/Pages/createaccount.dart';
import 'account/Pages/forgetpassword.dart';
import 'account/Pages/login.dart';
import 'initialPage/PageView.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/initialpage',
    page: () => InitPage(),
    title: 'Initialpage',
  ),
  GetPage(
    name: '/pay',
    page: () => Pay(),
    title: 'pay',
  ),
  GetPage(
    name: '/login',
    page: () => Login(),
    title: 'login',
  ),
  GetPage(
    name: '/home',
    page: () => Home(0),
    title: 'HomeView',
  ),
  GetPage(
    name: '/forgetpassword',
    page: () => Forgetpassword(),
    title: 'forgetpassword',
  ),
  GetPage(
    name: '/createAccount',
    page: () => CreateAccount(),
    title: 'CreateAccount',
  ),
  GetPage(
    name: '/condiciones',
    page: () => Condiciones(),
    title: '/condiciones',
  ),
  GetPage(
    name: '/offer',
    page: () => Offer(),
    title: '/Offer',
  ),
  GetPage(
    name: '/search',
    page: () => Search(),
    title: '/search',
  ),
  GetPage(
    name: '/details/masVendido',
    page: () => MasVendido(),
    title: '/details/masVendido',
  ),
  GetPage(
    name: '/details/categoria',
    page: () => Categoria(),
    title: '/details/categoria',
  ),
  GetPage(
    name: '/shopview',
    page: () => ShopView(),
    title: 'ShopView',
  ),
  GetPage(
    name: '/favorite',
    page: () => Favorite(),
    title: 'favorite',
  ),
  GetPage(
    name: '/mispedidos',
    page: () => Pedidos(),
    title: 'pedidos',
  ),
  GetPage(
    name: '/shoppingCart',
    page: () => ShoppingCart(),
    title: 'ShoppingCart',
  ),
];
