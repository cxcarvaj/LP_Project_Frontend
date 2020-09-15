import 'dart:convert';
import 'package:animal_rescue/screens/sponsor/components/PetCard.dart';
import 'package:animal_rescue/screens/sponsor/more_detail.dart';
import 'package:animal_rescue/services/Connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class HomeSponsor extends StatefulWidget {
  @override
  _HomeSponsorState createState() => _HomeSponsorState();
}


class _HomeSponsorState extends State<HomeSponsor> {
  bool loading = true;
  List mascotas = [];
  List contacts = [];
  List images= [];
  Connection connection = Connection();
  String get IP => connection.IP;
  String get PORT=> connection.PORT;

  getPets(int materia_id) async {
    var dio = Dio();
    var _pet = await dio.get('http://${IP}:${PORT}/api/pets/consult/${materia_id}');
    return _pet.data;
  }

  getNeedRecords() async {
    var dio = Dio();
    var response = await dio.get('http://${IP}:${PORT}/api/needrecords/consult');
    return response.data;
  }

  getImage(String especie) async{
    if(especie.toLowerCase().trim()=='perro'){
      var dio = Dio();
      var response = await dio.get('http://${IP}:${PORT}/api/api-dog');
      return response.data;
    }else{
      return '{"message":""}';
    }

  }

  @override
  void initState() {
    getNeedRecords().then((records) {
      setState(() {
        contacts = [];
        mascotas = [];
        images=[];
        for (var record in records){
          var pet_id= record['mascota'];
          getPets(pet_id).then((pet){
            setState(() {
              getImage(pet["especie"]).then((result) {
                setState(() {
                  result=jsonDecode(result);
                  images.add(result["message"]);
                  mascotas.add(pet);
                  contacts.add(record);
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
    final _sponsorKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Color(0xFFFFEFCA),
          title:
          Text("Mascotas por Apadrinar",
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
                    padding: const EdgeInsets.all(4),
                    key: _sponsorKey,
                    itemCount: mascotas.length,
                    itemBuilder: (BuildContext context, int index) => PetCard(
                        mascota: mascotas[index]['name'],
                        especie: mascotas[index]['especie'],
                        sexo: mascotas[index]['gender'],
                        edad: mascotas[index]['edad'],
                        caracteristica: mascotas[index]['caracteristica'],
                        image:images[index],
                        press: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> SponsorDetail(
                              petCard:  PetCard(
                                mascota: mascotas[index]['name'],
                                especie: mascotas[index]['especie'],
                                sexo: mascotas[index]['gender'],
                                edad: mascotas[index]['edad'],
                                caracteristica: mascotas[index]['caracteristica'],
                                press: (){},
                                image: images[index],
                              ),
                              contact: contacts[index]['contacto'],
                              telefono: contacts[index]['telefono'],
                              email: contacts[index]['correo'],
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

