import 'dart:io';

void main() {
  print("Insira um número: ");
  var number = int.parse(stdin.readLineSync()!);
  for (var i = 1; i <= number; i++) {
    if (isPrime(i)) {
      print(i);
    }
  }
}

bool isPrime(int n) {
  if (n <= 1) return false;
  for (var i = 2; i <= n / 2; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}
