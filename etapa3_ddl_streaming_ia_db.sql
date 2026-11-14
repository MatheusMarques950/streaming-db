CREATE DATABASE IF NOT EXISTS streaming_ia_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;


USE streaming_ia_db;

CREATE TABLE usuario (
    id_usuario       INT AUTO_INCREMENT,
    nome_completo    VARCHAR(100) NOT NULL,
    email            VARCHAR(120) NOT NULL,
    cpf              CHAR(11)     NOT NULL,
    data_nascimento  DATE         NOT NULL,
    plano            VARCHAR(10)  NOT NULL DEFAULT 'GRATUITO',
    status_conta     CHAR(1)      NOT NULL DEFAULT 'A',
    criado_em        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuario        PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_email  UNIQUE (email),
    CONSTRAINT uq_usuario_cpf    UNIQUE (cpf),
    CONSTRAINT ck_usuario_cpf    CHECK (cpf REGEXP '^[0-9]{11}$'),
    CONSTRAINT ck_usuario_email  CHECK (email LIKE '%_@_%._%'),
    CONSTRAINT ck_usuario_status CHECK (status_conta IN ('A', 'I', 'S')),
    CONSTRAINT ck_usuario_plano  CHECK (plano IN ('GRATUITO', 'PREMIUM', 'FAMILIA', 'ESTUDANTE'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE artista (
    id_artista       INT AUTO_INCREMENT,
    nome_artistico   VARCHAR(100) NOT NULL,
    pais_origem      VARCHAR(60)  NOT NULL,
    esta_verificado  BOOLEAN      NOT NULL DEFAULT FALSE,
    criado_em        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_artista               PRIMARY KEY (id_artista),
    CONSTRAINT uq_artista_nome_artistico UNIQUE (nome_artistico)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE genero (
    id_genero    INT AUTO_INCREMENT,
    nome_genero  VARCHAR(50)  NOT NULL,
    descricao    VARCHAR(255) NULL,
    criado_em    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_genero      PRIMARY KEY (id_genero),
    CONSTRAINT uq_genero_nome UNIQUE (nome_genero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE podcast (
    id_podcast    INT AUTO_INCREMENT,
    titulo        VARCHAR(120) NOT NULL,
    slug          VARCHAR(120) NOT NULL,
    descricao     TEXT         NULL,
    idioma        VARCHAR(5)   NOT NULL DEFAULT 'pt-BR',
    categoria     VARCHAR(50)  NOT NULL,
    nome_criador  VARCHAR(100) NOT NULL,
    criado_em     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_podcast      PRIMARY KEY (id_podcast),
    CONSTRAINT uq_podcast_slug UNIQUE (slug),
    CONSTRAINT ck_podcast_slug CHECK (slug REGEXP '^[a-z0-9]+(-[a-z0-9]+)*$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE album (
    id_album         INT AUTO_INCREMENT,
    id_artista       INT          NOT NULL,
    titulo           VARCHAR(150) NOT NULL,
    ano_lancamento   SMALLINT     NOT NULL,
    gravadora        VARCHAR(80)  NULL,
    criado_em        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_album         PRIMARY KEY (id_album),
    CONSTRAINT uq_album_artista_titulo UNIQUE (id_artista, titulo),
    CONSTRAINT ck_album_ano     CHECK (ano_lancamento BETWEEN 1900 AND 2100),
    CONSTRAINT fk_album_artista FOREIGN KEY (id_artista)
        REFERENCES artista (id_artista)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE musica (
    id_musica                  INT AUTO_INCREMENT,
    id_album                   INT          NOT NULL,
    titulo                     VARCHAR(150) NOT NULL,
    codigo_isrc                CHAR(12)     NOT NULL,
    numero_faixa               SMALLINT     NOT NULL DEFAULT 1,
    duracao_segundos           INT          NOT NULL,
    possui_conteudo_explicito  BOOLEAN      NOT NULL DEFAULT FALSE,
    criado_em                  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_musica         PRIMARY KEY (id_musica),
    CONSTRAINT uq_musica_isrc    UNIQUE (codigo_isrc),
    CONSTRAINT uq_musica_album_faixa UNIQUE (id_album, numero_faixa),
    CONSTRAINT ck_musica_duracao CHECK (duracao_segundos > 0),
    CONSTRAINT ck_musica_faixa   CHECK (numero_faixa > 0),
    CONSTRAINT ck_musica_isrc    CHECK (codigo_isrc REGEXP '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$'),
    CONSTRAINT fk_musica_album   FOREIGN KEY (id_album)
        REFERENCES album (id_album)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE metadados_acusticos_ia (
    id_metadado      INT AUTO_INCREMENT,
    id_musica        INT           NOT NULL,
    bpm              SMALLINT      NOT NULL,
    energia          DECIMAL(3,2)  NOT NULL,
    dancabilidade    DECIMAL(3,2)  NOT NULL,
    valencia         DECIMAL(3,2)  NOT NULL,
    tonalidade       TINYINT       NOT NULL,
    e_modo_maior     BOOLEAN       NOT NULL DEFAULT TRUE,
    vetor_embedding  JSON          NOT NULL,
    versao_modelo    VARCHAR(20)   NOT NULL DEFAULT 'v1.0',
    criado_em        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_metadados_acusticos_ia   PRIMARY KEY (id_metadado),
    CONSTRAINT uq_metadados_musica         UNIQUE (id_musica),
    CONSTRAINT ck_metadados_bpm            CHECK (bpm BETWEEN 20 AND 300),
    CONSTRAINT ck_metadados_energia        CHECK (energia BETWEEN 0.00 AND 1.00),
    CONSTRAINT ck_metadados_dancabilidade  CHECK (dancabilidade BETWEEN 0.00 AND 1.00),
    CONSTRAINT ck_metadados_valencia       CHECK (valencia BETWEEN 0.00 AND 1.00),
    CONSTRAINT ck_metadados_tonalidade     CHECK (tonalidade BETWEEN 0 AND 11),
    CONSTRAINT ck_metadados_vetor          CHECK (JSON_TYPE(vetor_embedding) = 'ARRAY'
                                                  AND JSON_LENGTH(vetor_embedding) = 8),
    CONSTRAINT fk_metadados_musica         FOREIGN KEY (id_musica)
        REFERENCES musica (id_musica)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE episodio_podcast (
    id_episodio                INT AUTO_INCREMENT,
    id_podcast                 INT          NOT NULL,
    titulo                     VARCHAR(150) NOT NULL,
    numero_episodio            SMALLINT     NOT NULL,
    duracao_segundos           INT          NOT NULL,
    data_publicacao            DATE         NOT NULL,
    possui_conteudo_explicito  BOOLEAN      NOT NULL DEFAULT FALSE,
    transcricao_texto          TEXT         NULL,
    criado_em                  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_episodio_podcast      PRIMARY KEY (id_episodio),
    CONSTRAINT uq_episodio_podcast_num  UNIQUE (id_podcast, numero_episodio),
    CONSTRAINT ck_episodio_duracao      CHECK (duracao_segundos > 0),
    CONSTRAINT ck_episodio_numero       CHECK (numero_episodio > 0),
    CONSTRAINT fk_episodio_podcast      FOREIGN KEY (id_podcast)
        REFERENCES podcast (id_podcast)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE playlist (
    id_playlist  INT AUTO_INCREMENT,
    id_usuario   INT          NOT NULL,
    nome         VARCHAR(100) NOT NULL,
    descricao    VARCHAR(255) NULL,
    e_publica    BOOLEAN      NOT NULL DEFAULT FALSE,
    criado_em    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_playlist          PRIMARY KEY (id_playlist),
    CONSTRAINT uq_playlist_usuario_nome UNIQUE (id_usuario, nome),
    CONSTRAINT fk_playlist_usuario  FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE historico_reproducao (
    id_reproducao    INT AUTO_INCREMENT,
    id_usuario       INT          NOT NULL,
    id_musica        INT          NULL,
    id_episodio      INT          NULL,
    reproduzido_em   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    segundos_ouvidos INT          NOT NULL,
    foi_pulada       BOOLEAN      NOT NULL DEFAULT FALSE,
    dispositivo      VARCHAR(15)  NOT NULL DEFAULT 'CELULAR',
    criado_em        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_historico_reproducao PRIMARY KEY (id_reproducao),
    CONSTRAINT ck_historico_segundos   CHECK (segundos_ouvidos >= 0),
    CONSTRAINT ck_historico_dispositivo CHECK (dispositivo IN
        ('CELULAR', 'DESKTOP', 'WEB', 'TV', 'CARRO', 'CAIXA_SOM')),
    CONSTRAINT ck_historico_midia      CHECK (
        (id_musica IS NOT NULL AND id_episodio IS NULL)
        OR (id_musica IS NULL AND id_episodio IS NOT NULL)),
    CONSTRAINT fk_historico_usuario    FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_historico_musica     FOREIGN KEY (id_musica)
        REFERENCES musica (id_musica)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    CONSTRAINT fk_historico_episodio   FOREIGN KEY (id_episodio)
        REFERENCES episodio_podcast (id_episodio)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE musica_artista (
    id_musica   INT         NOT NULL,
    id_artista  INT         NOT NULL,
    papel       VARCHAR(15) NOT NULL DEFAULT 'PRINCIPAL',
    criado_em   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_musica_artista        PRIMARY KEY (id_musica, id_artista),
    CONSTRAINT ck_musica_artista_papel  CHECK (papel IN ('PRINCIPAL', 'PARTICIPACAO', 'PRODUTOR')),
    CONSTRAINT fk_musica_artista_musica FOREIGN KEY (id_musica)
        REFERENCES musica (id_musica)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_musica_artista_artista FOREIGN KEY (id_artista)
        REFERENCES artista (id_artista)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE musica_genero (
    id_musica  INT      NOT NULL,
    id_genero  INT      NOT NULL,
    criado_em  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_musica_genero         PRIMARY KEY (id_musica, id_genero),
    CONSTRAINT fk_musica_genero_musica  FOREIGN KEY (id_musica)
        REFERENCES musica (id_musica)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_musica_genero_genero  FOREIGN KEY (id_genero)
        REFERENCES genero (id_genero)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE playlist_musica (
    id_playlist  INT      NOT NULL,
    id_musica    INT      NOT NULL,
    posicao      SMALLINT NOT NULL,
    criado_em    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_playlist_musica          PRIMARY KEY (id_playlist, id_musica),
    CONSTRAINT uq_playlist_musica_posicao  UNIQUE (id_playlist, posicao),
    CONSTRAINT ck_playlist_musica_posicao  CHECK (posicao > 0),
    CONSTRAINT fk_playlist_musica_playlist FOREIGN KEY (id_playlist)
        REFERENCES playlist (id_playlist)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_playlist_musica_musica   FOREIGN KEY (id_musica)
        REFERENCES musica (id_musica)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE FULLTEXT INDEX ft_episodio_transcricao
    ON episodio_podcast (transcricao_texto);


CREATE FULLTEXT INDEX ft_musica_titulo
    ON musica (titulo);


CREATE INDEX idx_historico_usuario_data
    ON historico_reproducao (id_usuario, reproduzido_em);


CREATE INDEX idx_historico_musica_skip
    ON historico_reproducao (id_musica, foi_pulada);


CREATE INDEX idx_metadados_recomendacao
    ON metadados_acusticos_ia (bpm, energia, dancabilidade, valencia);
