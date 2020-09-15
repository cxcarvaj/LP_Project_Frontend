import 'dart:convert';
import 'package:animal_rescue/screens/lost/components/PetCard.dart';
import 'package:animal_rescue/screens/lost/more_detail.dart';
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
  bool loading = true;
  final String ip = "192.168.112.1";

  getLossRecords() async {
    var response = await Dio().get('http://${ip}:3000/api/lossrecords/consult');
    return response.data;
  }

  getAllPets() async{
    var response = await Dio().get('http://${ip}:3000/api/pets/consult');
    return response.data;
  }

  getPhotos(String raza) async{
    if(raza == "mestizo")
      raza = "schnauzer";
    var response = await Dio().get('http://${ip}:3000/api/api-dog/${raza}');
    return response.data;
  }

  @override
  void initState() {
    getLossRecords().then((data) {
      getAllPets().then((data1) {
        setState(() {
          contacts = [];
          mascotas = [];
          int i = 0;
          for(var obj in data){
            contacts.add(obj);
            for(var obj1 in data1)
              if(obj1['id'] == obj['mascota']) // Se simula hacer un JOIN entre dos tablas
              {
                mascotas.add(obj1);
                getPhotos(obj1['especie'].toString().toLowerCase()).then((data2) {
                  setState(() {
                    data2 = jsonDecode(data2);
                    images.add(data2["message"][i++]);
                  });
                });
              }
          }
          loading = false;
        });
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
                              ubicacion: contacts[index]['ubicacion'],
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
