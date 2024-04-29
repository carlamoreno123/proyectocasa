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
    try {
      await _crearDB(conn);
      await _crearTablaUsuarios(conn);
      await conn.close();
    } catch (e) {
      print(e);
      await conn.close();
    }
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
        host: this._host,
        port: this._port,
        user: this._user,
        db: 'centrocomercialdb');

    return await MySqlConnection.connect(settings);
  }

  _crearDB(conn) async {
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
}
