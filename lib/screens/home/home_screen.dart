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
        onPressed: (){
          _settingModalBottomSheet(context, authService);
        },
        child: new Icon(Icons.input),
      ),

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.yellowAccent[100],
      title: Text("Home", style: TextStyle(color: Colors.black)),
      elevation: 0,
      leading: IconButton(
        icon:Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () {},
      ),
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
                    }
                ),

              ],
            ),
          );
        }
    );
  }
}

