class Persona {
  final String id;
  final String nombre;
  final String apellido;
  final String telefono;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  // Crear una instancia de Persona desde JSON
  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['_id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
    );
  }

  // Convertir una instancia de Persona a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
    };
  }
}
