-- =====================================================================
-- streaming_db — Consultas (versão resumida para execução rápida)
-- Mesma numeração e mesma lógica de consultas_dbeaver.sql (Q1 a Q15 + V1).
-- O motor de recomendação (Q14, Q15 e a view) está completo, sem cortes.
-- =====================================================================
USE streaming_db;

-- ---------- SIMPLES (Q1 a Q5) ----------
-- Q1. Rock entre 3 e 5 minutos (LIKE, BETWEEN, ORDER BY)
SELECT titulo, genero, duracao_segundos FROM musica
WHERE genero LIKE '%Rock%' AND duracao_segundos BETWEEN 180 AND 300
ORDER BY duracao_segundos DESC;

-- Q2. Contas ativas ou suspensas (IN)
SELECT nome, email, status_conta FROM usuario
WHERE status_conta IN ('A', 'S') ORDER BY criado_em;

-- Q3. Gêneros do catálogo (DISTINCT)
SELECT DISTINCT genero FROM musica WHERE genero IS NOT NULL ORDER BY genero;

-- Q4. Cinco músicas mais longas (LIMIT)
SELECT titulo, duracao_segundos FROM musica ORDER BY duracao_segundos DESC LIMIT 5;

-- Q5. Álbuns lançados a partir de 2000
SELECT titulo, data_lancamento FROM album
WHERE data_lancamento >= '2000-01-01' ORDER BY data_lancamento DESC;

-- ---------- JOIN + GROUP BY + HAVING (Q6 a Q10) ----------
-- Q6. Desempenho por música: plays, tempo médio e máximo (2 tabelas)
SELECT m.titulo, COUNT(*) AS plays,
       ROUND(AVG(h.tempo_ouvido_segundos)) AS media_s, MAX(h.tempo_ouvido_segundos) AS maximo_s
FROM historico_reproducao h INNER JOIN musica m ON m.id_musica = h.id_musica
GROUP BY m.id_musica, m.titulo HAVING COUNT(*) >= 3 ORDER BY plays DESC;

-- Q7. Resumo das playlists (2 tabelas)
SELECT p.titulo AS playlist, COUNT(*) AS musicas,
       MIN(pm.adicionada_em) AS primeira_inclusao, MAX(pm.adicionada_em) AS ultima_inclusao
FROM playlist p INNER JOIN playlist_musica pm ON pm.id_playlist = p.id_playlist
GROUP BY p.id_playlist, p.titulo HAVING COUNT(*) >= 2 ORDER BY musicas DESC;

-- Q8. Engajamento por usuário (2 tabelas)
SELECT u.nome AS usuario, COUNT(*) AS plays,
       SUM(h.tempo_ouvido_segundos) AS segundos, SUM(h.foi_pulada) AS skips
FROM usuario u INNER JOIN historico_reproducao h ON h.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome HAVING COUNT(*) >= 2 ORDER BY segundos DESC;

-- Q9. Taxa de skip por artista (3 tabelas)
SELECT a.nome_artistico AS artista, COUNT(*) AS plays, SUM(h.foi_pulada) AS skips,
       ROUND(100 * AVG(h.foi_pulada), 1) AS taxa_skip_pct
FROM historico_reproducao h
INNER JOIN musica_artista mar ON mar.id_musica = h.id_musica AND mar.papel = 'principal'
INNER JOIN artista a ON a.id_artista = mar.id_artista
GROUP BY a.id_artista, a.nome_artistico HAVING COUNT(*) >= 3 ORDER BY taxa_skip_pct DESC;

-- Q10. Perfil acústico por artista (4 tabelas)
SELECT a.nome_artistico AS artista, COUNT(*) AS musicas, ROUND(AVG(ma.bpm)) AS bpm_medio,
       MAX(ma.energia) AS maior_energia, MIN(ma.dancabilidade) AS menor_danca
FROM artista a
INNER JOIN musica_artista mar ON mar.id_artista = a.id_artista
INNER JOIN musica m ON m.id_musica = mar.id_musica
INNER JOIN metadados_acusticos ma ON ma.id_musica = m.id_musica
GROUP BY a.id_artista, a.nome_artistico HAVING AVG(ma.energia) >= 0.5 ORDER BY maior_energia DESC;

-- ---------- BONIFICAÇÃO (Q11 a Q13) ----------
-- Q11. Subconsulta: energia acima da média
SELECT m.titulo, ma.energia FROM musica m
INNER JOIN metadados_acusticos ma ON ma.id_musica = m.id_musica
WHERE ma.energia > (SELECT AVG(energia) FROM metadados_acusticos) ORDER BY ma.energia DESC;

-- Q12. LEFT JOIN: músicas sem nenhuma reprodução
SELECT m.id_musica, m.titulo FROM musica m
LEFT JOIN historico_reproducao h ON h.id_musica = m.id_musica WHERE h.id_historico IS NULL;

-- Q13. FULLTEXT: busca em transcrições de podcast (ajuste o termo)
SELECT p.titulo AS podcast, e.titulo AS episodio,
       MATCH(e.transcricao_texto) AGAINST('tecnologia' IN NATURAL LANGUAGE MODE) AS relevancia
FROM episodio_podcast e INNER JOIN podcast p ON p.id_podcast = e.id_podcast
WHERE MATCH(e.transcricao_texto) AGAINST('tecnologia' IN NATURAL LANGUAGE MODE)
ORDER BY relevancia DESC;

-- =====================================================================
-- MOTOR DE RECOMENDAÇÃO ACÚSTICA (completo)
-- Distância euclidiana:  d(x, y) = sqrt( (x1-y1)^2 + (x2-y2)^2 + ... )
-- Menor distância = música mais parecida.
-- =====================================================================
-- Q14. Atributos escalares (3 dimensões): BPM/300 (limite do CHECK), energia, dançabilidade
SELECT m2.titulo, a.nome_artistico AS artista,
       ROUND(SQRT(
           POW(ma2.bpm / 300 - ma1.bpm / 300, 2) +
           POW(ma2.energia - ma1.energia, 2) +
           POW(ma2.dancabilidade - ma1.dancabilidade, 2)
       ), 4) AS distancia_acustica
FROM musica m1
INNER JOIN metadados_acusticos ma1 ON ma1.id_musica = m1.id_musica
INNER JOIN metadados_acusticos ma2 ON ma2.id_musica <> m1.id_musica
INNER JOIN musica m2 ON m2.id_musica = ma2.id_musica
INNER JOIN musica_artista mar ON mar.id_musica = m2.id_musica AND mar.papel = 'principal'
INNER JOIN artista a ON a.id_artista = mar.id_artista
WHERE m1.titulo = 'Afterlife'
ORDER BY distancia_acustica ASC LIMIT 5;

-- Q15. Vetor JSON de 4 posições (SQL puro)
WITH vetores AS (
    SELECT m.id_musica, m.titulo,
           CAST(JSON_UNQUOTE(JSON_EXTRACT(ma.vetor_embedding, '$[0]')) AS DECIMAL(10,6)) AS v1,
           CAST(JSON_UNQUOTE(JSON_EXTRACT(ma.vetor_embedding, '$[1]')) AS DECIMAL(10,6)) AS v2,
           CAST(JSON_UNQUOTE(JSON_EXTRACT(ma.vetor_embedding, '$[2]')) AS DECIMAL(10,6)) AS v3,
           CAST(JSON_UNQUOTE(JSON_EXTRACT(ma.vetor_embedding, '$[3]')) AS DECIMAL(10,6)) AS v4
    FROM musica m
    INNER JOIN metadados_acusticos ma ON ma.id_musica = m.id_musica
)
SELECT c.titulo, a.nome_artistico AS artista,
       ROUND(SQRT(
           POW(c.v1 - r.v1, 2) + POW(c.v2 - r.v2, 2) +
           POW(c.v3 - r.v3, 2) + POW(c.v4 - r.v4, 2)
       ), 4) AS distancia_acustica
FROM vetores r
INNER JOIN vetores c ON c.id_musica <> r.id_musica
INNER JOIN musica_artista mar ON mar.id_musica = c.id_musica AND mar.papel = 'principal'
INNER JOIN artista a ON a.id_artista = mar.id_artista
WHERE r.titulo = 'Afterlife'
ORDER BY distancia_acustica ASC LIMIT 5;

-- V1. View consolidada do catálogo
CREATE OR REPLACE VIEW vw_catalogo_inteligente AS
SELECT m.id_musica, m.titulo AS musica, a.nome_artistico AS artista_principal, al.titulo AS album,
       ma.bpm, ma.energia, ma.dancabilidade, COUNT(h.id_historico) AS total_reproducoes
FROM musica m
INNER JOIN album al ON al.id_album = m.id_album
INNER JOIN musica_artista mar ON mar.id_musica = m.id_musica AND mar.papel = 'principal'
INNER JOIN artista a ON a.id_artista = mar.id_artista
INNER JOIN metadados_acusticos ma ON ma.id_musica = m.id_musica
LEFT JOIN historico_reproducao h ON h.id_musica = m.id_musica
GROUP BY m.id_musica, m.titulo, a.nome_artistico, al.titulo, ma.bpm, ma.energia, ma.dancabilidade;

SELECT * FROM vw_catalogo_inteligente ORDER BY total_reproducoes DESC;
