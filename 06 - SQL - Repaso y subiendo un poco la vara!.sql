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
SELECT TOP 10 nombre, apellido
FROM usuarios
ORDER BY apellido

--8. Obtener el nombre y apellido de los usuarios junto con el largo de su nombre (columna largo_nombre ), ordenado por largo descendente. (filas 228)
SELECT nombre, apellido, LEN(nombre) AS largo_nombre
FROM usuarios
ORDER BY largo_nombre DESC

--9. Obtener todos los beneficios que están activos. (filas 25)

GO