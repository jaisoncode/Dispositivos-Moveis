import 'dart:io';

void main() {
  print("Digite um número: ");
  var num = int.parse(stdin.readLineSync()!);
  
  if (num > 0) {
    print("O número é positivo.");
  } else if (num < 0) {
    print("O número é negativo.");
  } else {
    print("O número é zero.");
  }
}
