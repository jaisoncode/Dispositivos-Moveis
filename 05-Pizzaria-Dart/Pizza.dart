import 'main.dart';

class Pizza{
  int? _codigo;
  String? _sabor;
  double? _valor;


  Pizza(int codigo, String sabor, double valor){
    this._codigo = codigo;
    this._sabor = sabor;
    this._valor = valor;
  }

  double? get valor => _valor;

  set valor(double? value) {
    _valor = value;
  }

  String? get sabor => _sabor;

  set sabor(String? value) {
    _sabor = value;
  }

  int? get codigo => _codigo;

  set codigo(int? value) {
    _codigo = value;
  }

}