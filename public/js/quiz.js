var respostasCorretas = {
    q1: "Wendigo",
    q2: "Djinn",
    q3: "Metamorfo (Shapeshifter)",
    q4: "Leviatã",
    q5: "Fantasma"
};

function inicializarQuiz() {
    var idUsuario = sessionStorage.ID_USUARIO;

    if (!idUsuario) {
        window.location = "login.html";
        return;
    }

    var formulario = document.getElementById("quizForm");
    formulario.addEventListener("submit", enviarQuiz);
}

function enviarQuiz(evento) {
    evento.preventDefault();

    var formData = new FormData(document.getElementById("quizForm"));
    var perguntas = Object.keys(respostasCorretas);
    var pontuacao = 0;

    for (var i = 0; i < perguntas.length; i++) {
        var pergunta = perguntas[i];
        var resposta = formData.get(pergunta);

        if (!resposta) {
            document.getElementById("resultadoQuiz").textContent = "Responda todas as perguntas antes de enviar.";
            return;
        }

        if (resposta === respostasCorretas[pergunta]) {
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
                "Pontuação desta tentativa: " + pontuacao + "/5. Sua maior pontuação registrada: " + dados.maiorPontuacao + ".";
        })
        .catch(function (erro) {
            console.error(erro);
            document.getElementById("resultadoQuiz").textContent = "Não foi possível registrar a tentativa.";
        });
}
