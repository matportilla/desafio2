-- iniciar postgresql

psql -U postgres

-- Creacion de Base de datos
CREATE DATABASE desafio2_matias_portilla_685;

-- ingresar a Base

\c desafio2_matias_portilla_685

-- ingresar tabla

CREATE TABLE IF NOT EXISTS INSCRITOS(cantidad INT, fecha DATE, fuente
VARCHAR); 

-- ingresar registros
INSERT INTO INSCRITOS(cantidad, fecha, fuente) VALUES ( 44, '01/01/2021', 'Blog' ),
( 56, '01/01/2021', 'Página' ),
( 39, '01/02/2021', 'Blog' ),
( 81, '01/02/2021', 'Página' ),
( 12, '01/03/2021', 'Blog' ),
( 91, '01/03/2021', 'Página' ),
( 48, '01/04/2021', 'Blog' ),
( 45, '01/04/2021', 'Página' ),
( 55, '01/05/2021', 'Blog' ),
( 33, '01/05/2021', 'Página' ),
( 18, '01/06/2021', 'Blog' ),
( 12, '01/06/2021', 'Página' ),
( 34, '01/07/2021', 'Blog' ),
( 24, '01/07/2021', 'Página' ),
( 83, '01/08/2021', 'Blog' ),
( 99, '01/08/2021', 'Página' );


-- ¿Cuántos registros hay?
 
SELECT count(*) AS total_registros FROM inscritos;

-- respuesta

desafio2_matias_portilla_685=# SELECT count(*) AS total_registros FROM inscritos;
 total_registros 
-----------------
              16
(1 row)


-- ¿Cuántos inscritos hay en total?

SELECT sum(cantidad) AS total_inscritos FROM inscritos;

-- respuesta

desafio2_matias_portilla_685=# SELECT sum(cantidad) AS total_inscritos FROM inscritos;
 total_inscritos 
-----------------
             774
(1 row)

-- ¿Cuál o cuáles son los registros de mayor antigüedad?

SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);

-- respuesta

desafio2_matias_portilla_685=# SELECT * FROM inscritos WHERE fecha = (SELECT MIN(fecha) FROM inscritos);
 cantidad |   fecha    | fuente 
----------+------------+--------
       44 | 2021-01-01 | Blog
       56 | 2021-01-01 | Página
(2 rows)

-- ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
-- ahora en adelante)

SELECT fecha, sum(cantidad) FROM inscritos GROUP BY fecha ORDER BY fecha;

-- respuesta
desafio2_matias_portilla_685=# SELECT fecha, sum(cantidad) FROM inscritos GROUP BY fecha ORDER BY fecha;
   fecha    | sum 
------------+-----
 2021-01-01 | 100
 2021-01-02 | 120
 2021-01-03 | 103
 2021-01-04 |  93
 2021-01-05 |  88
 2021-01-06 |  30
 2021-01-07 |  58
 2021-01-08 | 182
(8 rows)

-- ¿Cuántos inscritos hay por fuente?

SELECT fuente, sum(cantidad) FROM inscritos GROUP BY fuente ORDER BY fuente;

-- respuesta

desafio2_matias_portilla_685=# SELECT fuente, sum(cantidad) FROM inscritos GROUP BY fuente ORDER BY fuente;
 fuente | sum 
--------+-----
 Blog   | 333
 Página | 441
(2 rows)

-- ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se
-- inscribieron en ese día?

SELECT fecha,SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha ORDER BY total_inscritos DESC LIMIT 1;

-- respuesta

desafio2_matias_portilla_685=# SELECT fecha,SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha ORDER BY total_inscritos DESC LIMIT 1;
   fecha    | total_inscritos 
------------+-----------------
 2021-01-08 |             182
(1 row)

-- ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas
-- personas fueron?

SELECT fecha, cantidad FROM inscritos WHERE fuente='Blog' ORDER BY cantidad DESC LIMIT 1;

-- respuesta

desafio2_matias_portilla_685=# 
SELECT fecha, cantidad FROM inscritos WHERE fuente='Blog' ORDER BY cantidad DESC LIMIT 1;
   fecha    | cantidad 
------------+----------
 2021-01-08 |       83
(1 row)

--  ¿Cuántas personas en promedio se inscriben en un día?

-- 1- Promedio diario
SELECT AVG(cantidad), fecha AS promedio FROM inscritos GROUP BY fecha order by fecha ASC;

-- 2 -Promedio total
SELECT AVG(resultado inscritos_por_dia) FROM SELECT fecha, SUM (cantidad) AS inscritos_por_dia FROM(inscritos GROUP BY fecha ORDER BY fecha) AS resultado;

-- respuesta

-- 1- Promedio diario

desafio2_matias_portilla_685=# 
SELECT AVG(cantidad), fecha AS promedio FROM inscritos GROUP BY fecha order by fecha ASC;
         avg         |  promedio  
---------------------+------------
 50.0000000000000000 | 2021-01-01
 60.0000000000000000 | 2021-01-02
 51.5000000000000000 | 2021-01-03
 46.5000000000000000 | 2021-01-04
 44.0000000000000000 | 2021-01-05
 15.0000000000000000 | 2021-01-06
 29.0000000000000000 | 2021-01-07
 91.0000000000000000 | 2021-01-08
(8 rows)

-- 2 -Promedio total

desafio2_matias_portilla_685=# SELECT AVG(inscritos_por_dia)
FROM (
  SELECT fecha, SUM(cantidad) AS inscritos_por_dia
  FROM inscritos
  GROUP BY fecha
) AS resultado;
         avg         
---------------------
 96.7500000000000000
(1 row)

-- ¿Qué días se inscribieron más de 50 personas?

SELECT fecha, sum(cantidad) FROM inscritos GROUP By fecha HAVING sum(cantidad) > 50 ORDER BY fecha ASC;

-- respuesta

desafio2_matias_portilla_685=# SELECT fecha, sum(cantidad) FROM inscritos GROUP By fecha HAVING sum(cantidad) > 50 ORDER BY fecha ASC;
   fecha    | sum 
------------+-----
 2021-01-01 | 100
 2021-01-02 | 120
 2021-01-03 | 103
 2021-01-04 |  93
 2021-01-05 |  88
 2021-01-07 |  58
 2021-01-08 | 182
(7 rows)

-- ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?

SELECT AVG(cantidad) FROM (SELECT fecha, SUM(cantidad) as cantidad FROM inscritos GROUP BY fecha HAVING fecha >= date('2021-01-03')) AS avg_personas_por_dia;

-- respuesta

desafio2_matias_portilla_685=# SELECT AVG(cantidad) FROM (SELECT fecha, SUM(cantidad) as cantidad FROM inscritos GROUP BY fecha HAVING fecha >= date('2021-01-03')) AS avg_personas_por_dia;
         avg         
---------------------
 92.3333333333333333
(1 row)
