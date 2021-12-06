-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 06-12-2021 a las 22:57:52
-- Versión del servidor: 5.7.34
-- Versión de PHP: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `preguntados`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id` int(11) NOT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `id_pregunta` int(11) DEFAULT NULL,
  `id_foto` varchar(10) DEFAULT NULL,
  `pregunta` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id`, `id_seccion`, `id_pregunta`, `id_foto`, `pregunta`) VALUES
(1, 1, 1, NULL, 'Quien fue el creador de la bandera?'),
(2, 1, 2, NULL, 'En que fecha se produjo la revolucion de mayo?'),
(3, 1, 3, '1-3.jpg', 'Quien es este procer?'),
(4, 1, 4, '1-4.jpg', 'Quien es este procer?'),
(5, 2, 1, NULL, 'Si X tiende a infinito, que valor se le asigna?'),
(6, 2, 2, NULL, 'Que numero esta en la tabla del 8?'),
(7, 2, 3, NULL, '1+2+3+4+5+6+7+8+9=?'),
(8, 2, 4, NULL, 'Definir el resultado de la ecuacion: 2x=-4'),
(9, 3, 1, '3-1.jpg', 'Quien es este jugador?'),
(10, 3, 2, NULL, 'Quien fue Ayrton Senna?'),
(11, 3, 3, NULL, 'Quien es Mike Tyson?'),
(12, 3, 4, '3-4.jpg', 'Quien es este jugador?'),
(13, 4, 1, NULL, 'Donde se encuentra la ciudad de Damasco?'),
(14, 4, 2, NULL, 'Andorra, es un pais?'),
(15, 4, 3, NULL, 'Cual es la capital de EE.UU?'),
(16, 4, 4, NULL, 'Cual es la capital de Tucuman?');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `id_pregunta` int(11) DEFAULT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  `id_estado_respuesta` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `id_seccion`, `id_pregunta`, `respuesta`, `id_estado_respuesta`) VALUES
(1, 1, 1, 'Jose de San Martin', 0),
(4, 1, 1, 'Manuel Belgrano', 1),
(5, 1, 1, 'Juan Manuel de Rosas', 0),
(6, 1, 1, 'Cornelio Saavedra', 0),
(7, 1, 2, '25 de mayo de 1810', 1),
(8, 1, 2, '25 de mayo de 1816', 0),
(9, 1, 2, '25 de mayo de 1812', 0),
(10, 1, 2, '25 de mayo de 1809', 0),
(11, 1, 3, 'Domingo faustino Sarmiento', 0),
(12, 1, 3, 'Cornelio Saavedra', 0),
(13, 1, 3, 'Bartolome Mitre', 0),
(14, 1, 3, 'Juan Manuel de Rosas', 1),
(15, 1, 4, 'Bernardino Rivadavia', 0),
(16, 1, 4, 'Justo Jose de Urquiza', 0),
(17, 1, 4, 'Manuel Belgrano', 1),
(18, 1, 4, 'Jose de San Martin', 0),
(19, 2, 1, '1', 0),
(20, 2, 1, 'infinito', 0),
(21, 2, 1, '0', 1),
(22, 2, 1, '-1', 0),
(23, 2, 2, '18', 0),
(24, 2, 2, '6', 0),
(25, 2, 2, '19', 0),
(26, 2, 2, '48', 1),
(27, 2, 3, '50', 0),
(28, 2, 3, '45', 1),
(29, 2, 3, '53', 0),
(30, 2, 3, '42', 0),
(31, 2, 4, '-2', 0),
(32, 2, 4, '0', 0),
(33, 2, 4, '2', 1),
(34, 2, 4, '1', 0),
(35, 3, 1, 'Pogba', 0),
(36, 3, 1, 'Ronaldo', 0),
(37, 3, 1, 'Mbappe', 0),
(38, 3, 1, 'Ronaldinho', 1),
(39, 3, 2, 'Un corredor', 1),
(40, 3, 2, 'Un boxeador', 0),
(41, 3, 2, 'Un atleta olimpico', 0),
(42, 3, 2, 'Un golfista profesional', 0),
(43, 3, 3, 'Un campeon de kickboxing', 0),
(44, 3, 3, 'Un campeon de boxeo', 1),
(45, 3, 3, 'Un campeon de taekwondo', 0),
(46, 3, 3, 'Un campeon de judo', 0),
(47, 3, 4, 'Javier Mascherano', 0),
(48, 3, 4, 'Mauro Icardi', 1),
(49, 3, 4, 'Maxi Lopez', 0),
(50, 3, 4, 'Angel Di Maria', 0),
(51, 4, 1, 'En Iran', 0),
(52, 4, 1, 'En Irak', 0),
(53, 4, 1, 'En Siria', 1),
(54, 4, 1, 'En Israel', 0),
(55, 4, 2, 'Si', 1),
(56, 4, 2, 'No, es una capital', 0),
(57, 4, 3, 'Texas', 0),
(58, 4, 3, 'New York', 0),
(59, 4, 3, 'Washington', 1),
(60, 4, 3, 'Los Angeles', 0),
(61, 4, 4, 'San Fernando del valle de tucuman', 0),
(62, 4, 4, 'San miguel de tucuman', 1),
(63, 4, 4, 'Viedma', 0),
(64, 4, 4, 'Resistencia', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `id` int(11) NOT NULL,
  `seccion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`id`, `seccion`) VALUES
(1, 'Historia'),
(2, 'Matematica'),
(3, 'Deportes'),
(4, 'Geografia');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
