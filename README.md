# Projeto Individual — Supernatural Fan Site

Site acadêmico inspirado na série **Supernatural** para cadastro de usuários, preferências de personagens/monstros, quiz e dashboard com visualização de dados.

---

## 📌 Sobre o projeto

Este projeto foi desenvolvido para aplicar, na prática, os conteúdos de:

- HTML
- CSS
- JavaScript (vanilla)
- Node.js + Express
- MySQL

### Funcionalidades principais

- Página inicial temática
- Catálogo de **personagens** e **monstros**
- Modais com detalhes (dados vindos da API/banco)
- Cadastro e login de usuário
- Registro de preferências (personagem/monstro)
- Quiz com pontuação
- Dashboard com:
  - preferências do usuário
  - maior pontuação no quiz
  - ranking de personagens e monstros (Top 5)

---

## 🧱 Arquitetura

Estrutura em camadas no backend:

- `src/routes` → define endpoints
- `src/controllers` → regra de entrada/saída HTTP
- `src/models` → queries SQL
- `src/database` → conexão e script do banco
- `public` → frontend (HTML, CSS, JS, assets)

---

## ✅ Pré-requisitos

Antes de rodar:

- Node.js (recomendado: versão 18+)
- npm
- MySQL Server em execução

---

## ⚙️ Configuração do ambiente

O projeto usa variáveis de ambiente (`.env.dev` para desenvolvimento e `.env` para produção), lidas pelo `app.js`.

### Variáveis esperadas

- `APP_HOST`
- `APP_PORT`
- `AMBIENTE_PROCESSO` (`desenvolvimento` ou `producao`)
- `DB_HOST`
- `DB_PORT`
- `DB_USER`
- `DB_PASSWORD`
- `DB_DATABASE`

> Em desenvolvimento, o app está configurado para usar `.env.dev`.

---

## 🗄️ Banco de dados

Script único do projeto:

- `src/database/script-tabelas.sql`

Esse script:

1. recria o banco `supernatural`;
2. cria tabelas (`personagem`, `monstro`, `usuario`, `quiz_tentativa`);
3. insere dados iniciais de catálogo;
4. insere usuários e tentativas de quiz para testes.

### Como aplicar

No MySQL Workbench (ou cliente SQL):

1. Abra o arquivo `src/database/script-tabelas.sql`
2. Execute o script completo

---

## ▶️ Como rodar o projeto

No terminal, na raiz do projeto:

```bash
npm install
npm start
```

A aplicação ficará disponível em:

```text
http://APP_HOST:APP_PORT
```

Exemplo comum em desenvolvimento:

```text
http://localhost:3333
```

---

## 🧪 Fluxo recomendado para teste

1. Acessar página inicial
2. Navegar por personagens e monstros
3. Criar conta em cadastro
4. Fazer login
5. Abrir dashboard e validar dados
6. Responder quiz
7. Voltar à dashboard e conferir maior pontuação

---

## 📁 Estrutura resumida

```text
projeto-individual/
├── app.js
├── public/
│   ├── index.html
│   ├── personagens.html
│   ├── monstros.html
│   ├── cadastro.html
│   ├── login.html
│   ├── dashboard.html
│   ├── quiz.html
│   ├── css/
│   ├── js/
│   └── assets/
└── src/
    ├── controllers/
    ├── models/
    ├── routes/
    └── database/
```

---

## 👨‍💻 Autor

**Alex Ikezili**

Projeto acadêmico — SPTech (2026)
