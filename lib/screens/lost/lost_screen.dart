import 'dart:convert';
import 'package:animal_rescue/screens/lost/components/PetCard.dart';
import 'package:animal_rescue/screens/lost/more_detail.dart';
import 'package:animal_rescue/services/Connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HomeLost extends StatefulWidget {
  @override
  _HomeLostState createState() => _HomeLostState();
}

class _HomeLostState extends State<HomeLost> {
  List contacts = [];
  List mascotas = [];
  List images = [];
  List ubicaciones =[];
  bool loading = true;
  Connection connection = Connection();
  String get ip => connection.IP;
  String get PORT=> connection.PORT;

  getLossRecords() async {
    var response = await Dio().get('http://${ip}:${PORT}/api/lossrecords/consult');
    return response.data;
  }

  getUbication(id) async{
    var response = await Dio().get('http://${ip}:${PORT}/api/ubications/consult/${id}');
    return response.data;
  }

  getAllPets() async{
    var response = await Dio().get('http://${ip}:${PORT}/api/pets/consult');
    return response.data;
  }
  getPets(int id) async {
    var dio = Dio();
    var _pet = await dio.get('http://${ip}:${PORT}/api/pets/consult/${id}');
    return _pet.data;
  }

  getPhotos(String raza) async{
    //if(raza == "mestizo")
    raza = "schnauzer";
    var response = await Dio().get('http://${ip}:${PORT}/api/api-dog/${raza}');
    return response.data;
  }

  getImage(String especie) async{
    if(especie.toLowerCase().trim()=='perro'){
      var dio = Dio();
      var response = await dio.get('http://${ip}:${PORT}/api/api-dog');
      return response.data;
    }else{
      return '{"message":""}';
    }

  }

  @override
  void initState() {
    getLossRecords().then((records) {
      setState(() {
        contacts = [];
        mascotas = [];
        images=[];
        for (var record in records){
          var pet_id= record['mascota'];
          var ubi_id= record['ubicacion'];
          getPets(pet_id).then((pet){
            setState(() {
              getImage(pet["especie"]).then((result) {
                setState(() {
                  getUbication(ubi_id).then((ubicacion){
                    setState(() {
                      print(ubicacion);
                      result=jsonDecode(result);
                      images.add(result["message"]);
                      mascotas.add(pet);
                      ubicaciones.add(ubicacion["direccion"]);
                      contacts.add(record);
                    });
                  });
                });
              });
            });
          });
        }
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _lostKey = GlobalKey<FormState>();
    // final List<String> entries = <String>[];
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Color(0xFFFFEFCA),
          title:
          Text("Mascotas Perdidas",
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
        body: !loading ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  child:
                  ListView.separated(
                    padding: const EdgeInsets.all(8),
                    key: _lostKey,
                    itemCount: mascotas.length,
                    itemBuilder: (BuildContext context, int index) => PetCard(
                        mascota: mascotas[index]['name'],
                        especie: mascotas[index]['especie'],
                        sexo: mascotas[index]['gender'],
                        edad: mascotas[index]['edad'],
                        caracteristica: mascotas[index]['caracteristica'],
                        image: images.length > 0 ? images[index] : "",
                        press: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> LostDetail(
                              petCard:  PetCard(
                                mascota: mascotas[index]['name'],
                                especie: mascotas[index]['especie'],
                                sexo: mascotas[index]['gender'],
                                edad: mascotas[index]['edad'],
                                caracteristica: mascotas[index]['caracteristica'],
                                image: images.length > 0 ? images[index] : "",
                                press: (){},
                              ),
                              contact: contacts[index]['contacto'],
                              telefono: contacts[index]['telefono'],
                              ubicacion: ubicaciones[index],
                            )),
                          )
                        }
                    ),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  )

              );
            }
        )
        : Center(
        child: CircularProgressIndicator(),
        )
    );

  }

}
