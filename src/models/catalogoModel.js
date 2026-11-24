var database = require("../database/config");

function listarPersonagens() {
    var instrucaoSql = `
        SELECT
            nome,
            categoria,
            caminho_imagem,
            descricao,
            personalidade,
            habilidades,
            historia,
            relacoes_importantes,
            curiosidades
        FROM personagem
        ORDER BY nome ASC;
    `;

    return database.executar(instrucaoSql);
}

function listarMonstros() {
    var instrucaoSql = `
        SELECT
            nome,
            categoria,
            caminho_imagem,
            descricao,
            caracteristicas,
            habilidades,
            fraquezas,
            curiosidades
        FROM monstro
        ORDER BY nome ASC;
    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    listarPersonagens,
    listarMonstros
};
