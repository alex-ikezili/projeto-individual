var graficoPersonagens = null;
var graficoMonstros = null;

var corPrimaria = "#8d332c";
var corPrimariaSuave = "rgba(141, 51, 44, 0.28)";
var corTexto = "#e7e0d2";
var corTextoSecundaria = "#c7c7c7";
var corGrade = "rgba(231, 224, 210, 0.12)";

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

function atualizarImagem(idElemento, caminhoImagem, fallback) {
    var elemento = document.getElementById(idElemento);

    if (!elemento) {
        return;
    }

    if (caminhoImagem && caminhoImagem.trim() !== "") {
        elemento.src = caminhoImagem;
        definirCategoriaImagem(elemento, caminhoImagem, idElemento);
    } else {
        elemento.src = fallback;
        definirCategoriaImagem(elemento, fallback, idElemento);
    }
}

function definirCategoriaImagem(elemento, caminhoImagem, idElemento) {
    if (!elemento) {
        return;
    }

    if (caminhoImagem && caminhoImagem.indexOf("assets/imgs/monstros/") !== -1) {
        elemento.dataset.categoria = "monstros";
        return;
    }

    if (caminhoImagem && caminhoImagem.indexOf("assets/imgs/personagens/") !== -1) {
        elemento.dataset.categoria = "personagens";
        return;
    }

    if (idElemento.toLowerCase().indexOf("monstro") !== -1) {
        elemento.dataset.categoria = "monstros";
    } else {
        elemento.dataset.categoria = "personagens";
    }
}

function carregarPreferencias(idUsuario) {
    buscarJson(`/api/dashboard/usuario/${idUsuario}`, "Erro ao buscar preferências do usuário")
        .then(function (dados) {
            document.getElementById("personagemFavorito").textContent =
                dados.personagemFavorito || "Não informado";

            document.getElementById("monstroTemido").textContent =
                dados.monstroMaisTemido || "Não informado";

            document.getElementById("kpiMaiorPontuacaoQuiz").textContent =
                Number(dados.maiorPontuacaoQuiz || 0);

            atualizarImagem(
                "personagemFavoritoImagem",
                dados.personagemFavoritoImagem,
                "assets/imgs/personagens/default.svg"
            );

            atualizarImagem(
                "monstroTemidoImagem",
                dados.monstroMaisTemidoImagem,
                "assets/imgs/monstros/default.svg"
            );
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

        atualizarImagem(
            "kpiPersonagemImagem",
            personagens[0].caminho_imagem,
            "assets/imgs/personagens/default.svg"
        );
    }

    if (monstros.length > 0) {
        document.getElementById("kpiMonstroNome").textContent = monstros[0].nome;
        document.getElementById("kpiMonstroPercentual").textContent =
            Number(monstros[0].percentualPreferencia).toFixed(1) + "%";

        atualizarImagem(
            "kpiMonstroImagem",
            monstros[0].caminho_imagem,
            "assets/imgs/monstros/default.svg"
        );
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
                label: "Quantidade de votos",
                data: votosPersonagens,
                backgroundColor: corPrimariaSuave,
                borderColor: corPrimaria,
                borderWidth: 1,
                borderRadius: 8,
                borderSkipped: false,
                maxBarThickness: 44
            }]
        },
        options: gerarOpcoesGrafico()
    });

    graficoMonstros = new Chart(document.getElementById("graficoMonstros"), {
        type: "bar",
        data: {
            labels: labelsMonstros,
            datasets: [{
                label: "Quantidade de votos",
                data: votosMonstros,
                backgroundColor: corPrimariaSuave,
                borderColor: corPrimaria,
                borderWidth: 1,
                borderRadius: 8,
                borderSkipped: false,
                maxBarThickness: 44
            }]
        },
        options: gerarOpcoesGrafico()
    });
}

function gerarOpcoesGrafico() {
    return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                labels: {
                    color: corTextoSecundaria,
                    boxWidth: 14,
                    usePointStyle: true,
                    pointStyle: "rectRounded"
                }
            },
            tooltip: {
                backgroundColor: "rgba(13, 13, 13, 0.96)",
                borderColor: corPrimaria,
                borderWidth: 1,
                titleColor: corTexto,
                bodyColor: corTexto,
                displayColors: false
            }
        },
        scales: {
            x: {
                ticks: {
                    color: corTextoSecundaria,
                    maxRotation: 0,
                    autoSkip: false,
                    font: { size: 11 }
                },
                grid: {
                    color: "transparent",
                    borderColor: corGrade
                }
            },
            y: {
                beginAtZero: true,
                ticks: {
                    precision: 0,
                    color: corTextoSecundaria
                },
                grid: {
                    color: corGrade,
                    borderColor: corGrade
                }
            }
        }
    };
}
