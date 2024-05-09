import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaUsuarioAdmin(conn);
      await _crearTablaingresos(conn);
      await _crearTablavaloraciones(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'centrocomercialdb'
    );
      
    return await MySqlConnection.connect(settings);
 
  }
  
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS centrocomercialdb');
    await conn.query('USE centrocomercialdb');
    print('Conectado a centrocomercialdb');
  }

  _crearTablaUsuarios(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE,
        apellido VARCHAR(50) NOT NULL,
        password VARCHAR(50) NOT NULL,
        direccion VARCHAR(200) NOT NULL,
        direccioncorreo VARCHAR(50) NOT NULL,
        vecesidas INT NOT NULL,
        dinerogastado VARCHAR(20) NOT NULL
      )''');
    print('Tabla usuarios creada');
  }
  _crearTablaUsuarioAdmin(conn)async{
    await conn.query('''CREATE TABLE IF NOT EXISTS UsuarioAdmin(
        idusuarioadmin INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombreadmin VARCHAR(50) NOT NULL,
        passwordadmin VARCHAR(50) NOT NULL,
        tiendaperteneciente VARCHAR(50) NOT NULL
       )''');
    print('Tabla usuarioadmin creada');
  }
   _crearTablaingresos(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS ingresos(
        idusuarioadmin INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombreadmin VARCHAR(50) NOT NULL UNIQUE,
        dinerototaltienda INT NOT NULL
        )''');
    print('Tabla ingresos creada');
  
  }
  _crearTablavaloraciones(conn)async{
    await conn.query ('''CREATE TABLE IF NOT EXISTS valoraciones(
        idvaloracion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        idusuario INT NOT NULL,
        tiendaperteneciente VARCHAR(50) NOT NULL,
        valoraciontienda VARCHAR(200) NOT NULL
        )''');
    print('Tabla valoraciones creada');
  }
}


 
  