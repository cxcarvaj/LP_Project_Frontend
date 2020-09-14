import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

enum AuthStatus{
  Authenticated,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  AuthStatus _status = AuthStatus.Unauthenticated;
  String _mssg= "";
  final String IP = "192.168.1.8";
  final String  PORT ="8000";

  void login(username, password) async{
    var user = await _handleLogin(username, password);;
    if(user!=null){
      _status = AuthStatus.Authenticated;
      notifyListeners();
    }else{
      _status = AuthStatus.Unauthenticated;
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
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get status => _status;
  String get mssg => _mssg;
}