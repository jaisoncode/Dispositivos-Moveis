import 'Conta.dart';
class Titular {
  static int _geraId = 1;
  int? _id;
  String? _nome;
  List<Conta>? _contasTitular;

  Titular(String nomeDoTitular) {
    this.id = _geraId++;
    this._nome = nomeDoTitular;
    this.contasTitular = [];
  }

  void adicionarConta(Conta conta) {
    this._contasTitular?.add(conta);
  }


  int? get getId => _id;

  set id(int? value) {
    _id = value;
  }

  String? get getNome => _nome;

  void set setNome(String? value) {
    _nome = value;
  }

  List<Conta>? get getContasTitular => _contasTitular;

  set contasTitular(List<Conta>? value) {
    _contasTitular = value;
  }

  @override
  String toString() {
    String contasStr = "";
    for (var conta in getContasTitular!) {
      contasStr += ' $conta \n'; //
    }
    return 'Titular -> nome: $getNome, id: $getId \n $contasStr';
  }
}