var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            id: resultadoAutenticar[0].id,
                            email: resultadoAutenticar[0].email,
                            nome: resultadoAutenticar[0].nome
                        });

                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var nome = req.body.nomeServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var personagem = req.body.personagemFavoritoServer;
    var monstro = req.body.monstroMedoServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else if (personagem == undefined) {
        res.status(400).send("Seu personagem está undefined!");
    } else if (monstro == undefined) {
        res.status(400).send("Seu monstro está undefined!");
    } else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, personagem, monstro)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

function atualizarPreferencias(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var personagem = req.body.personagemFavoritoServer;
    var monstro = req.body.monstroMedoServer;

    if (idUsuario == undefined || Number(idUsuario) <= 0) {
        return res.status(400).send("ID do usuário inválido!");
    } else if (personagem == undefined || personagem === "") {
        return res.status(400).send("Seu personagem está undefined!");
    } else if (monstro == undefined || monstro === "") {
        return res.status(400).send("Seu monstro está undefined!");
    }

    usuarioModel.atualizarPreferencias(idUsuario, personagem, monstro)
        .then(function (resultado) {
            if (resultado.affectedRows === 0) {
                return res.status(404).send("Usuário não encontrado!");
            }

            return res.status(200).json({
                mensagem: "Preferências atualizadas com sucesso"
            });
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("\nHouve um erro ao atualizar preferências! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    autenticar,
    cadastrar,
    atualizarPreferencias
}