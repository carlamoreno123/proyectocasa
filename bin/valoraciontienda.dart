import 'Database.dart';

class Valoraciontienda {
//propiedades
  int? idvaloracion;
  int? idusuario;
  String? tienda;
  String? valoracion;

  Valoraciontienda();
  Valoraciontienda.fromMap(map) {
    this.idvaloracion = map['idvaloracion'];
    this.idusuario = map['idusuario'];
    this.tienda = map['tienda'];
    this.valoracion = map['valoracion'];
  }

  insertarValoracion() async {
    var conn = await Database().conexion();
    try {
      await conn.query(
          'INSERT INTO jugador(idusario,tienda,valoracion) VALUES (?,?,?)',
          [idusuario, tienda, valoracion]);
      print('Valoracion insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}
