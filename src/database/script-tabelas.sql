-- ============================================================
-- SCRIPT DO ZERO - PROJETO SUPERNATURAL (MySQL 8+)
-- Objetivo: recriar banco completo e já popular catálogos + usuários
-- Execução: rode este arquivo inteiro no MySQL Workbench/CLI
-- ============================================================

DROP DATABASE IF EXISTS supernatural;

CREATE DATABASE supernatural
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE supernatural;

-- ============================================================
-- TABELAS
-- ============================================================

CREATE TABLE personagem (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    caminho_imagem VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_personagem_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE monstro (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    caminho_imagem VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_monstro_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    fk_personagem INT NULL,
    fk_monstro INT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_usuario_email (email),
    CONSTRAINT fk_usuario_personagem
      FOREIGN KEY (fk_personagem) REFERENCES personagem(id),
    CONSTRAINT fk_usuario_monstro
      FOREIGN KEY (fk_monstro) REFERENCES monstro(id)
) ENGINE=InnoDB;

CREATE TABLE quiz_tentativa (
    id INT NOT NULL AUTO_INCREMENT,
    fk_usuario INT NOT NULL,
    pontuacao INT NOT NULL,
    dt_tentativa DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_quiz_usuario (fk_usuario),
    CONSTRAINT fk_quiz_usuario
      FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
) ENGINE=InnoDB;

-- ============================================================
-- CARGA INICIAL: CATÁLOGO (PERSONAGENS E MONSTROS)
-- ============================================================

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
('Gabriel', 'assets/imgs/personagens/gabriel.png');

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
('Ceifador (Reaper)', 'assets/imgs/monstros/ceifador-reaper.png');

-- ============================================================
-- CARGA INICIAL: USUÁRIOS (POPULAÇÃO DA BASE)
-- Senhas em texto puro somente para ambiente acadêmico/local.
-- ============================================================

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
),
(
  'Diego Nunes',
  'diego.nunes@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Lucifer' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Leviatã' LIMIT 1)
),
(
  'Fernanda Alves',
  'fernanda.alves@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Rowena MacLeod' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Bruxa' LIMIT 1)
),
(
  'Gustavo Mendes',
  'gustavo.mendes@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'Gabriel' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Rakshasa' LIMIT 1)
),
(
  'Helena Costa',
  'helena.costa@supernatural.local',
  '123456',
  (SELECT id FROM personagem WHERE nome = 'John Winchester' LIMIT 1),
  (SELECT id FROM monstro WHERE nome = 'Cão do Inferno' LIMIT 1)
);

-- ============================================================
-- CARGA INICIAL: TENTATIVAS DE QUIZ (DADOS PARA DASHBOARD)
-- ============================================================

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
    UNION ALL SELECT 'diego.nunes@supernatural.local', 4
    UNION ALL SELECT 'fernanda.alves@supernatural.local', 9
    UNION ALL SELECT 'gustavo.mendes@supernatural.local', 6
    UNION ALL SELECT 'helena.costa@supernatural.local', 8
) t
JOIN usuario u
  ON u.email = t.email;

-- ============================================================
-- VERIFICAÇÕES RÁPIDAS
-- ============================================================

-- SELECT COUNT(*) AS total_personagens FROM personagem;
-- SELECT COUNT(*) AS total_monstros FROM monstro;
-- SELECT COUNT(*) AS total_usuarios FROM usuario;
-- SELECT id, nome, email, fk_personagem, fk_monstro FROM usuario ORDER BY id;
-- SELECT fk_usuario, MAX(pontuacao) AS maior_pontuacao FROM quiz_tentativa GROUP BY fk_usuario;
