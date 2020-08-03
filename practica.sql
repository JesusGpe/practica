-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-08-2020 a las 19:48:34
-- Versión del servidor: 10.4.11-MariaDB
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
-- Base de datos: `rest_api`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`) VALUES
(1, 'Jesus Gpe'),
(2, 'Marta Ramirez'),
(3, 'Maria Perez'),
(4, 'Loreto Solis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `tasa_fin` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`id`, `tasa_fin`) VALUES
(1, '4.50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plazos`
--

CREATE TABLE `plazos` (
  `id` int(11) NOT NULL,
  `monto` decimal(18,2) NOT NULL,
  `plazo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `plazos`
--

INSERT INTO `plazos` (`id`, `monto`, `plazo`) VALUES
(1, '200.00', 3),
(2, '100.00', 2),
(3, '100.00', 3),
(4, '500.00', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `monto` decimal(18,2) NOT NULL,
  `plazos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id`, `cliente_id`, `monto`, `plazos`) VALUES
(34, 2, '200.00', 3),
(35, 1, '500.00', 5),
(36, 1, '500.00', 5),
(37, 3, '200.00', 3),
(38, 1, '500.00', 5),
(39, 2, '100.00', 3),
(40, 2, '100.00', 3),
(41, 3, '100.00', 3),
(42, 2, '100.00', 2),
(43, 1, '100.00', 3),
(44, 1, '100.00', 3),
(45, 2, '100.00', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos_detalle`
--

CREATE TABLE `prestamos_detalle` (
  `id` int(11) NOT NULL,
  `prestamo_id` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `prestamo` decimal(18,2) NOT NULL,
  `interes` decimal(18,2) NOT NULL,
  `abono` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `prestamos_detalle`
--

INSERT INTO `prestamos_detalle` (`id`, `prestamo_id`, `fecha_pago`, `prestamo`, `interes`, `abono`) VALUES
(37, 34, '2020-08-18', '66.67', '3.00', '69.67'),
(38, 34, '2020-09-02', '66.67', '3.00', '69.67'),
(39, 34, '2020-09-17', '66.67', '3.00', '69.67'),
(40, 35, '2020-08-18', '100.00', '4.50', '104.50'),
(41, 35, '2020-09-02', '100.00', '4.50', '104.50'),
(42, 35, '2020-09-17', '100.00', '4.50', '104.50'),
(43, 35, '2020-10-02', '100.00', '4.50', '104.50'),
(44, 35, '2020-10-17', '100.00', '4.50', '104.50'),
(45, 36, '2020-08-18', '100.00', '4.50', '104.50'),
(46, 36, '2020-09-02', '100.00', '4.50', '104.50'),
(47, 36, '2020-09-17', '100.00', '4.50', '104.50'),
(48, 36, '2020-10-02', '100.00', '4.50', '104.50'),
(49, 36, '2020-10-17', '100.00', '4.50', '104.50'),
(50, 37, '2020-08-18', '66.67', '3.00', '69.67'),
(51, 37, '2020-09-02', '66.67', '3.00', '69.67'),
(52, 37, '2020-09-17', '66.67', '3.00', '69.67'),
(53, 38, '2020-08-18', '100.00', '4.50', '104.50'),
(54, 38, '2020-09-02', '100.00', '4.50', '104.50'),
(55, 38, '2020-09-17', '100.00', '4.50', '104.50'),
(56, 38, '2020-10-02', '100.00', '4.50', '104.50'),
(57, 38, '2020-10-17', '100.00', '4.50', '104.50'),
(58, 39, '2020-08-18', '33.33', '1.50', '34.83'),
(59, 39, '2020-09-02', '33.33', '1.50', '34.83'),
(60, 39, '2020-09-17', '33.33', '1.50', '34.83'),
(61, 40, '2020-08-18', '33.33', '1.50', '34.83'),
(62, 40, '2020-09-02', '33.33', '1.50', '34.83'),
(63, 40, '2020-09-17', '33.33', '1.50', '34.83'),
(64, 41, '2020-08-18', '33.33', '1.50', '34.83'),
(65, 41, '2020-09-02', '33.33', '1.50', '34.83'),
(66, 41, '2020-09-17', '33.33', '1.50', '34.83'),
(67, 42, '2020-08-18', '50.00', '2.25', '52.25'),
(68, 42, '2020-09-02', '50.00', '2.25', '52.25'),
(69, 43, '2020-08-18', '33.33', '1.50', '34.83'),
(70, 43, '2020-09-02', '33.33', '1.50', '34.83'),
(71, 43, '2020-09-17', '33.33', '1.50', '34.83'),
(72, 44, '2020-08-18', '33.33', '1.50', '34.83'),
(73, 44, '2020-09-02', '33.33', '1.50', '34.83'),
(74, 44, '2020-09-17', '33.33', '1.50', '34.83'),
(75, 45, '2020-08-18', '33.33', '1.50', '34.83'),
(76, 45, '2020-09-02', '33.33', '1.50', '34.83'),
(77, 45, '2020-09-17', '33.33', '1.50', '34.83');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plazos`
--
ALTER TABLE `plazos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `prestamos_detalle`
--
ALTER TABLE `prestamos_detalle`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `plazos`
--
ALTER TABLE `plazos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `prestamos_detalle`
--
ALTER TABLE `prestamos_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
