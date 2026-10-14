-- ==========================================================
-- PROJETO: Eficiência Operacional de Solo (DADOS FICTÍCIOS)
-- Consultas de análise. Execute UMA POR VEZ com Ctrl + Enter
-- (cursor dentro da consulta). Antes de tudo: USE portfolio_aeroporto;
-- Regra do projeto: "voo atrasado" = atraso maior que 10 minutos.
-- ==========================================================
USE portfolio_aeroporto;

-- 1) VISÃO GERAL: quantos voos, atraso médio e % de voos atrasados
SELECT
  COUNT(*) AS total_voos,
  ROUND(AVG(atraso_min), 1) AS atraso_medio_min,
  ROUND(100 * SUM(atraso_min > 10) / COUNT(*), 1) AS pct_voos_atrasados
FROM operacao_solo;

-- 2) POR TURNO: qual turno atrasa mais?
SELECT
  v.turno,
  COUNT(*) AS total_voos,
  ROUND(AVG(o.atraso_min), 1) AS atraso_medio_min,
  ROUND(100 * SUM(o.atraso_min > 10) / COUNT(*), 1) AS pct_voos_atrasados
FROM voos v
JOIN operacao_solo o ON o.id_voo = v.id_voo
GROUP BY v.turno
ORDER BY atraso_medio_min DESC;

-- 3) POR HORA DO DIA: em quais horários o problema aparece?
SELECT
  HOUR(v.horario_previsto) AS hora,
  COUNT(*) AS total_voos,
  ROUND(AVG(o.atraso_min), 1) AS atraso_medio_min
FROM voos v
JOIN operacao_solo o ON o.id_voo = v.id_voo
GROUP BY HOUR(v.horario_previsto)
ORDER BY hora;

-- 4) CAUSAS: o que mais pesa nos atrasos? (ignora "Sem atraso")
SELECT
  c.descricao AS causa,
  COUNT(*) AS ocorrencias,
  SUM(o.atraso_min) AS minutos_perdidos,
  ROUND(AVG(o.atraso_min), 1) AS atraso_medio_min
FROM operacao_solo o
JOIN causas_atraso c ON c.id_causa = o.id_causa
WHERE o.id_causa <> 1
GROUP BY c.descricao
ORDER BY minutos_perdidos DESC;

-- 5) EQUIPE: equipe desfalcada atrasa mais que equipe completa?
SELECT
  CASE WHEN e.funcionarios_presentes < e.funcionarios_necessarios
       THEN 'Equipe desfalcada' ELSE 'Equipe completa' END AS situacao_equipe,
  COUNT(*) AS total_voos,
  ROUND(AVG(o.atraso_min), 1) AS atraso_medio_min,
  ROUND(100 * SUM(o.atraso_min > 10) / COUNT(*), 1) AS pct_voos_atrasados
FROM voos v
JOIN operacao_solo o ON o.id_voo = v.id_voo
JOIN escala_turno e ON e.id_escala = v.id_escala
GROUP BY situacao_equipe;

-- 6) AERONAVE: tempo planejado x real por tipo
SELECT
  v.tipo_aeronave,
  COUNT(*) AS total_voos,
  ROUND(AVG(o.tempo_solo_planejado_min), 1) AS planejado_medio,
  ROUND(AVG(o.tempo_solo_real_min), 1) AS real_medio
FROM voos v
JOIN operacao_solo o ON o.id_voo = v.id_voo
GROUP BY v.tipo_aeronave;

-- 7) DIA DA SEMANA: algum dia é pior? (nomes em inglês no MySQL)
SELECT
  DAYNAME(v.data) AS dia_semana,
  COUNT(*) AS total_voos,
  ROUND(AVG(o.atraso_min), 1) AS atraso_medio_min
FROM voos v
JOIN operacao_solo o ON o.id_voo = v.id_voo
GROUP BY DAYNAME(v.data), DAYOFWEEK(v.data)
ORDER BY DAYOFWEEK(v.data);
