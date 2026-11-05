# AGENTS.md

## Visão geral

O projeto será um site pessoal inspirado na série Supernatural. A ideia é organizar personagens, episódios e momentos marcantes, com avaliações e comentários pessoais. O objetivo é captar informaçoes via formulario, gravar no banco de dados local e dashboard com as informacoes obtidas.

O projeto é um trabalho academico que tem como objetivo colocar em prática todo o conteudo aprendido no semestre para fixação e aprendizado.

## Tecnologias

HTML, CSS, JavaScript, Node.js, Express e MySQL.

## Comandos

- npm i — instalar as dependências listadas no package.json.
- npm start — iniciar a aplicação com node app.js.
Para encerrar a aplicação, usar Ctrl+C no terminal em que ela estiver rodando.

## Arquitetura

- routes: recebe e encaminha as requisições.
- controllers: trata a lógica da requisição.
- models: acessa o banco de dados.
- app.js: configuração principal da aplicação.
O fluxo esperado é formulário no site → rota → controller → model → MySQL.

## Padrões de desenvolvimento

- Priorize soluções simples, legíveis e compatíveis com as tecnologias existentes.
- Utilize HTML semântico, CSS organizado e JavaScript nativo.
- Utilize const por padrão e let somente quando houver necessidade de reatribuição.
- Utilize camelCase para variáveis e funções JavaScript.
- Utilize nomes descritivos para arquivos, funções, variáveis e elementos.
- Reutilize funções e componentes existentes, evitando duplicação de código.
- Siga o padrão de nomenclatura e formatação já adotado no projeto.
- Utilize commits objetivos, preferencialmente com os prefixos feat:, fix:, refactor: e docs:.

## Cuidados e restrições

- Não adicione frameworks, dependências ou ferramentas sem necessidade.
- Não introduza arquiteturas complexas ou novas camadas sem justificativa.
- Não exponha credenciais, senhas ou configurações sensíveis no frontend ou no repositório.
- Não utilize concatenação de dados do usuário em consultas SQL.
- Evite inserir conteúdo não confiável com innerHTML.
- Não altere o esquema do banco, contratos da API ou funcionalidades existentes sem analisar os impactos.

Não gerar o projeto inteiro de uma vez. Usar IA para tirar dúvidas, revisar e ajudar com trechos de código, entendendo o que cada parte faz. Não adicionar tecnologias ou bibliotecas sem justificativa e aprovação do professor. Não alterar a arquitetura do projeto de referência. O site será pessoal e não comercial.

## Regra geral: 

Antes de implementar uma alteração, siga as tecnologias, arquitetura, convenções e restrições descritas neste documento. Caso alguma informação esteja ausente, analise o código existente e siga os padrões já adotados no projeto.
Não invente estruturas ou dependências sem necessidade.