import 'package:flutter/material.dart';
import 'package:animal_rescue/models/AppIcon.dart';


class ItemCard extends StatelessWidget {
  final AppIcon appIcon;
  final Function press;
  
  const ItemCard({
    this.appIcon,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: appIcon.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${appIcon.id}",
                child: Image.asset(appIcon.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
          ),
          Center(
            child: Text(
              "${appIcon.title}",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
