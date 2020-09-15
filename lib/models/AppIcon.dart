import 'package:flutter/material.dart';

class AppIcon {
  final int id;
  final String image, title;
  final Color color;

  AppIcon({
    this.id,
    this.image,
    this.title,
    this.color,
  });
}

List<AppIcon> appIcons = [
  AppIcon(
    id:1,
    title: "Reportar Mascota",
    image: "assets/images/report.png",
    color: Color(0xffe2dfe6),
  ),
  AppIcon(
    id:2,
    title: "Mascota Perdidas",
    image: "assets/images/dogicon.png",
    color: Color(0xffd9fcc2),
  ),
  AppIcon(
    id:3,
    title: 'Apadrinar Mascotas',
    image: 'assets/images/apadrina.png',
    color: Color(0xffc8ebe4),
  ),
];
