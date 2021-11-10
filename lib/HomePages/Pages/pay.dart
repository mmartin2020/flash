import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/HomePages/Pages/intheway.dart';
import 'package:log/account/Controllers/models/ProductsList.dart';

class Pay extends GetWidget<ProductsList> {
   Pay({Key? key}) : super(key: key);
  final details = Get.put(ProductsList());

  @override
  Widget build(BuildContext context) {
    final total = Get.arguments;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if(details.radio ==2){
            


           Get.dialog(

              Container(
                child: Center(child: Icon(Icons.check_circle_outline_outlined,size: 350,color: Colors.green[100],),),
                decoration: BoxDecoration(color: Colors.green),),
                
                transitionCurve: Curves.bounceInOut,
                transitionDuration: Duration(seconds: 1));

                Future.delayed(Duration(seconds: 3),()=> Get.toNamed('/intheway'));

                
            }
          
          },
          label: Text('Confirmar'),
        ),
        appBar: AppBar(
            elevation: 0.5,
            
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: ()=>Get.back(),
             icon:Icon(Icons.arrow_back),
             
            ),
           
           
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
              GetBuilder<ProductsList>(
                builder: (cn) {
                  return RadioListTile<RxInt>(
                    value: 2.obs,
                    groupValue: cn.radio,
                    onChanged: (v) {
                      cn.changeRadioState(v);
                    },
                    title: Text('Efectivo'),
                  );
                }
              ),
              GetBuilder<ProductsList>(
                builder: (cn) {
                  return RadioListTile<RxInt>(
                     value: 0.obs,
                        groupValue: cn.radio,
                        onChanged: (v) {
                          cn.changeRadioState(v);
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
                      title: Text('WebPay'));
                }
              ),
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
                    Text('\$${details.numberFormat(total) }',
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
