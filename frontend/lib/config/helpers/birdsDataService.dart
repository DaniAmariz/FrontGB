import 'package:dio/dio.dart';
import 'package:frontend/config/models/birdModel.dart';

class GetDataBirds {
  final Dio _dio = Dio();

  Future<List<Bird>> getBirds() async {
    final response = await _dio.get('http://localhost:3000/api/bird');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      final List<Bird> birds = data.map((birdData) {
        final nombre = birdData['name'].toString();
        final especie = birdData['specie'].toString();
        final imagen = birdData['url_photo'].toString();
        final ubicacion = birdData['ubication'].toString();
        return Bird(name: nombre, specie: especie, img: imagen, ubication: ubicacion);
      }).toList();
      return birds;
    } else {
      print('Failed to fetch birds: ${response.data}');
      throw Exception('Failed to fetch birds');
    }
  }
}
