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
  int? vecesidas = 0;
  int? dinerogastado = 0;

  String?usuarioadmin;
  int? idusuarioadmin;
  String? nombreadmin;
  String? passwordadmin;
  String? tiendaperteneciente;
  int? dinerototaltienda;
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
        } else {
          return false;
        }
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
      if (password == usuario.password) {
        return usuario;
      } else {
        return false;
      }
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
          'INSERT INTO usuarios(nombre,apellido,password,direccion,direccioncorreo,vecesidas,dinerogastado) VALUES (?,?,?,?,?,?,?)',
          [nombre, apellido, password, direccion, direccioncorreo,vecesidas,dinerogastado]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
   insertarUsuarioAdmin() async {
    var conn = await Database().conexion();
    try {
      await conn.query(
          'INSERT INTO usuarioadmin(idusuarioadmin,nombreadmin,passwordadmin,tiendaperteneciente) VALUES (?,?,?,?)',
          [idusuarioadmin,nombreadmin,passwordadmin,tiendaperteneciente]);
      print('Usuario admin insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}