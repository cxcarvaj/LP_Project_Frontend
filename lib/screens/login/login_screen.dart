import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animal_rescue/services/Authentication.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _usernameController = TextEditingController();
final _passwordController = TextEditingController();

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    _showDialog(BuildContext context, String mssg) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('${mssg}')));
    }
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                      child: Column(
                        children: [
                          Builder(
                              builder: (BuildContext context) => Form(
                                  key: _loginKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
                                        child:
                                        Center(
                                          child: Align(
                                            child: Image.asset('assets/images/log.png'),
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                              child: Text("Usuario:", style:  TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
                                            ),
                                            TextFormField(
                                              style: TextStyle(fontSize: 16),
                                              decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 1.0)
                                                ),
                                                contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                isDense: true,
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 0.5),
                                                ),
                                              ),

                                              controller: _usernameController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Ingrese su Usuario';
                                                }
                                              },
                                              onSaved: (val) =>{},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                              child: Text("Contraseña:", style:  TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                                            ),
                                            TextFormField(
                                              style: TextStyle(fontSize: 16),
                                              decoration:
                                              InputDecoration(
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 1.0)
                                                ),
                                                contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                isDense: true,
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 0.5),
                                                ),
                                              ),
                                              controller: _passwordController,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Ingrese su Contraseña';
                                                }
                                              },

                                              onSaved: (val) =>{},
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 100.0),
                                          child: RaisedButton(
                                              onPressed: () async {

                                                final form = _loginKey.currentState;
                                                if (form.validate()){
                                                  form.save();
                                                  await authService.login(_usernameController.text, _passwordController.text);
                                                  _showDialog(context, authService.mssg);
                                                  _loginKey.currentState?.reset();
                                                }
                                              },
                                              color: const Color(0xffdff4ff),
                                              child: Text('Enviar')
                                          )
                                      ),
                                    ],
                                  )
                              )
                          )
                        ],
                      )
                  )
              );
            }
        )
    );

  }

}