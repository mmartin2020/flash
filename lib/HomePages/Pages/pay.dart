import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Pay extends StatelessWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text('Confirmar'),
        ),
        appBar: AppBar(
            elevation: 0.5,
            automaticallyImplyLeading: false,
            leading: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.grey[50],
            title: Text('Confirmación de Pago',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
               
                  leading: Icon(Icons.add_location),
                  title: Text('Mi Ubicación'),
                  subtitle: Text('Américo vespucio')),
              SizedBox(height: 20.0),
              Text('Contacto ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 20.0),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('+56 9 56762031'),
              ),
              SizedBox(height: 20.0),
              Text('Método de pago',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 20.0),
              RadioListTile(
                value: 1,
                groupValue: 1,
                onChanged: (v) {
                  print(v);
                },
                title: Text('Efectivo'),
              ),
              RadioListTile(
                  value: 2,
                  groupValue: 1,
                  onChanged: (v) {
                    print(v);
                  },
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 13.0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(Icons.credit_card_sharp,
                          size: 13.0, color: Colors.grey),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                  title: Text('WebPay')),
              SizedBox(
                height: 80,
              ),
              ListTile(
                leading: Icon(Icons.monetization_on_rounded),
                title: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total a pagar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    Text('\$45.898',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  ],
                )),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, size: 16.0, color: Colors.grey),
                    Text('Leer término y condiciones de pago',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
