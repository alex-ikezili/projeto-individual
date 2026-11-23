-- ============================================================
-- SEED IDÊMPOTENTE - SUPERNATURAL
-- Uso: execute após criar as tabelas (script-tabelas.sql)
-- ============================================================

USE supernatural;

-- CATÁLOGO DE PERSONAGENS
INSERT INTO personagem (nome, caminho_imagem) VALUES
('Dean Winchester', 'assets/imgs/personagens/dean-winchester.png'),
('Sam Winchester', 'assets/imgs/personagens/sam-winchester.png'),
('Castiel', 'assets/imgs/personagens/castiel.png'),
('Bobby Singer', 'assets/imgs/personagens/bobby-singer.png'),
('Crowley', 'assets/imgs/personagens/crowley.png'),
('Jack Kline', 'assets/imgs/personagens/jack-kline.png'),
('John Winchester', 'assets/imgs/personagens/john-winchester.png'),
('Rowena MacLeod', 'assets/imgs/personagens/rowena-macleod.png'),
('Lucifer', 'assets/imgs/personagens/lucifer.png'),
('Gabriel', 'assets/imgs/personagens/gabriel.png')
ON DUPLICATE KEY UPDATE
caminho_imagem = VALUES(caminho_imagem);

-- CATÁLOGO DE MONSTROS
INSERT INTO monstro (nome, caminho_imagem) VALUES
('Wendigo', 'assets/imgs/monstros/wendigo.png'),
('Leviatã', 'assets/imgs/monstros/leviathans.png'),
('Vampiro', 'assets/imgs/monstros/vampiro.png'),
('Lobisomem', 'assets/imgs/monstros/lobisomem.png'),
('Djinn', 'assets/imgs/monstros/djinn.png'),
('Metamorfo (Shapeshifter)', 'assets/imgs/monstros/shapeshifter.png'),
('Demônio', 'assets/imgs/monstros/demonio.png'),
('Fantasma', 'assets/imgs/monstros/fantasma.png'),
('Cão do Inferno', 'assets/imgs/monstros/cao-do-inferno.png'),
('Skinwalker', 'assets/imgs/monstros/skinwalker.png'),
('Rugaru', 'assets/imgs/monstros/rugaru.png'),
('Ghoul', 'assets/imgs/monstros/ghoul.png'),
('Banshee', 'assets/imgs/monstros/banshee.png'),
('Rakshasa', 'assets/imgs/monstros/rakshasa.png'),
('Arachne', 'assets/imgs/monstros/arachne.png'),
('Sereia (Siren)', 'assets/imgs/monstros/sereia-siren.png'),
('Kitsune', 'assets/imgs/monstros/kitsune.png'),
('Górgona', 'assets/imgs/monstros/gorgona.png'),
('Bruxa', 'assets/imgs/monstros/bruxa.png'),
('Ceifador (Reaper)', 'assets/imgs/monstros/ceifador-reaper.png')
ON DUPLICATE KEY UPDATE
caminho_imagem = VALUES(caminho_imagem);

-- USUÁRIOS DE EXEMPLO
INSERT INTO usuario (nome, email, senha, fk_personagem, fk_monstro)
VALUES
(
  'Alex Ikezili',
  'alex@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Dean Winchester' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Wendigo' LIMIT 1)
),
(
  'Maria Helena',
  'maria.helena@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Sam Winchester' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Fantasma' LIMIT 1)
),
(
  'João Pedro',
  'joao.pedro@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Castiel' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Demônio' LIMIT 1)
),
(
  'Ana Souza',
  'ana.souza@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Crowley' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Lobisomem' LIMIT 1)
),
(
  'Bruno Lima',
  'bruno.lima@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Bobby Singer' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Djinn' LIMIT 1)
),
(
  'Camila Rocha',
  'camila.rocha@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Jack Kline' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Vampiro' LIMIT 1)
)
ON DUPLICATE KEY UPDATE
nome = VALUES(nome),
senha = VALUES(senha),
fk_personagem = VALUES(fk_personagem),
fk_monstro = VALUES(fk_monstro);

-- TENTATIVAS DE QUIZ (somente para usuários acima, idempotente por limpeza prévia)
DELETE qt
FROM quiz_tentativa qt
JOIN usuario u ON u.id = qt.fk_usuario
WHERE u.email IN (
  'alex@supernatural.local',
  'maria.helena@supernatural.local',
  'joao.pedro@supernatural.local',
  'ana.souza@supernatural.local',
  'bruno.lima@supernatural.local',
  'camila.rocha@supernatural.local'
);

INSERT INTO quiz_tentativa (fk_usuario, pontuacao)
SELECT u.id, t.pontuacao
FROM (
    SELECT 'alex@supernatural.local' AS email, 8 AS pontuacao
    UNION ALL SELECT 'alex@supernatural.local', 10
    UNION ALL SELECT 'maria.helena@supernatural.local', 6
    UNION ALL SELECT 'maria.helena@supernatural.local', 7
    UNION ALL SELECT 'joao.pedro@supernatural.local', 9
    UNION ALL SELECT 'ana.souza@supernatural.local', 5
    UNION ALL SELECT 'bruno.lima@supernatural.local', 8
    UNION ALL SELECT 'camila.rocha@supernatural.local', 7
) t
JOIN usuario u
  ON u.email = t.email;
