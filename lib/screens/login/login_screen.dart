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

login(authService) async{
  await authService.login(_usernameController.text, _passwordController.text);
}

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();
  bool passwordVisible;
  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(

                          children: [
                            Builder(
                                builder: (BuildContext context) => Form(
                                    key: _loginKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
                                          child: Center(
                                            child: Text("Animal Rescue",
                                              style: TextStyle(fontFamily: 'MarckScript', fontSize: 45, fontWeight: FontWeight.bold,
                                                  color: const Color(0xff718489)),

                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                          child:
                                          Center(
                                            child: Align(
                                              child: Image.asset('assets/images/animalrescue.png'),
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                                child: Text("Usuario:",
                                                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
                                                  color: Color(0xff404f53)),),
                                              ),
                                              TextFormField(
                                                style: TextStyle(fontSize: 16,  color: Color(0xff073b4c)),
                                                decoration: InputDecoration(
                                                  hintText: "Ingrese su usuario",
                                                  hintStyle: TextStyle(fontWeight: FontWeight.w100),
                                                  fillColor: Color(0xffa0b7c0).withOpacity(0.04),
                                                  filled: true,
                                                  contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  isDense: true,
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: new BorderSide(
                                                        color: const Color(0xffa0b7c0),
                                                        width: 2.0,
                                                      )
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
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                                child: Text("Contraseña",
                                                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
                                                        color: Color(0xff404f53))),
                                              ),
                                              TextFormField(
                                                style: TextStyle(fontSize: 16, color: Color(0xff073b4c)),
                                                obscureText: !passwordVisible,
                                                decoration:
                                                InputDecoration(
                                                  hintText: "Ingrese su contraseña",
                                                  hintStyle: TextStyle(fontWeight: FontWeight.w100),
                                                  fillColor: Color(0xffa0b7c0).withOpacity(0.04),
                                                  filled: true,
                                                  contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                                  isDense: true,
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide: new BorderSide(
                                                        color: const Color(0xffa0b7c0),
                                                        width: 2.0,
                                                      )
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

                                            ]
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0, horizontal: 120.0),
                                            child: RaisedButton(
                                                onPressed: () async {

                                                  final form = _loginKey.currentState;
                                                  if (form.validate()){
                                                    form.save();
                                                    await login(authService);
                                                    _showDialog(context, authService.mssg);
                                                    _loginKey.currentState?.reset();
                                                  }
                                                },
                                                color: const Color(0xffa0b7c0),
                                                child: Text('Ingresar', style:  TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 15))
                                            )
                                        ),
                                      ],
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                  )
              );
            }
        )
    );

  }

}