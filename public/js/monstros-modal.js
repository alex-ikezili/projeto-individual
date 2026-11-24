var criaturasDetalhes = {};

function preencherModalCriatura(criatura, card) {
    var imagem = card.querySelector("img");

    document.getElementById("modalImagemCriatura").src = imagem ? imagem.getAttribute("src") : criatura.caminho_imagem;
    document.getElementById("modalImagemCriatura").alt = criatura.nome;
    document.getElementById("modalNomeCriatura").textContent = criatura.nome;
    document.getElementById("modalCategoriaCriatura").textContent = criatura.categoria;
    document.getElementById("modalDescricaoCriatura").textContent = criatura.descricao;
    document.getElementById("modalCaracteristicasCriatura").textContent = criatura.caracteristicas;
    document.getElementById("modalHabilidadesCriatura").textContent = criatura.habilidades;
    document.getElementById("modalFraquezasCriatura").textContent = criatura.fraquezas;
    document.getElementById("modalCuriosidadesCriatura").textContent = criatura.curiosidades;
}

function carregarDadosMonstros() {
    return fetch("/api/catalogo/monstros")
        .then(function (resposta) {
            if (!resposta.ok) {
                throw new Error("Erro ao carregar monstros");
            }

            return resposta.json();
        })
        .then(function (dados) {
            for (var i = 0; i < dados.length; i++) {
                criaturasDetalhes[dados[i].nome] = dados[i];
            }
        });
}

document.addEventListener("DOMContentLoaded", function () {
    carregarDadosMonstros()
        .then(function () {
            inicializarCardsComModal({
                modalId: "criaturaModal",
                botaoFecharId: "fecharCriaturaModal",
                seletorCards: ".personagem-card[data-criatura]",
                atributoChave: "data-criatura",
                baseDados: criaturasDetalhes,
                preencherModal: preencherModalCriatura
            });
        })
        .catch(function (erro) {
            console.error("Falha ao consultar API de monstros:", erro);
        });
});
