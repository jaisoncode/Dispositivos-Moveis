import 'Pizza.dart';
import 'main.dart';

class Pedido {
  int? _codigo;
  DateTime? _data;
  List<Pizza>? _pizzas;
  double? _valor;

  Pedido(int codigo, DateTime date, double valor){
    this._codigo = codigo;
    this._data = date;
    this._pizzas = [];
    this._valor = valor;
  }

  void adiconarPizza(int codigoPizza){
    pizzaList.forEach((pizza) {
      if(pizza.codigo == codigoPizza) {
        _pizzas?.add(pizza);
      }
    });
  }

  double? get valor => _valor;

  set valor(double? value) {
    _valor = value;
  }

  List<Pizza>? get pizzas => _pizzas;

  set pizzas(List<Pizza>? value) {
    _pizzas = value;
  }

  DateTime? get data => _data;

  set data(DateTime? value) {
    _data = value;
  }

  int? get codigo => _codigo;

  set codigo(int? value) {
    _codigo = value;
  }

  String? emitirNota() {
    String nota = "------------  NOTA FISCAL  -------------\n";
    nota += "| Pedido realizado em: ${_data} |\n";
    double valorTotal = 0;
    _pizzas?.forEach((pizzasPedidas) {
      valorTotal += pizzasPedidas.valor!;
      nota += "item -> cod: ${pizzasPedidas.codigo}, Sabor: ${pizzasPedidas.sabor} | Valor: ${pizzasPedidas.valor} \n";
    });
    nota += "-------- VALOR TOTAL: ${valorTotal} R\$ ---------";
    return nota;
  }

  @override
  String toString() {
    String nota = "\n------------  COD PEDIDO: $_codigo  -------------\n";
    nota += "| Pedido realizado em: ${_data} |\n";
    double valorTotal = 0;
    _pizzas?.forEach((pizzasPedidas) {
      valorTotal += pizzasPedidas.valor!;
      nota += "item -> cod: ${pizzasPedidas.codigo}, Sabor: ${pizzasPedidas.sabor} | Valor: ${pizzasPedidas.valor} \n";
    });
    nota += "-------- VALOR TOTAL: ${valorTotal} R\$ ---------";
    return nota;
  }

}