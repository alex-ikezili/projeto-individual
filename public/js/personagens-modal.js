var personagensDetalhes = {};

function preencherModalPersonagem(personagem, card) {
    var imagem = card.querySelector("img");

    document.getElementById("modalImagemPersonagem").src = imagem ? imagem.getAttribute("src") : (personagem.caminho_imagem || "");
    document.getElementById("modalImagemPersonagem").alt = personagem.nome;
    document.getElementById("modalNomePersonagem").textContent = personagem.nome;
    document.getElementById("modalCategoriaPersonagem").textContent = personagem.categoria;
    document.getElementById("modalDescricaoPersonagem").textContent = personagem.descricao;
    document.getElementById("modalPersonalidadePersonagem").textContent = personagem.personalidade;
    document.getElementById("modalHabilidadesPersonagem").textContent = personagem.habilidades;
    document.getElementById("modalHistoriaPersonagem").textContent = personagem.historia;
    document.getElementById("modalRelacoesPersonagem").textContent = personagem.relacoes_importantes;
    document.getElementById("modalCuriosidadesPersonagem").textContent = personagem.curiosidades;
}

function carregarDadosPersonagens() {
    return fetch("/api/catalogo/personagens")
        .then(function (resposta) {
            if (!resposta.ok) {
                throw new Error("Erro ao carregar personagens");
            }

            return resposta.json();
        })
        .then(function (dados) {
            for (var i = 0; i < dados.length; i++) {
                personagensDetalhes[dados[i].nome] = dados[i];
            }
        });
}

document.addEventListener("DOMContentLoaded", function () {
    carregarDadosPersonagens()
        .then(function () {
            inicializarCardsComModal({
                modalId: "personagemModal",
                botaoFecharId: "fecharPersonagemModal",
                seletorCards: ".personagem-card[data-personagem]",
                atributoChave: "data-personagem",
                baseDados: personagensDetalhes,
                preencherModal: preencherModalPersonagem
            });
        })
        .catch(function (erro) {
            console.error("Falha ao consultar API de personagens:", erro);
        });
});
