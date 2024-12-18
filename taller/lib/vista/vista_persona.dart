import 'package:flutter/material.dart';
import '../modelo/modelo_persona.dart';
import '../controlador/controlador_personas.dart';
import '../widgets/dialogo_actulizar.dart';

class VistaPersona extends StatefulWidget {
  @override
  _VistaPersonaState createState() => _VistaPersonaState();
}

class _VistaPersonaState extends State<VistaPersona> {
  final ControladorPersonas _controlador = ControladorPersonas();
  late Future<List<Persona>> _futurePersonas;

  @override
  void initState() {
    super.initState();
    _futurePersonas = _controlador.obtenerPersonas();
  }

  void _refresh() {
    setState(() {
      _futurePersonas = _controlador.obtenerPersonas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Personas'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 5,
      ),
      body: FutureBuilder<List<Persona>>(
        future: _futurePersonas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay personas disponibles.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final persona = snapshot.data![index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        persona.nombre[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      '${persona.nombre} ${persona.apellido}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      'Teléfono: ${persona.telefono}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  DialogoActualizar(persona: persona),
                            );
                            _refresh();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _controlador.eliminarPersona(persona.id);
                            _refresh();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => DialogoActualizar(),
          );
          _refresh();
        },
        label: const Text('Añadir',style: TextStyle(color: Colors.white), // Cambio a color blanco
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
