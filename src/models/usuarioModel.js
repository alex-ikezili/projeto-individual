var database = require("../database/config")

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT id, nome, email
        FROM usuario
        WHERE email = ? AND senha = ?;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [email, senha]);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, email, senha, personagem, monstro) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", nome, email, senha, personagem, monstro);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha, fk_personagem, fk_monstro)
        VALUES (
            ?,
            ?,
            ?,
            (SELECT id FROM personagem WHERE nome = ? LIMIT 1),
            (SELECT id FROM monstro WHERE nome = ? LIMIT 1)
        );
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [nome, email, senha, personagem, monstro]);
}

function atualizarPreferencias(idUsuario, personagem, monstro) {
    console.log("ACESSEI O USUARIO MODEL - atualizarPreferencias", idUsuario, personagem, monstro);

    var instrucaoSql = `
        UPDATE usuario
        SET
            fk_personagem = (SELECT id FROM personagem WHERE nome = ? LIMIT 1),
            fk_monstro = (SELECT id FROM monstro WHERE nome = ? LIMIT 1)
        WHERE id = ?;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [personagem, monstro, idUsuario]);
}

module.exports = {
    autenticar,
    cadastrar,
    atualizarPreferencias
};