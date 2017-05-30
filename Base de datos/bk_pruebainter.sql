-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pruebainter
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrador` (
  `nick` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `contradmin` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nick`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES ('Luis Riaño','eb05c08db88c5e4f6f348066d922bf0e');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asociado`
--

DROP TABLE IF EXISTS `asociado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asociado` (
  `cedula` int(10) unsigned NOT NULL,
  `anombre` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `acontrasena` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `persona_nit` int(255) unsigned NOT NULL,
  PRIMARY KEY (`cedula`),
  UNIQUE KEY `nombre_UNIQUE` (`anombre`),
  KEY `fk_asociado_persona1_idx` (`persona_nit`),
  CONSTRAINT `fk_asociado_persona1` FOREIGN KEY (`persona_nit`) REFERENCES `persona` (`pnit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asociado`
--

LOCK TABLES `asociado` WRITE;
/*!40000 ALTER TABLE `asociado` DISABLE KEYS */;
INSERT INTO `asociado` VALUES (19872104,'Carlos Ramirez','232ab968f5e71a084e4ac3794be2327e',469428650);
/*!40000 ALTER TABLE `asociado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comercio`
--

DROP TABLE IF EXISTS `comercio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comercio` (
  `idcomercio` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ccantidad` int(10) unsigned DEFAULT NULL,
  `gravante_nit` int(255) unsigned NOT NULL,
  `persona_nit` int(255) unsigned NOT NULL,
  PRIMARY KEY (`idcomercio`),
  KEY `fk_vendidas_gravante1` (`gravante_nit`),
  KEY `fk_comercio_persona1` (`persona_nit`),
  CONSTRAINT `fk_comercio_persona1` FOREIGN KEY (`persona_nit`) REFERENCES `persona` (`pnit`),
  CONSTRAINT `fk_vendidas_gravante1` FOREIGN KEY (`gravante_nit`) REFERENCES `gravante` (`nit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comercio`
--

LOCK TABLES `comercio` WRITE;
/*!40000 ALTER TABLE `comercio` DISABLE KEYS */;
/*!40000 ALTER TABLE `comercio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger htransaccion
after update 
on comercio
for each row
begin
if (new.ccantidad<old.ccantidad)
then
insert into transaccion (tdescripcion,  tcantidad, precio, tidcomercio, tgravante_nit, tpersona_pnit) values (‘venta’, new.ccantidad, (select gprecio from gravante where nit= new.gravante_nit), new.idcomercio, new.gravante_nit, new. persona_nit);
Elseif (new.ccantidad>old.ccantidad)
Then
insert into transaccion (tdescripcion,  tcantidad, precio, tidcomercio, tgravante_nit, tpersona_pnit) values (‘compra’, new.ccantidad, (select gprecio from gravante where nit= new.gravante_nit), new.idcomercio, new.gravante_nit, new. persona_nit);
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `gravante`
--

DROP TABLE IF EXISTS `gravante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gravante` (
  `nit` int(255) unsigned NOT NULL,
  `gnombre` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `gcontrasena` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `gprecio` int(10) unsigned DEFAULT NULL,
  `gcantidad` int(10) unsigned DEFAULT NULL,
  `gcorreo` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `gsociedad` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`nit`),
  UNIQUE KEY `nombre_UNIQUE` (`gnombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gravante`
--

LOCK TABLES `gravante` WRITE;
/*!40000 ALTER TABLE `gravante` DISABLE KEYS */;
INSERT INTO `gravante` VALUES (900367546,'Comercializadora S.A','714cf5a7b6140400e0cd7fb32254d3f8',25000,500,'comercializadorasa@comercializadora.com','SA.');
/*!40000 ALTER TABLE `gravante` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger historial 
after update 
on gravante
for each row
begin
if (new.gprecio!=old.gprecio)
then
insert into proyeccion (valor, prcantidad, gravante_nit, fecha) values (new.gprecio, new.gcantidad, new.nit, (select max(fecha)+1 from proyeccion));
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `pnit` int(255) unsigned NOT NULL,
  `pnombre` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `pcontrasena` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `pcorreo` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `psociedad` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`pnit`),
  UNIQUE KEY `nombre_UNIQUE` (`pnombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (469428650,'Exito','c55149a96903112a4592c364a026b937','info@exito.com','Ltda.'),(1019091642,'Johan Sebastian Dueñas Artunduaga','6f98137de531c987a0ab77e7599270dc','jduenas.duenas@gmail.com','Persona Natural');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyeccion`
--

DROP TABLE IF EXISTS `proyeccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyeccion` (
  `idproyeccion` int(255) unsigned NOT NULL,
  `valor` int(10) unsigned DEFAULT NULL,
  `prcantidad` int(10) unsigned DEFAULT NULL,
  `gravante_nit` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`idproyeccion`),
  KEY `fk_proyeccion_gravante1_idx` (`gravante_nit`),
  CONSTRAINT `fk_proyeccion_gravante1` FOREIGN KEY (`gravante_nit`) REFERENCES `gravante` (`nit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyeccion`
--

LOCK TABLES `proyeccion` WRITE;
/*!40000 ALTER TABLE `proyeccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `proyeccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restriccion`
--

DROP TABLE IF EXISTS `restriccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restriccion` (
  `idrestriccion` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `gravante_nit` int(255) unsigned NOT NULL,
  PRIMARY KEY (`idrestriccion`),
  KEY `fk_restriccion_gravante1_idx` (`gravante_nit`),
  CONSTRAINT `fk_restriccion_gravante1` FOREIGN KEY (`gravante_nit`) REFERENCES `gravante` (`nit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restriccion`
--

LOCK TABLES `restriccion` WRITE;
/*!40000 ALTER TABLE `restriccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `restriccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccion`
--

DROP TABLE IF EXISTS `transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaccion` (
  `idtransaccion` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tdescripcion` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tcantidad` int(10) unsigned DEFAULT NULL,
  `precio` int(10) unsigned DEFAULT NULL,
  `tidcomercio` int(10) unsigned NOT NULL,
  `tgravante_nit` int(255) unsigned NOT NULL,
  `tpersona_pnit` int(255) unsigned NOT NULL,
  PRIMARY KEY (`idtransaccion`),
  KEY `fk_transaccion_comercio1` (`tidcomercio`),
  CONSTRAINT `fk_transaccion_comercio1` FOREIGN KEY (`tidcomercio`) REFERENCES `comercio` (`idcomercio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccion`
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-30  8:17:27
