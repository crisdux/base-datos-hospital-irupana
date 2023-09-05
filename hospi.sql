-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 05-09-2023 a las 05:20:56
-- Versión del servidor: 10.2.23-MariaDB-log
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hospi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `antecedentes`
--

CREATE TABLE `antecedentes` (
  `id` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `antecedente_paciente`
--

CREATE TABLE `antecedente_paciente` (
  `id` int(10) UNSIGNED NOT NULL,
  `idantecedente` int(10) UNSIGNED NOT NULL,
  `idpaciente` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lugar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inicio_recuperacion` date NOT NULL,
  `fin_recuperacion` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradoras`
--

CREATE TABLE `aseguradoras` (
  `id` int(10) UNSIGNED NOT NULL,
  `empresa` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_urgencia` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradora_paciente`
--

CREATE TABLE `aseguradora_paciente` (
  `id` int(10) UNSIGNED NOT NULL,
  `idpaciente` int(10) UNSIGNED NOT NULL,
  `idseguro` int(10) UNSIGNED NOT NULL,
  `fecha_inicio_contrato` date NOT NULL,
  `fecha_fin_contrato` date NOT NULL,
  `numero_contrato` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id` int(10) UNSIGNED NOT NULL,
  `especialidad_old` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidad_new` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_old` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_new` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargos`
--

CREATE TABLE `cargos` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 255 valores diferentes',
  `cargo` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cargos`
--

INSERT INTO `cargos` (`id`, `cargo`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'Administrador General', 'Cargo relacionado con la medicina general', 0, NULL, NULL),
(2, 'Jefe de Pediatria', 'Cargo relacionado con niños', 0, NULL, NULL),
(3, 'Jefe de Ginecologia', 'Cargo relacionado con mujeres', 1, NULL, NULL),
(4, 'Jefe de Cardiologia', 'Cargo relacionado con el corazon', 1, NULL, NULL),
(5, 'Jefa de Enfermeria', 'Enfermera jefa', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo_doctor`
--

CREATE TABLE `cargo_doctor` (
  `id` int(10) UNSIGNED NOT NULL,
  `iddoctor` smallint(5) UNSIGNED NOT NULL,
  `idcargo` tinyint(3) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cargo_doctor`
--

INSERT INTO `cargo_doctor` (`id`, `iddoctor`, `idcargo`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 2, NULL, NULL),
(3, 3, 3, NULL, NULL),
(4, 4, 4, NULL, NULL),
(5, 5, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas`
--

CREATE TABLE `consultas` (
  `id` int(10) UNSIGNED NOT NULL,
  `idpaciente` int(10) UNSIGNED NOT NULL,
  `iddoctor` smallint(5) UNSIGNED NOT NULL,
  `fecha_consulta` date NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `examen_fisico` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('consulta','reconsulta') COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnostico_medico` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `talla` decimal(4,2) NOT NULL,
  `peso` decimal(4,1) NOT NULL,
  `temperatura` decimal(4,1) NOT NULL,
  `presion_1` int(11) NOT NULL,
  `presion_2` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `consultas`
--

INSERT INTO `consultas` (`id`, `idpaciente`, `iddoctor`, `fecha_consulta`, `motivo`, `examen_fisico`, `tipo`, `diagnostico_medico`, `talla`, `peso`, `temperatura`, `presion_1`, `presion_2`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2019-05-06', 'Vel saepe vitae rerum sint sit ullam aut quo sunt voluptatum in necessitatibus in labore non ut quibusdam non consequatur omnis rem.', 'Nobis voluptatibus quaerat perspiciatis aperiam tenetur at reprehenderit quisquam commodi corrupti rem ut omnis sunt provident deleniti corrupti velit rem voluptatem a ex totam est at ea ipsam saepe consequatur rerum tempore atque rerum amet expedita.', 'consulta', 'Aliquid quia eum enim eligendi vel qui veniam in beatae dicta inventore et tempore est nobis voluptates pariatur voluptas veritatis quae aut aliquam ex nesciunt consequatur deleniti quasi molestias esse vero nobis minima voluptates molestiae sunt iusto est corrupti culpa optio.', '1.80', '80.6', '39.3', 120, 90, NULL, NULL),
(2, 2, 3, '2000-10-15', 'bla bla bla bla bla bla', 'bla bla bla bla bla bla', 'consulta', 'bla bla blabla bla bla ', '1.50', '70.6', '40.0', 130, 70, NULL, NULL),
(3, 1, 1, '2019-05-12', 'bla bla bla', 'bla bla bla', 'reconsulta', 'bla bla bla', '1.82', '80.9', '37.2', 120, 80, NULL, NULL),
(4, 3, 4, '2015-05-12', 'dolores lumbares y jaquejas muy fuertes', 'bla bla bla bla bla bla', 'consulta', 'bla bla bla bla bla bla', '1.53', '75.6', '38.4', 150, 160, NULL, NULL),
(5, 2, 14, '1974-07-10', 'Consequatur eligendi iure ea harum enim et odit natus cupiditate autem ipsa magnam veritatis nemo cumque exercitationem minus voluptatem vel accusamus rem adipisci consectetur omnis a dolor sit tempora et ipsam eos illum labore et deserunt at placeat perspiciatis quo.', 'Et reprehenderit ullam praesentium voluptatibus et quidem rem aut consequatur facere voluptatem necessitatibus occaecati eos delectus non expedita et est dolorem ut maxime qui debitis quaerat laudantium consequatur illum eaque ipsam excepturi sequi fuga eaque veritatis consequatur eius aut quae sequi id veniam dolor aliquid et rerum impedit qui beatae ratione rerum voluptas ipsam odio amet quo ut iste est ipsum et fuga et error perspiciatis neque ea facilis amet accusantium fuga dicta amet quos nostrum fugit natus aut architecto omnis iste sunt modi et officia dolorem sapiente et eius eum in nihil asperiores.', 'reconsulta', 'Fugiat eos consequuntur facere consequuntur quis explicabo porro numquam in molestiae sed incidunt consequuntur sed doloribus numquam magnam quis quos perspiciatis ab voluptatem ducimus non nulla vel expedita libero numquam sit culpa ut nemo dolore sint ducimus quo ex consequatur dolores aut recusandae quibusdam qui architecto non excepturi esse possimus harum expedita dicta fuga numquam ipsa repudiandae facere sit magni veniam recusandae aut illum doloribus totam non provident voluptatibus repellat facilis veniam officia rem ut molestiae veniam ut enim quasi voluptatem rerum consequatur ut enim itaque nam quo fugit illum eius dignissimos rerum sint voluptatem sit fugiat aliquam sed natus id voluptatem est eveniet pariatur ut ex et corporis id nisi nihil eos nihil in quisquam inventore commodi nam ut autem tempore laudantium recusandae minus totam non et voluptatum neque et architecto corporis minima labore.', '2.00', '113.0', '37.0', 149, 49, '2019-12-20 01:32:19', '2019-12-20 01:32:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 255 valores diferentes',
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abr` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `descripcion`, `abr`) VALUES
(1, 'La Paz', 'LPZ'),
(2, 'Santa Cruz', 'SCZ'),
(3, 'Cochabamba', 'CBA'),
(4, 'Potosí', 'PSI'),
(5, 'Oruro', 'ORU'),
(6, 'Chuquisaca', 'CHQ'),
(7, 'Tarija', 'TJA'),
(8, 'Beni', 'BNI'),
(9, 'Pando', 'PND');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT '2 bytes - 65535 valores diferentes',
  `p_nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p_apellido` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula_identidad` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_fijo` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `departamento_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`id`, `p_nombre`, `s_nombre`, `t_nombre`, `p_apellido`, `s_apellido`, `c_apellido`, `email`, `cedula_identidad`, `fecha_nacimiento`, `direccion`, `telefono_fijo`, `celular`, `pais`, `genero`, `condicion`, `deleted_at`, `created_at`, `updated_at`, `departamento_id`) VALUES
(1, 'Felipe', 'Alejandro', '', 'Aliaga', 'Fernandez', '', 'felipe@gmial.com', '5614893', '1990-09-19', 'Calacoto Avenida Jurado #98', '2796340', '64820899', 'Bolivia', 'M', 1, NULL, NULL, NULL, 1),
(2, 'Susana', 'Carla', 'Diana', 'Pereira', 'Ramirez', 'Ochoa', 'susana@gmial.com', '8951493', '1995-01-15', 'Avenida Sanchez Lima Nro 789', NULL, '79741265', 'Bolivia', 'F', 1, NULL, NULL, NULL, 2),
(3, 'Pedro', 'Jesus', 'Andres', 'Callizaya', 'Mamani', '', 'pedro@gmial.com', '5230149', '1998-12-09', 'Calacoto Avenida Jurado Nro 96', NULL, '63148920', 'Bolivia', 'M', 1, NULL, NULL, NULL, 2),
(4, 'Miguel', '', '', 'Acevedo', 'Mamani', '', 'miki@gmial.com', '4698529', '1980-05-30', 'Calle Algonzo Machicado Esq. Los tajibos Nro 106', '2459874', '76942039', 'Bolivia', 'M', 1, NULL, NULL, NULL, 5),
(5, 'Alicia', 'Nancy', '', 'Quiroga', 'Choque', '', 'alicia@gmial.com', '2647031', '1985-03-18', 'Calacoto Avenida Jurado #98', '2796340', '64820893', 'Bolivia', 'O', 1, NULL, NULL, NULL, 9),
(6, 'Ramiro', 'Andres', 'Carlos', 'Rosales', 'Quispe', '', 'alicia@gmial.com', '1354988', '1980-07-11', 'Avenida de los radamales esq los olmos nro 89', NULL, '64826583', 'Bolivia', 'M', 1, NULL, NULL, NULL, 8),
(7, 'Augusto', 'Andres', '', 'Sanchez', 'Peralta', '', 'Augustoperalta8@yahoo.com', '4563259', '1990-05-10', 'Calle 33 Avenida del Yungueño Irupana', NULL, '69823841', 'Bolivia', 'M', 1, NULL, NULL, NULL, 1),
(8, 'Mariana', 'Elisabeth', 'Susana', 'Chuquimia', 'Choque', 'Perez', 'mariana_eli_sus@gmail.com', '4269875', '1980-12-24', 'Avenida Suarez Estevez Nro 89', NULL, '69812820', 'Bolivia', 'F', 1, NULL, NULL, NULL, 2),
(9, 'Ramiro', '', '', 'Andrada', 'Angulo', '', 'ramiro1069@hotmail.com', '8501479', '1985-09-18', 'Avenida Carrasco Nro 398 ', '2798546', '65128966', 'Bolivia', 'M', 1, NULL, NULL, NULL, 3),
(10, 'Carlos', 'Rodrigo', '', 'Paredes', 'Choque', '', 'carlosrodrigop@gmail.com', '5947863', '1991-03-16', 'Avenida Olmoz Suarez Vertis esq Sanchez de Olguin Pasaje M Nro 966', '2796345', '72042596', 'Bolivia', 'O', 1, NULL, NULL, NULL, 4),
(11, 'Wilson', 'Martin', 'Felipe', 'Alvarez', 'Colque', '', 'wilTincho_4585@gmail.com', '5947830', '1993-08-30', 'Avenida del presidente Nro 87', NULL, '96580463', 'Bolivia', 'M', 1, NULL, NULL, NULL, 6),
(12, 'Maria', 'Alejandra', '', 'Machicado', 'Camacho', '', 'mariale@yahoo.com', '2085693', '1994-07-08', 'Avenida Carroro Nro 8930', NULL, '63258710', 'Bolivia', 'F', 1, NULL, NULL, NULL, 8),
(13, 'Estefanie', 'Liseth', '', 'Calvo', 'Ramos', 'Urchiri', 'estefanie_lis45@gmail.com', '1478652', '1980-10-10', 'Avenida Carola Perez esq Andes Nro 96', NULL, '69730571', 'Bolivia', 'F', 1, NULL, NULL, NULL, 9),
(14, 'Eliana', 'Carla', '', 'Suarez', 'Uru', '', 'eli@gmail.com', '5203698', '1993-08-16', 'Avenida del Pueblo c/89 Nro 85', NULL, '62180500', 'Bolivia', 'F', 1, NULL, NULL, NULL, 2),
(15, 'Noelia', 'Carolina', 'Ana', 'Castro', 'Rosales', 'Miranda', 'noecaroana@gmail.com', '7962053', '1989-04-10', 'Avenida Los Sargentos Nro 20', '', '', 'Bolivia', 'F', 1, NULL, NULL, NULL, 1),
(16, 'Miriam', 'Monica', '', 'Castedo', 'Arias', '', 'castedomoni@gmail.com', '2849763', '1995-10-10', 'Avenida Augusto Seaz Perez Nro 963 Pasaje T', '2794106', '69710582', 'Bolivia', 'F', 1, NULL, NULL, NULL, 1),
(17, 'Carmen', '', '', 'Saenz', 'Aruquipa', '', 'carmencita@gmail.com', '1478258', '1995-08-03', 'Avenida Olmos Sanchez Nro 966 ', NULL, '', 'Bolivia', 'F', 1, NULL, NULL, NULL, 5),
(18, 'Sara', 'Rubi', '', 'Suarez', 'Suarez', '', 'sara@gmail.com', '2547203', '1994-08-03', 'Avenida Los Heroes del Pacifico Nro 96333', NULL, '62042863', 'Bolivia', 'F', 1, NULL, NULL, NULL, 1),
(19, 'Isabella', 'Romina', 'Irene', 'Quispe', 'Calla', '', 'irene@gmail.com', '4749320', '1990-02-09', 'Avenida Leon Nro 620 c/30', '2793058', '79850563', 'Bolivia', 'F', 1, NULL, NULL, NULL, 1),
(20, 'Mauricio', 'Canelo', '', 'Vertis', 'Rodriguez', '', 'maurii855@gmail.com', '2849638', '1985-05-18', 'Avenida MAriscal Sucre Nro 58', '2792086', '69741572', 'Bolivia', 'M', 1, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctor_especialidad`
--

CREATE TABLE `doctor_especialidad` (
  `id` int(10) UNSIGNED NOT NULL,
  `iddoctor` smallint(5) UNSIGNED NOT NULL,
  `idespecialidad` tinyint(3) UNSIGNED NOT NULL,
  `fecha_titulacion` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `doctor_especialidad`
--

INSERT INTO `doctor_especialidad` (`id`, `iddoctor`, `idespecialidad`, `fecha_titulacion`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '1998-12-09', NULL, NULL),
(2, 1, 3, '1998-12-09', NULL, NULL),
(3, 2, 4, '1998-12-09', NULL, NULL),
(4, 3, 1, '1998-12-09', NULL, NULL),
(5, 4, 3, '1998-12-09', NULL, NULL),
(6, 5, 1, '1998-12-09', NULL, NULL),
(7, 6, 1, '1997-12-09', NULL, NULL),
(8, 7, 1, '1998-12-09', NULL, NULL),
(9, 8, 4, '2001-09-06', NULL, NULL),
(10, 9, 1, '1998-12-09', NULL, NULL),
(11, 10, 1, '2008-06-26', NULL, NULL),
(12, 11, 1, '2017-04-12', NULL, NULL),
(13, 12, 5, '2000-08-08', NULL, NULL),
(14, 13, 5, '2009-12-09', NULL, NULL),
(15, 14, 5, '1998-12-09', NULL, NULL),
(16, 15, 5, '1998-12-09', NULL, NULL),
(17, 16, 5, '1998-12-09', NULL, NULL),
(18, 17, 5, '1998-12-09', NULL, NULL),
(19, 18, 1, '1998-12-09', NULL, NULL),
(20, 19, 5, '1998-12-09', NULL, NULL),
(21, 20, 5, '1998-12-09', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 255 valores diferentes',
  `especialidad` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `especialidad`, `descripcion`, `condicion`, `created_at`, `updated_at`) VALUES
(1, 'Medicina General', 'Todo lo relacionado con la medicina general', 1, NULL, NULL),
(2, 'Ginecologia', 'Todo lo relacionado con mujeres', 1, NULL, NULL),
(3, 'Cardiologia', 'Todo lo relacionado con el corazon', 1, NULL, NULL),
(4, 'Pediatria', '', 1, NULL, NULL),
(5, 'Enfermeria', 'Licenciados o auxilires en enfermeria', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_civil`
--

CREATE TABLE `estado_civil` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 255 valores diferentes',
  `estado_civil` enum('Soltero/a','Casado/a','Viudo/a','Divorciado/a') COLLATE utf8mb4_unicode_ci NOT NULL,
  `abr` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `estado_civil`
--

INSERT INTO `estado_civil` (`id`, `estado_civil`, `abr`) VALUES
(1, 'Soltero/a', 'solt'),
(2, 'Casado/a', 'cas'),
(3, 'Viudo/a', 'viu'),
(4, 'Divorciado/a', 'div');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiares`
--

CREATE TABLE `familiares` (
  `id` int(10) UNSIGNED NOT NULL,
  `p_nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p_apellido` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cedula_identidad` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_fijo` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_civil` enum('soltero/a','casado/a','viudo/a','divorciado/a') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ocupacion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresa` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `principal` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `departamento_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `familiares`
--

INSERT INTO `familiares` (`id`, `p_nombre`, `s_nombre`, `t_nombre`, `p_apellido`, `s_apellido`, `c_apellido`, `cedula_identidad`, `fecha_nacimiento`, `direccion`, `telefono_fijo`, `celular`, `estado_civil`, `ocupacion`, `empresa`, `pais`, `genero`, `principal`, `created_at`, `updated_at`, `departamento_id`) VALUES
(1, 'Rodolfo', 'Martin', 'Sergio', 'Pabon', 'Arias', '', '4259834', '1990-05-05', 'Calle Ernesto Suarez Nro 85', '2794218', '68420178', 'casado/a', 'comerciante', 'La Hollada SRL', 'Bolivia', 'M', 1, NULL, NULL, 1),
(2, 'Efrain', 'Mauricio', '', 'Mamani', 'Callizaya', '', '5698026', '1985-09-07', 'Calle Olmos Candia Suarez Nro 5266', '2462189', '69852145', 'soltero/a', 'estudiante', 'Colegio La Salle', 'Bolivia', 'M', 0, NULL, NULL, 1),
(3, 'Edwin', 'Edgar', 'Renan', 'Hurtado', 'Sanchez', '', '8965214', '2001-02-03', 'Sopocachi Av. Libertador', '2796541', '69820034', 'casado/a', 'vendedor', '', 'Bolivia', 'M', 1, NULL, NULL, 3),
(4, 'Esther', 'Margarita', 'Veronica', 'Mendoza', 'Tapia', '', '4565455', '1999-10-30', 'Iruapana c/56 avenida del ejercito', '', '78456325', 'soltero/a', 'ama de casa', '', 'Bolivia', 'F', 1, NULL, NULL, 1),
(5, 'Mariela', 'Ana', '', 'Ceballos', 'Valdivia', '', '1569874', '1980-11-01', 'Avenida Olmos c/85 zona norte', '', '79856324', 'soltero/a', 'abogada', '', 'Bolivia', 'F', 0, NULL, NULL, 5),
(6, 'Magali', 'Virginia', '', 'Garcia', 'Llanos', '', '7862014', '1996-12-03', 'Calle Alfonso Ugarte esq Barros ', '', '69874563', 'viudo/a', 'ingeniera petrolera', 'YPFB', 'Bolivia', 'F', 0, NULL, NULL, 2),
(7, 'Adolfo', 'Oscar', '', 'Rojas', 'Calle', '', '7896541', '1990-05-19', 'Calle 89 de calacoto', '2796854', '', 'soltero/a', 'estudiante', 'UMSA', 'Bolivia', 'M', 0, NULL, NULL, 1),
(8, 'Esteban', 'Luis', 'Alfredo', 'Poma', 'Aguirre', 'Mendieta', '7896542', '2001-09-11', 'Calle Ernesto Andrada Nro 96', '2798463', '69820032', 'soltero/a', 'arquitecto', 'KPMG', 'Bolivia', 'O', 1, NULL, NULL, 5),
(9, 'Maria', 'Guadalupe', '', 'Suarez', 'Rios', 'Gutierrez', '8965410', '2000-02-02', 'Calle 15 de chasquipamapa', '', '98745633', 'casado/a', 'estudiante', '', 'Bolivia', 'F', 1, NULL, NULL, 2),
(10, 'Ximena', 'Sonia', 'Roxana', 'Flores', 'Aruquipa', '', '4598774', '1995-03-03', 'cslle 15 de obrajes', '2795412', '69745222', 'soltero/a', 'estudiante', '', 'Bolivia', 'O', 0, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `familiar_paciente`
--

CREATE TABLE `familiar_paciente` (
  `id` int(10) UNSIGNED NOT NULL,
  `idpaciente` int(10) UNSIGNED NOT NULL,
  `idfamiliar` int(10) UNSIGNED NOT NULL,
  `parentezco` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `familiar_paciente`
--

INSERT INTO `familiar_paciente` (`id`, `idpaciente`, `idfamiliar`, `parentezco`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'padre', NULL, NULL),
(2, 2, 5, 'madre', NULL, NULL),
(3, 2, 6, 'hermano', NULL, NULL),
(4, 3, 9, 'cuñado', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_sanguineo`
--

CREATE TABLE `grupo_sanguineo` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 255 valores diferentes',
  `tipo_sangre` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grupo_sanguineo`
--

INSERT INTO `grupo_sanguineo` (`id`, `tipo_sangre`) VALUES
(1, 'A+'),
(2, 'A-'),
(3, 'B+'),
(4, 'B-'),
(5, 'AB+'),
(6, 'AB-'),
(7, 'O+'),
(8, 'O-');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2018_10_12_085127_create_especialidades_table', 1),
(3, '2018_10_16_153725_create_cargos_table', 1),
(4, '2018_10_20_193424_create_doctores_table', 1),
(5, '2018_10_21_183658_create_roles_table', 1),
(6, '2018_10_22_000000_create_users_table', 1),
(7, '2018_10_23_225235_create_role_user_table', 1),
(8, '2019_04_25_224051_create_doctor_especialidad_table', 1),
(9, '2019_06_12_040321_create_departamentos_table', 1),
(10, '2019_06_12_053154_add_departamento_id_at_column_to_doctores_table', 1),
(11, '2019_07_27_044009_create_cargo_doctor_table', 1),
(12, '2019_08_02_203838_create_familiares_table', 1),
(13, '2019_08_02_211743_add_departamento_id_at_column_to_familiares_table', 1),
(14, '2019_08_05_165543_create_pacientes_table', 1),
(15, '2019_08_05_172348_add_departamento_id_at_column_to_pacientes_table', 1),
(16, '2019_08_06_161205_create_familiar_paciente_table', 1),
(17, '2019_08_06_181054_create_vacunas_table', 1),
(18, '2019_08_06_181257_create_paciente_vacuna_table', 1),
(19, '2019_08_07_165338_create_consultas_table', 1),
(20, '2019_09_25_191156_auditoria', 1),
(21, '2019_10_04_033301_create_aseguradoras_table', 1),
(22, '2019_10_04_033950_create_aseguradora_paciente_table', 1),
(23, '2019_10_04_045103_create_antecedentes_table', 1),
(24, '2019_10_04_045134_create_antecedente_paciente_table', 1),
(25, '2019_11_14_033000_create_update_doctores_auditoria_table', 1),
(26, '2019_11_20_012359_create_grupo_sanguineo_table', 1),
(27, '2019_11_20_043853_add_grupo_sanguineo_id_at_column_to_pacientes_table', 1),
(28, '2019_11_22_015219_create_estado_civil_table', 1),
(29, '2019_11_22_023940_add_estado_civil_id_at_column_to_pacientes_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '4 bytes - 4294967295 valroes diferentes',
  `p_nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p_apellido` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_apellido` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cedula_identidad` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_fijo` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_civil` enum('soltero/a','casado/a','viudo/a','divorciado/a') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ocupacion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nacionalidad` enum('boliviana','extranjero') COLLATE utf8mb4_unicode_ci NOT NULL,
  `zona_residencia` enum('urbana','rural') COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `departamento_id` tinyint(3) UNSIGNED NOT NULL,
  `grupo_sanguineo_id` tinyint(3) UNSIGNED NOT NULL,
  `estado_civil_id` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `p_nombre`, `s_nombre`, `t_nombre`, `p_apellido`, `s_apellido`, `c_apellido`, `full_name`, `cedula_identidad`, `genero`, `fecha_nacimiento`, `direccion`, `telefono_fijo`, `celular`, `estado_civil`, `ocupacion`, `email`, `nacionalidad`, `zona_residencia`, `condicion`, `created_at`, `updated_at`, `departamento_id`, `grupo_sanguineo_id`, `estado_civil_id`) VALUES
(1, 'Joaquin', 'Alex', 'Bernardo', 'Aliaga', 'Suarez', '', 'Joaquin Alex Bernardo Aliaga Suarez', '5469845', 'M', '2005-03-09', 'Calle Alex Perez España', '', '', 'soltero/a', 'estudiante', 'juaquin@gmail.com', 'boliviana', 'urbana', 1, NULL, NULL, 1, 1, 1),
(2, 'Wilmer', 'Alberto', '', 'Sanchez', '', '', 'Wilmer Alberto Sanchez', '5621369', 'M', '1999-10-20', 'c/78 chasquipampa', '', '69845210', 'soltero/a', 'estudiante', 'wil@gmail.com', 'boliviana', 'urbana', 1, NULL, NULL, 1, 2, 2),
(3, 'Elsa', '', '', 'Cardenas', '', '', 'Elsa Cardenas', '5965213', 'F', '1985-12-25', 'Calle olmos nro 63', '', '', 'soltero/a', 'enfermra', 'elsa@gmail.com', 'boliviana', 'rural', 1, NULL, NULL, 1, 3, 3),
(4, 'Ricardo', 'Fernando', '', 'Milos', 'Rojas', '', 'Ricardo Fernando Milos Rojas', '8966633', 'M', '1975-06-14', 'Avenida del lobertador ', '', '65987452', 'soltero/a', 'arquitecto', 'lhk@gmail.com', 'extranjero', 'rural', 1, NULL, NULL, 5, 6, 4),
(5, 'Juliana', 'Irene', 'Tereza', 'Choque', 'Apaza', 'Mamani', 'Juliana Irene Tereza Choque Apaza', '6449877', 'F', '1980-12-02', 'Calle juan diaz cruz nro 8996', '2798456', '69820750', 'soltero/a', 'psicologia', 'cadd@gmail.com', 'boliviana', 'urbana', 1, NULL, NULL, 6, 3, 4),
(6, 'Andrea', 'Maria', '', 'Colque', 'Huanca', '', 'Andrea Maria Colque Huanca', '6400877', 'F', '1990-11-02', 'Calle alfonso ugarte ramires cruz nro 8', '2700456', '79820750', 'soltero/a', 'ingeniera', 'prueba@gmail.com', 'extranjero', 'urbana', 1, NULL, NULL, 2, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente_vacuna`
--

CREATE TABLE `paciente_vacuna` (
  `id` int(10) UNSIGNED NOT NULL,
  `idpaciente` int(10) UNSIGNED NOT NULL,
  `idvacuna` int(10) UNSIGNED NOT NULL,
  `fecha_vacuna` date NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  `obs` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` tinyint(3) UNSIGNED NOT NULL COMMENT '1 byte - 127 valores diferentes',
  `rol` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`, `descripcion`, `condicion`) VALUES
(1, 'Administrador/a', 'Administrador/a del sistema', 1),
(2, 'Doctor/a', 'Doctor/a del hospital', 1),
(3, 'Enfermera/o', 'Enfermera/o del hospital', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_user`
--

CREATE TABLE `role_user` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `iduser` smallint(5) UNSIGNED NOT NULL,
  `idrol` tinyint(3) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_user`
--

INSERT INTO `role_user` (`id`, `iduser`, `idrol`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 2, NULL, NULL),
(3, 3, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `update_doctores_auditoria`
--

CREATE TABLE `update_doctores_auditoria` (
  `id` int(10) UNSIGNED NOT NULL,
  `p_nombre_old` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `p_nombre_new` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_nombre_old` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `s_nombre_new` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_nombre_old` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `t_nombre_new` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p_apellido_old` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `p_apellido_new` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_apellido_old` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `s_apellido_new` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_apellido_old` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `c_apellido_new` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_old` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_new` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula_identidad_old` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula_identidad_new` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento_old` date NOT NULL,
  `fecha_nacimiento_new` date NOT NULL,
  `direccion_old` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_new` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_fijo_old` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono_fijo_new` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular_old` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular_new` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais_old` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pais_new` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero_old` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero_new` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion_old` tinyint(1) NOT NULL,
  `condicion_new` tinyint(1) NOT NULL,
  `departamento_id_old` tinyint(4) NOT NULL,
  `departamento_id_new` tinyint(4) NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` smallint(5) UNSIGNED NOT NULL COMMENT '2 bytes - 65535 valores diferentes',
  `iddoctor` smallint(5) UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `iddoctor`, `usuario`, `password`, `condicion`, `remember_token`) VALUES
(1, 1, 'admin', '$2y$10$F5zz8U0R4r824mcLNgojyusqJa17rNMHxO4qVP72vhfN8VXDfm.V6', 1, NULL),
(2, 2, 'spereira', '$2y$10$LOtyw/SBvvY8l3vZfXGIeeMN0puSOQ6MCYJMcJ7Tdtn6mqt3qtfFC', 1, NULL),
(3, 3, 'pcallisaya', '$2y$10$F5zz8U0R4r824mcLNgojyusqJa17rNMHxO4qVP72vhfN8VXDfm.V6', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacunas`
--

CREATE TABLE `vacunas` (
  `id` int(10) UNSIGNED NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `antecedentes`
--
ALTER TABLE `antecedentes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `antecedente_paciente`
--
ALTER TABLE `antecedente_paciente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `antecedente_paciente_idantecedente_foreign` (`idantecedente`),
  ADD KEY `antecedente_paciente_idpaciente_foreign` (`idpaciente`);

--
-- Indices de la tabla `aseguradoras`
--
ALTER TABLE `aseguradoras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `aseguradora_paciente`
--
ALTER TABLE `aseguradora_paciente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aseguradora_paciente_idpaciente_foreign` (`idpaciente`),
  ADD KEY `aseguradora_paciente_idseguro_foreign` (`idseguro`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cargo_doctor`
--
ALTER TABLE `cargo_doctor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cargo_doctor_iddoctor_foreign` (`iddoctor`),
  ADD KEY `cargo_doctor_idcargo_foreign` (`idcargo`);

--
-- Indices de la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `consultas_idpaciente_foreign` (`idpaciente`),
  ADD KEY `consultas_iddoctor_foreign` (`iddoctor`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctores_departamento_id_foreign` (`departamento_id`);

--
-- Indices de la tabla `doctor_especialidad`
--
ALTER TABLE `doctor_especialidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_especialidad_iddoctor_foreign` (`iddoctor`),
  ADD KEY `doctor_especialidad_idespecialidad_foreign` (`idespecialidad`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado_civil`
--
ALTER TABLE `estado_civil`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `familiares`
--
ALTER TABLE `familiares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `familiares_departamento_id_foreign` (`departamento_id`);

--
-- Indices de la tabla `familiar_paciente`
--
ALTER TABLE `familiar_paciente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `familiar_paciente_idpaciente_foreign` (`idpaciente`),
  ADD KEY `familiar_paciente_idfamiliar_foreign` (`idfamiliar`);

--
-- Indices de la tabla `grupo_sanguineo`
--
ALTER TABLE `grupo_sanguineo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pacientes_departamento_id_foreign` (`departamento_id`),
  ADD KEY `pacientes_grupo_sanguineo_id_foreign` (`grupo_sanguineo_id`),
  ADD KEY `pacientes_estado_civil_id_foreign` (`estado_civil_id`);

--
-- Indices de la tabla `paciente_vacuna`
--
ALTER TABLE `paciente_vacuna`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paciente_vacuna_idpaciente_foreign` (`idpaciente`),
  ADD KEY `paciente_vacuna_idvacuna_foreign` (`idvacuna`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_rol_unique` (`rol`);

--
-- Indices de la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_iduser_foreign` (`iduser`),
  ADD KEY `role_user_idrol_foreign` (`idrol`);

--
-- Indices de la tabla `update_doctores_auditoria`
--
ALTER TABLE `update_doctores_auditoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_iddoctor_foreign` (`iddoctor`);

--
-- Indices de la tabla `vacunas`
--
ALTER TABLE `vacunas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `antecedentes`
--
ALTER TABLE `antecedentes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `antecedente_paciente`
--
ALTER TABLE `antecedente_paciente`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aseguradoras`
--
ALTER TABLE `aseguradoras`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aseguradora_paciente`
--
ALTER TABLE `aseguradora_paciente`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 255 valores diferentes', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cargo_doctor`
--
ALTER TABLE `cargo_doctor`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 255 valores diferentes', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `doctores`
--
ALTER TABLE `doctores`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '2 bytes - 65535 valores diferentes', AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `doctor_especialidad`
--
ALTER TABLE `doctor_especialidad`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 255 valores diferentes', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estado_civil`
--
ALTER TABLE `estado_civil`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 255 valores diferentes', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `familiares`
--
ALTER TABLE `familiares`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `familiar_paciente`
--
ALTER TABLE `familiar_paciente`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `grupo_sanguineo`
--
ALTER TABLE `grupo_sanguineo`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 255 valores diferentes', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '4 bytes - 4294967295 valroes diferentes', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `paciente_vacuna`
--
ALTER TABLE `paciente_vacuna`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '1 byte - 127 valores diferentes', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `update_doctores_auditoria`
--
ALTER TABLE `update_doctores_auditoria`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '2 bytes - 65535 valores diferentes', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vacunas`
--
ALTER TABLE `vacunas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `antecedente_paciente`
--
ALTER TABLE `antecedente_paciente`
  ADD CONSTRAINT `antecedente_paciente_idantecedente_foreign` FOREIGN KEY (`idantecedente`) REFERENCES `antecedentes` (`id`),
  ADD CONSTRAINT `antecedente_paciente_idpaciente_foreign` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `aseguradora_paciente`
--
ALTER TABLE `aseguradora_paciente`
  ADD CONSTRAINT `aseguradora_paciente_idpaciente_foreign` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`id`),
  ADD CONSTRAINT `aseguradora_paciente_idseguro_foreign` FOREIGN KEY (`idseguro`) REFERENCES `aseguradoras` (`id`);

--
-- Filtros para la tabla `cargo_doctor`
--
ALTER TABLE `cargo_doctor`
  ADD CONSTRAINT `cargo_doctor_idcargo_foreign` FOREIGN KEY (`idcargo`) REFERENCES `cargos` (`id`),
  ADD CONSTRAINT `cargo_doctor_iddoctor_foreign` FOREIGN KEY (`iddoctor`) REFERENCES `doctores` (`id`);

--
-- Filtros para la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_iddoctor_foreign` FOREIGN KEY (`iddoctor`) REFERENCES `doctores` (`id`),
  ADD CONSTRAINT `consultas_idpaciente_foreign` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD CONSTRAINT `doctores_departamento_id_foreign` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);

--
-- Filtros para la tabla `doctor_especialidad`
--
ALTER TABLE `doctor_especialidad`
  ADD CONSTRAINT `doctor_especialidad_iddoctor_foreign` FOREIGN KEY (`iddoctor`) REFERENCES `doctores` (`id`),
  ADD CONSTRAINT `doctor_especialidad_idespecialidad_foreign` FOREIGN KEY (`idespecialidad`) REFERENCES `especialidades` (`id`);

--
-- Filtros para la tabla `familiares`
--
ALTER TABLE `familiares`
  ADD CONSTRAINT `familiares_departamento_id_foreign` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);

--
-- Filtros para la tabla `familiar_paciente`
--
ALTER TABLE `familiar_paciente`
  ADD CONSTRAINT `familiar_paciente_idfamiliar_foreign` FOREIGN KEY (`idfamiliar`) REFERENCES `familiares` (`id`),
  ADD CONSTRAINT `familiar_paciente_idpaciente_foreign` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_departamento_id_foreign` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `pacientes_estado_civil_id_foreign` FOREIGN KEY (`estado_civil_id`) REFERENCES `estado_civil` (`id`),
  ADD CONSTRAINT `pacientes_grupo_sanguineo_id_foreign` FOREIGN KEY (`grupo_sanguineo_id`) REFERENCES `grupo_sanguineo` (`id`);

--
-- Filtros para la tabla `paciente_vacuna`
--
ALTER TABLE `paciente_vacuna`
  ADD CONSTRAINT `paciente_vacuna_idpaciente_foreign` FOREIGN KEY (`idpaciente`) REFERENCES `pacientes` (`id`),
  ADD CONSTRAINT `paciente_vacuna_idvacuna_foreign` FOREIGN KEY (`idvacuna`) REFERENCES `vacunas` (`id`);

--
-- Filtros para la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_idrol_foreign` FOREIGN KEY (`idrol`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `role_user_iduser_foreign` FOREIGN KEY (`iduser`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_iddoctor_foreign` FOREIGN KEY (`iddoctor`) REFERENCES `doctores` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
