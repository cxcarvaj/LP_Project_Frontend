class Formulario {
  static const String Male = "Male";
  static const String Female = "Female";
  static const String Lost = "Perdido";
  static const String Need = "Necesitado";



  String petsName = '';
  String especie = '';
  int edad = 0;
  Map<String, bool> sex = {
    Male: false,
    Female: false,
  };
  String desc = "";
  Map<String, bool> estados = {
    Lost: true,
    Need: false,
  };
  double cordX = 0.0;
  double cordY = 0.0;
  String contacName = "";
  String cedula = "";
  String celular = "";

  save() {
    print('Guardando registro de mascota perdida!');
  }
}
