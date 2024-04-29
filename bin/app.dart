import 'dart:io';
import 'usuario.dart';

menuInicial() {
  menuInicial() {
    int? opcion;
    do {
      stdout.writeln('''Elige una opción
      1 - Crear usuario
      2 - Log in''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (_menuinicialrespuestanovalida(opcion));
    switch (opcion) {
      case 1:
        registrarusuario();
        break;
      case 2:
        login();
        break;
    }
  }
}

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

bool _menuinicialrespuestanovalida(var opcion) =>
    opcion == null || opcion != 1 && opcion != 2;
