var dashboardModel = require("../models/dashboardModel");

function buscarPreferenciasUser(req, res) {
    var id = req.params.id;

    if (Number(id) <= 0) {
        return res.status(400).json({
            mensagem: "ID de usuário inválido"
        });
    }

    dashboardModel.buscarPreferenciasUser(id)
        .then(resultado => {
            if (resultado.length === 0) {
                return res.status(404).json({
                    mensagem: "Usuário não encontrado"
                });
            }

            res.json(resultado[0]);
        })
        .catch(erro => {
            console.error(erro);

            res.status(500).json({
                mensagem: "Erro ao buscar preferências"
            });
        });
}

function buscarPersonagensFavoritos(req, res) {
    dashboardModel.buscarPersonagensFavoritos()
        .then(resultado => {
            res.status(200).json(resultado)
        })
        .catch(erro => {
            console.error(erro);

            res.status(500).json({
                mensagem: "Erro ao buscar personagens"
            });
        });
}

function buscarMonstrosTemidos(req, res) {
    dashboardModel.buscarMonstrosTemidos()
        .then(resultado => {
            res.status(200).json(resultado)
        })
         .catch(erro => {
            console.error(erro);

            res.status(500).json({
                mensagem: "Erro ao buscar monstros"
            });
        });
}

module.exports = {
    buscarPreferenciasUser,
    buscarPersonagensFavoritos,
    buscarMonstrosTemidos
}