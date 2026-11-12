function inicializarDashboard() {
    validarSessao();

    var idUsuario = sessionStorage.ID_USUARIO;

    document.getElementById("nomeUsuario").textContent =
        sessionStorage.NOME_USUARIO;

    carregarPreferencias(idUsuario);

    carregarPersonagens();
    carregarMonstros();
}

function carregarPreferencias(idUsuario) {
    fetch(`/api/dashboard/usuario/${idUsuario}`)
        .then(resposta => {
            if (!resposta.ok) {
                throw new Error("Erro ao buscar preferências");
            }

            return resposta.json();
        })
        .then(dados => {
            document.getElementById("personagemFavorito")
                .textContent = dados.personagemFavorito;

            document.getElementById("monstroTemido")
                .textContent = dados.monstroMaisTemido;
        })
        .catch(erro => {
            console.error(erro);
        });
}

function carregarPersonagens() {
    fetch(`/api/dashboard/personagens`)
        .then(resposta => resposta.json())
        .catch(erro => {
            console.error(erro);
        });
}

function carregarMonstros() {
    fetch(`/api/dashboard/monstros`)
        .then(resposta => resposta.json())
        .catch(erro => {
            console.error(erro);
        });
}