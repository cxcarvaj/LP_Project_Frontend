import 'package:animal_rescue/services/Authentication.dart';
import 'package:animal_rescue/services/PostData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import '../../models/Form.dart';


class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _form = Formulario();
  PostData post = PostData();
  int selectedRadioSex;
  int selectedRadioState;

  @override
  void initState() {
    super.initState();
    selectedRadioState = 0;
    selectedRadioSex = 0;
  }

  setSelectedRadioSex(int val) {
    setState(() {
      selectedRadioSex = val;
    });
  }

  setSelectedRadioState(int val) {
    setState(() {
      selectedRadioState = val;
    });
  }


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
            AuthService authService= Provider.of<AuthService>(context);
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
                                        if(value.length>40){
                                          return 'Solo tiene 40 caracteres';
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
                                            if(value.length>10){
                                              return 'Solor tiene 10 caracteres' ;
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
                                  RadioButtonGroup(
                                      labels: <String>[
                                        "Macho",
                                        "Hembra",
                                      ],
                                      onSelected: (String selected) => {
                                        setState(() =>
                                        _form.sex= selected),
                                        print(_form.sex)},
                                      picked: _form.sex,
                                  ),
                                  Padding(
                                   padding: EdgeInsets.fromLTRB(10,0, 10, 0),
                                   child: TextFormField(
                                       decoration: InputDecoration(
                                           labelText: 'Edad:'),
                                       keyboardType: TextInputType.number,
                                       validator: (value) {
                                         if (value.isEmpty) {
                                           return 'Por favor llene este campo.';
                                         }
                                       },
                                       onSaved: (val) =>
                                           setState(() => _form.edad = int.parse(val))
                                   ),
                                 ),
                                 Padding(
                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                   child:  TextFormField(
                                       decoration: InputDecoration(
                                           labelText: 'Descripción:'),
                                       validator: (value) {
                                         if (value.isEmpty) {
                                           return 'Por favor llene este campo.';
                                         }
                                         if(value.length>50){
                                           return 'Solo tiene 50 caracteres';
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
                                  RadioButtonGroup(
                                      labels: <String>[
                                        "Perdido",
                                        "Necesitado",
                                      ],
                                      onSelected: (String selected) => {
                                        setState(() =>
                                        _form.estado= selected
                                        ), print(_form.estado)},
                                      picked: _form.estado,
                                  ),

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
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty && _form.estado=="Perdido") {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        enabled: _form.estado=="Necesitado"? false: true,
                                        onSaved: (val) => {if(_form.estado=="Perdido"){
                                          setState(
                                                  () => _form.cordX = double.parse(val))
                                        }}),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Posición Y:'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty && _form.estado=="Perdido") {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        enabled: _form.estado=="Necesitado"? false: true,
                                        onSaved: (val) => {if(_form.estado=="Perdido"){
                                          setState(
                                                  () => _form.cordY = double.parse(val))
                                        }},
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Dirección:'),
                                        validator: (value) {
                                          if (value.isEmpty && _form.estado=="Perdido") {
                                            return 'Por favor llene este campo.';
                                          }
                                          if(value.length>50 && _form.estado=="Perdido"){
                                            return 'Solo tiene 50 caracteres';
                                          }
                                        },
                                        enabled: _form.estado=="Necesitado"? false: true,
                                        onSaved: (val) => setState(
                                                () => _form.direccion= val)),
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
                                        decoration: InputDecoration(
                                            labelText: 'Telf./No. de Celular:'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llene este campo.';
                                          }
                                          if(value.length<10){
                                            return 'Ingrese un número válido';
                                          }
                                        },
                                        keyboardType: TextInputType.phone,
                                        onSaved: (val) =>
                                            setState(() => _form.celular = val)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Correo:'),
                                        validator: (value) {
                                          if (value.isEmpty && _form.estado=="Necesitado") {
                                            return 'Por favor llene este campo.';
                                          }
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        enabled: _form.estado=="Necesitado"? true: false,
                                        onSaved: (val) =>
                                            setState(() => _form.email = val)),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 100.0),
                                      child: RaisedButton(
                                          onPressed: () async {
                                            final form = _formKey.currentState;
                                            if (form.validate()) {
                                              form.save();
                                              _form.save();
                                              _showDialog(context, 'Enviando Formulario ...');

                                              var keyValueEstado = _form.estado;
                                              if (keyValueEstado == "Necesitado") {
                                                var result = await post.postDataNeed(_form, authService);
                                                if(result==null){
                                                  _showDialog(context, result);
                                                }
                                              }
                                              if(keyValueEstado=="Perdido") {
                                                var result = await post.postData(_form, authService);
                                                if(result==null){
                                                  _showDialog(context, result);
                                                }
                                              }
                                              form.reset();
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

  _showDialog(BuildContext context, String text) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('${text}')));
  }
}
