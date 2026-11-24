var perguntasQuiz = [
    {
        id: "q1",
        enunciado: "1) Qual criatura se alimenta de carne humana em florestas isoladas?",
        opcoes: ["Wendigo", "Leviatã", "Ghoul", "Banshee"],
        correta: "Wendigo"
    },
    {
        id: "q2",
        enunciado: "2) Qual criatura cria ilusões para prender suas vítimas?",
        opcoes: ["Djinn", "Fantasma", "Bruxa", "Arachne"],
        correta: "Djinn"
    },
    {
        id: "q3",
        enunciado: "3) Qual criatura muda de aparência copiando outras pessoas?",
        opcoes: ["Metamorfo (Shapeshifter)", "Kitsune", "Rugaru", "Górgona"],
        correta: "Metamorfo (Shapeshifter)"
    },
    {
        id: "q4",
        enunciado: "4) Qual criatura é um predador antigo libertado do Purgatório?",
        opcoes: ["Leviatã", "Rakshasa", "Vampiro", "Skinwalker"],
        correta: "Leviatã"
    },
    {
        id: "q5",
        enunciado: "5) Qual criatura é conhecida por assombrar locais e pessoas após a morte?",
        opcoes: ["Fantasma", "Ceifador (Reaper)", "Kitsune", "Bruxa"],
        correta: "Fantasma"
    },
    {
        id: "q6",
        enunciado: "6) Qual criatura costuma se transformar em lobo durante a lua cheia?",
        opcoes: ["Lobisomem", "Vampiro", "Rugaru", "Ghoul"],
        correta: "Lobisomem"
    },
    {
        id: "q7",
        enunciado: "7) Qual criatura é associada ao consumo de sangue humano?",
        opcoes: ["Vampiro", "Demônio", "Arachne", "Djinn"],
        correta: "Vampiro"
    },
    {
        id: "q8",
        enunciado: "8) Qual criatura é ligada ao inferno e à possessão?",
        opcoes: ["Demônio", "Banshee", "Rakshasa", "Sereia (Siren)"],
        correta: "Demônio"
    },
    {
        id: "q9",
        enunciado: "9) Qual criatura pode assumir forma humana e selvagem para caçar?",
        opcoes: ["Skinwalker", "Górgona", "Ghoul", "Fantasma"],
        correta: "Skinwalker"
    },
    {
        id: "q10",
        enunciado: "10) Qual criatura costuma ser associada a lendas urbanas de choro e gritos sobrenaturais?",
        opcoes: ["Banshee", "Ceifador (Reaper)", "Leviatã", "Wendigo"],
        correta: "Banshee"
    }
];

function embaralharOpcoes(lista) {
    var copia = lista.slice();

    for (var i = copia.length - 1; i > 0; i--) {
        var indiceAleatorio = Math.floor(Math.random() * (i + 1));
        var temp = copia[i];
        copia[i] = copia[indiceAleatorio];
        copia[indiceAleatorio] = temp;
    }

    return copia;
}

function montarPerguntas() {
    var container = document.getElementById("perguntasContainer");

    if (!container) {
        return;
    }

    container.innerHTML = "";

    for (var i = 0; i < perguntasQuiz.length; i++) {
        var pergunta = perguntasQuiz[i];
        var opcoesAleatorias = embaralharOpcoes(pergunta.opcoes);

        var blocoPergunta = document.createElement("div");
        blocoPergunta.className = "campo quiz-pergunta";

        var tituloPergunta = document.createElement("span");
        tituloPergunta.textContent = pergunta.enunciado;
        blocoPergunta.appendChild(tituloPergunta);

        for (var j = 0; j < opcoesAleatorias.length; j++) {
            var opcao = opcoesAleatorias[j];

            var labelOpcao = document.createElement("label");
            labelOpcao.className = "quiz-alternativa";

            var inputOpcao = document.createElement("input");
            inputOpcao.type = "radio";
            inputOpcao.name = pergunta.id;
            inputOpcao.value = opcao;

            labelOpcao.appendChild(inputOpcao);
            labelOpcao.appendChild(document.createTextNode(" " + opcao));

            blocoPergunta.appendChild(labelOpcao);
        }

        container.appendChild(blocoPergunta);
    }
}

function inicializarQuiz() {
    var idUsuario = sessionStorage.ID_USUARIO;

    if (!idUsuario) {
        window.location = "login.html";
        return;
    }

    montarPerguntas();

    var formulario = document.getElementById("quizForm");
    formulario.addEventListener("submit", enviarQuiz);
}

function enviarQuiz(evento) {
    evento.preventDefault();

    var formData = new FormData(document.getElementById("quizForm"));
    var pontuacao = 0;

    for (var i = 0; i < perguntasQuiz.length; i++) {
        var perguntaAtual = perguntasQuiz[i];
        var resposta = formData.get(perguntaAtual.id);

        if (!resposta) {
            document.getElementById("resultadoQuiz").textContent = "Responda todas as perguntas antes de enviar.";
            return;
        }

        if (resposta === perguntaAtual.correta) {
            pontuacao++;
        }
    }

    fetch("/api/quiz/tentativas", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            idUsuarioServer: sessionStorage.ID_USUARIO,
            pontuacaoServer: pontuacao
        })
    })
        .then(function (resposta) {
            if (!resposta.ok) {
                throw new Error("Erro ao salvar tentativa");
            }

            return resposta.json();
        })
        .then(function (dados) {
            document.getElementById("resultadoQuiz").textContent =
                "Pontuação desta tentativa: " + pontuacao + "/10. Sua maior pontuação registrada: " + dados.maiorPontuacao + ".";
        })
        .catch(function (erro) {
            console.error(erro);
            document.getElementById("resultadoQuiz").textContent = "Não foi possível registrar a tentativa.";
        });
}
