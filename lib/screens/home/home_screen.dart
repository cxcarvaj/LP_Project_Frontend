import 'package:flutter/material.dart';
import 'package:animal_rescue/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
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
}
