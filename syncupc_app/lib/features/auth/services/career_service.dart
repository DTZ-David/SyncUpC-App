// services/auth_service.dart
import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/career.dart';

class CareerService {
  Future<List<Career>> fetchCareers() async {
    final url = Uri.parse('${AppConfig.baseUrl}/career/getallcareers');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List careersData = jsonData['data'];

        return careersData.map((e) => Career.fromJson(e)).toList();
      } else {
        throw Exception('Error desconocido: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
