var database = require("../database/config")

function buscarPreferenciasUser(id) {
    console.log("ACESSEI O DASHBOARD MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT
            u.id,
            u.nome,
            p.nome AS personagemFavorito,
            m.nome AS monstroMaisTemido

        FROM usuario u

            LEFT JOIN personagem p
            ON u.fk_personagem = p.id

            LEFT JOIN monstro m
            ON u.fk_monstro = m.id

        WHERE u.id = ${id};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPersonagensFavoritos() {
    console.log("ACESSEI O DASHBOARD MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT
            p.id,
            p.nome,
            COUNT(u.id) AS totalFavoritos

        FROM personagem p

            LEFT JOIN usuario u
            ON p.id = u.fk_personagem

        GROUP BY p.id, p.nome

        ORDER BY totalFavoritos DESC, p.nome ASC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMonstrosTemidos() {
    console.log("ACESSEI O DASHBOARD MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT
            m.id,
            m.nome,
            COUNT(u.id) AS totalTemidos

        FROM monstro m

            LEFT JOIN usuario u
            ON m.id = u.fk_monstro

        GROUP BY m.id, m.nome

        ORDER BY totalTemidos DESC, m.nome ASC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarPreferenciasUser,
    buscarPersonagensFavoritos,
    buscarMonstrosTemidos
};