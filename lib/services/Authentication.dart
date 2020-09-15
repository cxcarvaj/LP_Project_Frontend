import 'package:animal_rescue/services/Connection.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

enum AuthStatus{
  Authenticated,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  AuthStatus _status = AuthStatus.Unauthenticated;
  String _mssg= "";
  String _username="";
  Connection connection = Connection();
  String get IP => connection.IP;
  String get PORT=> connection.PORT;

  void login(username, password) async{
    var user = await _handleLogin(username, password);;
    if(user!=null){
      _username = username;
      print("USER NAME ES ${username}");
      _status = AuthStatus.Authenticated;
      notifyListeners();
    }else{
      _status = AuthStatus.Unauthenticated;
      _username="";
      notifyListeners();
    }
  }

   _handleLogin(username, password) async{
    var user = await _getUser(username, password);
    print(user);
    if(user=="" || user==null){
      _mssg= "No existe el usuario";
      return null;
    }
    if(user['password']==password){
      _mssg="Login Exitoso";
      return user;
    }else{
      _mssg ="Contraseña incorrecta";
      return null;
    }
  }

  _getUser(username, password) async {
    var response = await Dio().get('http://${IP}:${PORT}/api/users/consult/${username}');
    return response.data;
  }


  void logOut() {
    _username="";
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get status => _status;
  String get mssg => _mssg;
  String get username => _username;
}