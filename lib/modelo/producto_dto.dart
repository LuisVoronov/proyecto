class Producto
{
  late int idTienda;
  late int id;
  late String nombre;
  late String unidad;
  late double precio;
  late int compra;

  Producto(this.idTienda, this.id, this.nombre, this.unidad, this.precio, this.compra);

  Producto.fromString(String datos)
  {
    List<String> Tokens = datos.split(';'); //Divide la cadena recibida al encontrar un ;
    this.idTienda = int.parse(Tokens[0]);
    this.id = int.parse(Tokens[1]);
    this.nombre = Tokens[2];
    this.unidad = Tokens[3];
    this.precio = double.parse(Tokens[4]);
    this.compra = 0;
  }

  Producto.fromJson(Map<String, dynamic> json)
      : idTienda = int.parse(json['idTienda'].toString()),
        id = int.parse(json['id'].toString()),
        nombre = json['nombre'].toString(),
        unidad = json['unidad'].toString(),
        precio = double.parse(json['precio'].toString()),
        compra = int.parse(json['compra'].toString());

  Map<String, dynamic> toJson() => {
        "idTienda": idTienda,
        "id": id,
        "nombre": nombre,
        "unidad": unidad,
        "precio": precio,
        "compra": compra
      };
}