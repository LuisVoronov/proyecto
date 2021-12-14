import 'dart:io';
import 'package:proyecto/modelo/producto_dto.dart';
import 'package:proyecto/modelo/tienda_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class BaseDatos
{
  static late Database _database;
  final String _dataBaseName = "pedidosEnLinea.db";
  BaseDatos._();
  static final BaseDatos db = BaseDatos._();
  var bd_init = false;

  //#region Creación de tablas
  final String _CREATE_TIENDAS = "CREATE TABLE Tiendas("
      "id INTEGER PRIMARY KEY,"
      "nombre TEXT,"
      "direccion TEXT,"
      "telefono TEXT,"
      "correo TEXT,"
      "tipo TEXT,"
      "logo TEXT,"
      "coordenadas TEXT"
      ")";

  final String _CREATE_PEDIDOS = "CREATE TABLE Pedidos("
      "idTienda INTEGER,"
      "id INTEGER,"
      "nombre TEXT,"
      "unidad TEXT,"
      "precio REAL,"
      "compra INTEGER"
      ")";
  //#endregion

  Future<Database> get database async
  {
    if(bd_init)
      {
        return _database;
      }
    else
      {
        _database = await iniciarBaseDatos();
        bd_init = true;
      }
    return _database;
  }

  iniciarBaseDatos() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dataBaseName);

    return await openDatabase(path, version: 6, onOpen: (db) {},
        onCreate: (Database db, int version) async
        {
          await db.execute(_CREATE_TIENDAS);
          await db.execute(_CREATE_PEDIDOS);
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async
        {
          if (oldVersion < newVersion)
          {
            await db.execute("DROP TABLE IF EXISTS Tiendas");
            await db.execute(_CREATE_TIENDAS);
            await db.execute("DROP TABLE IF EXISTS Pedidos");
            await db.execute(_CREATE_PEDIDOS);
          }
        });
  }

  insertarTienda(Tienda td) async
  {
    final db = await database;
    var res = await db.insert("Tiendas", td.toJson());
    return res;
  }

  insertarProducto(Producto prd) async
  {
    final db = await database;
    var res = await db.insert("Pedidos", prd.toJson());
    return res;
  }

  Future<List<Tienda>> selectTiendas(String query) async
  {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Tienda> list = [];
    if (res.isNotEmpty)
    {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp)
      {
        list.add(Tienda.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Producto>> selectPedido() async
  {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM Pedidos');
    List<Producto> list = [];
    if (res.isNotEmpty)
    {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp)
      {
        list.add(Producto.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Producto>> deletePedido(Producto prt) async
  {
    final db = await database;
    var res = await db.rawQuery('DELETE FROM Pedidos ' + 'WHERE idTienda =' + prt.idTienda.toString() + ' AND ' + 'id =' + prt.id.toString() + ' AND ' + 'compra =' + prt.compra.toString());
    List<Producto> list = [];

    if (res.isNotEmpty)
    {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp)
      {
        list.add(Producto.fromJson(t));
      }
    }
    return list;
  }
}