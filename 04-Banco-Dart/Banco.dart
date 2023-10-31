import 'Principal.dart';
import 'Titular.dart';
import 'Conta.dart';


class Banco {
  String? _nomeBanco;
  int? _idBanco;
  List<Titular>? _titulares;
  List<Conta>? _contas;

  Banco(String nome) {
    this.nomeBanco = nome;
    this.idBanco = 1;
    this.titulares = [];
    this.contas = [];
  }

  void adicionarTitular(Titular titular) {
    this._titulares?.add(titular);
  }

  void adicionarConta(Conta conta){
    this._contas?.add(conta);
  }

  Titular? editarTitular(int idParaEditar, String nome) {
    List<Titular>? titulares = banco.getTitulares;
    if (titulares != null) {
      for (Titular titular in titulares) {
        if (titular.getId == idParaEditar) {
          titular.setNome = nome;
          return titular;
        }
      }
    }
    return null;
  }

  Titular? deletarTitular(int idParaDeletar){
    List<Titular>? titulares = banco.getTitulares;
    for (Titular titular in titulares!) {
        if (titular.getId == idParaDeletar) {
          titulares.remove(titular);
          return titular;
        }
      }
    return null;
  }

  Conta? editarConta(int idParaEditar, String novaDescricao){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!) {
      if(conta.getId == idParaEditar){
        conta.descricao = novaDescricao;
        return conta;
      }
    }
    return null;
  }

  Conta? deletarContar(int idParaDeletar){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!) {
      if(conta.getId == idParaDeletar){
        contas.remove(conta);
        return conta;
      }
    }
    return null;
  }

  bool sacar(double valorSaque, int idContaOperante){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!){
      if(conta.getId == idContaOperante) {
        if (conta.getSaldo! >= valorSaque) {
          conta.setSaldo = (conta.getSaldo! - valorSaque);
          return true;
        }
      }
    }
    return false;
  }

  bool depositar(double valorDeposito, int idContaOperante){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!){
      if(conta.getId == idContaOperante) {
        if (valorDeposito > 0) {
          conta.setSaldo = (conta.getSaldo! + valorDeposito);
          return true;
        }
      }
    }
    return false;
  }

  double? exibirSaldo(int idContaOperante){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!){
      if(conta.getId == idContaOperante) {
        double? saldoAtual = conta.getSaldo;
        return saldoAtual;
      }
    }
    return null;
  }

  bool transferirSaldo(double valorTrasferido, int idMandaSaldo, int idRecebeSaldo){
    List<Conta>? contas = banco.getContas;
    for (Conta conta in contas!){
      if(conta.getId == idMandaSaldo) {
        if (valorTrasferido > 0){
          conta.setSaldo = (conta.getSaldo! - valorTrasferido);
          List<Conta>? contas = banco.getContas;
          for (Conta conta in contas!){
            if(conta.getId == idRecebeSaldo) {
              conta.setSaldo = (conta.getSaldo! + valorTrasferido);
            }
          }
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  String? get nomeBanco => _nomeBanco;

  set nomeBanco(String? value) {
    _nomeBanco = value;
  }



  int? get idBanco => _idBanco;

  set idBanco(int? value) {
    _idBanco = value;
  }

  List<Titular>? get getTitulares => _titulares;

  set titulares(List<Titular>? value) {
    _titulares = value;
  }

  List<Conta>? get getContas => _contas;

  set contas(List<Conta>? value) {
    _contas = value;
  }

  @override
  String toString() {
    String titularesStr = "Titulares do Banco $nomeBanco:\n";
    for (var titular in _titulares!) {
      titularesStr += "ID: ${titular.getId}, Nome: ${titular.getNome}\n";
    }
    return titularesStr;
  }
}


