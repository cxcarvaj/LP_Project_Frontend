import 'package:animal_rescue/models/Form.dart';
import 'package:animal_rescue/services/Authentication.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'Connection.dart';

class PostData{
  Connection connection = Connection();
  String get IP => connection.IP;
  String get PORT=> connection.PORT;



  postPet(Formulario formulario) async {
    var dio = Dio();
    try {
      var response = await dio.post("http://${IP}:${PORT}/api/pets/register", data: {
        "name": formulario.petsName,
        "especie": formulario.especie,
        "gender": formulario.sex,
        "edad": formulario.edad,
        "caracteristica": formulario.desc,
        "estado": formulario.estado,
        "state": true,
      });
      return response.data;
    } catch (e) {
      print("Error in postPet ${e}");
      return 1;
    }
  }

  postUbicacion(Formulario formulario) async {
    var dio = Dio();
    try {
      var response =
      await dio.post("http://${IP}:${PORT}/api/ubications/register", data: {
        "latitud": formulario.cordX,
        "longitud": formulario.cordY,
        "direccion": formulario.direccion,
        "state": true,
      });
      return response.data;
    } catch (e) {
      print("Error in postUbicacion ${e}");
      return 2;
    }
  }

  postDataNeed(Formulario formulario, AuthService authService) async {
    var dio = Dio();
    try {
      var response_Pet = await postPet(formulario);
      if(response_Pet==1) return "No se pudo cargar la información de la mascota";
      var pet_id = response_Pet["id"];
      var username ="";
      if(authService.username!="") username= authService.username;
      else username="cxcarvaj";
      var response =
      await dio.post("http://${IP}:${PORT}/api/needrecords/register", data: {
        "username": username,
        "mascota": pet_id,
        "tipo": formulario.estado,
        "state": true,
        "contacto": formulario.contacName,
        "correo":formulario.email,
        "telefono": formulario.celular,
      });
      return "Registro exitoso";
    } catch (e) {
      return "No se pudieron guardar sus respuestas";
    }

  }

 postData(Formulario formulario, AuthService authService) async {
    var dio = Dio();
    try {
      var response_Pet = await postPet(formulario);
      if(response_Pet==1) return "No se pudo cargar la información de la mascota";
      var response_Ubication = await postUbicacion(formulario);
      if(response_Ubication==2) return "No se pudo cargar la ubicación";
      var petID= response_Pet["id"];
      var dirID=response_Ubication["id"];
      var response =
      await dio.post("http://${IP}:${PORT}/api/lossrecords/register", data: {
        "username": "cxcarvaj",
        "mascota": petID,
        "contacto": formulario.contacName,
        "gender": formulario.sex,
        "state": true,
        "ubicacion": dirID,
        "telefono": formulario.celular
      });

      return "Registro exitoso";

    } catch (e) {
      return "No se pudieron guardar sus respuestas";
    }
  }
}