class AppIcon {
  final String image, title;

  AppIcon({
    this.image,
    this.title,
  });
}

List<AppIcon> appIcons = [
  AppIcon(
    title: 'Apdrinar Mascotas',
    image: 'assets/images/ApadrinarMascotas.png',
  ),
  AppIcon(
    title: "Reportar Mascota",
    image: "assets/images/ReporteMascota.png",
  ),
  AppIcon(
    title: "Mascota Perdidas",
    image: "assets/images/mascotasPorAdoptar.png",
  ),
];
