
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HomeLost extends StatefulWidget {
  @override
  _HomeLostState createState() => _HomeLostState();
}

class _HomeLostState extends State<HomeLost> {
  List entries = ['A', 'B', 'C', 'E', 'F', 'G'];
  List mascotas = [];
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

  @override
  void initState() {
    getLossRecords().then((data) {
      setState(() {
        getAllPets().then((data1) {
          setState(() {
            mascotas = [];
            for(var obj in data)
              for(var obj1 in data1)
                if(obj1['id'] == obj['mascota'])
                  mascotas.add(obj1);
            loading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _lostKey = GlobalKey<FormState>();
    // final List<String> entries = <String>[];
    print(mascotas);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.yellowAccent[100],
          title:
          Text("Mascotas Perdidas", style: TextStyle(color: Colors.black)),
        ),
        body: !loading ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                key: _lostKey,
                itemCount: mascotas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 170,
                    color: Colors.transparent,
                    child: Center(child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child:
                        Card(
                            color: const Color(0xffdff4ff),
                            child: Row(

                                children: <Widget>[
                                  Column(
                                      children: <Widget>[
                                        Center(
                                            child: Container(
                                                height: 140,
                                                width: 140,
                                                child: Align(
                                                    child: Image.asset(
                                                        'assets/images/apadrinar.jpg',
                                                        height: 100,
                                                        width: 100),
                                                    alignment: Alignment.center
                                                )
                                            )
                                          //alignment: Alignment.center,
                                        ),
                                      ]
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start ,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Mascota ${mascotas[index]['name']}', style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Especie ${mascotas[index]['especie']}'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Sexo ${mascotas[index]['gender']}'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Caracteristica ${mascotas[index]['caracteristica']}'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Edad ${mascotas[index]['edad']}'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Estado ${mascotas[index]['estado']}'),
                                        ),
                                      ],
                                    ),
                                  ),

                                ]
                            )

                        )
                    )
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            }
        )
        : Center(
        child: CircularProgressIndicator(),
        )
    );

  }

}
