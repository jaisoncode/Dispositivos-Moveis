import 'Titular.dart';
class Conta {
  static int _geraId = 1;
  int? _id;
  String? _descricao;
  int? _numeroConta;
  double? _saldo;
  Titular? _titularDaConta;

  Conta(String descricao, int numeroConta, Titular titularDaConta) {
    this.id = _geraId++;
    this._saldo = 0;
    this.descricao = descricao;
    this.numeroConta = numeroConta;
    this.titularDaConta = titularDaConta;
  }

  int? get getId => _id;

  set id(int? value) {
    _id = value;
  }

  String? get getDescricao => _descricao;

  set descricao(String? value) {
    _descricao = value;
  }

  int? get getNumeroConta => _numeroConta;

  set numeroConta(int? value) {
    _numeroConta = value;
  }

  double? get getSaldo => _saldo;

  set setSaldo(double? value) {
    _saldo = value;
  }

  Titular? get getTitularDaConta => _titularDaConta;

  set titularDaConta(Titular? value) {
    _titularDaConta = value;
  }

  @override
  String toString() {
    return 'Conta ID: ${_id}, Descricao: ${_descricao}, Conta: ${_numeroConta}, Saldo: ${_saldo}.';
  }

}