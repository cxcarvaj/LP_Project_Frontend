import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animal_rescue/screens/home/components/body.dart';
import 'package:animal_rescue/services/Authentication.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xffe8d39f),
        onPressed: (){
          _settingModalBottomSheet(context, authService);
        },
        child: new Icon(Icons.input , color: Colors.white,),
      ),

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xffFFEFCA),
      title: Center(child: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),),
      elevation: 1,
      leading: IconButton(
        icon:Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.transparent,),
          color: Colors.transparent,
          onPressed: (){},
        )
      ],
      centerTitle: true,

    );
  }

  void _settingModalBottomSheet(context, authService){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.account_circle),
                    title: new Text('Cerrar Sesión'),
                    onTap: ()  {
                      authService.logOut();
                      Navigator.pop(context);
                    }
                ),

              ],
            ),
          );
        }
    );
  }
}

