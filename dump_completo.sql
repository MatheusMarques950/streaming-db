-- MySQL dump 10.13  Distrib 8.4.10, for Linux (x86_64)
--
-- Host: localhost    Database: streaming_db
-- ------------------------------------------------------
-- Server version	8.4.10

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `id_album` int NOT NULL AUTO_INCREMENT,
  `id_artista` int NOT NULL,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_lancamento` enum('ALBUM','EP','SINGLE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ALBUM',
  `data_lancamento` date NOT NULL,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_album`),
  UNIQUE KEY `uq_album_artista_titulo` (`id_artista`,`titulo`),
  KEY `idx_album_data_lancamento` (`data_lancamento`),
  CONSTRAINT `fk_album_artista` FOREIGN KEY (`id_artista`) REFERENCES `artista` (`id_artista`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,1,'Afterlife','SINGLE','2025-03-28','2026-11-05 21:20:49'),(2,2,'Meteora','ALBUM','2003-03-25','2026-11-05 21:20:49'),(3,3,'Party Monster','SINGLE','2024-01-15','2026-11-05 21:20:49'),(4,4,'Unleashed','ALBUM','2016-08-05','2026-11-05 21:20:49'),(5,5,'Serotonina','SINGLE','2023-06-10','2026-11-05 21:20:49'),(6,6,'A/B','ALBUM','2016-06-10','2026-11-05 21:20:49'),(7,7,'Appetite For Destruction','ALBUM','1987-07-21','2026-11-05 21:20:49'),(8,8,'Back In Black','ALBUM','1980-07-25','2026-11-05 21:20:49'),(9,9,'Nevermind','ALBUM','1991-09-24','2026-11-05 21:20:49'),(10,10,'Slippery When Wet','ALBUM','1986-08-18','2026-11-05 21:20:49'),(11,11,'News Of The World','ALBUM','1977-10-28','2026-11-05 21:20:49'),(12,12,'The Wall','ALBUM','1979-11-30','2026-11-05 21:20:49'),(13,13,'Elephant','ALBUM','2003-04-01','2026-11-05 21:20:49'),(14,14,'The Colour and the Shape','ALBUM','1997-05-20','2026-11-05 21:20:49'),(15,15,'Toxicity','ALBUM','2001-09-04','2026-11-05 21:20:49');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artista`
--

DROP TABLE IF EXISTS `artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artista` (
  `id_artista` int NOT NULL AUTO_INCREMENT,
  `nome_artistico` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais_origem` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `biografia` text COLLATE utf8mb4_unicode_ci,
  `is_verificado` tinyint(1) NOT NULL DEFAULT '0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_artista`),
  UNIQUE KEY `uq_artista_nome` (`nome_artistico`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artista`
--

LOCK TABLES `artista` WRITE;
/*!40000 ALTER TABLE `artista` DISABLE KEYS */;
INSERT INTO `artista` VALUES (1,'Evanescence','Estados Unidos','Banda de rock alternativo e metal gótico formada em Little Rock, Arkansas, em 1995.',1,'2026-11-05 21:20:49'),(2,'Linkin Park','Estados Unidos','Banda de rock alternativo e nu metal formada na Califórnia em 1996.',1,'2026-11-05 21:20:49'),(3,'Grioten','Não informado',NULL,0,'2026-11-05 21:20:49'),(4,'Skillet','Estados Unidos','Banda de rock cristão formada em Memphis, Tennessee, em 1996.',1,'2026-11-05 21:20:49'),(5,'AniRap','Brasil','Projeto brasileiro de rap com temática de animes e cultura geek.',1,'2026-11-05 21:20:49'),(6,'KALEO','Islândia','Banda islandesa de blues rock formada em Mosfellsbær em 2012.',1,'2026-11-05 21:20:49'),(7,'Guns N\' Roses','Estados Unidos','Banda de hard rock formada em Los Angeles em 1985.',1,'2026-11-05 21:20:49'),(8,'AC/DC','Austrália','Banda de hard rock formada em Sydney em 1973.',1,'2026-11-05 21:20:49'),(9,'Nirvana','Estados Unidos','Banda de grunge formada em Aberdeen, Washington, em 1987.',1,'2026-11-05 21:20:49'),(10,'Bon Jovi','Estados Unidos','Banda de rock formada em Sayreville, Nova Jersey, em 1983.',1,'2026-11-05 21:20:49'),(11,'Queen','Reino Unido','Banda de rock formada em Londres em 1970.',1,'2026-11-05 21:20:49'),(12,'Pink Floyd','Reino Unido','Banda de rock progressivo formada em Londres em 1965.',1,'2026-11-05 21:20:49'),(13,'The White Stripes','Estados Unidos','Dupla de garage rock formada em Detroit em 1997.',1,'2026-11-05 21:20:49'),(14,'Foo Fighters','Estados Unidos','Banda de rock alternativo formada em Seattle em 1994.',1,'2026-11-05 21:20:49'),(15,'System Of A Down','Estados Unidos','Banda de metal alternativo formada em Glendale, Califórnia, em 1994.',1,'2026-11-05 21:20:49');
/*!40000 ALTER TABLE `artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episodio_podcast`
--

DROP TABLE IF EXISTS `episodio_podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodio_podcast` (
  `id_episodio` int NOT NULL AUTO_INCREMENT,
  `id_podcast` int NOT NULL,
  `numero_episodio` smallint NOT NULL,
  `titulo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duracao_segundos` int NOT NULL,
  `data_publicacao` date NOT NULL,
  `transcricao_texto` longtext COLLATE utf8mb4_unicode_ci,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_episodio`),
  UNIQUE KEY `uq_episodio_podcast_numero` (`id_podcast`,`numero_episodio`),
  KEY `idx_episodio_data_publicacao` (`data_publicacao`),
  FULLTEXT KEY `idx_ft_episodio_transcricao` (`transcricao_texto`),
  CONSTRAINT `fk_episodio_podcast` FOREIGN KEY (`id_podcast`) REFERENCES `podcast` (`id_podcast`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_episodio_duracao` CHECK ((`duracao_segundos` > 0)),
  CONSTRAINT `ck_episodio_numero` CHECK ((`numero_episodio` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episodio_podcast`
--

LOCK TABLES `episodio_podcast` WRITE;
/*!40000 ALTER TABLE `episodio_podcast` DISABLE KEYS */;
INSERT INTO `episodio_podcast` VALUES (1,1,12,'Modelagem relacional e a terceira forma normal',2760,'2026-03-10','Neste episódio conversamos sobre banco de dados relacional, modelagem entidade relacionamento, chaves primárias e chaves estrangeiras, normalização até a terceira forma normal e boas práticas de MySQL. Falamos de índices B-Tree, consultas SQL com JOIN, transações no InnoDB e desempenho de consultas em tabelas grandes.','2026-11-05 21:20:49'),(2,2,8,'Inteligência artificial dentro do banco de dados',3180,'2026-04-02','Como usar inteligência artificial e aprendizado de máquina próximo dos dados. Explicamos embeddings, vetores de características, similaridade de cosseno, motores de recomendação de músicas e como armazenar vetores em colunas JSON para calcular distância euclidiana direto no SQL.','2026-11-05 21:20:49'),(3,3,31,'Software livre e contribuição em projetos',2520,'2026-02-18','Software livre, código aberto, Linux, Git, GitHub, pull request, revisão de código, licenças MIT e GPL, comunidade de desenvolvedores, contribuição em projetos open source e manutenção de repositórios.','2026-11-05 21:20:49'),(4,4,19,'Computação em nuvem e escalabilidade',3360,'2026-05-14','Computação em nuvem, servidores, contêineres, Docker, Kubernetes, escalabilidade horizontal, balanceamento de carga, banco de dados gerenciado, backup, alta disponibilidade e custos de infraestrutura.','2026-11-05 21:20:49'),(5,5,45,'Nu metal e rock alternativo nos anos 2000',3900,'2026-01-25','Linkin Park, Evanescence, System Of A Down, Meteora, Toxicity, Breaking the Habit, Chop Suey, guitarra distorcida, riff, vocal feminino e masculino, scream, nu metal, rock alternativo e turnês pelo mundo.','2026-11-05 21:20:49'),(6,6,22,'A história do grunge de Seattle',3480,'2026-03-28','Nirvana, Nevermind, Smells Like Teen Spirit, Seattle, grunge, Kurt Cobain, Foo Fighters, Everlong, Dave Grohl, bateria, guitarra, gravadora, anos 90 e a influência da MTV.','2026-11-05 21:20:49'),(7,7,14,'Os grandes hinos do hard rock',4020,'2026-02-07','Guns N\' Roses, Appetite For Destruction, Sweet Child O\' Mine, AC/DC, Back In Black, Bon Jovi, Livin\' On A Prayer, solo de guitarra, hard rock, vinil, anos 80 e estádios lotados.','2026-11-05 21:20:49'),(8,8,9,'Rock progressivo e as turnês lendárias',3720,'2026-04-19','Pink Floyd, The Wall, Another Brick In The Wall, Queen, News Of The World, We Will Rock You, rock progressivo, álbum conceitual, espetáculo ao vivo, palco, efeitos de luz e estádio.','2026-11-05 21:20:49'),(9,9,63,'Trilhas sonoras de anime e rap geek',2880,'2026-05-03','Anime, mangá, abertura, encerramento, trilha sonora, rap nerd, AniRap, Serotonina, cultura otaku, personagens, dublagem e convenção de anime.','2026-11-05 21:20:49'),(10,10,101,'Cultura geek: games, quadrinhos e música',4200,'2026-03-15','Cultura geek, jogos, quadrinhos, Devil May Cry, Evanescence, Afterlife, trilha sonora de série animada, Netflix, cosplay, RPG e colecionáveis.','2026-11-05 21:20:49'),(11,11,27,'Rap de anime e a nova geração de MCs',2640,'2026-04-26','Rap de anime, MCs, batida trap, Grioten, Party Monster, AniRap, produção musical, sample, letra, flow, cultura pop japonesa e comunidade nerd.','2026-11-05 21:20:49'),(12,12,38,'Serotonina e o cérebro: como a música muda o humor',3300,'2026-02-22','Neurociência, serotonina, dopamina, humor, música e cérebro, emoção, ritmo, frequência cardíaca, bem-estar, estudos científicos, ansiedade e prazer musical.','2026-11-05 21:20:49'),(13,13,16,'Física do som e das guitarras elétricas',2940,'2026-05-20','Física do som, ondas sonoras, frequência, amplitude, timbre, distorção, captador, amplificador valvulado, harmônicos, afinação e acústica de salas.','2026-11-05 21:20:49'),(14,14,52,'Buracos negros e a origem do universo',3600,'2026-01-12','Astronomia, buracos negros, Big Bang, galáxias, telescópio espacial, matéria escura, relatividade, cosmologia, estrelas e exoplanetas.','2026-11-05 21:20:49'),(15,15,7,'Sono, memória e aprendizado',2700,'2026-04-08','Neurociência, sono, memória, aprendizado, hipocampo, sinapses, ritmo circadiano, melatonina, estudo, concentração e rotina de estudos para estudantes de engenharia.','2026-11-05 21:20:49');
/*!40000 ALTER TABLE `episodio_podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_reproducao`
--

DROP TABLE IF EXISTS `historico_reproducao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_reproducao` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_musica` int NOT NULL,
  `tempo_ouvido_segundos` int NOT NULL DEFAULT '0',
  `foi_pulada` tinyint(1) NOT NULL DEFAULT '0',
  `data_reproducao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historico`),
  KEY `idx_hist_usuario_data` (`id_usuario`,`data_reproducao`),
  KEY `idx_hist_musica_skip` (`id_musica`,`foi_pulada`),
  CONSTRAINT `fk_hist_musica` FOREIGN KEY (`id_musica`) REFERENCES `musica` (`id_musica`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_hist_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_hist_tempo_ouvido` CHECK ((`tempo_ouvido_segundos` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_reproducao`
--

LOCK TABLES `historico_reproducao` WRITE;
/*!40000 ALTER TABLE `historico_reproducao` DISABLE KEYS */;
INSERT INTO `historico_reproducao` VALUES (1,1,2,196,0,'2026-10-01 08:15:00'),(2,1,1,205,0,'2026-10-01 08:19:00'),(3,2,4,205,0,'2026-10-01 18:30:00'),(4,2,2,196,0,'2026-10-01 18:34:00'),(5,3,5,200,0,'2026-10-02 21:10:00'),(6,3,3,12,1,'2026-10-02 21:14:00'),(7,4,6,18,1,'2026-10-03 14:02:00'),(8,4,12,239,0,'2026-10-03 14:05:00'),(9,5,7,356,0,'2026-10-04 20:45:00'),(10,6,2,196,0,'2026-10-05 09:00:00'),(11,6,1,205,0,'2026-10-05 09:04:00'),(12,7,8,255,0,'2026-10-06 17:20:00'),(13,7,6,22,1,'2026-10-06 17:25:00'),(14,8,4,205,0,'2026-10-07 19:00:00'),(15,8,10,249,0,'2026-10-07 19:05:00'),(16,9,2,196,0,'2026-10-08 22:10:00'),(17,9,15,210,0,'2026-10-08 22:14:00'),(18,10,9,301,0,'2026-10-09 16:40:00'),(19,10,13,8,1,'2026-10-09 16:46:00'),(20,11,5,200,0,'2026-10-10 20:00:00'),(21,11,3,180,0,'2026-10-10 20:04:00'),(22,12,1,205,0,'2026-10-11 23:30:00'),(23,12,5,200,0,'2026-10-11 23:34:00'),(24,13,11,122,0,'2026-10-12 12:10:00'),(25,13,12,15,1,'2026-10-12 12:13:00'),(26,14,8,255,0,'2026-10-13 18:50:00'),(27,14,4,205,0,'2026-10-13 18:55:00'),(28,15,15,25,1,'2026-10-14 07:30:00'),(29,15,3,7,1,'2026-10-14 07:32:00'),(30,1,9,20,1,'2026-10-15 08:05:00'),(31,2,7,5,1,'2026-10-16 18:10:00'),(32,3,2,190,0,'2026-10-16 21:30:00'),(33,5,1,205,0,'2026-10-17 20:00:00'),(34,7,8,255,0,'2026-10-18 17:00:00'),(35,3,8,140,0,'2026-10-18 21:15:00'),(36,8,6,400,0,'2026-10-19 21:00:00'),(37,4,5,200,0,'2026-10-20 15:00:00'),(38,6,4,205,0,'2026-10-21 09:10:00');
/*!40000 ALTER TABLE `historico_reproducao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadados_acusticos_ia`
--

DROP TABLE IF EXISTS `metadados_acusticos_ia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metadados_acusticos_ia` (
  `id_metadado` int NOT NULL AUTO_INCREMENT,
  `id_musica` int NOT NULL,
  `bpm` smallint NOT NULL,
  `energia` decimal(3,2) NOT NULL,
  `dancabilidade` decimal(3,2) NOT NULL,
  `valencia` decimal(3,2) NOT NULL,
  `vetor_embedding` json NOT NULL,
  `versao_modelo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'v1.0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_metadado`),
  UNIQUE KEY `uq_metadados_musica` (`id_musica`),
  KEY `idx_metadados_bpm_energia` (`bpm`,`energia`),
  KEY `idx_metadados_perfil_emocional` (`valencia`,`energia`,`dancabilidade`),
  CONSTRAINT `fk_metadados_musica` FOREIGN KEY (`id_musica`) REFERENCES `musica` (`id_musica`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_metadados_bpm` CHECK ((`bpm` between 20 and 300)),
  CONSTRAINT `ck_metadados_dancabilidade` CHECK ((`dancabilidade` between 0.00 and 1.00)),
  CONSTRAINT `ck_metadados_embedding_array` CHECK ((json_type(`vetor_embedding`) = _utf8mb4'ARRAY')),
  CONSTRAINT `ck_metadados_energia` CHECK ((`energia` between 0.00 and 1.00)),
  CONSTRAINT `ck_metadados_valencia` CHECK ((`valencia` between 0.00 and 1.00))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadados_acusticos_ia`
--

LOCK TABLES `metadados_acusticos_ia` WRITE;
/*!40000 ALTER TABLE `metadados_acusticos_ia` DISABLE KEYS */;
INSERT INTO `metadados_acusticos_ia` VALUES (1,1,138,0.88,0.47,0.18,'[0.88, 0.47, 0.18, 0.69]','v1.0','2026-11-05 21:20:49'),(2,2,100,0.80,0.50,0.15,'[0.82, 0.52, 0.17, 0.5]','v1.0','2026-11-05 21:20:49'),(3,3,140,0.85,0.75,0.35,'[0.84, 0.77, 0.36, 0.7]','v1.0','2026-11-05 21:20:49'),(4,4,115,0.95,0.55,0.60,'[0.94, 0.56, 0.62, 0.58]','v1.0','2026-11-05 21:20:49'),(5,5,90,0.70,0.72,0.55,'[0.68, 0.74, 0.54, 0.45]','v1.0','2026-11-05 21:20:49'),(6,6,72,0.50,0.38,0.25,'[0.52, 0.36, 0.27, 0.36]','v1.0','2026-11-05 21:20:49'),(7,7,125,0.78,0.45,0.60,'[0.8, 0.44, 0.61, 0.63]','v1.0','2026-11-05 21:20:49'),(8,8,94,0.90,0.52,0.70,'[0.91, 0.54, 0.69, 0.47]','v1.0','2026-11-05 21:20:49'),(9,9,117,0.91,0.50,0.72,'[0.92, 0.49, 0.7, 0.59]','v1.0','2026-11-05 21:20:49'),(10,10,123,0.89,0.55,0.83,'[0.88, 0.57, 0.84, 0.62]','v1.0','2026-11-05 21:20:49'),(11,11,81,0.75,0.69,0.56,'[0.74, 0.7, 0.55, 0.41]','v1.0','2026-11-05 21:20:49'),(12,12,104,0.62,0.70,0.55,'[0.63, 0.71, 0.54, 0.52]','v1.0','2026-11-05 21:20:49'),(13,13,124,0.74,0.74,0.32,'[0.75, 0.73, 0.33, 0.62]','v1.0','2026-11-05 21:20:49'),(14,14,158,0.90,0.43,0.40,'[0.91, 0.42, 0.41, 0.79]','v1.0','2026-11-05 21:20:49'),(15,15,127,0.95,0.40,0.20,'[0.96, 0.41, 0.21, 0.64]','v1.0','2026-11-05 21:20:49');
/*!40000 ALTER TABLE `metadados_acusticos_ia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musica`
--

DROP TABLE IF EXISTS `musica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musica` (
  `id_musica` int NOT NULL AUTO_INCREMENT,
  `id_album` int NOT NULL,
  `codigo_isrc` char(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_faixa` smallint NOT NULL,
  `duracao_segundos` int NOT NULL,
  `genero` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_explicito` tinyint(1) NOT NULL DEFAULT '0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_musica`),
  UNIQUE KEY `uq_musica_isrc` (`codigo_isrc`),
  UNIQUE KEY `uq_musica_album_faixa` (`id_album`,`numero_faixa`),
  KEY `idx_musica_genero` (`genero`),
  FULLTEXT KEY `idx_ft_musica_titulo` (`titulo`),
  CONSTRAINT `fk_musica_album` FOREIGN KEY (`id_album`) REFERENCES `album` (`id_album`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_musica_duracao` CHECK ((`duracao_segundos` > 0)),
  CONSTRAINT `ck_musica_numero_faixa` CHECK ((`numero_faixa` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musica`
--

LOCK TABLES `musica` WRITE;
/*!40000 ALTER TABLE `musica` DISABLE KEYS */;
INSERT INTO `musica` VALUES (1,1,'BRSTR2600001','Afterlife',1,205,'Rock Alternativo',0,'2026-11-05 21:20:49'),(2,2,'BRSTR2600002','Breaking the Habit',9,196,'Rock Alternativo',0,'2026-11-05 21:20:49'),(3,3,'BRSTR2600003','Party Monster',1,180,'Hip Hop',1,'2026-11-05 21:20:49'),(4,4,'BRSTR2600004','Feel Invincible',1,205,'Rock Alternativo',0,'2026-11-05 21:20:49'),(5,5,'BRSTR2600005','Serotonina',1,200,'Hip Hop',0,'2026-11-05 21:20:49'),(6,6,'BRSTR2600006','I Can\'t Go on Without You',10,400,'Blues Rock',0,'2026-11-05 21:20:49'),(7,7,'BRSTR2600007','Sweet Child O\' Mine',9,356,'Hard Rock',0,'2026-11-05 21:20:49'),(8,8,'BRSTR2600008','Back In Black',6,255,'Hard Rock',0,'2026-11-05 21:20:49'),(9,9,'BRSTR2600009','Smells Like Teen Spirit',1,301,'Grunge',0,'2026-11-05 21:20:49'),(10,10,'BRSTR2600010','Livin\' On A Prayer',3,249,'Hard Rock',0,'2026-11-05 21:20:49'),(11,11,'BRSTR2600011','We Will Rock You',1,122,'Rock',0,'2026-11-05 21:20:49'),(12,12,'BRSTR2600012','Another Brick In The Wall, Pt. 2',5,239,'Rock Progressivo',0,'2026-11-05 21:20:49'),(13,13,'BRSTR2600013','Seven Nation Army',1,232,'Garage Rock',0,'2026-11-05 21:20:49'),(14,14,'BRSTR2600014','Everlong',11,250,'Rock Alternativo',0,'2026-11-05 21:20:49'),(15,15,'BRSTR2600015','Chop Suey!',6,210,'Metal Alternativo',0,'2026-11-05 21:20:49');
/*!40000 ALTER TABLE `musica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musica_artista`
--

DROP TABLE IF EXISTS `musica_artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musica_artista` (
  `id_musica` int NOT NULL,
  `id_artista` int NOT NULL,
  `papel` enum('PRINCIPAL','PARTICIPACAO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PRINCIPAL',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_musica`,`id_artista`),
  KEY `idx_ma_artista` (`id_artista`),
  CONSTRAINT `fk_ma_artista` FOREIGN KEY (`id_artista`) REFERENCES `artista` (`id_artista`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ma_musica` FOREIGN KEY (`id_musica`) REFERENCES `musica` (`id_musica`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musica_artista`
--

LOCK TABLES `musica_artista` WRITE;
/*!40000 ALTER TABLE `musica_artista` DISABLE KEYS */;
INSERT INTO `musica_artista` VALUES (1,1,'PRINCIPAL','2026-11-05 21:20:49'),(2,2,'PRINCIPAL','2026-11-05 21:20:49'),(3,3,'PRINCIPAL','2026-11-05 21:20:49'),(4,4,'PRINCIPAL','2026-11-05 21:20:49'),(5,5,'PRINCIPAL','2026-11-05 21:20:49'),(6,6,'PRINCIPAL','2026-11-05 21:20:49'),(7,7,'PRINCIPAL','2026-11-05 21:20:49'),(8,8,'PRINCIPAL','2026-11-05 21:20:49'),(9,9,'PRINCIPAL','2026-11-05 21:20:49'),(10,10,'PRINCIPAL','2026-11-05 21:20:49'),(11,11,'PRINCIPAL','2026-11-05 21:20:49'),(12,12,'PRINCIPAL','2026-11-05 21:20:49'),(13,13,'PRINCIPAL','2026-11-05 21:20:49'),(14,14,'PRINCIPAL','2026-11-05 21:20:49'),(15,15,'PRINCIPAL','2026-11-05 21:20:49');
/*!40000 ALTER TABLE `musica_artista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id_playlist` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `titulo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publica` tinyint(1) NOT NULL DEFAULT '1',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_playlist`),
  UNIQUE KEY `uq_playlist_usuario_titulo` (`id_usuario`,`titulo`),
  KEY `idx_playlist_publica` (`publica`,`criado_em`),
  CONSTRAINT `fk_playlist_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,1,'Só Rock: As Melhores de Todos os Tempos',1,'2026-11-05 21:20:49'),(2,2,'Treino Pesado - Skillet & Linkin Park',1,'2026-11-05 21:20:49'),(3,3,'Vibe Anime & Geek - AniRap',1,'2026-11-05 21:20:49'),(4,4,'Foco nos Estudos de Engenharia',0,'2026-11-05 21:20:49'),(5,5,'Clássicos Anos 80 e 90',1,'2026-11-05 21:20:49'),(6,6,'Rock Alternativo Nostálgico',1,'2026-11-05 21:20:49'),(7,7,'Estrada e Hard Rock',1,'2026-11-05 21:20:49'),(8,8,'Hinos de Estádio',1,'2026-11-05 21:20:49'),(9,9,'Nu Metal Forever',1,'2026-11-05 21:20:49'),(10,10,'Grunge e Garage Rock',0,'2026-11-05 21:20:49'),(11,11,'Trilha para Jogar',1,'2026-11-05 21:20:49'),(12,12,'Madrugada de Programação',0,'2026-11-05 21:20:49'),(13,13,'Rock Progressivo e Clássicos',1,'2026-11-05 21:20:49'),(14,14,'Churrasco com Rock',1,'2026-11-05 21:20:49'),(15,15,'Pesadão para Correr',1,'2026-11-05 21:20:49');
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_musica`
--

DROP TABLE IF EXISTS `playlist_musica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_musica` (
  `id_playlist` int NOT NULL,
  `id_musica` int NOT NULL,
  `adicionada_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_playlist`,`id_musica`),
  KEY `idx_pm_musica` (`id_musica`),
  CONSTRAINT `fk_pm_musica` FOREIGN KEY (`id_musica`) REFERENCES `musica` (`id_musica`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pm_playlist` FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_musica`
--

LOCK TABLES `playlist_musica` WRITE;
/*!40000 ALTER TABLE `playlist_musica` DISABLE KEYS */;
INSERT INTO `playlist_musica` VALUES (1,7,'2026-09-01 10:00:00'),(1,8,'2026-09-01 10:02:00'),(1,9,'2026-09-01 10:05:00'),(1,10,'2026-09-01 10:08:00'),(1,11,'2026-09-02 09:30:00'),(1,12,'2026-09-02 09:33:00'),(2,2,'2026-09-05 17:03:00'),(2,4,'2026-09-05 17:00:00'),(2,15,'2026-09-05 17:06:00'),(3,1,'2026-09-08 20:15:00'),(3,3,'2026-09-08 20:12:00'),(3,5,'2026-09-08 20:10:00'),(4,6,'2026-09-10 14:00:00'),(4,12,'2026-09-10 14:05:00'),(5,7,'2026-09-12 19:00:00'),(5,9,'2026-09-12 19:04:00'),(5,10,'2026-09-12 19:08:00'),(6,2,'2026-09-15 08:20:00'),(6,13,'2026-09-15 08:27:00'),(6,14,'2026-09-15 08:24:00'),(7,7,'2026-09-18 16:45:00'),(7,8,'2026-09-18 16:40:00'),(8,10,'2026-09-20 21:03:00'),(8,11,'2026-09-20 21:00:00'),(9,2,'2026-09-22 22:15:00'),(9,15,'2026-09-22 22:18:00'),(10,9,'2026-09-25 15:30:00'),(10,13,'2026-09-25 15:34:00'),(11,3,'2026-09-27 20:00:00'),(11,5,'2026-09-27 20:03:00'),(12,5,'2026-09-29 23:14:00'),(12,6,'2026-09-29 23:10:00'),(13,11,'2026-10-01 11:04:00'),(13,12,'2026-10-01 11:00:00'),(14,8,'2026-10-02 18:00:00'),(14,11,'2026-10-02 18:05:00'),(15,4,'2026-10-03 06:48:00'),(15,15,'2026-10-03 06:45:00');
/*!40000 ALTER TABLE `playlist_musica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `podcast`
--

DROP TABLE IF EXISTS `podcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `podcast` (
  `id_podcast` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apresentador` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idioma` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pt-BR',
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `is_explicito` tinyint(1) NOT NULL DEFAULT '0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_podcast`),
  UNIQUE KEY `uq_podcast_titulo` (`titulo`),
  UNIQUE KEY `uq_podcast_slug` (`slug`),
  KEY `idx_podcast_categoria` (`categoria`),
  CONSTRAINT `ck_podcast_slug` CHECK (regexp_like(`slug`,_utf8mb4'^[a-z0-9]+(-[a-z0-9]+)*$'))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `podcast`
--

LOCK TABLES `podcast` WRITE;
/*!40000 ALTER TABLE `podcast` DISABLE KEYS */;
INSERT INTO `podcast` VALUES (1,'Papo de Dados','papo-de-dados','Rafael Menezes','Tecnologia','pt-BR','Conversas sobre bancos de dados, engenharia de dados e carreira em tecnologia.',0,'2026-11-05 21:20:49'),(2,'Bit a Bit','bit-a-bit','Camila Duarte','Tecnologia','pt-BR','Inteligência artificial, aprendizado de máquina e o impacto da tecnologia no dia a dia.',0,'2026-11-05 21:20:49'),(3,'Código Aberto FM','codigo-aberto-fm','Thiago Barbosa','Tecnologia','pt-BR','Software livre, comunidades de desenvolvedores e projetos open source.',0,'2026-11-05 21:20:49'),(4,'Cloud Café','cloud-cafe','Juliana Prado','Tecnologia','pt-BR','Computação em nuvem, infraestrutura e arquitetura de sistemas explicadas com café.',0,'2026-11-05 21:20:49'),(5,'Riff Brasil','riff-brasil','André Vasconcelos','Rock','pt-BR','Bandas, álbuns e bastidores do rock alternativo e do metal moderno.',0,'2026-11-05 21:20:49'),(6,'Distorção Podcast','distorcao-podcast','Marcelo Tavares','Rock','pt-BR','A história do rock dos anos 90 e da cena alternativa mundial.',0,'2026-11-05 21:20:49'),(7,'Vinil e Cia','vinil-e-cia','Patrícia Lacerda','Rock','pt-BR','Clássicos do rock e do hard rock revisitados faixa a faixa.',0,'2026-11-05 21:20:49'),(8,'Palco Pesado','palco-pesado','Bruno Cavalcanti','Rock','pt-BR','Turnês lendárias, álbuns conceituais e shows históricos.',1,'2026-11-05 21:20:49'),(9,'Otaku em Foco','otaku-em-foco','Larissa Okamoto','Anime','pt-BR','Lançamentos de anime, mangá e trilhas sonoras da cultura otaku.',0,'2026-11-05 21:20:49'),(10,'Sala dos Nerds','sala-dos-nerds','Gustavo Pimentel','Cultura Geek','pt-BR','Games, quadrinhos, séries e música na cultura geek brasileira.',1,'2026-11-05 21:20:49'),(11,'Mangá e Mate','manga-e-mate','Felipe Nakamura','Anime','pt-BR','Bate-papo sobre mangás, animes e o rap inspirado em personagens.',0,'2026-11-05 21:20:49'),(12,'Ciência em Pauta','ciencia-em-pauta','Helena Rocha','Ciência','pt-BR','Divulgação científica sobre neurociência, saúde e comportamento.',0,'2026-11-05 21:20:49'),(13,'Átomo e Café','atomo-e-cafe','Ricardo Alencar','Ciência','pt-BR','Física e química do cotidiano em episódios curtos e diretos.',0,'2026-11-05 21:20:49'),(14,'Universo em Expansão','universo-em-expansao','Sofia Albuquerque','Ciência','pt-BR','Astronomia, cosmologia e as maiores descobertas do espaço.',0,'2026-11-05 21:20:49'),(15,'Neurônios no Ar','neuronios-no-ar','Paulo Esteves','Ciência','pt-BR','Como o cérebro aprende, lembra e descansa.',0,'2026-11-05 21:20:49');
/*!40000 ALTER TABLE `podcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_plano` enum('GRATUITO','PREMIUM','FAMILIA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GRATUITO',
  `status_conta` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `uq_usuario_email` (`email`),
  UNIQUE KEY `uq_usuario_cpf` (`cpf`),
  CONSTRAINT `ck_usuario_cpf` CHECK (regexp_like(`cpf`,_utf8mb4'^[0-9]{11}$')),
  CONSTRAINT `ck_usuario_email` CHECK ((`email` like _utf8mb4'%_@_%._%')),
  CONSTRAINT `ck_usuario_status` CHECK ((`status_conta` in (_utf8mb4'A',_utf8mb4'S',_utf8mb4'C')))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Mariana Souza Oliveira','mariana.oliveira@email.com','38472916050','PREMIUM','A','2026-11-05 21:20:49'),(2,'Carlos Eduardo Lima','carlos.lima@email.com','71905284631','GRATUITO','A','2026-11-05 21:20:49'),(3,'Ana Beatriz Ferreira','ana.ferreira@email.com','25618349702','FAMILIA','A','2026-11-05 21:20:49'),(4,'João Pedro Santos','joao.santos@email.com','90347152860','PREMIUM','A','2026-11-05 21:20:49'),(5,'Fernanda Costa Almeida','fernanda.almeida@email.com','46281793507','GRATUITO','S','2026-11-05 21:20:49'),(6,'Lucas Gabriel Rocha','lucas.rocha@email.com','83150629478','PREMIUM','A','2026-11-05 21:20:49'),(7,'Juliana Martins Pereira','juliana.pereira@email.com','57924318062','GRATUITO','A','2026-11-05 21:20:49'),(8,'Rafael Henrique Barbosa','rafael.barbosa@email.com','19683540271','FAMILIA','A','2026-11-05 21:20:49'),(9,'Camila Rodrigues Nunes','camila.nunes@email.com','62037485916','PREMIUM','A','2026-11-05 21:20:49'),(10,'Thiago Augusto Carvalho','thiago.carvalho@email.com','34859216730','GRATUITO','C','2026-11-05 21:20:49'),(11,'Larissa Mendes Araújo','larissa.araujo@email.com','78246103952','PREMIUM','A','2026-11-05 21:20:49'),(12,'Gustavo Henrique Ribeiro','gustavo.ribeiro@email.com','41570928364','GRATUITO','A','2026-11-05 21:20:49'),(13,'Beatriz Cardoso Moreira','beatriz.moreira@email.com','95312760845','FAMILIA','A','2026-11-05 21:20:49'),(14,'Pedro Henrique Gomes','pedro.gomes@email.com','20468391750','PREMIUM','A','2026-11-05 21:20:49'),(15,'Isabela Teixeira Duarte','isabela.duarte@email.com','67795134208','GRATUITO','A','2026-11-05 21:20:49');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'streaming_db'
--

--
-- Dumping routines for database 'streaming_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-13 22:03:23
