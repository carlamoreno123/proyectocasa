import 'dart:io';
import 'usuario.dart';
import 'database.dart';
import 'valoraciontienda.dart';

class app {
  //Constructores

  menuInicial() {
    int? opcion;
    do {
      stdout.writeln('''Elige una opción
      1 - Crear usuario
      2 - Registrarse como admin
      3 - Log in''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (_menuinicialrespuestanovalida(opcion));
    switch (opcion) {
      case 1:
        registrarusuario();
        break;
      case 2:
        comprobarAdmin();
        break;
      case 3:
        login();
        break;
    }
  }

  comprobarAdmin() {
    String? respuesta = stdin.readLineSync() ?? 'e';
    if (respuesta == 'porno') {
      registrarAdmin();
    }
    print('contraseña incorrecta');
  }

  registrarAdmin() {
    Usuario usuario = Usuario();
    stdout.write(
        '''Hola, bienvenido estas apunto de resgistrarte en este centro comercial, porfavor
      rellene estos datos:''');
    stdout.write('1- nombre:');
    usuario.nombre = stdin.readLineSync();
    stdout.write('2-apelido:');
    usuario.apellido = stdin.readLineSync();
    stdout.write('3-contraseña:');
    usuario.password = stdin.readLineSync();
    stdout.write('4-direccion:');
    usuario.direccion = stdin.readLineSync();
    stdout.write('5-direccioncorreo:');
    usuario.direccioncorreo = stdin.readLineSync();
    usuario.admin = true;
    usuario.insertarUsuario();
  }

  registrarusuario() async {
    Usuario usuario = Usuario();
    stdout.write(
        '''Hola, bienvenido estas apunto de resgistrarte en este centro comercial, porfavor
      rellene estos datos:''');
    stdout.write('1- nombre:');
    usuario.nombre = stdin.readLineSync();
    stdout.write('2-apelido:');
    usuario.apellido = stdin.readLineSync();
    stdout.write('3-contraseña:');
    usuario.password = stdin.readLineSync();
    stdout.write('4-direccion:');
    usuario.direccion = stdin.readLineSync();
    stdout.write('5-direccioncorreo:');
    usuario.direccioncorreo = stdin.readLineSync();
    usuario.insertarUsuario();
  }

  menuLogueado(usuario) async {
    int? opcion;
    do {
      stdout.writeln('''Hola, ${usuario.nombre}, elige una opción
      1 - dejar valoración
      2 - salir
      ''');
      opcion = parsearrespuesta();
    } while (_menulogueadorespuestanovalida(opcion));
    switch (opcion) {
      case 1:
        crearValoracion(usuario);
        break;
      case 2:
        print('adios!');
        break;
    }
  }

  crearValoracion(usuario) {
    Valoraciontienda valoracion = Valoraciontienda();
    valoracion.idusuario = usuario.idusuario;
    valoracion.tienda = elegirTienda();
    stdout.write('deja tu valoración:');
    valoracion.valoracion = stdin.readLineSync();
    valoracion.insertarValoracion();
  }

  elegirTienda() {
    Map<int, String> tiendas = {1: 'Zara', 2: 'Carrefour'};
    int? opcion;
    do {
      stdout.writeln('''Elige una tienda:
      1 -> Zara
      2 -> Carrefour''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while (opcion == null || opcion != 1 && opcion != 2);
    return tiendas[opcion];
  }

  menuAdmin(usuario) {
    int? opcion;
    do {
      stdout.writeln('''Hola, ${usuario.nombre}, elige una opción
      1- sumar ingresos totales
      2 - ver valoraciones
      3-salir
      ''');
      opcion = parsearrespuesta();
    } while (_menulogueadorespuestanovalida(opcion));
    switch (opcion) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        print('adios!');
        break;
    }
  }

  login() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce tu nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();
    if (resultado == false) {
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicial();
    } else {
      if (usuario.admin) {
        menuAdmin(usuario);
      }
      menuLogueado(resultado);
    }
  }
}

bool _menuinicialrespuestanovalida(var opcion) =>
    opcion == null || opcion != 1 && opcion != 2 && opcion != 3;
bool _menulogueadorespuestanovalida(var opcion) =>
    opcion == null || opcion != 1 && opcion != 2 && opcion != 3 && opcion != 4;
int? parsearrespuesta() => int.tryParse(stdin.readLineSync() ?? 'e');
