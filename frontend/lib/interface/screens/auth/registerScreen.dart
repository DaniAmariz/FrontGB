import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/config/helpers/ubicationDataService.dart';
import 'package:frontend/config/models/userModel.dart';
import 'package:frontend/config/theme/appTheme.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/config/helpers/authService.dart';
import 'package:frontend/config/validations/auth/registerValidator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String name = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ubicationService = UbicationService();
  List<String> departments = [];
  List<String> municipalities = [];
  String? departmentController;
  String? municipalityController;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  Future<void> loadDepartments() async {
    try {
      departments = await ubicationService.getDepartments();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadMunicipalities(String department) async {
    try {
      municipalities = await ubicationService.getMunicipalities(department);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }


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
                  width: 200,
                  height: 200,
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
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'NOMBRE',
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
                          validator: (value) => RegisterValidator.validateName(value),
                        ),
                  Padding(padding: const EdgeInsets.only(top:10, bottom:10),
                    child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: lastNameController,
                          decoration: InputDecoration(
                              hintText: 'APELLIDOS',
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
                          validator: (value) => RegisterValidator.validateLastName(value),
                        ),
                  ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                birthController.text =
                                '${pickedDate.day.toString().padLeft(2, '0')}/'
                                    '${pickedDate.month.toString().padLeft(2, '0')}/'
                                    '${pickedDate.year}';
                              }
                            });
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: birthController,
                              decoration: InputDecoration(
                                hintText: 'FECHA NACIMIENTO',
                                hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              readOnly: true,
                              validator: (value) => RegisterValidator.validateBirthDate(value),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              hintText: 'GÉNERO',
                              hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            value: genderController.text.isEmpty ? null : genderController.text,
                            onChanged: (newValue) {
                              genderController.text = newValue as String;
                            },
                            items: [
                              'Masculino',
                              'Femenino',
                              'Otro',
                            ].map((gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'DEPARTAMENTO',
                            hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: departmentController,
                          items: departments.isNotEmpty
                              ? departments.map((String state) => DropdownMenuItem(
                            value: state,
                            child: Text(state),
                          )).toList()
                              : [],
                          onChanged: (String? newValue) {
                            setState(() {
                              departmentController = newValue!;
                            });
                            if (newValue != null) {
                              loadMunicipalities(newValue);
                            }
                          },
                          validator: (value) => RegisterValidator.validateSelection(value, 'departamento'),
                        ),

                        Padding(padding: const EdgeInsets.only(top:10, bottom:10),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'MUNICIPIO',
                        hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      value: municipalityController,
                      items: municipalities.isNotEmpty
                          ? municipalities.map((String municipality) => DropdownMenuItem(
                        value: municipality,
                        child: Text(municipality),
                      )).toList()
                          : [],
                      onChanged: (String? newValue) {
                        setState(() {
                          municipalityController = newValue!;
                        });
                      },
                      validator: (value) => RegisterValidator.validateSelection(value, 'municipio'),
                    ),
                  ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'OCUPACIÓN',
                            hintStyle: const TextStyle(color: AppTheme.verdeAgua, fontSize: 14),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: occupationController.text.isEmpty ? null : occupationController.text,
                          onChanged: (newValue) {
                            occupationController.text = newValue as String;
                          },
                          items: [
                            'Estudiante',
                            'Profesor'
                          ].map((gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                        ),
                  Padding(padding: const EdgeInsets.only(top:10, bottom:10),
                    child: TextFormField(
                          style: const TextStyle(color: Colors.black),
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
                          textInputAction: TextInputAction.next,
                          validator: (value) => RegisterValidator.validateEmail(value)),
                        ),
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
                          validator: (value) => RegisterValidator.validateUsername(value),
                        ),
                  Padding(padding: const EdgeInsets.only(top:10, bottom:10),
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
                          textInputAction: TextInputAction.next,
                          validator: (value) => RegisterValidator.validatePassword(value),
                        ),
                  ),
                        Padding(padding: const EdgeInsets.only(bottom:10),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'CONFIRMAR CONTRASEÑA',
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
                            validator: (value) => RegisterValidator.validateConfirmedPassword(value, passwordController.text),
                          ),
                        ),

                        Center(
                          child: SizedBox(
                            width: 190,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (departmentController != null && municipalityController != null) {
                                  User user = User(
                                    name: nameController.text,
                                    lastName: lastNameController.text,
                                    birth: birthController.text,
                                    gender: genderController.text,
                                    department: departmentController!,
                                    municipality: municipalityController!,
                                    occupation: occupationController.text,
                                    email: emailController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  );
                                  AuthService().register(user, context);
                                } else {
                                  // Mostrar un mensaje de error al usuario
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Por favor, seleccione un departamento y municipio'),
                                    ),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(AppTheme.azulOscuro),
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                              child: const Text(
                                'REGISTRARSE',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding:const EdgeInsets.only(top:10, bottom:8),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/');
                            },
                            child: const Text(
                              "¿Ya tienes una cuenta? Inicia sesión",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                              ),
                            ),
                          ),),

                        Padding(padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                              label: const Text('REGISTRARSE CON GOOGLE'),
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