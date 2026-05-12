USE [DAI]
--1. Obtener todos los datos de todos los usuarios. (filas 228)
SELECT * FROM usuarios

--2. Obtener el nombre y el apellido de todos los usuarios. (filas 228)
SELECT nombre, apellido FROM usuarios

--3. Obtener nombre y apellido de todos los usuarios, ordenados por apellido. (filas 228)
SELECT nombre, apellido FROM usuarios
ORDER BY apellido

--4. Obtener apellido y nombre, ordenados primero por apellido y después por nombre (ORDER BY compuesto). (filas 228)
SELECT nombre, apellido FROM usuarios
ORDER BY apellido, nombre

--5. Obtener el nombre completo de cada usuario como una sola columna llamada nombre_completo , ordenado por apellido. (filas 228)
SELECT CONCAT (nombre, apellido) as 'nombre_completo' FROM usuarios 

--6. Obtener el nombre de los usuarios sin repetidos, ordenado alfabéticamente. (filas 192)
SELECT DISTINCT nombre FROM usuarios
ORDER BY nombre

--7. Obtener los primeros 10 usuarios ordenados por apellido. (filas 10)
SELECT TOP 10 nombre, apellido FROM usuarios ORDER BY apellido

--8. Obtener el nombre y apellido de los usuarios junto con el largo de su nombre (columna largo_nombre ), ordenado por largo descendente. (filas 228)
SELECT nombre, apellido, LEN(nombre) AS largo_nombre
FROM usuarios
ORDER BY largo_nombre DESC

--9. Obtener todos los beneficios que están activos. (filas 25)
SELECT nombre AS beneficios_activos FROM beneficios WHERE activo = 1

--10. Obtener los beneficios activos Y con descuento mayor o igual a 20. (filas 19)
SELECT nombre AS beneficios_activos_beneficio_mayorIgual20 FROM beneficios WHERE activo = 1 AND descuento >= 20

--11. Obtener los beneficios cuyo descuento sea menor a 10 O mayor a 50. (filas 2)
SELECT nombre AS beneficios_descuento FROM beneficios WHERE activo = 1 AND descuento <10 OR descuento>50

--12. Obtener los comercios cuyo nombre empiece con 'M'. (filas 125)
SELECT nombre FROM comercios WHERE nombre LIKE 'M%'

--13. Obtener los comercios cuyo nombre termine con 'SA'. (filas 13)
SELECT nombre FROM comercios WHERE nombre LIKE '%SA'

--14. Obtener los comercios cuyo nombre contenga la palabra 'super' (en cualquier parte). (filas 3)
SELECT nombre FROM comercios WHERE nombre LIKE '%super%'

--15. Obtener los usuarios cuya segunda letra del nombre sea una 'a'. (filas 63)
SELECT nombre FROM usuarios WHERE nombre LIKE '_a%'

--16. Obtener los usuarios cuyo apellido sea 'Gonzalez', 'Ruiz' o 'Gomez'. (filas 8)
SELECT nombre, apellido FROM usuarios WHERE apellido IN ('Gonzalez', 'Ruiz', 'Gomez')

--17. Obtener los usuarios cuyo apellido NO sea 'Gonzalez', 'Ruiz' ni 'Gomez'. (filas 220)
SELECT nombre, apellido FROM usuarios WHERE apellido NOT IN ('Gonzalez', 'Ruiz', 'Gomez')

--18. Obtener los beneficios de los comercios activos (usando subconsulta con IN). (filas 274)
SELECT nombre, descuento FROM beneficios WHERE id_comercio IN (SELECT id FROM comercios WHERE activo = 1)

--19. Obtener la misma lista que en el ejercicio 18, pero sin repetir combinaciones de nombre y descuento . (filas 197)
SELECT DISTINCT nombre , descuento FROM beneficios WHERE id_comercio IN (SELECT id FROM comercios WHERE activo = 1)

--20. Obtener los beneficios que NO pertenecen a comercios activos. (filas 21)
SELECT descuento FROM beneficios WHERE id_comercio NOT IN (SELECT id FROM comercios WHERE activo = 1)

--21. Obtener los 5 beneficios con mayor descuento. (filas 5)
SELECT TOP 5 nombre, descuento FROM beneficios
ORDER BY descuento DESC

--22. Obtener los usuarios que nacieron en el año 1981. (filas 6)
SELECT nombre, apellido FROM usuarios WHERE YEAR(fecha_nacimiento) = 1981

--23. Obtener los usuarios que cumplen años en el mes de mayo. (filas 20)
SELECT nombre, apellido FROM usuarios WHERE MONTH(fecha_nacimiento) = 5

--24. Obtener el nombre, apellido y la edad de cada usuario (columna edad ), ordenado por edad descendente. (filas 228)
SELECT nombre, apellido, DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS edad FROM usuarios
ORDER BY edad DESC

--25. Obtener los canjes de beneficios ( beneficios_usuarios ) realizados en los últimos 30 días. (filas 49)
SELECT * FROM beneficios_usuarios WHERE fecha >= DATEADD(DAY, -30, GETDATE()) --Los canjes son muy viejos, estamos a 11/5/26, el mas reciente marca que fue el 2026-03-31 16:06:23.000, asi que no aparece nada en las tablas
	
--26. Obtener los canjes realizados entre el 1 de enero y el 31 de marzo de 2025. (filas 375)
SELECT * FROM beneficios_usuarios WHERE fecha >= '2025-01-01' AND fecha < '2025-04-01'

--27. Obtener los usuarios que NO tienen fecha de nacimiento cargada. (filas 0)
SELECT nombre, apellido FROM usuarios WHERE fecha_nacimiento = NULL

--28. Obtener los comercios que tienen email cargado (no nulo) y además están activos. (filas 109)
SELECT nombre FROM comercios WHERE email IS NOT NULL AND activo=1

--29. Contar cuántos usuarios hay en total. (filas 228)
SELECT COUNT(*) AS usuarios_totales FROM usuarios

--30. Contar cuántos usuarios tienen fecha de nacimiento cargada (y cuántos no).(filas 1)
SELECT COUNT(fecha_nacimiento) AS usuarios_con_nacimiento, COUNT(*) - COUNT(fecha_nacimiento) AS usuarios_sin_nacimiento FROM usuarios

--31. Obtener el descuento máximo, mínimo y promedio de los beneficios activos. (filas 1)
SELECT MAX(descuento) AS maximo, MIN(descuento) AS minimo, AVG(descuento) AS promedio FROM beneficios WHERE activo = 1 

--32. Obtener el nombre del beneficio junto con el nombre del comercio que lo ofrece. (filas 295)
SELECT beneficios.nombre, comercios.nombre AS comercio
FROM beneficios
INNER JOIN comercios
ON beneficios.id_comercio = comercios.id

--33. Obtener nombre y apellido de cada usuario junto con el nombre de su provincia. (filas 200)
SELECT usuarios.nombre, usuarios.apellido, provincias.nombre AS provincia
FROM usuarios
INNER JOIN provincias
ON usuarios.id_provincia = provincias.id

--34. Obtener todos los usuarios y, si tienen provincia, el nombre; si no, mostrar NULL. (filas 228)
SELECT usuarios.nombre, usuarios.apellido, provincias.nombre AS provincia
FROM usuarios
LEFT JOIN provincias
ON usuarios.id_provincia = provincias.id

--35. Obtener todas las provincias y los usuarios que viven en ellas (aunque una provincia no tenga usuarios). (filas 219)
SELECT provincias.nombre AS provincia, usuarios.nombre, usuarios.apellido --Dan 224 filas, no 219, pero el código está bien (solo no uní nombre y apellido)
FROM usuarios
RIGHT JOIN provincias
ON usuarios.id_provincia = provincias.id 

--36. Obtener los usuarios que nunca canjearon un beneficio (usando LEFT JOIN). (filas 0)
SELECT usuarios.nombre, usuarios.apellido FROM usuarios
LEFT JOIN beneficios_usuarios 
ON usuarios.id = beneficios_usuarios.id_usuario
WHERE beneficios_usuarios.id_usuario IS NULL

--37. Obtener el nombre del usuario, nombre del beneficio, nombre del comercio y fecha del canje — triple JOIN. (filas 506)
SELECT usuarios.nombre, beneficios.nombre, comercios.nombre, beneficios_usuarios.fecha
FROM beneficios_usuarios
INNER JOIN usuarios ON beneficios_usuarios.id_usuario = usuarios.id
INNER JOIN beneficios ON beneficios_usuarios.id_beneficio = beneficios.id
INNER JOIN comercios ON beneficios.id_comercio = comercios.id

--38. Nombre del comercio y cantidad de beneficios que ofrece, ordenado de mayor a menor. (filas 98)
SELECT comercios.nombre, COUNT(beneficios.id) AS cantidad_beneficios
FROM comercios
INNER JOIN beneficios ON comercios.id = beneficios.id_comercio
GROUP BY comercios.nombre
ORDER BY cantidad_beneficios DESC

--39. Nombre del comercio y cantidad de beneficios que ofrece, pero solo los comercios que tienen más de 3 beneficios. (filas 25)
SELECT comercios.nombre, COUNT(beneficios.id) AS cantidad_beneficios
FROM comercios
INNER JOIN beneficios ON comercios.id = beneficios.id_comercio
GROUP BY comercios.nombre
HAVING COUNT(beneficios.id) > 3
ORDER BY cantidad_beneficios DESC

--40. Nombre del comercio y suma total de descuentos de sus beneficios activos, ordenado de mayor a menor. (filas 16)
SELECT comercios.nombre, SUM(beneficios.descuento) AS descuento_beneficios
FROM comercios
INNER JOIN beneficios ON comercios.id = beneficios.id_comercio
WHERE  beneficios.activo = 1
GROUP BY comercios.nombre
ORDER BY descuento_beneficios DESC

--41. Nombre del comercio, descuento promedio y cantidad de beneficios, solo los comercios que tengan promedio mayor a 15. (filas 84)
SELECT comercios.nombre, AVG(beneficios.descuento) AS promedio_descuento, COUNT(beneficios.id) AS cantidad_beneficios
FROM comercios
INNER JOIN beneficios ON comercios.id = beneficios.id_comercio
GROUP BY comercios.nombre
HAVING AVG(beneficios.descuento) >15

--42. Nombre de la provincia y cantidad de beneficios distintos canjeados por los usuarios de esa provincia, ordenada de mayor a menor. (filas 6)
SELECT provincias.nombre, COUNT(DISTINCT beneficios_usuarios.id_beneficio) AS cantidad_beneficios_distintos
FROM provincias
INNER JOIN usuarios ON provincias.id = usuarios.id_provincia
INNER JOIN beneficios_usuarios ON usuarios.id = beneficios_usuarios.id_usuario
GROUP BY provincias.nombre
ORDER BY cantidad_beneficios_distintos DESC

--43. Nombre de la provincia y cantidad de usuarios que viven en ella, usando INNER JOIN (no aparecen provincias sin usuarios). (filas 6)
SELECT provincias.nombre, COUNT(usuarios.id) AS cantidad_usuarios
FROM provincias
INNER JOIN usuarios ON provincias.id = usuarios.id_provincia
WHERE provincias.nombre IS NOT NULL
GROUP BY provincias.nombre

--44. Nombre de TODAS las provincias y cantidad de usuarios que viven en cada una, usando LEFT JOIN — las provincias sin usuarios aparecen con 0. (filas 25)
SELECT provincias.nombre, COUNT(usuarios.id) AS cantidad_usuarios
FROM provincias
LEFT JOIN usuarios ON provincias.id = usuarios.id_provincia
GROUP BY provincias.nombre

--45. Top 5 comercios con más canjes de sus beneficios (mostrar nombre del comercio y cantidad de canjes). (filas 5)


--46. Apellido, nombre y cantidad de beneficios canjeados de cada usuario (incluir usuarios que no canjearon nunca, mostrando 0). (filas 201)



--47. Obtener el comercio con mayor promedio de descuento (mostrar nombre y promedio). (filas 1)
--48. Nombre de la provincia, cantidad de usuarios y cantidad total de canjes que hicieron esos usuarios. (filas 25)



GO