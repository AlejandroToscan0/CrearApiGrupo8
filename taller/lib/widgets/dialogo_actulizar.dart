import 'package:flutter/material.dart';
import '../modelo/modelo_persona.dart';
import '../controlador/controlador_personas.dart';

class DialogoActualizar extends StatefulWidget {
  final Persona? persona;

  const DialogoActualizar({Key? key, this.persona}) : super(key: key);

  @override
  _DialogoActualizarState createState() => _DialogoActualizarState();
}

class _DialogoActualizarState extends State<DialogoActualizar> {
  final _formKey = GlobalKey<FormState>();
  final ControladorPersonas _controlador = ControladorPersonas();

  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.persona?.nombre ?? '');
    apellidoController = TextEditingController(text: widget.persona?.apellido ?? '');
    telefonoController = TextEditingController(text: widget.persona?.telefono ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.persona == null ? 'Agregar Persona' : 'Actualizar Persona'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: telefonoController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final persona = Persona(
              id: widget.persona?.id ?? '',
              nombre: nombreController.text,
              apellido: apellidoController.text,
              telefono: telefonoController.text,
            );

            if (widget.persona == null) {
              await _controlador.crearPersona(persona);
            } else {
              await _controlador.actualizarPersona(persona.id, persona);
            }

            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
