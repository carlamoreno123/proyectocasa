import 'dart:io';
import 'app.dart';

class Usuario {
  //propiedades
  int? idusuario;
  String? nombre;
  String? apellido;
  String? password;
  String? direccion;
  String? direccioncorreo;

  //Constructores
  Usuario();

  //Metodos
  registrarusuario() async {
    var respuesta;
    do {
      stdout.write(
          '''Hola, bienvenido estas apunto de resgistrarte en este centro comercial, porfavor
      rellene estos datos
      1- nombre:
      2-appelido:
      3-direccion
      4-direccioncorreo
    ''');
      String respuesta = stdin.readLineSync() ?? 'e';
      int.tryParse(respuesta);
    } while (respuesta == null &&
        respuesta != 1 &&
        respuesta != 2 &&
        respuesta != 3 &&
        respuesta != 4);
  }
}
