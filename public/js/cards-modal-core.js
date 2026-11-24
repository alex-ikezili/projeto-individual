function inicializarCardsComModal(configuracao) {
    var modal = document.getElementById(configuracao.modalId);
    var botaoFechar = document.getElementById(configuracao.botaoFecharId);

    if (!modal || !botaoFechar) {
        return;
    }

    var scrollAntesModal = 0;

    function abrirModal(item, card) {
        if (!item) {
            return;
        }

        configuracao.preencherModal(item, card);

        scrollAntesModal = window.scrollY || window.pageYOffset;
        document.body.classList.add("modal-aberto");
        modal.classList.add("ativo");
        modal.setAttribute("aria-hidden", "false");
        botaoFechar.focus();
    }

    function fecharModal() {
        modal.classList.remove("ativo");
        modal.setAttribute("aria-hidden", "true");
        document.body.classList.remove("modal-aberto");
        window.scrollTo(0, scrollAntesModal);
    }

    var cards = document.querySelectorAll(configuracao.seletorCards);

    for (var i = 0; i < cards.length; i++) {
        (function () {
            var card = cards[i];
            var chave = card.getAttribute(configuracao.atributoChave);
            var item = configuracao.baseDados[chave];

            if (!item) {
                return;
            }

            card.style.cursor = "pointer";
            card.setAttribute("tabindex", "0");

            card.addEventListener("click", function () {
                abrirModal(item, card);
            });

            card.addEventListener("keydown", function (evento) {
                if (evento.key === "Enter" || evento.key === " ") {
                    evento.preventDefault();
                    abrirModal(item, card);
                }
            });
        })();
    }

    botaoFechar.addEventListener("click", fecharModal);

    modal.addEventListener("click", function (evento) {
        if (evento.target === modal || evento.target.getAttribute("data-close") === "overlay") {
            fecharModal();
        }
    });

    document.addEventListener("keydown", function (evento) {
        if (evento.key === "Escape" && modal.classList.contains("ativo")) {
            fecharModal();
        }
    });
}
