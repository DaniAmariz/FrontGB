import 'package:dio/dio.dart';

class UbicationService {
  final Dio _dio = Dio();
  final List<String> departments = [];
  final Map<String, List<String>> municipalities = {};

  Future<List<dynamic>> getUbication() async {
    try {
      final response = await _dio.get("http://localhost:3000/info/department");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error obtaining ubications');
      }
    } on DioException catch (e) {
      throw Exception('Error obtaining ubications: ${e.response?.data}');
    }
  }

  Future<List<String>> getDepartments() async {
    List<dynamic> data = await getUbication();
    departments.clear();
    departments.addAll(List<String>.from(data.map((d) => d['name'])));

    municipalities.clear();
    for (var department in data) {
      String departmentName = department['name'];
      List<dynamic> municipalitiesData = department['municipalities'];
      municipalities[departmentName] = List<String>.from(municipalitiesData.map((m) => m['name']));
    }

    return departments;
  }

  Future<List<String>> getMunicipalities(String departmentName) async {
    if (municipalities.containsKey(departmentName)) {
      return municipalities[departmentName]!;
    } else {
      throw Exception('Department not found');
    }
  }
}
