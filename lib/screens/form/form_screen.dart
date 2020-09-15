import 'package:flutter/material.dart';
import '../../models/Form.dart';
import 'package:dio/dio.dart';

void postPet(Formulario formulario) async {
  var keyValueSex = formulario.sex.keys
      .firstWhere((k) => formulario.sex[k] == true, orElse: () => null);

  var keyValueEstado = formulario.estados.keys
      .firstWhere((k) => formulario.estados[k] == true, orElse: () => null);
  var dio = Dio();
  try {
    var response =
        await dio.post("http://localhost:3000/api/pets/register", data: {
      "name": formulario.petsName,
      "especie": formulario.especie,
      "gender": keyValueSex,
      // "edad": formulario.edad,
      "edad":12,
      "caracteristica": formulario.desc,
      "estado": keyValueEstado,
      "state": true,
      "contacto": formulario.contacName,
      "telefono": formulario.celular,
    });
    return response.data;
  } catch (e) {
    print(e);
  }
}

void postUbicacion(Formulario formulario) async {
  var dio = Dio();
  try {
    var response =
      await dio.post("http://localhost:3000/api/ubications/register", data: {
      "id": "1234",//cambiar
      "latitud": formulario.cordX,
      "longitud": formulario.cordY,
      "direccion": "Direccion",
      "state": true,
    });
    return response.data;
  } catch (e) {
    print(e);
  }
}

void postDataNeed(Formulario formulario) async {
  var dio = Dio();
  int petID = 0;
  try {
    Response response = await dio.get("http://localhost:3000/api/pets/consult");
    var data1 = response.data;
    for (var r in data1) {
      if (r["name"] == formulario.petsName) {
        petID = r["id"];
      }
    }
  } catch (e) {
    print(e);
  }
  try {
    var response =
        await dio.post("http://localhost:3000/api/needrecords/register", data: {
      "username": "cxcarvaj",
      "mascota": petID,
      "tipo": "Carlos",
      "state": true,
      "contacto": formulario.contacName,
      "correo":"admin12@hotmail.com",
      "telefono": formulario.celular,
    });
    return response.data;
  } catch (e) {
    print(e);
  }
}

void postData(Formulario formulario) async {
  var keyValueSex = formulario.sex.keys
      .firstWhere((k) => formulario.sex[k] == true, orElse: () => null);
  var dio = Dio();
  int petID = 0;
  String dirID = "";
  try {
    Response response = await dio.get("http://localhost:3000/api/pets/consult");
    Response response2 = await dio.get("http://localhost:3000/api/ubications/consult");
    var data1 = response.data;
    var data2 = response2.data;
    for (var r in data1) {
      if (r["name"] == formulario.petsName) {
        petID = int.parse(r["id"]);
      }
    }
    for (var d in data2) {
      if (d["latitud"] == formulario.cordX &&
          d["longitud"] == formulario.cordY) {
        dirID = (d["id"]);
      }
    }
  } catch (e) {
    print(e);
  }
  try {
    print(petID);
    var response =
      await dio.post("http://localhost:3000/api/lossrecords/register", data: {
      "username": "cxcarvaj",
      "mascota": petID,
      "contacto": formulario.contacName,
      "gender": keyValueSex,
      "state": true,
      "ubicacion": dirID,
      "telefono": formulario.celular
    });
  } catch (e) {
    print(e);
  }
}

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
          backgroundColor: Color(0xFFFFEFCA),
          title:
          Text("Reportar Mascotas",
              style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              icon: Icon(Icons.monetization_on, color: Colors.transparent,),
              color: Colors.transparent,
              onPressed: (){},
            )
          ],
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(children: [
                  Builder(
                      builder: (context) => Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                      color: const Color(0xffededed),
                                      width: 350,
                                      height: 30,
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Información de la mascota", textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
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
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child:TextFormField(
                                          decoration:
                                          InputDecoration(labelText: 'Especie:'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Porfavor entre la especie de la mascota.';
                                            }
                                          },
                                          onSaved: (val) =>
                                              setState(() => _form.especie = val)),
                                  ),
                                  Text(""),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      "Sexo",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
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
                                 Padding(
                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                   child:  TextFormField(
                                       decoration: InputDecoration(
                                           labelText: 'Descripción:'),
                                       validator: (value) {
                                         if (value.isEmpty) {
                                           return 'Por favor llene este campo.';
                                         }
                                       },
                                       onSaved: (val) =>
                                           setState(() => _form.desc = val)),
                                 ),
                                  Text(""),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      "Estatus",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CheckboxListTile(
                                      title: const Text('Perdido'),
                                      value: _form.estados[Formulario.Lost],
                                      onChanged: (val) {
                                        setState(() =>
                                        _form.estados[Formulario.Lost] = val);
                                      }),
                                  CheckboxListTile(
                                      title: const Text('Necesitado'),
                                      value: _form.estados[Formulario.Need],
                                      onChanged: (val) {
                                        setState(() =>
                                        _form.estados[Formulario.Need] = val);
                                      }),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                    child: Text(
                                      "Ubicación",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Posición X:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        onSaved: (val) => setState(
                                                () => _form.cordX = double.parse(val))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Posición Y:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        onSaved: (val) => setState(
                                                () => _form.cordY = double.parse(val))),
                                  ),
                                  Container(
                                      color: const Color(0xffededed),
                                      width: 350,
                                      height: 30,
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Información del contacto", textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
                                      )
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Nombre y Apellido:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        onSaved: (val) =>
                                            setState(() => _form.contacName = val)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
                                        decoration:
                                        InputDecoration(labelText: 'Cédula:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        onSaved: (val) =>
                                            setState(() => _form.cedula = val)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Telf./No. de Celular:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        onSaved: (val) =>
                                            setState(() => _form.celular = val)),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 100.0),
                                      child: RaisedButton(
                                          onPressed: () {
                                            final form = _formKey.currentState;
                                            if (form.validate()) {
                                              form.save();
                                              _form.save();
                                              _showDialog(context);
                                              var keyValueEstado =
                                              _form.estados.keys.firstWhere(
                                                      (k) =>
                                                  _form.estados[k] ==
                                                      true,
                                                  orElse: () => null);
                                              postPet(_form);
                                              postUbicacion(_form);
                                              if (keyValueEstado ==
                                                  "Necesitado") {
                                                postDataNeed(_form);
                                              } else {
                                                postData(_form);
                                              }
                                            }
                                          },
                                          child: Text('Enviar'))),
                                ]
                            )
                        ),
                        )
                      )
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
