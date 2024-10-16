import 'package:flutter/material.dart';
import 'package:frontend/config/theme/appTheme.dart';
import 'package:frontend/config/validations/auth/registerValidator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool visibilityPassword = true;


class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    decoration: const BoxDecoration(
    image: DecorationImage(image: AssetImage("lib/interface/assets/background.jpeg"), fit: BoxFit.cover),
    ),
      child:Form(
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
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
                validator: (value) => RegisterValidator.validateUsername(value),
              ),
              Padding(padding: const EdgeInsets.only(top:10, bottom:10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  controller: passwordController,
                  obscureText: visibilityPassword,
                  decoration: InputDecoration(
                      labelText: 'CONTRASEÑA',
                      labelStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.7),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none
                      ),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          visibilityPassword = !visibilityPassword;
                        });
                      }, icon: Icon(
                        visibilityPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppTheme.verdeAgua,
                      ),)
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => RegisterValidator.validatePassword(value),

                ),
              ),
        TextFormField(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          controller: emailController,
          decoration: InputDecoration(
              hintText: 'CORREO ELECTRÓNICO',
              hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
              filled: true,
              fillColor: Colors.white.withOpacity(0.7),
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
              )
          ),
        )
            ],
          ),
      ),
      )
    );
  }
}
