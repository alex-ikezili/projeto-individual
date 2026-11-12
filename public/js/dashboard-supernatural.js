var graficoPersonagens = null;
var graficoMonstros = null;

function inicializarDashboard() {
    var idUsuario = sessionStorage.ID_USUARIO;
    var nomeUsuario = sessionStorage.NOME_USUARIO;

    if (!idUsuario || !nomeUsuario) {
        window.location = "../login.html";
        return;
    }

    document.getElementById("nomeUsuario").textContent = nomeUsuario;

    carregarPreferencias(idUsuario);
    carregarRankings();
}

function buscarJson(url, mensagemErro) {
    return fetch(url).then(function (resposta) {
        if (!resposta.ok) {
            throw new Error(mensagemErro);
        }
        return resposta.json();
    });
}

function carregarPreferencias(idUsuario) {
    buscarJson(`/api/dashboard/usuario/${idUsuario}`, "Erro ao buscar preferências do usuário")
        .then(function (dados) {
            document.getElementById("personagemFavorito").textContent =
                dados.personagemFavorito || "Não informado";

            document.getElementById("monstroTemido").textContent =
                dados.monstroMaisTemido || "Não informado";
        })
        .catch(function (erro) {
            console.error(erro);
        });
}

function carregarRankings() {
    Promise.all([
        buscarJson("/api/dashboard/personagens", "Erro ao buscar ranking de personagens"),
        buscarJson("/api/dashboard/monstros", "Erro ao buscar ranking de monstros")
    ])
        .then(function (resultado) {
            var personagens = resultado[0];
            var monstros = resultado[1];

            atualizarKpis(personagens, monstros);
            plotarGraficos(personagens, monstros);
        })
        .catch(function (erro) {
            console.error(erro);
        });
}

function atualizarKpis(personagens, monstros) {
    if (personagens.length > 0) {
        document.getElementById("kpiPersonagemNome").textContent = personagens[0].nome;
        document.getElementById("kpiPersonagemPercentual").textContent =
            Number(personagens[0].percentualPreferencia).toFixed(1) + "%";
    }

    if (monstros.length > 0) {
        document.getElementById("kpiMonstroNome").textContent = monstros[0].nome;
        document.getElementById("kpiMonstroPercentual").textContent =
            Number(monstros[0].percentualPreferencia).toFixed(1) + "%";
    }
}

function plotarGraficos(personagens, monstros) {
    var labelsPersonagens = [];
    var votosPersonagens = [];

    for (var i = 0; i < personagens.length; i++) {
        labelsPersonagens.push(personagens[i].nome);
        votosPersonagens.push(Number(personagens[i].totalFavoritos));
    }

    var labelsMonstros = [];
    var votosMonstros = [];

    for (var j = 0; j < monstros.length; j++) {
        labelsMonstros.push(monstros[j].nome);
        votosMonstros.push(Number(monstros[j].totalTemidos));
    }

    if (graficoPersonagens) graficoPersonagens.destroy();
    if (graficoMonstros) graficoMonstros.destroy();

    graficoPersonagens = new Chart(document.getElementById("graficoPersonagens"), {
        type: "bar",
        data: {
            labels: labelsPersonagens,
            datasets: [{
                label: "Votos",
                data: votosPersonagens,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true, ticks: { precision: 0 } }
            }
        }
    });

    graficoMonstros = new Chart(document.getElementById("graficoMonstros"), {
        type: "bar",
        data: {
            labels: labelsMonstros,
            datasets: [{
                label: "Votos",
                data: votosMonstros,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true, ticks: { precision: 0 } }
            }
        }
    });
}