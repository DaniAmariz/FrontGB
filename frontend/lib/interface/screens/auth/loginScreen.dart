import 'package:flutter/material.dart';
import 'package:frontend/config/theme/appTheme.dart';
import 'package:frontend/config/validations/auth/loginValidator.dart';
import 'package:frontend/config/helpers/authService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/interface/assets/background.jpeg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('lib/interface/assets/logo.png'),
                  width: 300,
                  height: 300,
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: 'USUARIO',
                            hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                              )
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) => LoginValidator.validateUsername(value),
                        ),
                        Padding(padding: const EdgeInsets.only(top:15, bottom:10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'CONTRASEÑA',
                            hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none
                              )
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) => LoginValidator.validatePassword(value),
                        ),
                        ),

                        Center(
                          child: SizedBox(
                            width: 190,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                AuthService().login(usernameController.text, passwordController.text, context);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(AppTheme.azulOscuro),
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                              child: const Text(
                                'INICIAR SESIÓN',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding:const EdgeInsets.only(top:10, bottom:8),
                        child: GestureDetector(
                          onTap: () {
                            context.go('/register');
                          },
                          child: const Text(
                            "¿No tienes cuenta? Regístrate",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                            ),
                          ),
                        ),),

                        Padding(padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 300,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              foregroundColor: WidgetStateProperty.all<Color>(AppTheme.azulOscuro),
                            ),
                            icon: const Icon(FontAwesomeIcons.google, color: AppTheme.azulOscuro,),
                            label: const Text('CONTINUAR CON GOOGLE'),
                          ),
                        ),
                        )

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}