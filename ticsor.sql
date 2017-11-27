/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : ticsor

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2017-11-26 03:29:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for certificado
-- ----------------------------
DROP TABLE IF EXISTS `certificado`;
CREATE TABLE `certificado` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_nivel` int(20) NOT NULL,
  `fk_curso_usuario` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_certificado_nivel` (`fk_nivel`),
  KEY `fk_certificado_curso` (`fk_curso_usuario`),
  CONSTRAINT `fk_certificado_curso` FOREIGN KEY (`fk_curso_usuario`) REFERENCES `curso_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_certificado_nivel` FOREIGN KEY (`fk_nivel`) REFERENCES `nivel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of certificado
-- ----------------------------

-- ----------------------------
-- Table structure for curso
-- ----------------------------
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `estado` int(5) NOT NULL DEFAULT '0' COMMENT '0= inactivo, 1 = activo',
  `fk_nivel` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_nivel` (`fk_nivel`),
  CONSTRAINT `fk_curso_nivel` FOREIGN KEY (`fk_nivel`) REFERENCES `nivel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso
-- ----------------------------
INSERT INTO `curso` VALUES ('1', 'Lenguaje de Señas', '1', '1');

-- ----------------------------
-- Table structure for curso_usuario
-- ----------------------------
DROP TABLE IF EXISTS `curso_usuario`;
CREATE TABLE `curso_usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_curso` int(20) NOT NULL,
  `fk_usuario` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_usuario` (`fk_curso`),
  KEY `fk_usuario_curso` (`fk_usuario`),
  CONSTRAINT `fk_curso_usuario` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_curso` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso_usuario
-- ----------------------------

-- ----------------------------
-- Table structure for denuncia
-- ----------------------------
DROP TABLE IF EXISTS `denuncia`;
CREATE TABLE `denuncia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_usuario` int(20) NOT NULL,
  `fk_marcador` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_denuncia_usuario` (`fk_usuario`),
  KEY `fk_denuncia_marcador` (`fk_marcador`),
  CONSTRAINT `fk_denuncia_marcador` FOREIGN KEY (`fk_marcador`) REFERENCES `marcador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_denuncia_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of denuncia
-- ----------------------------

-- ----------------------------
-- Table structure for evaluacion
-- ----------------------------
DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE `evaluacion` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `fk_curso` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_curso_evaluacion` (`fk_curso`),
  CONSTRAINT `fk_curso_evaluacion` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluacion
-- ----------------------------

-- ----------------------------
-- Table structure for evaluacion_usuario
-- ----------------------------
DROP TABLE IF EXISTS `evaluacion_usuario`;
CREATE TABLE `evaluacion_usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nota` decimal(20,0) DEFAULT NULL,
  `fk_usuario` int(20) NOT NULL,
  `fk_evaluacion` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_evaluacion_usuario` (`fk_evaluacion`),
  KEY `fk_usuario_evaluacion` (`fk_usuario`),
  CONSTRAINT `fk_evaluacion_usuario` FOREIGN KEY (`fk_evaluacion`) REFERENCES `evaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_evaluacion` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluacion_usuario
-- ----------------------------

-- ----------------------------
-- Table structure for marcador
-- ----------------------------
DROP TABLE IF EXISTS `marcador`;
CREATE TABLE `marcador` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `tipo` int(5) NOT NULL DEFAULT '0' COMMENT '0=publico, 1=oficial',
  `localizacion` varchar(255) DEFAULT NULL,
  `estado` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '0=solicitado, 1=aceptado, 2=rechazado, 3=denunciado',
  `fk_usuario` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marcador_usuario` (`fk_usuario`),
  CONSTRAINT `fk_marcador_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of marcador
-- ----------------------------

-- ----------------------------
-- Table structure for marcador_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `marcador_multimedia`;
CREATE TABLE `marcador_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_marcador` int(20) NOT NULL,
  `fk_multimedia` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marcador_multimedia` (`fk_marcador`),
  KEY `fk_multimedia_marcador` (`fk_multimedia`),
  CONSTRAINT `fk_marcador_multimedia` FOREIGN KEY (`fk_marcador`) REFERENCES `marcador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_multimedia_marcador` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of marcador_multimedia
-- ----------------------------

-- ----------------------------
-- Table structure for multimedia
-- ----------------------------
DROP TABLE IF EXISTS `multimedia`;
CREATE TABLE `multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `tipo` int(5) NOT NULL DEFAULT '0' COMMENT '0=imagen, 1=video',
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of multimedia
-- ----------------------------
INSERT INTO `multimedia` VALUES ('28', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/A.gif', '1', 'A');
INSERT INTO `multimedia` VALUES ('29', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/B.gif', '1', 'B');
INSERT INTO `multimedia` VALUES ('30', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/C.gif', '1', 'C');
INSERT INTO `multimedia` VALUES ('31', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/D.gif', '1', 'D');
INSERT INTO `multimedia` VALUES ('32', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/E.gif', '1', 'E');
INSERT INTO `multimedia` VALUES ('33', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/F.gif', '1', 'F');
INSERT INTO `multimedia` VALUES ('34', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/G.gif', '1', 'G');
INSERT INTO `multimedia` VALUES ('35', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/H.gif', '1', 'H');
INSERT INTO `multimedia` VALUES ('36', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/I.gif', '1', 'I');
INSERT INTO `multimedia` VALUES ('37', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/J.gif', '1', 'J');
INSERT INTO `multimedia` VALUES ('38', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/K.gif', '1', 'K');
INSERT INTO `multimedia` VALUES ('39', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/L.gif', '1', 'L');
INSERT INTO `multimedia` VALUES ('40', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/M.gif', '1', 'M');
INSERT INTO `multimedia` VALUES ('41', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/N.gif', '1', 'N');
INSERT INTO `multimedia` VALUES ('42', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Ñ.jpg', '1', 'Ñ');
INSERT INTO `multimedia` VALUES ('43', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/O.gif', '1', 'O');
INSERT INTO `multimedia` VALUES ('44', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/P.gif', '1', 'P');
INSERT INTO `multimedia` VALUES ('45', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Q.gif', '1', 'Q');
INSERT INTO `multimedia` VALUES ('46', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/R.gif', '1', 'R');
INSERT INTO `multimedia` VALUES ('47', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/S.gif', '1', 'S');
INSERT INTO `multimedia` VALUES ('48', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/T.gif', '1', 'T');
INSERT INTO `multimedia` VALUES ('49', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/U.gif', '1', 'U');
INSERT INTO `multimedia` VALUES ('50', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/V.gif', '1', 'V');
INSERT INTO `multimedia` VALUES ('51', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/W.gif', '1', 'W');
INSERT INTO `multimedia` VALUES ('52', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/X.gif', '1', 'X');
INSERT INTO `multimedia` VALUES ('53', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Y.gif', '1', 'Y');
INSERT INTO `multimedia` VALUES ('54', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/Z.gif', '1', 'Z');
INSERT INTO `multimedia` VALUES ('55', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/1.png', '1', '1');
INSERT INTO `multimedia` VALUES ('56', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/2.png', '1', '2');
INSERT INTO `multimedia` VALUES ('57', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/3.png', '1', '3');
INSERT INTO `multimedia` VALUES ('58', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/4.png', '1', '4');
INSERT INTO `multimedia` VALUES ('59', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/5.png', '1', '5');
INSERT INTO `multimedia` VALUES ('60', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/6.png', '1', '6');
INSERT INTO `multimedia` VALUES ('61', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/7.png', '1', '7');
INSERT INTO `multimedia` VALUES ('62', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/8.png', '1', '8');
INSERT INTO `multimedia` VALUES ('63', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/9.png', '1', '9');
INSERT INTO `multimedia` VALUES ('64', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/10.png', '1', '10');
INSERT INTO `multimedia` VALUES ('65', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/11.png', '1', '11');
INSERT INTO `multimedia` VALUES ('66', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/12.png', '1', '12');
INSERT INTO `multimedia` VALUES ('67', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/13.png', '1', '13');
INSERT INTO `multimedia` VALUES ('68', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/14.png', '1', '14');
INSERT INTO `multimedia` VALUES ('69', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/15.png', '1', '15');
INSERT INTO `multimedia` VALUES ('70', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/16.png', '1', '16');
INSERT INTO `multimedia` VALUES ('71', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/17.png', '1', '17');
INSERT INTO `multimedia` VALUES ('72', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/18.png', '1', '18');
INSERT INTO `multimedia` VALUES ('73', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/19.png', '1', '19');
INSERT INTO `multimedia` VALUES ('74', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/20.png', '1', '20');
INSERT INTO `multimedia` VALUES ('75', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/30.png', '1', '30');
INSERT INTO `multimedia` VALUES ('76', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/40.png', '1', '40');
INSERT INTO `multimedia` VALUES ('77', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/50.png', '1', '50');
INSERT INTO `multimedia` VALUES ('78', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/60.png', '1', '60');
INSERT INTO `multimedia` VALUES ('79', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/70.png', '1', '70');
INSERT INTO `multimedia` VALUES ('80', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/80.png', '1', '80');
INSERT INTO `multimedia` VALUES ('81', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/90.png', '1', '90');
INSERT INTO `multimedia` VALUES ('82', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/100.png', '1', '100');

-- ----------------------------
-- Table structure for nivel
-- ----------------------------
DROP TABLE IF EXISTS `nivel`;
CREATE TABLE `nivel` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nivel
-- ----------------------------
INSERT INTO `nivel` VALUES ('1', 'Principiante');
INSERT INTO `nivel` VALUES ('2', 'Básico');
INSERT INTO `nivel` VALUES ('3', 'Avanzado');
INSERT INTO `nivel` VALUES ('4', 'Intermedio');

-- ----------------------------
-- Table structure for pregunta
-- ----------------------------
DROP TABLE IF EXISTS `pregunta`;
CREATE TABLE `pregunta` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(200) NOT NULL,
  `fk_temario` int(20) DEFAULT NULL,
  `estado` int(20) NOT NULL DEFAULT '0' COMMENT '0=inactivo, 1=activo',
  `fk_evaluacion` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pregunta_temario` (`fk_temario`),
  KEY `fk_pregunta_evaluacion` (`fk_evaluacion`),
  CONSTRAINT `fk_pregunta_evaluacion` FOREIGN KEY (`fk_evaluacion`) REFERENCES `evaluacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pregunta_temario` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pregunta
-- ----------------------------

-- ----------------------------
-- Table structure for pregunta_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `pregunta_multimedia`;
CREATE TABLE `pregunta_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_pregunta` int(20) NOT NULL,
  `fk_multimedia` int(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pregunta_multimedia` (`fk_pregunta`),
  KEY `fk_multimedia_pregunta` (`fk_multimedia`),
  CONSTRAINT `fk_multimedia_pregunta` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pregunta_multimedia` FOREIGN KEY (`fk_pregunta`) REFERENCES `pregunta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pregunta_multimedia
-- ----------------------------

-- ----------------------------
-- Table structure for respuesta
-- ----------------------------
DROP TABLE IF EXISTS `respuesta`;
CREATE TABLE `respuesta` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `contenido` varchar(80) NOT NULL,
  `fk_pregunta` int(20) NOT NULL,
  `correcta` int(20) NOT NULL DEFAULT '0' COMMENT '0=Incorrecta, 1=correcta',
  `fk_multimedia` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_respuesta_pregunta` (`fk_pregunta`),
  KEY `fk_respuesta_multimedia` (`fk_multimedia`),
  CONSTRAINT `fk_respuesta_multimedia` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_respuesta_pregunta` FOREIGN KEY (`fk_pregunta`) REFERENCES `pregunta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuesta
-- ----------------------------

-- ----------------------------
-- Table structure for respuesta_temario
-- ----------------------------
DROP TABLE IF EXISTS `respuesta_temario`;
CREATE TABLE `respuesta_temario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_curso_usuario` int(20) NOT NULL,
  `fk_temario` int(20) NOT NULL,
  `resultado` int(20) DEFAULT NULL COMMENT 'porcentaje',
  PRIMARY KEY (`id`),
  KEY `fk_res_temario_temario` (`fk_temario`),
  KEY `fk_res_temario_curso` (`fk_curso_usuario`),
  CONSTRAINT `fk_res_temario_curso` FOREIGN KEY (`fk_curso_usuario`) REFERENCES `curso_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_res_temario_temario` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of respuesta_temario
-- ----------------------------

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES ('1', 'Estudiante');
INSERT INTO `rol` VALUES ('2', 'Administrador');

-- ----------------------------
-- Table structure for temario
-- ----------------------------
DROP TABLE IF EXISTS `temario`;
CREATE TABLE `temario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `fk_curso` int(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_temario_curso` (`fk_curso`),
  CONSTRAINT `fk_temario_curso` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temario
-- ----------------------------
INSERT INTO `temario` VALUES ('1', 'Abecedario', '1', 'Abecedario en el lenguaje de Señas Colombiano', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Abecedario/ABC.gif');
INSERT INTO `temario` VALUES ('2', 'Números', '1', 'Números en el lenguaje de Señas Colombiano', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Numeros/Numeros.png');
INSERT INTO `temario` VALUES ('3', 'Salas', '1', 'Salas de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Salas/Salas.png');
INSERT INTO `temario` VALUES ('4', 'Laboratorios', '1', 'Laboratorios de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Laboratorios/Laborarotios.gif');
INSERT INTO `temario` VALUES ('5', 'Biblioteca', '1', 'Secciones de la Biblioteca de la U.Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Biblioteca/Biblioteca.png');
INSERT INTO `temario` VALUES ('6', 'Cafeterias', '1', 'Cafeterías de la Universidad de la Amazonia en Señas', 'https://raw.githubusercontent.com/LuisVela/ImagenesTicSor/master/Cafeteria/cafeteria.png');
INSERT INTO `temario` VALUES ('7', 'Oficinas', '1', 'Oficinas de la Universidad de la Amazonia en Señas', 'https://firebasestorage.googleapis.com/v0/b/ticsor-fa2f1.appspot.com/o/Oficinas%2Foficinas.png?alt=media&token=2354685a-f3ea-4ac9-9b58-088b051a3c58');

-- ----------------------------
-- Table structure for temario_multimedia
-- ----------------------------
DROP TABLE IF EXISTS `temario_multimedia`;
CREATE TABLE `temario_multimedia` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_temario` int(11) NOT NULL,
  `fk_multimedia` int(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_temario_multimedia` (`fk_temario`),
  KEY `fk_multimedia_temario` (`fk_multimedia`),
  CONSTRAINT `fk_multimedia_temario` FOREIGN KEY (`fk_multimedia`) REFERENCES `multimedia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_temario_multimedia` FOREIGN KEY (`fk_temario`) REFERENCES `temario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temario_multimedia
-- ----------------------------

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` int(5) NOT NULL DEFAULT '1' COMMENT '0 = inactivo, 1 = activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('2', 'Yeison', 'Gomez Rodriguez', 'yeisom40@gmail.com', 'https://avatars3.githubusercontent.com/u/14795272?s=460&v=4', '1');

-- ----------------------------
-- Table structure for usuario_rol
-- ----------------------------
DROP TABLE IF EXISTS `usuario_rol`;
CREATE TABLE `usuario_rol` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `fk_usuario` int(20) NOT NULL,
  `fk_rol` int(20) NOT NULL,
  `tipo` int(5) NOT NULL DEFAULT '0' COMMENT '0 = natural, 1 = juridica',
  PRIMARY KEY (`id`),
  KEY `fk_usuario_rol` (`fk_usuario`),
  KEY `fk_rol_usuario` (`fk_rol`),
  CONSTRAINT `fk_rol_usuario` FOREIGN KEY (`fk_rol`) REFERENCES `rol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`fk_usuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario_rol
-- ----------------------------
INSERT INTO `usuario_rol` VALUES ('2', '2', '1', '0');

-- ----------------------------
-- Procedure structure for LOGIN_USER
-- ----------------------------
DROP PROCEDURE IF EXISTS `LOGIN_USER`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LOGIN_USER`(p_nombres varchar(80), p_apellidos varchar(80), p_correo varchar(80), p_foto varchar(255))
BEGIN
	
  declare v_user_id integer;
	declare _id integer;
	declare _rol_estudiante integer;
	
	set _rol_estudiante = 1;
	
	select u.id 
	into v_user_id 
	from usuario u where u.correo = p_correo;
	
	if v_user_id is null then
		#Registrar usuario
		insert into usuario
		(nombres, apellidos, correo, foto)
		values
		(p_nombres, p_apellidos, p_correo, p_foto);
		
		set _id = LAST_INSERT_ID();
		
		insert into usuario_rol
		(fk_usuario, fk_rol)
		values
		(_id, _rol_estudiante);
	end if;

END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
