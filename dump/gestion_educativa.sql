-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-07-2021 a las 11:04:17
-- Versión del servidor: 8.0.25-0ubuntu0.20.04.1
-- Versión de PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_educativa`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`andres`@`localhost` PROCEDURE `alta_materia` (IN `id_carrera` TINYINT, IN `id_campo` TINYINT, IN `id_curso` TINYINT, IN `nombre` VARCHAR(100) CHARSET utf8mb4, IN `cargar_horaria` TINYINT UNSIGNED, IN `id_profesor` SMALLINT UNSIGNED)  BEGIN
	INSERT INTO `materias`(`materia_carrera_id`, `materia_campo_id`, `materia_curso_id`, `materia_nombre`, `materia_carga_horaria`, `materia_profesor_id`) VALUES (id_carrera,id_campo,id_curso,nombre,cargar_horaria,id_profesor);
END$$

CREATE DEFINER=`andres`@`localhost` PROCEDURE `cambiar_estado_materia` (IN `id_carrera` TINYINT, IN `id_estado` TINYINT)  BEGIN
# este procedimineto recibe id carrera e id_estado para actualizar el estado de las camterias de esa carrera
	CASE id_estado 
    	WHEN 1 THEN
			UPDATE materias SET materias.materia_estado_id = 1 WHERE materias.materia_carrera_id = id_carrera;
		WHEN 2 THEN
			UPDATE materias SET materias.materia_estado_id = 2 WHERE materias.materia_carrera_id = id_carrera;
        WHEN 3 THEN
			UPDATE materias SET materias.materia_estado_id = 3 WHERE materias.materia_carrera_id = id_carrera;
        WHEN 4 THEN
			UPDATE materias SET materias.materia_estado_id = 4 WHERE materias.materia_carrera_id = id_carrera;
	END CASE;    
END$$

CREATE DEFINER=`andres`@`localhost` PROCEDURE `cargar_correlativas` (IN `para_rendir` SMALLINT UNSIGNED, IN `debe_aprobar` SMALLINT UNSIGNED)  BEGIN
	INSERT INTO `materias_correlativas`(`correlat_materia_id`, `correlat_materia_correlat_id`) VALUES (para_rendir,debe_aprobar);
END$$

--
-- Funciones
--
CREATE DEFINER=`andres`@`localhost` FUNCTION `alta_carrera` (`nombre` VARCHAR(150) CHARSET utf8mb4, `titulo` VARCHAR(200) CHARSET utf8mb4, `resolucion` VARCHAR(50) CHARSET utf8mb4, `preceptor_id` SMALLINT UNSIGNED) RETURNS TINYINT NO SQL
BEGIN
# recibira los datos del formulario de alta de carrera
# como puede haber 2 carreras igual el dato unico es la resolucion
	DECLARE flag TINYINT DEFAULT 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET flag = 0;
    CASE flag
    	WHEN 0 THEN
        	RETURN flag;
        WHEN 1 THEN
			INSERT INTO `carreras`(`carrera_nombre`, `carrera_titulo`, `carrera_resolucion`, `carrera_preceptor_id`) VALUES (nombre,titulo,resolucion,preceptor_id);
            RETURN flag;
    END CASE;
END$$

CREATE DEFINER=`andres`@`localhost` FUNCTION `crear_alumno` (`nombres` VARCHAR(50) CHARSET utf8mb4, `apellidos` VARCHAR(50) CHARSET utf8mb4, `dni` VARCHAR(10) CHARSET utf8mb4, `pass` VARCHAR(20) CHARSET utf8mb4, `id_rol` TINYINT, `id_estado` TINYINT, `id_carrera` TINYINT, `legajo` VARCHAR(12) CHARSET utf8mb4) RETURNS TINYINT NO SQL
    COMMENT 'lo que devuelve lo utilizo para informar'
BEGIN
# declaro una variable para el id del profesor
# declaro una bandera por si se ingresa un DNI repetido a la hora de crear el usuario
# esto genera un error que se maneja con la bandera
	DECLARE aux INT UNSIGNED DEFAULT 0;
    DECLARE flag TINYINT DEFAULT 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET flag = 0;
# inserto los datos que vienen del formulario para crear el usuario	
# si se repite el DNI se cambia el estado de la bandera
	INSERT INTO usuarios (`usuario_nombres`, `usuario_apellidos`, `usuario_dni`, `usuario_password`, `usuario_rol_id`, `usuario_estado_id`) 
    	VALUES (nombres,apellidos,dni,pass,id_rol,id_estado);
    CASE flag
    	WHEN 0 THEN
    		RETURN flag;
    	WHEN 1 THEN
# luego busco por el DNI que es unico y obtengo el id de usuario que se lo asigno a la variable
    		SET aux = (SELECT usuario_id FROM usuarios WHERE usuario_dni=dni);
# ahora hago el insert en la tabla de preceptores
# y le paso el id_usuario que obtuve de la consulta anterior + los datos del formulario
			INSERT INTO alumnos (alumno_usuario_id,alumno_carrera_id,alumno_legajo) VALUES (aux,id_carrera,legajo);
            RETURN flag;    	
    END CASE;
END$$

CREATE DEFINER=`andres`@`localhost` FUNCTION `crear_preceptor` (`nombres` VARCHAR(50) CHARSET utf8mb4, `apellidos` VARCHAR(50) CHARSET utf8mb4, `dni` VARCHAR(10) CHARSET utf8mb4, `pass` VARCHAR(20) CHARSET utf8mb4, `id_rol` TINYINT, `id_estado` TINYINT, `id_carrera` TINYINT) RETURNS TINYINT NO SQL
    COMMENT 'devuelve 0 si se creo el usuario, sino 1'
BEGIN
# declaro una variable para el id del profesor
# declaro una bandera por si se ingresa un DNI repetido a la hora de crear el usuario
# esto genera un error que se maneja con la bandera
	DECLARE aux INT UNSIGNED DEFAULT 0;
    DECLARE flag TINYINT DEFAULT 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET flag = 0;
# inserto los datos que vienen del formulario para crear el usuario	
# si se repite el DNI se cambia el estado de la bandera
	INSERT INTO usuarios (`usuario_nombres`, `usuario_apellidos`, `usuario_dni`, `usuario_password`, `usuario_rol_id`, `usuario_estado_id`) 
    	VALUES (nombres,apellidos,dni,pass,id_rol,id_estado);    
    CASE flag
    	WHEN 0 THEN
    		RETURN flag;
    	WHEN 1 THEN
# luego busco por el DNI que es unico y obtengo el id de usuario que se lo asigno a la variable
    		SET aux = (SELECT usuario_id FROM usuarios WHERE usuario_dni=dni);
# ahora hago el insert en la tabla de preceptores
# y le paso el id_usuario que obtuve de la consulta anterior + los datos del formulario
			INSERT INTO preceptores (preceptor_usuario_id,preceptor_carrera_id) VALUES (aux,id_carrera);
            RETURN flag;    	
    END CASE;
END$$

CREATE DEFINER=`andres`@`localhost` FUNCTION `crear_profesor` (`nombres` VARCHAR(50) CHARSET utf8mb4, `apellidos` VARCHAR(50) CHARSET utf8mb4, `dni` VARCHAR(10) CHARSET utf8mb4, `pass` VARCHAR(20) CHARSET utf8mb4, `id_rol` TINYINT, `id_estado` TINYINT) RETURNS TINYINT NO SQL
    COMMENT 'crea un usuario con rol profesor y lo agrega a su tabla'
BEGIN
# declaro una variable para el id del profesor
	DECLARE aux INT UNSIGNED DEFAULT 0;
    DECLARE flag TINYINT DEFAULT 1;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET flag = 0;
# inserto los datos que vienen del formulario para crear el usuario	
	INSERT INTO usuarios (`usuario_nombres`, `usuario_apellidos`, `usuario_dni`, `usuario_password`, `usuario_rol_id`, `usuario_estado_id`) 
    	VALUES (nombres,apellidos,dni,pass,id_rol,id_estado);    
    CASE flag
    	WHEN 0 THEN
    		RETURN flag;
    	WHEN 1 THEN
# luego busco por el DNI que es unico y obtengo el id de usuario que se lo asigno a la variable
    		SET aux = (SELECT usuario_id FROM usuarios WHERE usuario_dni=dni);
# ahora hago el insert en la tabla de preceptores
# y le paso el id_usuario que obtuve de la consulta anterior + los datos del formulario
			INSERT INTO profesores (profesor_usuario_id) VALUES (aux);
            RETURN flag;    	
    END CASE;
END$$

CREATE DEFINER=`andres`@`localhost` FUNCTION `porcentaje_asistencia` (`id_cursada` INT UNSIGNED) RETURNS TINYINT NO SQL
    COMMENT 'devuelve el porcentaje de asistencia'
BEGIN
# declaro variables para realizar la operacion
	DECLARE asistencia TINYINT DEFAULT 0;
    DECLARE carga_horaria TINYINT DEFAULT 0;
    DECLARE porcentaje TINYINT DEFAULT 0;    
# consulto la tabla cursadas con el id_cursada que viene del TRIGGER
# asigno los valores de asistencia y carga horaria
	SET asistencia = (SELECT cursada_asistencia FROM cursadas WHERE cursada_id = id_cursada);
    SET carga_horaria = (SELECT materia_carga_horaria FROM materias AS M JOIN cursadas AS C ON M.materia_id = C.cursada_materia_id WHERE C.cursada_id =  id_cursada);
# hago el calculo para sacar el porcentaje
	SET porcentaje = (asistencia * 100) / carga_horaria;
# devuelvo el porcentaje
    RETURN porcentaje;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `alumno_id` int UNSIGNED NOT NULL,
  `alumno_usuario_id` int UNSIGNED NOT NULL,
  `alumno_carrera_id` tinyint NOT NULL,
  `alumno_legajo` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`alumno_id`, `alumno_usuario_id`, `alumno_carrera_id`, `alumno_legajo`) VALUES
(1, 2, 1, '900'),
(2, 4, 1, '800');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

CREATE TABLE `carreras` (
  `carrera_id` tinyint NOT NULL,
  `carrera_nombre` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `carrera_titulo` varchar(200) NOT NULL,
  `carrera_resolucion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `carrera_preceptor_id` smallint UNSIGNED NOT NULL COMMENT 'id de la tabla preceptores',
  `carrera_estado_id` tinyint DEFAULT '4'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `carreras`
--

INSERT INTO `carreras` (`carrera_id`, `carrera_nombre`, `carrera_titulo`, `carrera_resolucion`, `carrera_preceptor_id`, `carrera_estado_id`) VALUES
(1, 'Sistemas', 'Tecnico Analista', 'RE/0001', 1, 2),
(2, 'Ambiental', 'Tecnicatura Ambiental', 'RE/002', 2, 2),
(3, 'Sistemas', 'Tecnico sistemas analista', 'REV/0112', 1, 4);

--
-- Disparadores `carreras`
--
DELIMITER $$
CREATE TRIGGER `estado_carrera` BEFORE UPDATE ON `carreras` FOR EACH ROW BEGIN
# declaro variable para pasarlas al STORE PROCEDURE
	DECLARE id_carrera TINYINT DEFAULT 0;
    DECLARE id_estado TINYINT DEFAULT 0;
# leo el valor del campo id carrera
    SET id_carrera = OLD.carrera_id;
# leo el nuevo valor el estado    
    SET id_estado = NEW.carrera_estado_id;
# llamo al STORE PROCEDURE y le paso los valores
 	CALL cambiar_estado_materia(id_carrera,id_estado);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras_estado`
--

CREATE TABLE `carreras_estado` (
  `estado_id` tinyint NOT NULL,
  `estado_carrera` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `carreras_estado`
--

INSERT INTO `carreras_estado` (`estado_id`, `estado_carrera`) VALUES
(1, 'Inscripcion Abierta'),
(2, 'Inscripcion Cerrada'),
(3, 'Finalizar Cursada'),
(4, 'Sin Materias'),
(5, 'Ya no se dicta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursadas`
--

CREATE TABLE `cursadas` (
  `cursada_id` int UNSIGNED NOT NULL,
  `cursada_periodo` year NOT NULL,
  `cursada_materia_id` smallint UNSIGNED NOT NULL,
  `cursada_alumno_id` int UNSIGNED NOT NULL,
  `cursada_asistencia` tinyint UNSIGNED DEFAULT NULL,
  `cursada_nota_1er_parcial` tinyint DEFAULT NULL,
  `cursada_nota_2do_parcial` tinyint DEFAULT NULL,
  `cursada_condicion_id` tinyint DEFAULT NULL,
  `cursada_estado_id` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cursadas`
--

INSERT INTO `cursadas` (`cursada_id`, `cursada_periodo`, `cursada_materia_id`, `cursada_alumno_id`, `cursada_asistencia`, `cursada_nota_1er_parcial`, `cursada_nota_2do_parcial`, `cursada_condicion_id`, `cursada_estado_id`) VALUES
(1, 2020, 1, 2, 45, 4, 2, 1, 0),
(2, 2020, 3, 2, 41, 7, 2, 1, 0),
(3, 2020, 5, 2, 30, 4, 4, 1, 0),
(4, 2020, 6, 2, 60, 7, 9, 1, 0),
(5, 2020, 1, 1, 40, 2, 6, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursadas_condicion`
--

CREATE TABLE `cursadas_condicion` (
  `cond_id` tinyint NOT NULL,
  `cond_nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='si esta o no regularizada';

--
-- Volcado de datos para la tabla `cursadas_condicion`
--

INSERT INTO `cursadas_condicion` (`cond_id`, `cond_nombre`) VALUES
(1, 'Presencial'),
(2, 'Libre'),
(3, 'Regularizada'),
(4, 'Integrador'),
(5, 'Recursar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursadas_estado`
--

CREATE TABLE `cursadas_estado` (
  `estado_id` tinyint NOT NULL,
  `estado_cursada` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cursadas_estado`
--

INSERT INTO `cursadas_estado` (`estado_id`, `estado_cursada`) VALUES
(1, 'No iniciada'),
(2, 'En Curso'),
(3, 'Finalizada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_estado`
--

CREATE TABLE `examenes_estado` (
  `estado_id` tinyint NOT NULL,
  `estado_examen` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `examenes_estado`
--

INSERT INTO `examenes_estado` (`estado_id`, `estado_examen`) VALUES
(1, 'Inscripcion Abierta'),
(2, 'Inscripcion Cerrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_fechas`
--

CREATE TABLE `examenes_fechas` (
  `examen_fecha_id` int UNSIGNED NOT NULL,
  `examen_fecha_instacia_id` tinyint NOT NULL,
  `examen_fecha_materia_id` smallint UNSIGNED NOT NULL,
  `examen_fecha_dia` date NOT NULL,
  `examen_fecha_estado` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `examenes_fechas`
--

INSERT INTO `examenes_fechas` (`examen_fecha_id`, `examen_fecha_instacia_id`, `examen_fecha_materia_id`, `examen_fecha_dia`, `examen_fecha_estado`) VALUES
(1, 1, 1, '2020-12-05', 0),
(2, 1, 3, '2020-12-05', 0),
(3, 1, 5, '2020-12-05', 0),
(4, 1, 6, '2020-12-05', 0),
(5, 1, 2, '2020-12-05', 0),
(6, 1, 4, '2020-12-05', 0),
(7, 1, 7, '2020-12-05', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_finales`
--

CREATE TABLE `examenes_finales` (
  `final_id` int UNSIGNED NOT NULL,
  `final_alumno_id` int UNSIGNED NOT NULL COMMENT 'id usuario con rol alumno',
  `final_fecha_id` int UNSIGNED NOT NULL,
  `final_nota` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `examenes_finales`
--

INSERT INTO `examenes_finales` (`final_id`, `final_alumno_id`, `final_fecha_id`, `final_nota`) VALUES
(1, 2, 1, 7),
(2, 2, 2, 7),
(3, 2, 3, 2),
(4, 2, 4, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_instancia`
--

CREATE TABLE `examenes_instancia` (
  `instancia_id` tinyint NOT NULL,
  `instancia_examen` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `examenes_instancia`
--

INSERT INTO `examenes_instancia` (`instancia_id`, `instancia_examen`) VALUES
(1, 'Diciembre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenes_integrador`
--

CREATE TABLE `examenes_integrador` (
  `integrador_id` int UNSIGNED NOT NULL,
  `integrador_alumno_id` int UNSIGNED NOT NULL COMMENT 'id de usuario alumno',
  `integrador_fecha_id` int UNSIGNED NOT NULL,
  `integrdor_nota` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `materia_id` smallint UNSIGNED NOT NULL,
  `materia_carrera_id` tinyint NOT NULL,
  `materia_campo_id` tinyint NOT NULL,
  `materia_curso_id` tinyint NOT NULL,
  `materia_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `materia_carga_horaria` tinyint UNSIGNED NOT NULL,
  `materia_profesor_id` smallint UNSIGNED DEFAULT NULL COMMENT 'id de la tabla profesores',
  `materia_estado_id` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`materia_id`, `materia_carrera_id`, `materia_campo_id`, `materia_curso_id`, `materia_nombre`, `materia_carga_horaria`, `materia_profesor_id`, `materia_estado_id`) VALUES
(1, 1, 1, 1, 'Ingles I', 64, 1, 2),
(2, 1, 1, 2, 'Ingles II', 64, 1, 2),
(3, 1, 2, 1, 'Análisis Matemático I', 64, 3, 2),
(4, 1, 2, 2, 'Análisis Matemático II', 64, 3, 2),
(5, 1, 2, 1, 'Algebra', 64, 3, 2),
(6, 1, 3, 1, 'Algoritmos y estructuras de datos I', 128, 2, 2),
(7, 1, 3, 2, 'Algoritmos y estructuras de datos II', 128, 2, 2),
(8, 2, 2, 1, 'Biología', 64, 5, 2),
(9, 1, 1, 1, 'Ciencia, Tecnología y Sociedad', 64, 1, NULL),
(10, 1, 3, 1, 'Sistemas y Organizaciones', 64, 2, NULL),
(11, 1, 3, 1, 'Arquitectura de Computadores', 64, 3, NULL),
(12, 1, 4, 1, 'Prácticas Profesionalizantes I', 64, 1, NULL),
(13, 1, 2, 2, 'Estadística', 64, 2, NULL),
(14, 1, 3, 2, 'Ingeniería de Software I', 64, 3, NULL),
(15, 1, 3, 2, 'Sistemas Operativos', 64, 3, NULL),
(16, 1, 3, 2, 'Bases de Datos', 64, 1, NULL),
(17, 1, 4, 2, 'Prácticas Profesionalizantes II', 128, 2, NULL),
(18, 1, 1, 3, 'Inglés III', 64, 1, NULL),
(19, 1, 2, 3, 'Aspectos legales de la Profesión', 64, 2, NULL),
(20, 1, 3, 3, 'Seminario de actualización', 64, 3, NULL),
(21, 1, 3, 3, 'Redes y Comunicaciones', 64, 2, NULL),
(22, 1, 3, 3, 'Ingeniería de Software II', 64, 1, NULL),
(23, 1, 3, 3, 'Algoritmos y estructuras de datos III', 128, 2, NULL),
(24, 1, 4, 3, 'Prácticas Profesionalizantes III', 192, 2, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias_campo`
--

CREATE TABLE `materias_campo` (
  `campo_id` tinyint NOT NULL,
  `campo_nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `materias_campo`
--

INSERT INTO `materias_campo` (`campo_id`, `campo_nombre`) VALUES
(1, 'Campo General'),
(2, 'Campo del Fundamento'),
(3, 'Campo Técnico Especifico'),
(4, 'Campo de la Práctica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias_correlativas`
--

CREATE TABLE `materias_correlativas` (
  `correlat_id` smallint UNSIGNED NOT NULL,
  `correlat_materia_id` smallint UNSIGNED NOT NULL COMMENT 'para rendir ... ',
  `correlat_materia_correlat_id` smallint UNSIGNED NOT NULL COMMENT 'debe aprobar ...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='sistema de correlatividad';

--
-- Volcado de datos para la tabla `materias_correlativas`
--

INSERT INTO `materias_correlativas` (`correlat_id`, `correlat_materia_id`, `correlat_materia_correlat_id`) VALUES
(1, 2, 1),
(2, 4, 3),
(3, 4, 5),
(4, 7, 6),
(5, 18, 2),
(6, 13, 3),
(7, 13, 5),
(8, 14, 10),
(9, 15, 11),
(10, 16, 6),
(11, 17, 12),
(12, 17, 10),
(13, 21, 15),
(14, 22, 14),
(15, 23, 7),
(16, 24, 17),
(17, 24, 7),
(18, 24, 16),
(19, 24, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias_cursos`
--

CREATE TABLE `materias_cursos` (
  `curso_id` tinyint NOT NULL,
  `curso_nombre` varchar(10) NOT NULL,
  `curso_detalle` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `materias_cursos`
--

INSERT INTO `materias_cursos` (`curso_id`, `curso_nombre`, `curso_detalle`) VALUES
(1, 'Primero', '1º'),
(2, 'Segundo', '2º'),
(3, 'Tercero', '3º');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias_estado`
--

CREATE TABLE `materias_estado` (
  `estado_id` tinyint NOT NULL,
  `estado_cursada` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='si finalizo o no la cursada';

--
-- Volcado de datos para la tabla `materias_estado`
--

INSERT INTO `materias_estado` (`estado_id`, `estado_cursada`) VALUES
(1, 'Inscripcion abierta'),
(2, 'En Curso'),
(3, 'Finalizada'),
(4, 'Caducada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preceptores`
--

CREATE TABLE `preceptores` (
  `preceptor_id` smallint UNSIGNED NOT NULL,
  `preceptor_usuario_id` int UNSIGNED NOT NULL,
  `preceptor_carrera_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `preceptores`
--

INSERT INTO `preceptores` (`preceptor_id`, `preceptor_usuario_id`, `preceptor_carrera_id`) VALUES
(1, 5, 1),
(2, 14, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesores`
--

CREATE TABLE `profesores` (
  `profesor_id` smallint UNSIGNED NOT NULL,
  `profesor_usuario_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `profesores`
--

INSERT INTO `profesores` (`profesor_id`, `profesor_usuario_id`) VALUES
(2, 6),
(1, 7),
(3, 8),
(5, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuario_id` int UNSIGNED NOT NULL,
  `usuario_nombres` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `usuario_apellidos` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `usuario_dni` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `usuario_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `usuario_rol_id` tinyint NOT NULL COMMENT 'rol asignado dentro del sistema',
  `usuario_estado_id` tinyint NOT NULL COMMENT 'si esta habilitado o no para usar el sistema',
  `usuario_fechaAltaSist` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='alumnos-preceptores-profesores';

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuario_id`, `usuario_nombres`, `usuario_apellidos`, `usuario_dni`, `usuario_password`, `usuario_rol_id`, `usuario_estado_id`, `usuario_fechaAltaSist`) VALUES
(1, 'Admin', 'Sys', '0000000000', 'zaq12', 1, 1, '2021-07-08 08:41:11'),
(2, 'Andres', 'Romano', '30067284', '123', 4, 1, '2021-07-11 09:07:27'),
(4, 'joaquin', 'romano', '55337203', '123', 4, 1, '2021-07-11 15:32:14'),
(5, 'Fabricio', 'Prece', '22000111', '123', 2, 1, '2021-07-11 15:54:21'),
(6, 'walter', 'carnero', '44555222', '123', 3, 1, '2021-07-11 16:10:52'),
(7, 'garbiela', 'costela', '44555111', '123', 3, 1, '2021-07-11 16:13:02'),
(8, 'javier', 'pereyra', '11000222', '123', 3, 1, '2021-07-11 16:16:00'),
(12, 'fabian', 'lopez', '55123654', 'qw12', 3, 1, '2021-07-11 17:35:57'),
(14, 'Sergio', 'R', '11444777', 'wq12', 2, 1, '2021-07-18 02:09:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_datos`
--

CREATE TABLE `usuarios_datos` (
  `datos_id` int UNSIGNED NOT NULL,
  `datos_usuario_id` int UNSIGNED NOT NULL,
  `datos_usuario_email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `datos_usuario_telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `datos_usuario_fechaNac` date DEFAULT NULL,
  `datos_usuario_foto` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'ruta de la imagen'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='datos de los alumnos';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_domicilio`
--

CREATE TABLE `usuarios_domicilio` (
  `dom_id` int UNSIGNED NOT NULL,
  `dom_usuario_id` int UNSIGNED NOT NULL,
  `dom_usuario_localidad_id` tinyint NOT NULL,
  `dom_usuario_calle` varchar(100) DEFAULT NULL,
  `dom_usuario_altura` smallint UNSIGNED DEFAULT NULL,
  `dom_usuario_piso` tinyint DEFAULT NULL,
  `dom_usuario_depto` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_estado`
--

CREATE TABLE `usuarios_estado` (
  `estado_id` tinyint NOT NULL,
  `estado_nombre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios_estado`
--

INSERT INTO `usuarios_estado` (`estado_id`, `estado_nombre`) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Pendiente'),
(4, 'Deshabilitado'),
(5, 'Baja');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_roles`
--

CREATE TABLE `usuarios_roles` (
  `rol_id` tinyint NOT NULL,
  `rol_nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios_roles`
--

INSERT INTO `usuarios_roles` (`rol_id`, `rol_nombre`) VALUES
(1, 'SysAdmin'),
(2, 'Preceptor/a'),
(3, 'Profesor/a'),
(4, 'Alumno/a'),
(5, 'Directivo/a');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`alumno_id`),
  ADD KEY `alumno_usuario_id` (`alumno_usuario_id`),
  ADD KEY `alumno_carrera_id` (`alumno_carrera_id`);

--
-- Indices de la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD PRIMARY KEY (`carrera_id`),
  ADD UNIQUE KEY `carrera_resolucion` (`carrera_resolucion`),
  ADD KEY `carrera_preceptor_id` (`carrera_preceptor_id`),
  ADD KEY `carrera_estado_id` (`carrera_estado_id`);

--
-- Indices de la tabla `carreras_estado`
--
ALTER TABLE `carreras_estado`
  ADD PRIMARY KEY (`estado_id`);

--
-- Indices de la tabla `cursadas`
--
ALTER TABLE `cursadas`
  ADD PRIMARY KEY (`cursada_id`),
  ADD KEY `cursada_materia_id` (`cursada_materia_id`),
  ADD KEY `cursada_alumno_id` (`cursada_alumno_id`),
  ADD KEY `cursada_condicion_id` (`cursada_condicion_id`),
  ADD KEY `cursada_estado` (`cursada_estado_id`);

--
-- Indices de la tabla `cursadas_condicion`
--
ALTER TABLE `cursadas_condicion`
  ADD PRIMARY KEY (`cond_id`);

--
-- Indices de la tabla `cursadas_estado`
--
ALTER TABLE `cursadas_estado`
  ADD PRIMARY KEY (`estado_id`);

--
-- Indices de la tabla `examenes_estado`
--
ALTER TABLE `examenes_estado`
  ADD PRIMARY KEY (`estado_id`);

--
-- Indices de la tabla `examenes_fechas`
--
ALTER TABLE `examenes_fechas`
  ADD PRIMARY KEY (`examen_fecha_id`),
  ADD KEY `final_fecha_instacia_id` (`examen_fecha_instacia_id`),
  ADD KEY `final_fecha_materia_id` (`examen_fecha_materia_id`),
  ADD KEY `examenes_estado` (`examen_fecha_estado`);

--
-- Indices de la tabla `examenes_finales`
--
ALTER TABLE `examenes_finales`
  ADD PRIMARY KEY (`final_id`),
  ADD KEY `final_alumno_id` (`final_alumno_id`),
  ADD KEY `final_fecha_id` (`final_fecha_id`);

--
-- Indices de la tabla `examenes_instancia`
--
ALTER TABLE `examenes_instancia`
  ADD PRIMARY KEY (`instancia_id`);

--
-- Indices de la tabla `examenes_integrador`
--
ALTER TABLE `examenes_integrador`
  ADD PRIMARY KEY (`integrador_id`),
  ADD KEY `integrador_alumno_id` (`integrador_alumno_id`),
  ADD KEY `integrador_fecha_id` (`integrador_fecha_id`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`materia_id`),
  ADD KEY `materia_carrera_id` (`materia_carrera_id`),
  ADD KEY `materia_profesor_id` (`materia_profesor_id`),
  ADD KEY `materia_campo_id` (`materia_campo_id`),
  ADD KEY `materia_curso_id` (`materia_curso_id`),
  ADD KEY `materia_estado_id` (`materia_estado_id`);

--
-- Indices de la tabla `materias_campo`
--
ALTER TABLE `materias_campo`
  ADD PRIMARY KEY (`campo_id`);

--
-- Indices de la tabla `materias_correlativas`
--
ALTER TABLE `materias_correlativas`
  ADD PRIMARY KEY (`correlat_id`),
  ADD KEY `correlat_materia_id` (`correlat_materia_id`),
  ADD KEY `correlat_materia_correlat_id` (`correlat_materia_correlat_id`);

--
-- Indices de la tabla `materias_cursos`
--
ALTER TABLE `materias_cursos`
  ADD PRIMARY KEY (`curso_id`);

--
-- Indices de la tabla `materias_estado`
--
ALTER TABLE `materias_estado`
  ADD PRIMARY KEY (`estado_id`);

--
-- Indices de la tabla `preceptores`
--
ALTER TABLE `preceptores`
  ADD PRIMARY KEY (`preceptor_id`),
  ADD KEY `preceptor_usuario_id` (`preceptor_usuario_id`),
  ADD KEY `preceptor_carrera_id` (`preceptor_carrera_id`);

--
-- Indices de la tabla `profesores`
--
ALTER TABLE `profesores`
  ADD PRIMARY KEY (`profesor_id`),
  ADD KEY `profesor_usuario_id` (`profesor_usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuario_id`),
  ADD UNIQUE KEY `alumno_dni` (`usuario_dni`),
  ADD KEY `usuario_rol_id` (`usuario_rol_id`),
  ADD KEY `usuario_estado_id` (`usuario_estado_id`);

--
-- Indices de la tabla `usuarios_datos`
--
ALTER TABLE `usuarios_datos`
  ADD PRIMARY KEY (`datos_id`),
  ADD KEY `datos_alumno_id` (`datos_usuario_id`);

--
-- Indices de la tabla `usuarios_domicilio`
--
ALTER TABLE `usuarios_domicilio`
  ADD PRIMARY KEY (`dom_id`),
  ADD KEY `dom_usuario_id` (`dom_usuario_id`),
  ADD KEY `dom_usuario_localidad_id` (`dom_usuario_localidad_id`);

--
-- Indices de la tabla `usuarios_estado`
--
ALTER TABLE `usuarios_estado`
  ADD PRIMARY KEY (`estado_id`);

--
-- Indices de la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `alumno_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `carreras`
--
ALTER TABLE `carreras`
  MODIFY `carrera_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `carreras_estado`
--
ALTER TABLE `carreras_estado`
  MODIFY `estado_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cursadas`
--
ALTER TABLE `cursadas`
  MODIFY `cursada_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cursadas_condicion`
--
ALTER TABLE `cursadas_condicion`
  MODIFY `cond_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cursadas_estado`
--
ALTER TABLE `cursadas_estado`
  MODIFY `estado_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `examenes_estado`
--
ALTER TABLE `examenes_estado`
  MODIFY `estado_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `examenes_fechas`
--
ALTER TABLE `examenes_fechas`
  MODIFY `examen_fecha_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `examenes_finales`
--
ALTER TABLE `examenes_finales`
  MODIFY `final_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `examenes_instancia`
--
ALTER TABLE `examenes_instancia`
  MODIFY `instancia_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `examenes_integrador`
--
ALTER TABLE `examenes_integrador`
  MODIFY `integrador_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `materia_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `materias_campo`
--
ALTER TABLE `materias_campo`
  MODIFY `campo_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `materias_correlativas`
--
ALTER TABLE `materias_correlativas`
  MODIFY `correlat_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `materias_cursos`
--
ALTER TABLE `materias_cursos`
  MODIFY `curso_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `materias_estado`
--
ALTER TABLE `materias_estado`
  MODIFY `estado_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `preceptores`
--
ALTER TABLE `preceptores`
  MODIFY `preceptor_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `profesores`
--
ALTER TABLE `profesores`
  MODIFY `profesor_id` smallint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuario_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuarios_datos`
--
ALTER TABLE `usuarios_datos`
  MODIFY `datos_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios_domicilio`
--
ALTER TABLE `usuarios_domicilio`
  MODIFY `dom_id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios_estado`
--
ALTER TABLE `usuarios_estado`
  MODIFY `estado_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios_roles`
--
ALTER TABLE `usuarios_roles`
  MODIFY `rol_id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
