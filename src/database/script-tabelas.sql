DROP DATABASE IF EXISTS supernatural;

CREATE DATABASE supernatural;

USE supernatural;

CREATE TABLE personagem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL UNIQUE,
    categoria VARCHAR(40) NOT NULL,
    caminho_imagem VARCHAR(255) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    personalidade VARCHAR(500) NOT NULL,
    habilidades VARCHAR(500) NOT NULL,
    historia VARCHAR(500) NOT NULL,
    relacoes_importantes VARCHAR(500) NOT NULL,
    curiosidades VARCHAR(500) NOT NULL
);

CREATE TABLE monstro (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    categoria VARCHAR(40) NOT NULL,
    caminho_imagem VARCHAR(255) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    caracteristicas VARCHAR(500) NOT NULL,
    habilidades VARCHAR(500) NOT NULL,
    fraquezas VARCHAR(500) NOT NULL,
    curiosidades VARCHAR(500) NOT NULL
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    fk_personagem INT,
    fk_monstro INT,
    CONSTRAINT fk_usuario_personagem FOREIGN KEY (fk_personagem) REFERENCES personagem(id),
    CONSTRAINT fk_usuario_monstro FOREIGN KEY (fk_monstro) REFERENCES monstro(id)
);

CREATE TABLE quiz_tentativa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fk_usuario INT NOT NULL,
    pontuacao INT NOT NULL,
    dt_tentativa DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tentativa_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
    CONSTRAINT ch_tentativa_pontuacao CHECK (pontuacao BETWEEN 0 AND 10)
);

INSERT INTO personagem
(nome, categoria, caminho_imagem, descricao, personalidade, habilidades, historia, relacoes_importantes, curiosidades)
VALUES
('Dean Winchester', 'Caçador', 'assets/imgs/personagens/dean-winchester.png',
'Caçador de criaturas sobrenaturais e um dos protagonistas da série. É conhecido por sua coragem, humor sarcástico e lealdade à família.',
'Impulsivo, protetor, sarcástico e emocionalmente reservado. Costuma esconder seus sentimentos por trás de piadas e atitudes confiantes.',
'Combate corpo a corpo, uso de armas de fogo, conhecimento de criaturas sobrenaturais, exorcismos e estratégias de caça.',
'Filho de John e Mary Winchester. Após a morte de sua mãe pelas mãos de Azazel, cresceu acompanhando o pai nas caçadas. Ao longo da série, torna-se hospedeiro do arcanjo Miguel e carrega a Marca de Caim.',
'Sam Winchester, John Winchester, Mary Winchester, Castiel, Bobby Singer e Crowley.',
'É profundamente ligado ao Chevrolet Impala 1967, apelidado de Baby. Sua comida favorita é hambúrguer e ele possui grande interesse por rock clássico.'),

('Sam Winchester', 'Caçador', 'assets/imgs/personagens/sam-winchester.png',
'Caçador e irmão mais novo de Dean Winchester. Inicialmente tenta abandonar a vida de caça para estudar em Stanford.',
'Inteligente, empático, determinado e reflexivo. Geralmente procura soluções que evitem mortes desnecessárias.',
'Investigação, pesquisa, exorcismos, combate, conhecimento de ocultismo e habilidades psíquicas adquiridas após o contato com o sangue de Azazel.',
'Abandonou a vida de caçador para estudar Direito em Stanford. Sua namorada Jessica foi assassinada por Azazel, levando-o de volta à caça. Descobre posteriormente seu papel como receptáculo de Lúcifer.',
'Dean Winchester, John Winchester, Jessica Moore, Castiel, Bobby Singer e Jack Kline.',
'Foi escolhido por Lúcifer como receptáculo por causa de sua ligação com Azazel e seu sangue demoníaco.'),

('Castiel', 'Anjo', 'assets/imgs/personagens/castiel.png',
'Anjo do Senhor que recebe a missão de retirar Dean Winchester do Inferno e acaba desenvolvendo uma relação profunda com os irmãos.',
'Sério, literal, curioso sobre a humanidade e progressivamente mais compassivo. Sua compreensão das emoções humanas evolui ao longo da série.',
'Teletransporte, cura, ressurreição, leitura de pensamentos, manipulação de energia angelical e combate com lâmina angelical.',
'Foi enviado por Miguel para retirar Dean do Inferno. Posteriormente desobedece às ordens do Céu e passa a ajudar os Winchester, envolvendo-se em conflitos entre anjos e demônios.',
'Dean Winchester, Sam Winchester, Jimmy Novak, Jack Kline, Hannah e outros anjos.',
'Sua aparência humana pertence a Jimmy Novak, um homem que aceitou ser seu receptáculo. Sua frase característica é a apresentação como Castiel, do Céu.'),

('Bobby Singer', 'Caçador', 'assets/imgs/personagens/bobby-singer.png',
'Caçador experiente, pesquisador e figura paterna para Dean e Sam Winchester.',
'Prático, inteligente, sarcástico e extremamente leal. Demonstra afeto principalmente por meio de atitudes.',
'Pesquisa sobrenatural, idiomas, rituais, exorcismos, fabricação de armas e conhecimento de criaturas e entidades.',
'Após a morte de sua esposa Karen, Bobby se dedica à caça de criaturas sobrenaturais. Torna-se um dos principais aliados dos Winchester e oferece abrigo, conhecimento e apoio durante suas missões.',
'Dean Winchester, Sam Winchester, Karen Singer, Rufus Turner e outros caçadores.',
'Seu ferro-velho funciona como esconderijo e centro de pesquisa. Mesmo após ficar paraplégico, continua participando ativamente das caçadas.'),

('Crowley', 'Demônio', 'assets/imgs/personagens/crowley.png',
'Demônio que ascende ao posto de Rei do Inferno e mantém uma relação complexa de alianças e conflitos com os Winchester.',
'Manipulador, sarcástico, calculista e ambicioso. Apesar de suas atitudes cruéis, demonstra vínculos afetivos inesperados.',
'Teletransporte, possessão, manipulação de contratos, magia demoníaca e controle de outros demônios.',
'Originalmente chamado Fergus MacLeod, tornou-se um demônio após sua morte. Ascendeu ao poder no Inferno e assumiu o título de Rei do Inferno, negociando frequentemente com os Winchester.',
'Rowena MacLeod, Dean Winchester, Sam Winchester, Lúcifer e outros demônios.',
'É filho da bruxa Rowena MacLeod. Seu nome humano era Fergus MacLeod e ele costuma utilizar contratos como instrumento de manipulação.'),

('Jack Kline', 'Nephilim', 'assets/imgs/personagens/jack-kline.png',
'Nephilim nascido da união entre Lúcifer e a humana Kelly Kline. Sua existência provoca conflitos entre anjos e outras forças sobrenaturais.',
'Inocente, curioso, empático e determinado a fazer o bem. Busca compreender sua identidade e controlar seus poderes.',
'Poderes angelicais e demoníacos herdados de seus pais, telecinese, cura, manipulação de energia e grande potencial sobrenatural.',
'Filho de Lúcifer e Kelly Kline. É protegido pelos Winchester e por Castiel, que passam a exercer um papel familiar em sua vida. Sua jornada envolve aprender a controlar seus poderes e definir quem deseja ser.',
'Lúcifer, Kelly Kline, Castiel, Dean Winchester e Sam Winchester.',
'Por ser filho de um arcanjo com uma humana, é um Nephilim de poder excepcional.'),

('John Winchester', 'Caçador', 'assets/imgs/personagens/john-winchester.png',
'Pai de Dean e Sam Winchester. Após a morte de Mary, dedica sua vida à caça de criaturas sobrenaturais e à busca por Azazel.',
'Determinado, rígido, obsessivo e protetor. Sua dedicação à vingança afeta profundamente sua relação com os filhos.',
'Combate, investigação, uso de armas, conhecimento de criaturas sobrenaturais e estratégias de caça.',
'Antes da morte de Mary, era um homem comum. Após encontrar sua esposa morta em circunstâncias sobrenaturais, passa a investigar o ocorrido e treinar seus filhos para enfrentar monstros.',
'Mary Winchester, Dean Winchester, Sam Winchester e Bobby Singer.',
'Serviu ao Corpo de Fuzileiros Navais dos Estados Unidos e deixou um diário com informações importantes sobre criaturas sobrenaturais.'),

('Rowena MacLeod', 'Bruxa', 'assets/imgs/personagens/rowena-macleod.png',
'Bruxa extremamente poderosa e mãe de Crowley. Sua trajetória envolve ambição, magia e conflitos familiares.',
'Manipuladora, arrogante, inteligente e ambiciosa. Com o tempo, demonstra maior capacidade de sacrifício e afeto.',
'Feitiços avançados, teletransporte, necromancia, maldições, manipulação de energia e conhecimento de magia antiga.',
'Uma das bruxas mais poderosas da série. Participa de conflitos envolvendo o Grande Coven, os Winchester e o Livro dos Condenados. Sua relação com Crowley é marcada por abandono e ressentimento.',
'Crowley, Sam Winchester, Dean Winchester e os integrantes do Grande Coven.',
'Seu nome verdadeiro é Rowena MacLeod. Sua relação conturbada com Crowley é um dos elementos centrais de sua história.'),

('Lucifer', 'Arcanjo', 'assets/imgs/personagens/lucifer.png',
'Arcanjo caído que se revoltou contra Deus e foi aprisionado na Jaula do Inferno. É um dos principais antagonistas da série.',
'Orgulhoso, cruel, sarcástico e ressentido. Costuma manipular pessoas e explorar suas fraquezas emocionais.',
'Poder angelical de nível arcanjo, teletransporte, manipulação de energia, possessão, voo e enorme capacidade destrutiva.',
'Após se rebelar contra Deus, foi lançado na Jaula. Sua libertação desencadeia eventos relacionados ao Apocalipse. Sam é escolhido como seu receptáculo e, posteriormente, Lúcifer se torna pai de Jack.',
'Satanás, Miguel, Sam Winchester, Nick, Kelly Kline e Jack Kline.',
'Foi o responsável por iniciar a rebelião dos anjos. Seu receptáculo humano mais conhecido é Sam Winchester.'),

('Gabriel', 'Arcanjo', 'assets/imgs/personagens/gabriel.png',
'Arcanjo que abandona o Céu e passa a viver na Terra escondido sob a identidade de Loki.',
'Irônico, brincalhão, imprevisível e avesso aos conflitos familiares. Esconde sua dor por meio de ilusões e humor.',
'Manipulação da realidade, criação de ilusões, teletransporte, poderes angelicais e combate com energia celestial.',
'Abandona o Céu após os conflitos entre seus irmãos. Na Terra, assume a identidade de Loki e passa a viver como um Trickster, até ser envolvido novamente nos conflitos do Apocalipse.',
'Miguel, Lúcifer, Rafael, Dean Winchester e Sam Winchester.',
'Sua identidade como Loki é uma forma de esconder sua verdadeira natureza. É responsável por várias situações em que os Winchester acreditam estar presos em realidades alternativas.');


INSERT INTO monstro
(nome, categoria, caminho_imagem, descricao, caracteristicas, habilidades, fraquezas, curiosidades)
VALUES

('Wendigo', 'Criatura', 'assets/imgs/monstros/wendigo.png',
'Criatura humana transformada pela prática de canibalismo em circunstâncias extremas. É apresentada como uma ameaça que caça pessoas em regiões isoladas.',
'Possui aparência humanoide deformada, grande agilidade e comportamento predatório. Costuma viver em florestas e cavernas.',
'Força física elevada, velocidade, escalada e capacidade de imitar vozes humanas para atrair vítimas.',
'O fogo é sua principal fraqueza conhecida na série.',
'Aparece no episódio piloto da série, quando Sam e Dean investigam desaparecimentos em uma floresta.'),

('Leviatã', 'Criatura', 'assets/imgs/monstros/leviathans.png',
'Seres primordiais criados por Deus e aprisionados no Purgatório. São libertados quando Castiel absorve as almas do local.',
'Podem assumir aparência humana e apresentam comportamento extremamente predatório. Dick Roman é o principal líder dos Leviatãs apresentados na série.',
'Imitação de aparência humana, regeneração, força elevada e capacidade de consumir seres humanos.',
'O bórax pode enfraquecê-los. Para matar um Leviatã de forma definitiva, é necessário utilizar o osso de um justo lavado no sangue de três caídos.',
'Os Leviatãs são os principais antagonistas da sétima temporada e sua liderança está ligada à empresa SucroCorp.'),

('Vampiro', 'Criatura', 'assets/imgs/monstros/vampiro.png',
'Predador sobrenatural que se alimenta de sangue humano. Na série, vampiros vivem em grupos organizados e podem formar famílias.',
'Possuem presas, força superior à humana e comportamento predatório. Alguns grupos seguem códigos próprios.',
'Força física elevada, velocidade, sentidos aguçados e regeneração.',
'A decapitação é uma forma eficaz de matá-los. Sangue de homem morto pode enfraquecê-los temporariamente.',
'Os Winchester encontram diferentes grupos de vampiros ao longo da série, incluindo aqueles que tentam abandonar a alimentação humana.'),

('Lobisomem', 'Criatura', 'assets/imgs/monstros/lobisomem.png',
'Humano infectado por uma condição sobrenatural que provoca transformações e comportamento predatório.',
'Durante a transformação, apresenta características animalescas, garras e comportamento agressivo.',
'Força física elevada, velocidade, sentidos aguçados e capacidade de rastrear vítimas.',
'A prata é uma fraqueza importante. Um golpe de prata no coração pode matar um lobisomem.',
'No episódio Heart, Sam e Dean enfrentam uma lobisomem chamada Madison, cuja história apresenta o conflito entre humanidade e instinto.'),

('Djinn', 'Criatura', 'assets/imgs/monstros/djinn.png',
'Criatura que ataca suas vítimas por meio de alucinações e realidades ilusórias, mantendo-as presas em um estado de inconsciência.',
'Possui aparência humana e costuma se alimentar de suas vítimas enquanto elas vivenciam sonhos ou pesadelos.',
'Indução de alucinações, manipulação de percepções e produção de realidades ilusórias.',
'Uma faca de prata mergulhada em sangue de cordeiro é utilizada para matá-lo.',
'No episódio What Is and What Should Never Be, Dean é preso em uma realidade ilusória criada por um Djinn.'),

('Metamorfo (Shapeshifter)', 'Criatura', 'assets/imgs/monstros/shapeshifter.png',
'Criatura capaz de assumir a aparência de outras pessoas, imitando seus rostos e características físicas.',
'Pode abandonar sua pele antiga durante a transformação. Em geral, utiliza a aparência de humanos para cometer crimes.',
'Imitação de aparência humana, infiltração e força física superior à humana.',
'A prata pode ser utilizada para feri-lo e matá-lo, incluindo ataques ao coração. A decapitação também é eficaz.',
'A criatura aparece no episódio Skin, no qual um metamorfo assume a aparência de Dean Winchester.'),

('Demônio', 'Entidade', 'assets/imgs/monstros/demonio.png',
'Alma humana corrompida após sofrimento e tortura no Inferno. Demônios frequentemente possuem seres humanos para agir no mundo físico.',
'Na forma verdadeira, costuma aparecer como fumaça escura. Quando possui humanos, apresenta olhos negros ou outras manifestações demoníacas.',
'Possessão, teletransporte, manipulação, força sobrenatural e uso de poderes demoníacos.',
'Exorcismos podem expulsar demônios de seus hospedeiros, mas não necessariamente os matam. A faca demoníaca e lâminas angelicais podem eliminá-los.',
'Azazel, Lilith, Alastair e Crowley são exemplos de demônios importantes na história da série.'),

('Fantasma', 'Espírito', 'assets/imgs/monstros/fantasma.png',
'Espírito de uma pessoa falecida que permanece no mundo dos vivos devido a questões não resolvidas, objetos de ligação ou circunstâncias traumáticas.',
'Pode apresentar aparência humana, deformações ou manifestações violentas. Alguns ficam presos a objetos ou locais.',
'Intangibilidade, telecinese, aparições e capacidade de atacar pessoas.',
'O sal pode impedir ou repelir manifestações. Queimar os restos mortais ou destruir o objeto de ligação pode libertar o espírito.',
'Os Winchester frequentemente investigam mortes violentas e objetos associados aos espíritos para descobrir como encerrá-los.'),

('Cão do Inferno', 'Criatura', 'assets/imgs/monstros/cao-do-inferno.png',
'Criatura demoníaca utilizada para perseguir e cobrar pessoas que fizeram pactos com demônios de encruzilhada.',
'Normalmente invisível aos olhos humanos. Suas vítimas costumam perceber apenas os sons de suas garras e ataques.',
'Velocidade elevada, força sobrenatural e capacidade de rastrear pessoas marcadas por contratos demoníacos.',
'Barreiras de sal e fogo sagrado podem ser utilizados para impedir seus ataques. Armas sobrenaturais também podem feri-los.',
'São frequentemente associados aos contratos de dez anos feitos com demônios de encruzilhada.'),

('Skinwalker', 'Criatura', 'assets/imgs/monstros/skinwalker.png',
'Criatura capaz de assumir a forma de um animal, especialmente cães, e circular entre humanos sem levantar suspeitas.',
'Pode alternar entre aparência humana e animal. Em sua forma canina, pode atacar pessoas e outros animais.',
'Transformação, força física, velocidade e capacidade de perseguir vítimas.',
'A prata é uma das principais fraquezas utilizadas pelos caçadores.',
'Na série, os Skinwalkers são apresentados como criaturas capazes de se infiltrar em ambientes humanos.'),

('Rugaru', 'Criatura', 'assets/imgs/monstros/rugaru.png',
'Ser humano que carrega uma condição sobrenatural hereditária e pode se transformar em uma criatura canibal.',
'Inicialmente parece humano, mas desenvolve uma fome crescente por carne humana e mudanças físicas progressivas.',
'Força física elevada, resistência e comportamento predatório após a transformação.',
'O fogo é a principal forma de eliminar um Rugaru transformado.',
'No episódio Metamorphosis, Sam e Dean investigam Jack Montgomery, que começa a apresentar os sintomas da transformação.'),

('Ghoul', 'Criatura', 'assets/imgs/monstros/ghoul.png',
'Criatura que se alimenta de cadáveres e pode assumir a aparência de pessoas mortas ao consumir seus corpos.',
'Possui aparência humana quando imita suas vítimas. Sua natureza predatória está ligada ao consumo de carne de cadáveres.',
'Imitação de aparência, força física e capacidade de se infiltrar entre humanos.',
'Ferimentos graves na cabeça e decapitação são formas de eliminá-lo.',
'No episódio Jump the Shark, os Winchester encontram ghouls que assumem a aparência de membros da família Campbell.'),

('Banshee', 'Criatura', 'assets/imgs/monstros/banshee.png',
'Criatura sobrenatural que ataca suas vítimas por meio de gritos de alta intensidade e explora vulnerabilidades humanas.',
'Pode assumir aparência humana e costuma escolher vítimas vulneráveis, causando sofrimento antes de atacá-las.',
'Grito sobrenatural capaz de ferir e incapacitar vítimas, além de habilidades de manipulação.',
'Na série, uma lâmina de ouro é utilizada contra a criatura, e símbolos específicos podem ser empregados para contê-la.',
'A Banshee aparece no episódio Into the Mystic, envolvendo a personagem Eileen Leahy.'),

('Rakshasa', 'Criatura', 'assets/imgs/monstros/rakshasa.png',
'Criatura sobrenatural que se disfarça de humana e se alimenta de pessoas. Na série, possui comportamento associado à invasão de residências.',
'Pode permanecer invisível e assumir aparência humana para enganar suas vítimas.',
'Invisibilidade, disfarce e capacidade de atacar pessoas sem ser percebida.',
'Bronze pode ser utilizado para feri-la e matá-la. A criatura também não consegue entrar em uma residência sem convite.',
'Aparece no episódio Everybody Loves a Clown, no qual os Winchester investigam mortes relacionadas a um circo.'),

('Arachne', 'Criatura', 'assets/imgs/monstros/arachne.png',
'Criatura semelhante a uma aranha que utiliza teias para capturar vítimas e pode transformar humanos em seres de sua espécie.',
'Possui características aracnídeas, comportamento predatório e capacidade de produzir teias resistentes.',
'Produção de teias, captura de vítimas e transformação de humanos por meio de mordidas.',
'A decapitação é uma forma eficaz de eliminá-la.',
'A criatura aparece no episódio Unforgiven, em uma investigação relacionada a desaparecimentos.'),

('Sereia (Siren)', 'Criatura', 'assets/imgs/monstros/sereia-siren.png',
'Criatura que assume a aparência de alguém desejado por sua vítima para criar vínculos emocionais e manipular seu comportamento.',
'Utiliza manipulação psicológica e aparência humana para controlar suas vítimas.',
'Manipulação emocional, sedução e produção de substâncias que afetam o comportamento humano.',
'Uma adaga de bronze mergulhada no sangue de uma pessoa sob seu controle pode matá-la.',
'Aparece no episódio Sex and Violence, no qual a criatura manipula os sentimentos das vítimas.'),

('Kitsune', 'Criatura', 'assets/imgs/monstros/kitsune.png',
'Criatura de aparência humana que se alimenta de tecido da glândula pituitária de suas vítimas.',
'Pode viver entre humanos sem revelar sua verdadeira natureza. Apresenta características físicas e biológicas incomuns.',
'Força física, garras e capacidade de atacar vítimas para se alimentar.',
'Ferimentos no coração podem ser fatais para a criatura.',
'Aparece no episódio The Girl Next Door, envolvendo uma criatura chamada Amy Pond.'),

('Górgona', 'Criatura', 'assets/imgs/monstros/gorgona.png',
'Criatura sobrenatural apresentada na série como um predador humanoide com capacidades especiais de percepção e ataque.',
'Possui aparência humana e utiliza habilidades sobrenaturais para capturar e matar suas vítimas.',
'Capacidade de prever movimentos e utilizar venenos ou substâncias letais em suas vítimas.',
'Pode ser morta por armas adequadas e ataques físicos fatais.',
'Na série, Noah Ophis é apresentado como uma Górgona no episódio Ouroboros. Sua representação não corresponde exatamente à versão da mitologia grega.'),

('Bruxa', 'Entidade', 'assets/imgs/monstros/bruxa.png',
'Ser humano que utiliza magia por meio de feitiços, rituais, objetos e conhecimentos sobrenaturais.',
'Pode agir individualmente ou integrar grupos organizados, como o Grande Coven.',
'Feitiços, maldições, encantamentos, manipulação de energia e rituais mágicos.',
'Não existe uma fraqueza universal para todas as bruxas. O método de combate depende da magia utilizada e das proteções envolvidas.',
'Rowena MacLeod é uma das bruxas mais poderosas da série e possui papel importante em diversos acontecimentos.'),

('Ceifador (Reaper)', 'Entidade', 'assets/imgs/monstros/ceifador-reaper.png',
'Entidade sobrenatural responsável por conduzir almas após a morte. Na série, os ceifadores possuem funções ligadas ao equilíbrio entre vida e morte.',
'Podem aparecer como humanos e interagir com pessoas próximas da morte. Não são necessariamente criaturas hostis.',
'Percepção de mortes iminentes, deslocamento sobrenatural e capacidade de conduzir almas.',
'Não possuem uma fraqueza comum aplicável a todos os ceifadores. Sua natureza e hierarquia variam ao longo da série.',
'Tessa e Billie são exemplos importantes de ceifadoras. Billie posteriormente assume uma posição muito mais elevada na estrutura da Morte.');

INSERT INTO usuario (nome, email, senha, fk_personagem, fk_monstro) VALUES
('Alex Ikezili', 'alex@email.com', '123456', 1, 2),
('Maria Silva', 'maria@email.com', '123456', 1, 8),
('Pedro Santos', 'pedro@email.com', '123456', 2, 2),
('Ana Costa', 'ana@email.com', '123456', 3, 1),
('Lucas Oliveira', 'lucas@email.com', '123456', 4, 2),
('Julia Souza', 'julia@email.com', '123456', 5, 5),
('Carlos Lima', 'carlos@email.com', '123456', 6, 6),
('Fernanda Alves', 'fernanda@email.com', '123456', 7, 2),
('Rafael Ferreira', 'rafael@email.com', '123456', 8, 3),
('Beatriz Rocha', 'beatriz@email.com', '123456', 9, 3),
('Gabriel Martins', 'gabriel@email.com', '123456', 10, 3),
('Mariana Ribeiro', 'mariana@email.com', '123456', 2, 2),
('Thiago Gomes', 'thiago@email.com', '123456', 4, 13),
('Camila Mendes', 'camila@email.com', '123456', 1, 14);

INSERT INTO quiz_tentativa (fk_usuario, pontuacao) VALUES
(1, 4), 
(1, 8),
(2, 5), 
(2, 7),
(3, 9),
(4, 6), 
(4, 8),
(5, 7),
(6, 9),
(7, 5),
(8, 10),
(9, 8),
(10, 7),
(11, 9),
(12, 8),
(13, 6),
(14, 7);
