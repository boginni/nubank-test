# Nubank - Teste Técnico

Esse projeto é um teste técnico para qualificação no processo seletivo do Nubank.

## Exemplo de Execução

<details>
  <summary><b>Clique aqui para ver o vídeo de demonstração</b></summary>

  <br>

<video src="https://github.com/user-attachments/assets/d093af70-7e89-4f97-b9b9-0c44a59ad096" width="600" controls></video>

</details>

## Tecnologias

- **Flutter** - Escolhi porque é a tecnologia na qual sou especialista. Mas, dando uma visão
  técnica, ser multiplataforma compilado com código nativo e o uso de motores gráficos da própria
  plataforma o tornam a melhor escolha quando se visa consistência de UI e desempenho.

## Arquitetura

- **Clean Architecture** - Utilizada para garantir a escalabilidade e por se alinhar perfeitamente
  com os princípios de separação de conceitos e SOLID.

- **Injeção de dependências** - Utilizei o GetIt como Service Locator e o Go Router para instanciar
  as dependências. A combinação deles garante que elas serão invocadas apenas na declaração da rota,
  evitando causar obscurecimento de dependências e alto acoplamento.

- **Gerenciamento de estado** - Usando o padrão de projeto BLoC, implementei o State Pattern para
  ser usado com o ChangeNotifier, sendo essa uma das formas mais próximas do nativo para fazer o
  gerenciamento.

## Melhorias

Tendo em vista a limitação de tempo para a entrega do projeto, várias funcionalidades que eu
adoraria implementar foram deixadas de lado para focar no essencial. Como cada nova feature aumenta
a área em que bugs podem ocorrer e também exige testes e revisão, algumas das melhorias consideradas
para o desenvolvimento futuro foram:

- Scroll infinito (*endless scroll*) na listagem do histórico de URLs encurtadas.
- Tratamento de erros mais avançado, como problemas de CORS e permissões.
- Tela ou modal com detalhes de cada URL encurtada.
- Configurações de tema e internacionalização (l10n).
- Uso do Alice para interceptar requisições e mostrar erros.
- Implementação de Deeplinks para demonstrar domínio sólido em navegação.

## Executando o Projeto

Este projeto foi desenvolvido com foco na versão do Flutter 3.44.0, sendo esta a versão recomendada
para a execução.

1. Rode o comando do Flutter (ele resolverá as dependências sozinho):
   `flutter run`

2. Se os arquivos de internacionalização não forem gerados, force a geração manual:
   `cd packages/nu_l10n`
   `flutter gen-l10n`

## Executando os Testes

**Aviso**: Os *Golden Tests* foram feitos para serem executados no macOS e podem não funcionar
corretamente em outras plataformas!

1. Rode os testes principais:
   `flutter test`

2. Para rodar também os testes do Design System:
   `cd packages/nu_design_system/`
   `flutter test`

## Projetos Similares

Infelizmente, as instruções do teste solicitam para não colocar informações pessoais, então vou
deixar esta seção em branco.
