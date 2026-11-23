var quizModel = require("../models/quizModel");

function registrarTentativa(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var pontuacao = req.body.pontuacaoServer;

    if (idUsuario == undefined || Number(idUsuario) <= 0) {
        return res.status(400).send("ID do usuário inválido!");
    }

    if (pontuacao == undefined || Number(pontuacao) < 0) {
        return res.status(400).send("Pontuação inválida!");
    }

    quizModel.salvarTentativa(idUsuario, pontuacao)
        .then(function () {
            return quizModel.buscarMaiorPontuacaoPorUsuario(idUsuario);
        })
        .then(function (resultado) {
            res.status(200).json({
                mensagem: "Tentativa registrada com sucesso",
                maiorPontuacao: resultado[0].maiorPontuacao
            });
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("\nHouve um erro ao registrar tentativa! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    registrarTentativa
};
