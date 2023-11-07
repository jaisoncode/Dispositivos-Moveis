## 🚀 Aplicativo Flutter de Contador (trabalha conceitos de rotas)

Permite fazer login e direcionar a tela para o contador, caso as credencias forem falsas um poupap informará. Na HomePage, permite que os usuários incrementem, decrementem e reiniciem um contador por meio de botões interativos. Abaixo estão os detalhes do código:

### Estrutura do Projeto

- `main.dart`: Arquivo principal contendo a implementação do aplicativo Flutter de contador.
- `login.dart`: Arquivo que contém a implementação da página de login.
- `home_page.dart`: Arquivo que contém a implementação da tela principal do aplicativo.

### Implementação em Flutter

O aplicativo usa o framework Flutter para construir a interface do usuário. Ele consiste em:

- Uma classe `MyApp` que é o ponto de entrada do aplicativo e define o tema global.
- Uma classe `Login` que representa a página de login e permite ao usuário fazer login com um e-mail e senha.
- Uma classe `MyHomePage` que representa a página inicial do aplicativo e possui um contador que pode ser incrementado, decrementado e reiniciado.
- Vários widgets do Flutter, como `Scaffold`, `AppBar`, `Text`, `Row`, `Column`, `ElevatedButton` e `FloatingActionButton`, que são usados para construir a interface do aplicativo.

### Funcionalidades

- `Incrementar contador`: Permite aumentar o valor do contador em 1.
- `Decrementar contador`: Permite diminuir o valor do contador em 1.
- `Reiniciar contador`: Define o valor do contador de volta para 0.
- `Login e Logout`: Permite que o usuário faça login na tela de login e navegue para a tela principal. Além disso, na tela principal, há um botão de logout para retornar o usuário para a tela de login.

### Capturas de Tela

Aqui está uma captura de tela do aplicativo em execução:

<img src="https://github.com/jaisoncode/Dispositivos-Moveis-Dart-Flutter/assets/138302102/444c9e0a-1d76-434d-a1f0-17255589f75e" alt="Captura de tela do aplicativo" width="20%">

---

<p align="center">
  <sub>Feito com ❤️ por <strong>Jaison</strong></sub>
</p>
