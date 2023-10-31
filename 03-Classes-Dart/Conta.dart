class Conta {
  late String _titular;
  late double _saldo;

  Conta(this._titular, this._saldo);

  String get titular => _titular;

  set titular(String value) {
    _titular = value;
  }

  double get saldo => _saldo;

  set saldo(double value) {
    _saldo = value;
  }

  void sacar(double valor) {
    if (valor <= _saldo) {
      _saldo -= valor;
      print('Saque de $valor realizado. Saldo restante: $_saldo');
    } else {
      print('Saldo insuficiente para saque.');
    }
  }

  void depositar(double valor) {
    _saldo += valor;
    print('Depósito de $valor realizado. Novo saldo: $_saldo');
  }

  void transferir(Conta destino, double valor) {
    if (valor <= _saldo) {
      this.sacar(valor);
      destino.depositar(valor);
      print('Transferência de $valor realizada para ${destino.titular}');
    } else {
      print('Saldo insuficiente para transferência.');
    }
  }

  void mostrarSaldo() {
    print('Saldo atual: $_saldo');
  }
}