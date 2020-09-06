import 'package:animal_rescue/models/AppIcon.dart';
import 'package:flutter/material.dart';
import 'item_card.dart';
import 'package:animal_rescue/screens/form/form_screen.dart';
import 'package:animal_rescue/screens/sponsor/sponsor_screen.dart';

class Body extends StatelessWidget {
  var pages =[ HomeSponsor(), HomeMaterial(),HomeMaterial(),];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Animal Rescue",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: 3,
                itemBuilder: (context, index) => ItemCard(
                  appIcon: appIcons[index],
                  press: ()=>Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> pages[index]),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
