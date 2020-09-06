class AppIcon {
  final int id;
  final String image, title;

  AppIcon({
    this.id,
    this.image,
    this.title,
  });
}

List<AppIcon> appIcons = [
  AppIcon(
    id:1,
    title: 'Apadrinar Mascotas',
    image: 'assets/images/ApadrinarMascotas.png',
  ),
  AppIcon(
    id:2,
    title: "Reportar Mascota",
    image: "assets/images/ReporteMascota.png",
  ),
  AppIcon(
    id:3,
    title: "Mascota Perdidas",
    image: "assets/images/mascotasPorAdoptar.png",
  ),
];
