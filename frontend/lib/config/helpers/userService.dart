import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import 'package:go_router/go_router.dart';

class UserService {

  final Dio _dio = Dio();

  //OBTENER USUARIO
  Future getUser (username, BuildContext context) async {
    try {
      final response = await _dio.put(
        "http://localhost:3000/api/user/$username",
      );

      if (response.statusCode == 200) {
        final userData = response.data['data'];
        return {
          'department': userData['department']['name'],
          'name': "${userData['firstName']} ${userData['firstlastName']}",
          'email': userData['email'],
          'occupation': userData['occupation'],
        };
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario no encontrado')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error interno, intente más tarde')),
        );
      }
    }
  }


  //ACTUALIZAR USUARIO
  Future updateUser (User user, BuildContext context) async {
    try {
      final data = {
        'username': user.username,
        'email': user.email,
        'password': user.password,
      };

      final response = await _dio.post(
          "http://localhost:3000/api/user", data: data);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario modificado con éxito')),
        );
        context.go('/user');
      } else {
        return 'Error en la modificación';
      }
    } on DioException {
      return 'Error en el servidor';
    }
  }


}