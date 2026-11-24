var catalogoModel = require("../models/catalogoModel");

function listarPersonagens(req, res) {
    catalogoModel.listarPersonagens()
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json({ mensagem: "Erro ao buscar personagens" });
        });
}

function listarMonstros(req, res) {
    catalogoModel.listarMonstros()
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json({ mensagem: "Erro ao buscar monstros" });
        });
}

module.exports = {
    listarPersonagens,
    listarMonstros
};
