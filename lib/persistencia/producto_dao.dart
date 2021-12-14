import 'conexion_http.dart';
import 'package:proyecto/modelo/producto_dto.dart';

class ProductosDao
{
  Future<List<Producto>> ObtenerProductosDelServidor(String idTienda) async
  {
    final List<Producto> productos = [];
    var srvConn = ServerConnection();
    await srvConn.getProductos(idTienda).then((datos_productos)
        {
          var records = datos_productos.split('|');
          records.forEach((element)
          {
            productos.add(Producto.fromString(idTienda+';'+element));
          });
        });
    return productos;
  }
}