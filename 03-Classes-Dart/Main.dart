import 'Conta.dart';

void main() {
  var conta1 = Conta('João', 1000);
  var conta2 = Conta('Maria', 500);

  print('Saldo inicial da Conta 1:');
  conta1.mostrarSaldo();
  print('Saldo inicial da Conta 2:');
  conta2.mostrarSaldo();

  conta1.sacar(300);
  conta2.depositar(300);

  print('Novo saldo da Conta 1 após saque:');
  conta1.mostrarSaldo();
  print('Novo saldo da Conta 2 após depósito:');
  conta2.mostrarSaldo();

  conta1.transferir(conta2, 200);

  print('Saldo final da Conta 1 após transferência:');
  conta1.mostrarSaldo();
  print('Saldo final da Conta 2 após transferência:');
  conta2.mostrarSaldo();
}
