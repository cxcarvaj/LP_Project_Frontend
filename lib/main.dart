import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var obj = {
      'Apdrinar Mascotas': 'assets/images/ApadrinarMascotas.png',
      'Reportar Mascota': 'assets/images/ReporteMascota.png',
      'Mascotas Perdidas': 'assets/images/mascotasPorAdoptar.png',
    };
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellow[50],
          title: Center(
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),
          automaticallyImplyLeading: true,
          titleSpacing: -29,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            // onPressed: ()=> Navigator.pop(context,true),
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: List.generate(
            3,
            (index) {
              return GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(top:5.0),
                    width: 120,
                    height: 40,
                    child: Text(obj.keys.toList()[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                          image:
                              AssetImage(obj.values.toList()[index].toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    print("you clicked me");
                  });
            },
          ),
        ),
      ),
    );
  }
}
