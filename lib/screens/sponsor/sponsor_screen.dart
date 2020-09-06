import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSponsor extends StatefulWidget {
  @override
  _HomeSponsorState createState() => _HomeSponsorState();
}

class _HomeSponsorState extends State<HomeSponsor> {
  @override
  Widget build(BuildContext context) {
    final _sponsorKey = GlobalKey<FormState>();
    final List<String> entries = <String>['A', 'B', 'C', 'E', 'F', 'G'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.yellowAccent[100],
        title:
        Text("Mascotas por Apadrinar", style: TextStyle(color: Colors.black)),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            key: _sponsorKey,
            itemCount: entries.length,
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
                                    child: Text('Mascota ${entries[index]}', style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Especie ${entries[index]}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Sexo ${entries[index]}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Caracteristica ${entries[index]}'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('Edad ${entries[index]}'),
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
    );
  }

}
