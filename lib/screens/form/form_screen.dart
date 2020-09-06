import 'package:flutter/material.dart';
import '../../models/Form.dart';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _form = Formulario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.yellowAccent[100],
          title:
              Text("Reportar Mascota", style: TextStyle(color: Colors.black)),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(children: [
                  Builder(
                      builder: (context) => Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Información de la mascota:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Nombre:'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Porfavor entre el nombre de la mascota';
                                    }
                                  },
                                  onSaved: (val) =>
                                      setState(() => _form.petsName = val),
                                ),
                                TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Especie:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Porfavor entre la especie de la mascota.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _form.especie = val)),
                                Text(""),
                                Text(
                                  "Sexo",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                CheckboxListTile(
                                    title: Text("Macho"),
                                    value: _form.sex[Formulario.Male],
                                    onChanged: (val) {
                                      setState(() =>
                                          _form.sex[Formulario.Male] = val);
                                    }),
                                CheckboxListTile(
                                    title: Text("Hembra"),
                                    value: _form.sex[Formulario.Female],
                                    onChanged: (val) {
                                      setState(() =>
                                          _form.sex[Formulario.Female] = val);
                                    }),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Descripción:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _form.desc = val)),
                                Text(""),
                                Text(
                                  "Estatus",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                CheckboxListTile(
                                    title: const Text('Perdido'),
                                    value: _form.estados[Formulario.Lost],
                                    onChanged: (val) {
                                      setState(() =>
                                          _form.estados[Formulario.Lost] = val);
                                    }),
                                Text(""),
                                Text(
                                  "Ubicación",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Posición X:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) => setState(
                                        () => _form.cordX = double.parse(val))),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Posición Y:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) => setState(
                                        () => _form.cordY = double.parse(val))),
                                Text(
                                  "Información de Contacto:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Nombre y Apellido:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _form.contacName = val)),
                                TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Cédula:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _form.cedula = val)),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Telf./No. de Celular:'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Por favor llene este campo.';
                                      }
                                    },
                                    onSaved: (val) =>
                                        setState(() => _form.celular = val)),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                    child: RaisedButton(
                                        onPressed: () {
                                          final form = _formKey.currentState;
                                          if (form.validate()) {
                                            form.save();
                                            _form.save();
                                            _showDialog(context);
                                          }
                                        },
                                        child: Text('Enviar'))),
                              ])))
                ]),
              ),
            );
          },
        ));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Enviando Formulario')));
  }
}
