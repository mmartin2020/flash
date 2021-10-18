import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/createAccountController.dart';

class CreateAccount extends GetWidget {
  final createAccountController =
      Get.put<CreateAccountController>(CreateAccountController());
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: createAccountController.formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: media * 0.07),
                  Text(
                    'Creación de cuenta',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: media * 0.1),

                  // textInput name
                  _inputT(
                      createAccountController.name,
                      Icon(
                        Icons.person,
                        size: 12.0,
                      ),
                      'Nombre Completo',
                      context,
                      false,
                      'na'),

                  SizedBox(height: 20.0),

                  // email
                  _inputT(
                      createAccountController.email,
                      Icon(
                        Icons.email,
                        size: 12.0,
                      ),
                      'Correo',
                      context,
                      false,
                      'em'),

                  SizedBox(height: 20.0),

                  // Teléfono
                  _inputT(
                      createAccountController.phone,
                      Icon(
                        Icons.phone,
                        size: 12.0,
                      ),
                      'Teléfono',
                      context,
                      false,
                      'ph'),

                  SizedBox(height: 20.0),

                  // Contraseña
                  _inputT(
                      createAccountController.password,
                      Icon(
                        Icons.lock,
                        size: 12.0,
                      ),
                      'Contraseña',
                      context,
                      true,
                      'pa'),

                  SizedBox(height: 20.0),

                  // Repetir la contraseña
                  _inputT(
                      createAccountController.passwordverify,
                      Icon(
                        Icons.lock,
                        size: 12.0,
                      ),
                      'Repetir la contraseña',
                      context,
                      true,
                      'pv'),
                  SizedBox(height: 40.0),

                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    child: Text('Registrarse'),
                    onPressed: () {
                      if (createAccountController.formkey.currentState
                          .validate()) createAccountController.register();
                    },
                  ),
                  SizedBox(height: media * 0.1),
                  Center(
                    child: Text(
                        'Al presionar registrarse estas acceptando las codiciones y terminos para utilizar nuestro servicio ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/condiciones'),
                      child: Text('Revisar termino y condiciones',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                  SizedBox(height: 5.0),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _inputT(TextEditingController _controller, Icon icon, String text,
      BuildContext context, bool obscur, String id) {
    return Container(
      child: TextFormField(
       
          validator: (valide) {
            if (valide!.isEmpty) return 'Requerido';
            if (createAccountController.passwdcontroller.text !=
                    createAccountController.passwordverify.text &&
                id == 'pv') return 'Las contraseña no coinciden';

            return null;
          },
          controller: _controller,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 14.0, decoration: TextDecoration.none),
          keyboardType:  id=='ph'? TextInputType.phone:TextInputType.emailAddress,
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
