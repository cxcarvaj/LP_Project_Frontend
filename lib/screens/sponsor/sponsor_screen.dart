import 'package:animal_rescue/screens/sponsor/components/PetCard.dart';
import 'package:animal_rescue/screens/sponsor/more_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class HomeSponsor extends StatefulWidget {
  @override
  _HomeSponsorState createState() => _HomeSponsorState();
}


class _HomeSponsorState extends State<HomeSponsor> {
  bool loading = true;
  List values = [];
  List contacts = [];

  getPets() async {
    var dio = Dio();
    var _pet = await dio.get('http://192.168.1.8:8000/api/pets/consult');
    return _pet.data;
  }

  getNeedRecords() async {
    var dio = Dio();
    var response = await dio.get('http://192.168.1.8:8000/api/needrecords/consult');
    return response.data;
  }

  @override
  void initState() {
    getNeedRecords().then((records) {
      setState(() {
        getPets().then((pets) {
          setState(() {
            values = [];
            contacts = [];
            for (var record in records)
              for (var pet in pets)
                if (pet['id'] == record['mascota']) {
                  values.add(pet);
                  contacts.add(record);
                }

            loading = false;
          });
        });
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
          backgroundColor: Colors.yellowAccent[100],
          title:
          Text("Mascotas por Apadrinar",
              style: TextStyle(color: Colors.black)),
        ),
        body: !loading ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  child:
                  ListView.separated(
                    padding: const EdgeInsets.all(8),
                    key: _sponsorKey,
                    itemCount: values.length,
                    itemBuilder: (BuildContext context, int index) => PetCard(
                        mascota: values[index]['name'],
                        especie: values[index]['especie'],
                        sexo: values[index]['gender'],
                        edad: values[index]['edad'],
                        caracteristica: values[index]['caracteristica'],
                        press: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> SponsorDetail(
                              petCard:  PetCard(
                                mascota: values[index]['name'],
                                especie: values[index]['especie'],
                                sexo: values[index]['gender'],
                                edad: values[index]['edad'],
                                caracteristica: values[index]['caracteristica'],
                                press: (){},
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

