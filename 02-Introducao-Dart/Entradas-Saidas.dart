import 'dart:io';

void main() {
  const double taxaCambio = 0.85;
  
  print("Insira o valor em dólares: ");
  var valorDolares = double.parse(stdin.readLineSync()!);
  
  var valorEuros = valorDolares * taxaCambio;
  print("O valor em euros é: €$valorEuros");
}
