var database = require("../database/config");

function salvarTentativa(idUsuario, pontuacao) {
    console.log("ACESSEI O QUIZ MODEL - salvarTentativa", idUsuario, pontuacao);

    var instrucaoSql = `
        INSERT INTO quiz_tentativa (fk_usuario, pontuacao)
        VALUES (?, ?);
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idUsuario, pontuacao]);
}

function buscarMaiorPontuacaoPorUsuario(idUsuario) {
    console.log("ACESSEI O QUIZ MODEL - buscarMaiorPontuacaoPorUsuario", idUsuario);

    var instrucaoSql = `
        SELECT COALESCE(MAX(pontuacao), 0) AS maiorPontuacao
        FROM quiz_tentativa
        WHERE fk_usuario = ?;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [idUsuario]);
}

module.exports = {
    salvarTentativa,
    buscarMaiorPontuacaoPorUsuario
};
