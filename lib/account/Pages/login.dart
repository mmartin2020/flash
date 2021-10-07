import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/account/Controllers/loginController.dart';

class Login extends GetWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.height;
    LoginController loginController = LoginController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentDirectional.center,
                  end: AlignmentDirectional.bottomCenter,
                  stops: [
                0.6,
                1.0
              ],
                  colors: [
                Colors.white,
                Theme.of(context).primaryColor.withOpacity(0.5)
              ])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: media * 0.2),
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 50.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('Ingresa tus datos para iniciar',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(
                  height: media * 0.1,
                ),
                Container(
                    child: Form(
                  key: loginController.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _inputT(
                          'email',
                          loginController.emailcontroller,
                          Icon(
                            Icons.person,
                            size: 12.0,
                          ),
                          'Ingresa tu email ',
                          false,
                          context),
                      SizedBox(height: 12.0),
                      _inputT(
                          'passwd',
                          loginController.passwdcontroller,
                          Icon(Icons.lock, size: 12.0),
                          'Ingresa tu contraseña ',
                          true,
                          context),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        child: Text('Iniciar sessión'),
                        onPressed: () {
                          if (loginController.formkey.currentState.validate())
                            loginController.signInWithEmailAndPassword();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                      ),
                      SizedBox(
                        height: media * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 36.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('OR'),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Divider(
                              height: 36.0,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF3b5998)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        label: Text('Loggear con Facebook'),
                        onPressed: () {},
                        icon: Icon(Icons.facebook_outlined),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFdb4a39)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        label: Text('Loggear con Google'),
                        onPressed: () => loginController.signInWithGoogle(),
                        icon: Icon(Icons.g_mobiledata_outlined),
                      ),
                      SizedBox(height: media * 0.07),
                      GestureDetector(
                          onTap: () => Get.toNamed('/forgetpassword'),
                          child: Center(
                            child: Text(
                              '¿Has olvidado tu cuenta?',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿No tienes una cuenta?',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                              onTap: () => Get.toNamed('/createAccount'),
                              child: Text(
                                'Inscribirse',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                    ],
                  ),
                ))
              ],

              //Contenedor formulario
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputT(String _key, TextEditingController textEditingController,
      Icon icon, String text, bool obscur, BuildContext context) {
    return Container(
      child: TextFormField(
          controller: textEditingController,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "Obligatorio";
            } else if (_key == 'email' && !value.isEmail) {
              return "Email invalido";
            } else {
              return null;
            }
          },
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 14.0, decoration: TextDecoration.none),
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
