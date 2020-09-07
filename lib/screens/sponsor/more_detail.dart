import 'package:animal_rescue/screens/sponsor/components/PetCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SponsorDetail extends StatefulWidget {
  final String contact;
  final String telefono;
  final String email;
  final PetCard petCard;
  const SponsorDetail({
    this.contact, this.email, this.telefono,
    this.petCard,
  });

  @override
  _SponsorDetailState createState() => _SponsorDetailState(contact: this.contact,
      email: this.email, telefono: this.telefono, petCard: this.petCard);
}


class _SponsorDetailState extends State<SponsorDetail> {
  final String contact;
  final String telefono;
  final String email;
  final PetCard petCard;
  _SponsorDetailState({
    this.contact,this.email, this.telefono,
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
        backgroundColor: Colors.yellowAccent[100],
        title:
        Text("Mascotas por Apadrinar", style: TextStyle(color: Colors.black)),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
           return Container(
             key: _moredetail,
             child: Column(
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
                   child: Text("Información", textAlign: TextAlign.center,
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
                                      child: Text("Correo:", textAlign: TextAlign.start,
                                        style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Text('${email}', textAlign: TextAlign.start,),
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
