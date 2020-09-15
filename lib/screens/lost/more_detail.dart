import 'package:animal_rescue/screens/lost/components/PetCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LostDetail extends StatefulWidget {
  final String contact;
  final String telefono;
  final String ubicacion;
  final PetCard petCard;
  const LostDetail({
    this.contact, this.ubicacion, this.telefono,
    this.petCard,
  });

  @override
  _LostDetailState createState() => _LostDetailState(contact: this.contact,
      ubicacion: this.ubicacion, telefono: this.telefono, petCard: this.petCard);
}


class _LostDetailState extends State<LostDetail> {
  final String contact;
  final String telefono;
  final String ubicacion;
  final PetCard petCard;
  _LostDetailState({
    this.contact,this.ubicacion, this.telefono,
    this.petCard,
  });
  @override
  Widget build(BuildContext context) {
    final _moredetail = GlobalKey<FormState>();
    final List<String> entries = <String>['A', 'B', 'C', 'E', 'F', 'G'];
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
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                key: _moredetail,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                      child: Text(" ", textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black45),),
                    ),

                    this.petCard,

                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 45.0, 10.0, 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              color: const Color(0xffededed),
                              width: 350,
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Información de Contacto", textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0,10.0, 10.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15,15, 15, 15),
                        color: const Color(0xffededed),
                        width: 350,
                        child: Table(
                          children: [
                            TableRow(

                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text("Nombre:", textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text('${contact}', textAlign: TextAlign.start,),
                                      )
                                    ],
                                  )
                                ]
                            ),
                            TableRow(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text("Teléfono:", textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text('${telefono}', textAlign: TextAlign.start,),
                                      )
                                    ],
                                  )
                                ]
                            ),
                            TableRow(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text("Ubicación:", textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text('${ubicacion}', textAlign: TextAlign.start,),
                                      )
                                    ],
                                  )
                                ]
                            ),

                          ],
                        ),
                      ),
                    )

                  ],
                ),
              );
            }
        )
    );
  }

}
