import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  final String mascota;
  final String especie;
  final String sexo;
  final int edad;
  final String caracteristica;
  final Function press;
  const PetCard({
    this.mascota, this.caracteristica, this.especie, this.edad, this.sexo,
    this.press,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        child: Column(
          children: <Widget>[
            Center(child: Padding(
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
                                  child: Text('${mascota}', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('${especie}'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('${sexo}'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('${caracteristica}'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('${edad}'),
                                ),
                              ],
                            ),
                          ),

                        ]
                    )

                )
            )
            ),
          ],
        ),
      )

    );
  }


}