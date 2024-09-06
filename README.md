# DigioStore

## Sobre o App

O app foi desenvolvido com base nos pedidos do teste da Digio

## Como começar

Usar o xcode 15.4 ou superior.

Usar o SwiftLint

> É preciso configurar o SwiftLint na sua própria máquina, siga o tutorial do link abaixo:
> https://github.com/realm/SwiftLint

## Definições técnicas

#### Arquitetura
Foi escolhido a arquitetura [VIP](https://clean-swift.com/) para manter separado todas as responsabilidades e termos um projeto que tenha fácil manutenção, testável e escalável.

>> ```View```: Este componente é para exibir dados na tela e capturar interações do usuário. Ele consiste em Views e ViewControllers.

>> ```Interactor```: O Interactor é responsável por manipular a lógica de negócios e manipulação de dados. Ele se comunica com o Presenter para atualizar a View com novos dados.

>> ```Presenter```: O Presenter serve como uma ponte entre a View e o Interactor.

>> ```Router```: O Router é usado para lógica de navegação.

>> ```Worker```: O Worker é usado para solicitações à API ou ao Banco de Dados para buscar dados.

#### Comunicação com o backend
Muitos desenvolvedores escolhem usar libs como [```Alamofire```](https://github.com/Alamofire/Alamofire), [```Moya```](https://github.com/Moya/Moya) entre outros, mas essas bibliotecas nada mais são que camadas de abstração do [```URLSession```](https://developer.apple.com/documentation/foundation/urlsession), por se tratar de um projeto de teste não achei necessário usar nenhuma lib, mantendo o [```URLSession```](https://developer.apple.com/documentation/foundation/urlsession) e utilizando o [```Codable```](https://developer.apple.com/documentation/swift/codable) para tratar o decoder das respostas do servidor, mas ainda assim criei uma camada de abstração que utiliza [```Generics```](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/) para evitar código [```Boilerplate```](https://en.wikipedia.org/wiki/Boilerplate_code).

#### Layout
Sabemos que nos dias atuais é de extrema importância desenvolver de forma modular as funções do sistema, por este motivo todo o projeto foi desenvolvido utilizando ViewCode com o [UIKit](https://developer.apple.com/documentation/uikit/).

#### Testes unitários
Utilizei o XCTest para implementar um teste únitario na camada da ```Home```, considerando 2 cenários, no ```sucesso do recebimento``` dos dados e no ```erro de parse```.

#### Fastlane
Foi adicionado no projeto, mas apenas para automatizar os testes com o [```scan```](https://docs.fastlane.tools/actions/scan/).

### Dependências
Foi utilizado o mínimo possível de dependências pensando em segurança para evitar usar lib de terceiros e demonstrar todo o conhecimento nos frameworks que a própria Apple disponibiliza.

>> Gerenciador útilizado [Swift Package Manager](https://www.swift.org/documentation/package-manager/)

[SwiftLint](https://github.com/realm/swiftlint)
>> O SwiftLint impõe as regras do guia de estilo que são geralmente aceitas pela comunidade Swift. [Leia mais](https://github.com/kodecocodes/swift-style-guide)
