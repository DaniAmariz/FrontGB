import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import 'package:go_router/go_router.dart';

class AuthService {

  final Dio _dio = Dio();

  //LOGIN
  Future login (String username, String password, BuildContext context) async {
    try {
      final response = await _dio.post(
        "http://localhost:3000/auth/login",
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        context.go('/home');
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error interno, intente más tarde')),
        );
      }
    }

  }

  //REGISTRO
  Future register (User user, BuildContext context) async {
    try {
      final data = {
        'name': user.name,
        'lastName': user.lastName,
        'birth': user.birth,
        'gender': user.gender,
        'department': user.department,
        'municipality': user.municipality,
        'occupation': user.occupation,
        'username': user.username,
        'email': user.email,
        'password': user.password,
      };

      final response = await _dio.post(
          "http://localhost:3000/auth/register", data: data);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario creado con éxito')),
        );
        context.go('/');
      } else {
        return 'Error en el registro';
      }
    } on DioException {
      return 'Error en el servidor';
    }
  }


}
