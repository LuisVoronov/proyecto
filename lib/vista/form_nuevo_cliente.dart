import 'package:flutter/material.dart';
import 'package:proyecto/persistencia/conexion_http.dart';

void main() => runApp(const VistaNuevoCliente());

class VistaNuevoCliente extends StatelessWidget {
  const VistaNuevoCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de nuevo cliente';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle), backgroundColor: Colors.redAccent,
        ),
        body: const FormularioNuevoCliente(),
      ),
    );
  }
}

// Create a Form widget.
class FormularioNuevoCliente extends StatefulWidget {
  const FormularioNuevoCliente({Key? key}) : super(key: key);

  @override
  FormularioNuevoClienteState createState() {
    return FormularioNuevoClienteState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormularioNuevoClienteState extends State<FormularioNuevoCliente> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String _id, _nombre, _direccion, _telefono, _correo;

  @override
  Widget build(BuildContext context)
  {
    const estiloEtiqueta = TextStyle(fontSize: 25.0, color: Colors.black87);
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nombre: ', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su nombre.';
              }
              else
                {
                  setState(() {
                    _nombre = value;
                  });
                  return null;
                }
            },
          ),
          const Text('Identificación: ', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su número de identificación.';
              }
              else
              {
                setState(() {
                  _id = value;
                });
                return null;
              }
            },
          ),
          const Text('Dirección: ', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su dirección.';
              }
              else
              {
                setState(() {
                  _direccion = value;
                });
                return null;
              }
            },
          ),
          const Text('Teléfono: ', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su teléfono.';
              }
              else
              {
                setState(() {
                  _telefono = value;
                });
                return null;
              }
            },
          ),
          const Text('Correo: ', style: estiloEtiqueta),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su correo.';
              }
              else
              {
                setState(() {
                  _correo = value;
                });
                return null;
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate())
                {
                  var con = ServerConnection();
                  con.insert('Clientes', _id + ';' + _nombre + ';' + _direccion + ';' + _telefono + ';' + _correo);
                      // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Datos guardados.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              child: const Text('Registrar cliente', style: TextStyle(fontSize: 25.0, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}