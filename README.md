# Cronômetro de Voltas - Cronotimer

Este é um aplicativo mobile desenvolvido em **Flutter** utilizando o padrão **MVVM** para gerenciar um cronômetro de voltas. O app inclui **notificações locais** e **recursos de acessibilidade** para garantir que todos os usuários possam utilizar a aplicação de forma eficiente.

---

## Funcionalidades

* **Iniciar, pausar e reiniciar o cronômetro**.
* **Registrar voltas**, mostrando o tempo de cada volta e o tempo total.
* **Notificação persistente** enquanto o cronômetro está em execução.
* **Notificações de voltas registradas** com detalhes do tempo.
* **Notificação de lembrete** quando o cronômetro permanece pausado por mais de 10 segundos.
* **Acessibilidade** utilizando widgets `Semantics` para leitores de tela.
* Interface simples e responsiva, adaptada a diferentes tamanhos de tela.

---

## Pacotes Utilizados

* [provider](https://pub.dev/packages/provider) — Gerenciamento de estado MVVM.
* [flutter\_local\_notifications](https://pub.dev/packages/flutter_local_notifications) — Notificações locais para Android e iOS.
* [intl](https://pub.dev/packages/intl) — Formatação de durações e tempos (opcional).

---

## Estrutura do Projeto

```
lib/
├── model/
│   └── timer_lap.dart        # Model da volta do cronômetro
│   └── timer_model.dart      # Model do cronômetro
├── viewModel/
│   ├── timer_viewmodel.dart  # Lógica do cronômetro
│   └── notification_service.dart # Serviço de notificações
│   └── notification_viewmodel.dart # viewmodel das notificações
├── views/
│   └── timer_view.dart       # UI do cronômetro
└── main.dart                 # Entrada principal do app
```

---

## Como Rodar

1. Clone o repositório:

```bash
git clone (https://github.com/shinzola/Cronotimer.git)
```

2. Entre na pasta do projeto:

```bash
cd cronometro_mobile2
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o app em modo debug ou release:

```bash
flutter run
```

> Certifique-se de ter um dispositivo ou emulador conectado.

---

## Notificações

* **Cronômetro em execução:** notificação persistente indicando o tempo atual.
* **Voltas registradas:** cada volta disparará uma notificação com o tempo da volta e o tempo total.
* **Lembrete de pausa:** se o cronômetro ficar pausado por mais de 10 segundos, será exibida uma notificação lembrando de continuar.

> Observação: As notificações exigem configuração adicional para iOS e Android, incluindo permissões no AndroidManifest.xml e no Info.plist.

---

## Acessibilidade

* Botões com **Semantics** e rótulos claros para leitores de tela.
* Leitura do **tempo decorrido** em tempo real.
* Interface com **contraste adequado** e fontes dimensionáveis.

---

## Video de funcionamento do App

https://youtube.com/shorts/s_r9WCjomHg

---

## Licença

Este projeto está sob a **MIT License**. Consulte o arquivo [LICENSE.md](./LICENSE.md) para mais detalhes.
