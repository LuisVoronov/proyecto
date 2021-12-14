enum TipoNegocio { Tienda, Drogueria, Lavanderia, Pizzeria, Ferreteria }

class Tienda
{
  String id;
  String nombre;
  String direccion;
  String telefono;
  String correo;
  TipoNegocio tipo;
  String logo;
  String coordenadas;

  Tienda(
      {required this.id,
      required this.nombre,
      required this.direccion,
      required this.telefono,
      required this.correo,
      required this.tipo,
      required this.logo,
      required this.coordenadas});

  Tienda.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        nombre = json['nombre'].toString(),
        direccion = json['direccion'].toString(),
        telefono = json['telefono'].toString(),
        correo = json['correo'].toString(),
        tipo = TipoNegocio.values.firstWhere((element) => element.toString() == json['tipo'].toString()),
        logo = json['logo'],
        coordenadas = json['coordenadas'].toString();

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "correo": correo,
        "tipo": tipo.toString(),
        "logo": logo,
        "coordenadas": coordenadas
      };
}
