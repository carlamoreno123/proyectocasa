import 'dart:io';
import 'app.dart';
import 'database.dart';

class Usuario {
  //propiedades
  int? idusuario;
  String? nombre;
  String? apellido;
  String? password;
  String? direccion;
  String? direccioncorreo;
  bool admin = false;

  //Constructores

  Usuario();
  Usuario.fromMap(map) {
    this.idusuario = map['idusuario'];
    this.nombre = map['nombre'];
    this.password = map['password'];
    this.direccion = map['direccion'];
    this.direccioncorreo = map['direccioncorreo'];

    //Metodos
    LoginUsuario() async {
      var conn = await Database().conexion();
      try {
        var resultado = await conn
            .query('SELECT * FROM usuarios WHERE nombre = ?', [this.nombre]);
        Usuario usuario = Usuario.fromMap(resultado.first);
        if (this.password == usuario.password) {
          return usuario;
        } else
          return false;
      } catch (e) {
        print(e);
        return false;
      } finally {
        await conn.close();
      }
    }
  }

  loginUsuario() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn
          .query('SELECT * FROM usuarios WHERE nombre = ?', [this.nombre]);
      Usuario usuario = Usuario.fromMap(resultado.first);
      if (this.password == usuario.password) {
        return usuario;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }

  all() async {
    var conn = await Database().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM usuarios');
      List<Usuario> usuarios =
          resultado.map((row) => Usuario.fromMap(row)).toList();
      return usuarios;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  insertarUsuario() async {
    var conn = await Database().conexion();
    try {
      await conn.query(
          'INSERT INTO jugador(nombre,apellido,password,direccion,direccioncorreo) VALUES (?,?,?,?,?)',
          [nombre, apellido, password, direccion, direccioncorreo]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}
