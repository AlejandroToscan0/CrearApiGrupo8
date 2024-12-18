import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/modelo_persona.dart';

class ControladorPersonas {
  static const String baseUrl = 'http://localhost:5000/api/personas';

  // Obtener todas las personas
  Future<List<Persona>> obtenerPersonas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return data.map((json) => Persona.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener personas');
    }
  }

  // Crear una persona
  Future<void> crearPersona(Persona persona) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear persona');
    }
  }

  // Actualizar una persona
  Future<void> actualizarPersona(String id, Persona persona) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar persona');
    }
  }

  // Eliminar una persona
  Future<void> eliminarPersona(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar persona');
    }
  }
}
