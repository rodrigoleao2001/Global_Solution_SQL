-- Resposta 1
SELECT 
    P.Nome AS Pais, 
    C.Nome AS Cultura,
    SUM(Pr.Quantidade) AS Producao_Total,
    SUM(Co.Quantidade) AS Consumo_Total,
    SUM(D.Quantidade) AS Desperdicio_Total
FROM 
    PF0645.Paises P
    JOIN PF0645.Producao Pr ON P.ID_Pais = Pr.ID_Pais
    JOIN PF0645.Culturas C ON Pr.ID_Cultura = C.ID_Cultura
    JOIN PF0645.Consumo Co ON P.ID_Pais = Co.ID_Pais AND Co.ID_Cultura = C.ID_Cultura
    JOIN PF0645.Desperdicio D ON P.ID_Pais = D.ID_Pais AND D.ID_Cultura = C.ID_Cultura
GROUP BY 
    P.Nome, 
    C.Nome
ORDER BY 
    P.Nome;
    


-- Resposta 2
GRANT CREATE VIEW TO RM87887;

CREATE OR REPLACE VIEW CONSUMO_BRASIL AS 
SELECT 
    C.Nome AS Cultura, 
    SUM(Co.Quantidade) AS ConsumoTotal
FROM 
    PF0645.Consumo Co
    JOIN PF0645.Paises P ON Co.ID_Pais = P.ID_Pais
    JOIN PF0645.Culturas C ON Co.ID_Cultura = C.ID_Cultura
WHERE 
    P.Nome = 'Brasil'
GROUP BY 
    C.Nome;
select * from consumo_brasil;



-- Resposta 3
INSERT INTO PRODUCAO_0_7500
SELECT * FROM PF0645.PRODUCAO
WHERE Quantidade BETWEEN 0 AND 7500;

INSERT INTO PRODUCAO_7501_10000
SELECT * FROM PF0645.PRODUCAO
WHERE Quantidade BETWEEN 7501 AND 10000;

INSERT INTO PRODUCAO_10001_20000
SELECT * FROM PF0645.PRODUCAO
WHERE Quantidade BETWEEN 10001 AND 20000;



-- Resposta 4
WITH ConsumoMedia AS (
    SELECT AVG(Quantidade) AS MediaConsumo 
    FROM PF0645.Consumo
),
ConsumoPais AS (
    SELECT 
        P.Nome AS Pais,
        SUM(C.Quantidade) AS ConsumoTotal
    FROM 
        PF0645.Consumo C
        JOIN PF0645.Paises P ON C.ID_Pais = P.ID_Pais
    GROUP BY 
        P.Nome
)
SELECT 
    Pais,
    ConsumoTotal
FROM 
    ConsumoPais
WHERE 
    ConsumoTotal > (SELECT MediaConsumo FROM ConsumoMedia);




