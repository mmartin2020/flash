import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/forgetpasswordcontroller.dart';

class Forgetpassword extends StatelessWidget {
  final forgetPasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingresa su correo para recuperar su cuenta',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Form(key: forgetPasswordController.formkey, child: _inputT(Icon(Icons.email_outlined, size: 13.0),
                'Ingresa tu email...', context,false),),
            
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
              child: Text('Enviar'),
              onPressed: () {
                if(forgetPasswordController.formkey.currentState!.validate())
                forgetPasswordController.forgetpassword();
                ;
          
              },
            ),
            SizedBox(height: 60.0),
            Text(
                'En unos minutos le llegará a su correo un mensaje que contendrá el link para poder recuperar su cuenta por favor revisar su correo.')
          ],
        ),
      ),
    );
  }

  Widget _inputT(Icon icon, String text, BuildContext context, bool obscur) {
    return Container(
      child: TextFormField(
        controller: forgetPasswordController.email,
        validator: (e){
if(e!.isEmpty) return '* Debes completar el campo';
if(!e.isEmail) return '* Email invalido';
return null;
        },
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 13.0, decoration: TextDecoration.none),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.grey,
          obscureText: obscur,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(14),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefix: icon,
              hintText: text,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ))),
    );
  }
}
