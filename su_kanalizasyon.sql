-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 05 Oca 2022, 19:31:07
-- Sunucu sürümü: 5.7.31
-- PHP Sürümü: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `2019469066_su_kana_kds_mvt`
--

DELIMITER $$
--
-- Yordamlar
--
DROP PROCEDURE IF EXISTS `aritmayan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `aritmayan` ()  NO SQL
CREATE VIEW aritmayan AS
SELECT
(aritmayan_miktar.arma_de-aritmayan_miktar.arma_ba) AS 'deniz baraj farkı arıtılmayan miktar', 
(CASE WHEN (aritmayan_miktar.arma_de-aritmayan_miktar.arma_ba)>0 THEN 'pozitif' WHEN (aritmayan_miktar.arma_de-aritmayan_miktar.arma_ba)<0 THEN 'negatif' ELSE 'sıfır' END) AS durum
FROM aritmayan_miktar
ORDER BY durum$$

DROP PROCEDURE IF EXISTS `atiksu_arit_mik`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `atiksu_arit_mik` ()  NO SQL
CREATE VIEW atiksu_arit_mik_gedo AS
SELECT
(atiksu_arit_mik.atiksu_arit_mik_gel-atiksu_arit_mik.atiksu_arit_mik_dog) AS 'atıksu arıtma arıtılan atıksu miktarı gelişmiş doğal', 
(CASE WHEN (atiksu_arit_mik.atiksu_arit_mik_gel-atiksu_arit_mik.atiksu_arit_mik_dog)>0 THEN 'pozitif' WHEN (atiksu_arit_mik.atiksu_arit_mik_gel-atiksu_arit_mik.atiksu_arit_mik_dog)<0 THEN 'negatif' ELSE 'sıfır' END) AS sonuc
FROM atiksu_arit_mik
ORDER BY sonuc$$

DROP PROCEDURE IF EXISTS `en_dusuk_en_yuksek_ilce_artıs`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `en_dusuk_en_yuksek_ilce_artıs` ()  NO SQL
SELECT il_ilce_nufus.ilceler as ilce,(il_ilce_nufus.nuf_art_hiz_ilce) as nuf_artis
FROM il_ilce_nufus
WHERE il_ilce_nufus.nuf_art_hiz_ilce=((SELECT MAX(il_ilce_nufus.nuf_art_hiz_ilce) FROM il_ilce_nufus)) OR il_ilce_nufus.nuf_art_hiz_ilce=((SELECT MIN(il_ilce_nufus.nuf_art_hiz_ilce) FROM il_ilce_nufus))$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `aritimayan_yuz`
--

DROP TABLE IF EXISTS `aritimayan_yuz`;
CREATE TABLE IF NOT EXISTS `aritimayan_yuz` (
  `arm_yil` int(4) NOT NULL,
  `army_top` int(2) DEFAULT NULL,
  `army_de` int(2) DEFAULT NULL,
  `army_gol` int(2) DEFAULT NULL,
  `army_ak` int(2) DEFAULT NULL,
  `army_ba` int(2) DEFAULT NULL,
  `army_ar` int(2) DEFAULT NULL,
  `army_dig` int(3) DEFAULT NULL,
  PRIMARY KEY (`arm_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `aritimayan_yuz`
--

INSERT INTO `aritimayan_yuz` (`arm_yil`, `army_top`, `army_de`, `army_gol`, `army_ak`, `army_ba`, `army_ar`, `army_dig`) VALUES
(1994, 90, 84, 93, 94, 83, 96, 100),
(1995, 90, 84, 87, 93, 84, 95, 100),
(1996, 88, 83, 75, 93, 77, 97, 100),
(1997, 81, 69, 77, 86, 79, 96, 100),
(1998, 72, 65, 79, 73, 75, 96, 100),
(2001, 48, 21, 49, 62, 74, 81, 67),
(2002, 47, 20, 38, 62, 75, 84, 58),
(2003, 45, 24, 44, 56, 77, 86, 77),
(2004, 35, 15, 41, 48, 47, 84, 45),
(2006, 36, 20, 39, 50, 31, 90, 34),
(2008, 31, 16, 28, 45, 27, 72, 43),
(2010, 24, 10, 50, 32, 36, 74, 40),
(2012, 20, 7, 51, 30, 45, 75, 17),
(2014, 19, 8, 49, 26, 49, 53, 21),
(2016, 15, 5, 32, 20, 39, 30, 20),
(2018, 12, 3, 21, 15, 30, 31, 25);

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `aritmayan`
-- (Asıl görünüm için aşağıya bakın)
--
DROP VIEW IF EXISTS `aritmayan`;
CREATE TABLE IF NOT EXISTS `aritmayan` (
`deniz baraj farkı arıtılmayan miktar` bigint(12)
,`durum` varchar(7)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `aritmayan_miktar`
--

DROP TABLE IF EXISTS `aritmayan_miktar`;
CREATE TABLE IF NOT EXISTS `aritmayan_miktar` (
  `arma_yil` int(4) NOT NULL,
  `arma_top` varchar(7) COLLATE utf8_turkish_ci DEFAULT NULL,
  `arma_de` int(6) DEFAULT NULL,
  `arma_gol` int(5) DEFAULT NULL,
  `arma_ak` int(6) DEFAULT NULL,
  `arma_ba` int(5) DEFAULT NULL,
  `arma_ar` int(6) DEFAULT NULL,
  `arma_dig` int(5) DEFAULT NULL,
  PRIMARY KEY (`arma_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `aritmayan_miktar`
--

INSERT INTO `aritmayan_miktar` (`arma_yil`, `arma_top`, `arma_de`, `arma_gol`, `arma_ak`, `arma_ba`, `arma_ar`, `arma_dig`) VALUES
(1994, '1359590', 469756, 49567, 748638, 48239, 38969, 4421),
(1995, '1463247', 489935, 65982, 807881, 54017, 40475, 4957),
(1996, '1477337', 489675, 47622, 840406, 45238, 48566, 5830),
(1997, '1554603', 413528, 67667, 885319, 49148, 47612, 91328),
(1998, '1507198', 513084, 69075, 734000, 41062, 53308, 96670),
(2001, '1107178', 177899, 18696, 761765, 66020, 33381, 49417),
(2002, '1185277', 176165, 14769, 841402, 72586, 31179, 48446),
(2003, '1274429', 281096, 19691, 788708, 73653, 37283, 73998),
(2004, '1021743', 174265, 17723, 667121, 46988, 33586, 82059),
(2006, '1226400', 307255, 18249, 705054, 37517, 108514, 49813),
(2008, '1009874', 226581, 18899, 625871, 31030, 36266, 71226),
(2010, '862979', 150751, 38143, 560448, 46816, 25925, 40897),
(2012, '812167', 124528, 38368, 540896, 50903, 26771, 30701),
(2014, '813005', 155833, 45703, 489262, 58938, 9587, 53683),
(2016, '656795', 87858, 25289, 425122, 49665, 6027, 62833),
(2018, '558711', 66270, 14571, 337511, 44443, 5878, 90038);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `atiksu_arit_mik`
--

DROP TABLE IF EXISTS `atiksu_arit_mik`;
CREATE TABLE IF NOT EXISTS `atiksu_arit_mik` (
  `bel_atiksu_yil` int(4) NOT NULL,
  `atiksu_arit_mik` int(7) DEFAULT NULL,
  `atiksu_arit_mik_fiz` int(7) DEFAULT NULL,
  `atiksu_arit_mik_biy` int(7) DEFAULT NULL,
  `atiksu_arit_mik_gel` int(7) DEFAULT NULL,
  `atiksu_arit_mik_dog` int(5) DEFAULT NULL,
  PRIMARY KEY (`bel_atiksu_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `atiksu_arit_mik`
--

INSERT INTO `atiksu_arit_mik` (`bel_atiksu_yil`, `atiksu_arit_mik`, `atiksu_arit_mik_fiz`, `atiksu_arit_mik_biy`, `atiksu_arit_mik_gel`, `atiksu_arit_mik_dog`) VALUES
(1994, 150061, 77725, 72335, 0, 0),
(1995, 169287, 78874, 90413, 0, 0),
(1996, 201902, 90159, 111743, 0, 0),
(1997, 365719, 145383, 220336, 0, 0),
(1998, 589515, 281374, 308142, 0, 0),
(2001, 1193975, 325329, 662610, 206036, 0),
(2002, 1312379, 344509, 745852, 222018, 0),
(2003, 1586550, 482251, 877252, 227046, 0),
(2004, 1901040, 598769, 1071217, 231054, 0),
(2006, 2140494, 714404, 926581, 499509, 0),
(2008, 2251581, 735710, 861428, 648536, 5906),
(2010, 2719151, 751101, 931356, 1031616, 5079),
(2012, 3256980, 929334, 1072873, 1245977, 8795),
(2014, 3483787, 869248, 1155353, 1450494, 8692),
(2016, 3842350, 906221, 1214977, 1708361, 12791),
(2018, 4236419, 1024184, 1169612, 2029510, 13112);

-- --------------------------------------------------------

--
-- Görünüm yapısı durumu `atiksu_arit_mik_gedo`
-- (Asıl görünüm için aşağıya bakın)
--
DROP VIEW IF EXISTS `atiksu_arit_mik_gedo`;
CREATE TABLE IF NOT EXISTS `atiksu_arit_mik_gedo` (
`atıksu arıtma arıtılan atıksu miktarı gelişmiş doğal` bigint(12)
,`sonuc` varchar(7)
);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `atiksu_arit_tes_kap`
--

DROP TABLE IF EXISTS `atiksu_arit_tes_kap`;
CREATE TABLE IF NOT EXISTS `atiksu_arit_tes_kap` (
  `bel_atiksu_yil` int(4) NOT NULL,
  `atiksu_arit_tes_kap` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  `atiksu_arit_tes_kap_fiz` int(7) DEFAULT NULL,
  `atiksu_arit_tes_kap_biy` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  `atiksu_arit_tes_kap_gel` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  `atiksu_arit_tes_kap_dog` int(5) DEFAULT NULL,
  PRIMARY KEY (`bel_atiksu_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `atiksu_arit_tes_kap`
--

INSERT INTO `atiksu_arit_tes_kap` (`bel_atiksu_yil`, `atiksu_arit_tes_kap`, `atiksu_arit_tes_kap_fiz`, `atiksu_arit_tes_kap_biy`, `atiksu_arit_tes_kap_gel`, `atiksu_arit_tes_kap_dog`) VALUES
(1994, '586877', 376698, '210180', '0', 0),
(1995, '606736', 376698, '230038', '0', 0),
(1996, '690441', 412522, '277919', '0', 0),
(1997, '1245719', 641214, '604505', '0', 0),
(1998, '1559087', 738711, '820376', '0', 0),
(2001, '2287918', 770346, '1250270', '267302', 0),
(2002, '2358507', 771081, '1320124', '267302', 0),
(2003, '2805164', 1045584, '1484394', '275186', 0),
(2004, '3410352', 1384634, '1750532', '275186', 0),
(2006, '3648198', 1329470, '1510835', '807893', 0),
(2008, '4143140', 1537719, '1594640', '1709415', 9967),
(2010, '5293204', 1838627, '1732674', '1000814', 12488),
(2012, '5 532 352', 1904642, '1703694', '1 888 974', 35042),
(2014, '5 549 506', 1823038, '1 712 865', '1 955 192', 58411),
(2016, '5 911 326', 1802239, '1748095', '2 336 052', 24940),
(2018, '6366650', 1737866, '1718037', '2884750', 25997);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `belediye_nufus`
--

DROP TABLE IF EXISTS `belediye_nufus`;
CREATE TABLE IF NOT EXISTS `belediye_nufus` (
  `bel_yi` int(4) NOT NULL,
  `bel_nuf` int(8) DEFAULT NULL,
  `bel_top` int(4) DEFAULT NULL,
  `buy_bel` int(2) DEFAULT NULL,
  `il_bel` int(2) DEFAULT NULL,
  `ilce_bel` int(3) DEFAULT NULL,
  `belde_ka` int(4) DEFAULT NULL,
  PRIMARY KEY (`bel_yi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `belediye_nufus`
--

INSERT INTO `belediye_nufus` (`bel_yi`, `bel_nuf`, `bel_top`, `buy_bel`, `il_bel`, `ilce_bel`, `belde_ka`) VALUES
(2007, 58538501, 3225, 16, 65, 850, 2294),
(2008, 59093094, 2954, 16, 65, 892, 1981),
(2009, 60264546, 2951, 16, 65, 892, 1978),
(2010, 61571332, 2950, 16, 65, 892, 1977),
(2011, 62678751, 2950, 16, 65, 892, 1977),
(2012, 63743047, 2950, 16, 65, 892, 1977),
(2013, 71251022, 1394, 30, 51, 919, 394),
(2014, 72505107, 1396, 30, 51, 919, 396),
(2015, 73739101, 1397, 30, 51, 919, 397),
(2016, 74911343, 1397, 30, 51, 919, 397),
(2017, 75988625, 1398, 30, 51, 921, 396),
(2018, 76888607, 1389, 30, 51, 922, 386),
(2019, 78360074, 1389, 30, 51, 922, 386),
(2020, 78920614, 1389, 30, 51, 922, 386);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bel_atiksu_gos`
--

DROP TABLE IF EXISTS `bel_atiksu_gos`;
CREATE TABLE IF NOT EXISTS `bel_atiksu_gos` (
  `kana_bel_hiz_sayi` int(4) DEFAULT NULL,
  `kana_bel_hiz_nuf` int(8) DEFAULT NULL,
  `kana_hiz_nuf_top_oran` int(2) DEFAULT NULL,
  `ortam_atiksu` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `atiksu_arit_tes` int(3) DEFAULT NULL,
  `atiksu_arit_tes_kap` varchar(9) CHARACTER SET utf8 DEFAULT NULL,
  `atiksu_arit_mik` int(7) DEFAULT NULL,
  `atiksu_arit_tes_hiz_bel_sayi` int(3) DEFAULT NULL,
  `atiksu_arit_tes_hiz_bel_nuf` int(8) DEFAULT NULL,
  `atiksu_arit_tes_hiz_bel_oran` int(2) DEFAULT NULL,
  `kisi_gun_atiksu_mik` int(3) DEFAULT NULL,
  `derin_deniz_des_bel_sayi` int(2) DEFAULT NULL,
  `bel_atiksu_yil` int(4) NOT NULL,
  PRIMARY KEY (`bel_atiksu_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bel_atiksu_gos`
--

INSERT INTO `bel_atiksu_gos` (`kana_bel_hiz_sayi`, `kana_bel_hiz_nuf`, `kana_hiz_nuf_top_oran`, `ortam_atiksu`, `atiksu_arit_tes`, `atiksu_arit_tes_kap`, `atiksu_arit_mik`, `atiksu_arit_tes_hiz_bel_sayi`, `atiksu_arit_tes_hiz_bel_nuf`, `atiksu_arit_tes_hiz_bel_oran`, `kisi_gun_atiksu_mik`, `derin_deniz_des_bel_sayi`, `bel_atiksu_yil`) VALUES
(1188, 32696622, 69, '1509651', 41, '586877', 150061, 71, 6044364, 13, 126, 0, 1994),
(1347, 34225981, 72, '1632534', 46, '606736', 169287, 75, 5614840, 12, 131, 31, 1995),
(1383, 34246075, 72, '1679239', 55, '690441', 201902, 82, 6548459, 14, 134, 32, 1996),
(1493, 36652449, 77, '1920322', 68, '1245719', 365719, 97, 9039469, 19, 144, 34, 1997),
(1646, 37189736, 78, '2096714', 80, '1559087', 589515, 115, 10449370, 22, 154, 34, 1998),
(2003, 43034156, 81, '2301152', 126, '2287918', 1193975, 238, 18455498, 35, 147, 38, 2001),
(2115, 44342222, 83, '2497657', 145, '2358507', 1312379, 248, 18955305, 35, 154, 59, 2002),
(2195, 45202682, 85, '2860980', 156, '2805164', 1586550, 278, 20109347, 38, 173, 61, 2003),
(2226, 46149479, 86, '2922783', 172, '3410352', 1901040, 319, 24369119, 45, 174, 73, 2004),
(2321, 50856943, 87, '3366894', 184, '3648198', 2140494, 362, 29643258, 51, 181, 77, 2006),
(2421, 51673078, 88, '3261455', 236, '4143140', 2251581, 442, 32518318, 56, 173, 92, 2008),
(2235, 54017052, 88, '3582131', 326, '5293204', 2719151, 438, 38050717, 62, 182, 80, 2010),
(2300, 58754795, 92, '4072563', 460, '5 532 352', 3256980, 536, 43543737, 68, 190, 80, 2012),
(1309, 65071589, 90, '4296851', 604, '5 549 506', 3483787, 513, 49358266, 68, 181, 36, 2014),
(1338, 67227191, 90, '4 499 145', 881, '5 911 326', 3842350, 581, 56016738, 75, 183, 36, 2016),
(1357, 69732686, 91, '4795130', 991, '6366650', 4236419, 644, 60528175, 79, 188, 38, 2018);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bel_su_gos`
--

DROP TABLE IF EXISTS `bel_su_gos`;
CREATE TABLE IF NOT EXISTS `bel_su_gos` (
  `bel_su_yil` int(4) NOT NULL,
  `icme_bel_hiz_sayi` int(4) DEFAULT NULL,
  `icme_bel_hiz_nuf` int(8) DEFAULT NULL,
  `hiz_nuf_top_oran` int(2) DEFAULT NULL,
  `ic_top_su` int(7) DEFAULT NULL,
  `ic_yuz_mik` int(7) DEFAULT NULL,
  `ic_yer_mik` int(7) DEFAULT NULL,
  `kisi_gun_mik` int(3) DEFAULT NULL,
  `ic_dag_su_mik` int(7) DEFAULT NULL,
  `ic_arit_tes` int(3) DEFAULT NULL,
  `arit_tes_kap` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  `ic_arit_su_mik` int(7) DEFAULT NULL,
  `ic_arit_tes_hiz_bel_sayi` int(3) DEFAULT NULL,
  `ic_arit_tes_hiz_bel_nuf` int(8) DEFAULT NULL,
  `ic_arit_tes_hiz_bel_oran` int(2) DEFAULT NULL,
  PRIMARY KEY (`bel_su_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bel_su_gos`
--

INSERT INTO `bel_su_gos` (`bel_su_yil`, `icme_bel_hiz_sayi`, `icme_bel_hiz_nuf`, `hiz_nuf_top_oran`, `ic_top_su`, `ic_yuz_mik`, `ic_yer_mik`, `kisi_gun_mik`, `ic_dag_su_mik`, `ic_arit_tes`, `arit_tes_kap`, `ic_arit_su_mik`, `ic_arit_tes_hiz_bel_sayi`, `ic_arit_tes_hiz_bel_nuf`, `ic_arit_tes_hiz_bel_oran`) VALUES
(1994, 1962, 42068230, 88, 3242733, 1109701, 2133032, 211, 0, 60, '1925231', 981900, 132, 14134849, 30),
(1995, 2134, 43931706, 92, 3732608, 1369127, 2363480, 233, 0, 68, '2095651', 1144488, 143, 13051851, 27),
(1996, 2194, 44049447, 92, 3938678, 1486538, 2452139, 245, 0, 71, '2099007', 1262543, 150, 13405602, 28),
(1997, 2329, 44906669, 94, 4080963, 1641903, 2439059, 249, 0, 80, '2374839', 1365850, 166, 14867898, 31),
(1998, 2577, 44673961, 93, 4175011, 1598868, 2576144, 256, 0, 89, '2392915', 1558810, 173, 16777485, 35),
(2001, 3092, 50747292, 95, 4664411, 1982555, 2681857, 252, 0, 113, '3244979', 1667032, 236, 18510532, 35),
(2002, 3140, 51613433, 97, 4813097, 2063323, 2749774, 255, 0, 123, '3525507', 1709727, 252, 19375843, 36),
(2003, 3161, 51945136, 97, 4918477, 2164364, 2754113, 259, 0, 131, '3736368', 1892348, 303, 20855947, 39),
(2004, 3159, 53194450, 99, 4954292, 2215193, 2739098, 255, 1988217, 140, '3718085', 2079116, 313, 22794758, 42),
(2006, 3167, 57686003, 98, 5163500, 2381628, 2781872, 245, 2375043, 139, '3994060', 2426639, 413, 28839265, 49),
(2008, 3190, 58052383, 99, 4546574, 2209921, 2336654, 215, 2400522, 170, '4422745', 2120561, 434, 29074451, 50),
(2010, 2925, 60664687, 99, 4784734, 2495047, 2289687, 216, 2579676, 206, '4499508', 2520085, 346, 32992877, 54),
(2012, 2928, 62649551, 98, 4936342, 2592253, 2344090, 216, 2801939, 258, '4629842', 2729430, 411, 35868415, 56),
(2014, 1394, 70522136, 97, 5237407, 2828787, 2408620, 203, 3394545, 381, '5 346 014', 2995001, 436, 41610124, 58),
(2016, 1394, 73587584, 98, 5838561, 3275202, 2563359, 217, 3732875, 519, '5 558 307', 3350389, 436, 43881160, 59),
(2018, 1397, 75779007, 99, 6193158, 3314654, 2878503, 224, 4045486, 629, '6023791', 3574058, 443, 46229893, 60);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `donem`
--

DROP TABLE IF EXISTS `donem`;
CREATE TABLE IF NOT EXISTS `donem` (
  `donem_id` int(2) NOT NULL,
  `donem_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`donem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `donem`
--

INSERT INTO `donem` (`donem_id`, `donem_ad`) VALUES
(20, 'ocak-subat'),
(21, 'subat-mart'),
(22, 'mart-nisan'),
(23, 'nisan-mayis'),
(24, 'mayis-haziran'),
(25, 'haziran-temmuz'),
(26, 'temmuz-agustos'),
(27, 'agustos-eylul'),
(28, 'eylul-ekim'),
(29, 'ekim-kasım'),
(30, 'kasım-aralik'),
(31, 'aralik-ocak');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guncel_kullanici_sayisi`
--

DROP TABLE IF EXISTS `guncel_kullanici_sayisi`;
CREATE TABLE IF NOT EXISTS `guncel_kullanici_sayisi` (
  `sayi` int(11) NOT NULL,
  `tarih` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `guncel_kullanici_sayisi`
--

INSERT INTO `guncel_kullanici_sayisi` (`sayi`, `tarih`) VALUES
(5, '2022-01-03 20:49:49'),
(5, '2022-01-03 21:19:03'),
(6, '2022-01-03 21:19:03'),
(5, '2022-01-03 21:19:16'),
(4, '2022-01-03 21:19:16');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `icme_arit_tes_kap`
--

DROP TABLE IF EXISTS `icme_arit_tes_kap`;
CREATE TABLE IF NOT EXISTS `icme_arit_tes_kap` (
  `bel_su_yil` int(4) NOT NULL,
  `arit_tes_kap_fiz` int(6) DEFAULT NULL,
  `arit_tes_kap_kon` int(7) DEFAULT NULL,
  `arit_tes_kap_gel` varchar(7) COLLATE utf8_turkish_ci DEFAULT NULL,
  `arit_tes_kap` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`bel_su_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `icme_arit_tes_kap`
--

INSERT INTO `icme_arit_tes_kap` (`bel_su_yil`, `arit_tes_kap_fiz`, `arit_tes_kap_kon`, `arit_tes_kap_gel`, `arit_tes_kap`) VALUES
(1994, 138050, 1786676, '505', '1925231'),
(1995, 141388, 1953759, '505', '2095651'),
(1996, 141545, 1956957, '505', '2099007'),
(1997, 146940, 2227395, '505', '2374839'),
(1998, 159719, 2232691, '505', '2392915'),
(2001, 131585, 3112889, '505', '3244979'),
(2002, 149328, 3375674, '505', '3525507'),
(2003, 269669, 3466194, '505', '3736368'),
(2004, 273931, 3443649, '505', '3718085'),
(2006, 163128, 3829791, '1142', '3994060'),
(2008, 136743, 4166692, '119310', '4422745'),
(2010, 156490, 4172571, '170447', '4499508'),
(2012, 132800, 4291360, '205681', '4629842'),
(2014, 148052, 4955564, '242 398', '5 346 014'),
(2016, 115489, 4989372, '453 446', '5 558 307'),
(2018, 31000, 5437331, '555461', '6023791');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `icme_arit_tes_su_mik`
--

DROP TABLE IF EXISTS `icme_arit_tes_su_mik`;
CREATE TABLE IF NOT EXISTS `icme_arit_tes_su_mik` (
  `bel_su_yil` int(4) NOT NULL,
  `ic_arit_su_fiz` int(6) DEFAULT NULL,
  `ic_arit_su_kon` int(7) DEFAULT NULL,
  `ic_arit_su_gel` int(6) DEFAULT NULL,
  `ic_arit_su_mik` int(7) DEFAULT NULL,
  PRIMARY KEY (`bel_su_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `icme_arit_tes_su_mik`
--

INSERT INTO `icme_arit_tes_su_mik` (`bel_su_yil`, `ic_arit_su_fiz`, `ic_arit_su_kon`, `ic_arit_su_gel`, `ic_arit_su_mik`) VALUES
(1994, 47984, 933916, 0, 981900),
(1995, 56821, 1087667, 0, 1144488),
(1996, 58433, 1204110, 0, 1262543),
(1997, 64174, 1301675, 0, 1365850),
(1998, 66573, 1492236, 0, 1558810),
(2001, 34368, 1632665, 0, 1667032),
(2002, 43520, 1666207, 0, 1709727),
(2003, 102689, 1789659, 0, 1892348),
(2004, 100224, 1978891, 0, 2079116),
(2006, 63528, 2362437, 675, 2426639),
(2008, 54425, 2019619, 46517, 2120561),
(2010, 54615, 2401093, 64378, 2520085),
(2012, 43314, 2602102, 84015, 2729430),
(2014, 47875, 2860041, 87085, 2995001),
(2016, 33653, 3113183, 203553, 3350389),
(2018, 3677, 3292165, 278216, 3574058);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ic_arit_tes_sayi`
--

DROP TABLE IF EXISTS `ic_arit_tes_sayi`;
CREATE TABLE IF NOT EXISTS `ic_arit_tes_sayi` (
  `bel_su_yil` int(4) NOT NULL,
  `arit_tes_fiz` int(2) DEFAULT NULL,
  `arit_tes_kon` int(3) DEFAULT NULL,
  `arit_tes_gel` int(3) DEFAULT NULL,
  `ic_arit_tes` int(3) DEFAULT NULL,
  PRIMARY KEY (`bel_su_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ic_arit_tes_sayi`
--

INSERT INTO `ic_arit_tes_sayi` (`bel_su_yil`, `arit_tes_fiz`, `arit_tes_kon`, `arit_tes_gel`, `ic_arit_tes`) VALUES
(1994, 26, 33, 1, 60),
(1995, 29, 38, 1, 68),
(1996, 30, 40, 1, 71),
(1997, 34, 45, 1, 80),
(1998, 40, 48, 1, 89),
(2001, 57, 55, 1, 113),
(2002, 63, 59, 1, 123),
(2003, 69, 61, 1, 131),
(2004, 73, 66, 1, 140),
(2006, 69, 68, 2, 139),
(2008, 71, 84, 15, 170),
(2010, 77, 96, 33, 206),
(2012, 79, 132, 47, 258),
(2014, 69, 165, 147, 381),
(2016, 54, 197, 268, 519),
(2018, 22, 197, 410, 629);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ic_top_su_mik`
--

DROP TABLE IF EXISTS `ic_top_su_mik`;
CREATE TABLE IF NOT EXISTS `ic_top_su_mik` (
  `ic_bar` int(7) DEFAULT NULL,
  `ic_ku` int(7) DEFAULT NULL,
  `ic_ka` int(7) DEFAULT NULL,
  `ic_ak` int(6) DEFAULT NULL,
  `ic_gol` int(6) DEFAULT NULL,
  `bel_su_yil` int(4) NOT NULL,
  `ic_top_su` int(7) DEFAULT NULL,
  PRIMARY KEY (`bel_su_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ic_top_su_mik`
--

INSERT INTO `ic_top_su_mik` (`ic_bar`, `ic_ku`, `ic_ka`, `ic_ak`, `ic_gol`, `bel_su_yil`, `ic_top_su`) VALUES
(899707, 1295410, 837622, 101270, 108724, 1994, 3242733),
(976763, 1451466, 912014, 108439, 283925, 1995, 3732608),
(1033072, 1521606, 930533, 167152, 286314, 1996, 3938678),
(1077831, 1378715, 1060344, 273452, 290620, 1997, 4080963),
(1174198, 1591410, 984734, 135606, 289064, 1998, 4175011),
(1389239, 1598865, 1082992, 131754, 461562, 2001, 4664411),
(1795963, 1455114, 1294660, 131295, 136065, 2002, 4813097),
(1925653, 1547717, 1206396, 141194, 97517, 2003, 4918477),
(1984739, 1375738, 1363360, 143062, 87392, 2004, 4954292),
(1843736, 1401815, 1380057, 305271, 232621, 2006, 5163500),
(1810188, 1275691, 1060963, 173928, 225805, 2008, 4546574),
(2252421, 1273822, 1015865, 159472, 83154, 2010, 4784734),
(2416018, 1395957, 948133, 78282, 97953, 2012, 4936342),
(1886617, 1423751, 984869, 652370, 289800, 2014, 5237407),
(2618225, 1563154, 1000205, 552624, 104354, 2016, 5838561),
(2468103, 1740116, 1138388, 560356, 286196, 2018, 6193158);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `iller`
--

DROP TABLE IF EXISTS `iller`;
CREATE TABLE IF NOT EXISTS `iller` (
  `il_ad` varchar(20) COLLATE utf8_turkish_ci NOT NULL,
  `il_id` int(2) NOT NULL,
  PRIMARY KEY (`il_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `iller`
--

INSERT INTO `iller` (`il_ad`, `il_id`) VALUES
('Adana', 1),
('Adıyaman', 2),
('Afyonkarahisar', 3),
('Ağrı', 4),
('Amasya', 5),
('Ankara', 6),
('Antalya', 7),
('Artvin', 8),
('Aydın', 9),
('Balıkesir', 10),
('Bilecik', 11),
('Bingöl', 12),
('Bitlis', 13),
('Bolu', 14),
('Burdur', 15),
('Bursa', 16),
('Çanakkale', 17),
('Çankırı', 18),
('Çorum', 19),
('Denizli', 20),
('Diyarbakır', 21),
('Edirne', 22),
('Elazığ', 23),
('Erzincan', 24),
('Erzurum', 25),
('Eskişehir', 26),
('Gaziantep', 27),
('Giresun', 28),
('Gümüşhane', 29),
('Hakkari', 30),
('Hatay', 31),
('Isparta', 32),
('Mersin', 33),
('İstanbul', 34),
('İzmir', 35),
('Kars', 36),
('Kastamonu', 37),
('Kayseri', 38),
('Kırklareli', 39),
('Kırşehir', 40),
('Kocaeli', 41),
('Konya', 42),
('Kütahya', 43),
('Malatya', 44),
('Manisa', 45),
('Kahramanmaraş', 46),
('Mardin', 47),
('Muğla', 48),
('Muş', 49),
('Nevşehir', 50),
('Niğde', 51),
('Ordu', 52),
('Rize', 53),
('Sakarya', 54),
('Samsun', 55),
('Siirt', 56),
('Sinop', 57),
('Sivas', 58),
('Tekirdağ', 59),
('Tokat', 60),
('Trabzon', 61),
('Tunceli', 62),
('Şanlıurfa', 63),
('Uşak', 64),
('Van', 65),
('Yozgat', 66),
('Zonguldak', 67),
('Aksaray', 68),
('Bayburt', 69),
('Karaman', 70),
('Kırıkkale', 71),
('Batman', 72),
('Şırnak', 73),
('Bartın', 74),
('Ardahan', 75),
('Iğdır', 76),
('Yalova', 77),
('Karabük', 78),
('Kilis', 79),
('Osmaniye', 80),
('Düzce', 81);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `il_ilce_nufus`
--

DROP TABLE IF EXISTS `il_ilce_nufus`;
CREATE TABLE IF NOT EXISTS `il_ilce_nufus` (
  `ilceler` varchar(16) COLLATE utf8_turkish_ci DEFAULT NULL,
  `ilce_mer_nuf` int(6) DEFAULT NULL,
  `top_nuf_ilce` int(6) DEFAULT NULL,
  `bel_koy_nuf_ilce` int(5) DEFAULT NULL,
  `nuf_art_hiz_ilce` int(4) DEFAULT NULL,
  `il_id` int(2) NOT NULL,
  `ilce_id` int(3) NOT NULL,
  PRIMARY KEY (`ilce_id`),
  KEY `ilce_nu` (`il_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `il_ilce_nufus`
--

INSERT INTO `il_ilce_nufus` (`ilceler`, `ilce_mer_nuf`, `top_nuf_ilce`, `bel_koy_nuf_ilce`, `nuf_art_hiz_ilce`, `il_id`, `ilce_id`) VALUES
('Aladağ', 15998, 15998, 0, -8, 1, 1),
('Ceyhan', 161159, 161159, 0, 1, 1, 2),
('Çukurova', 386634, 386634, 0, 27, 1, 3),
('Feke', 16536, 16536, 0, -23, 1, 4),
('İmamoğlu', 27784, 27784, 0, -6, 1, 5),
('Karaisalı', 22065, 22065, 0, 5, 1, 6),
('Karataş', 23667, 23667, 0, 0, 1, 7),
('Kozan', 132974, 132974, 0, 10, 1, 8),
('Pozantı', 19930, 19930, 0, -2, 1, 9),
('Saimbeyli', 14560, 14560, 0, -14, 1, 10),
('Sarıçam', 194019, 194019, 0, 66, 1, 11),
('Seyhan', 796131, 796131, 0, 0, 1, 12),
('Tufanbeyli', 16966, 16966, 0, -8, 1, 13),
('Yumurtalık', 18203, 18203, 0, 10, 1, 14),
('Yüreğir', 412092, 412092, 0, -6, 1, 15),
('Merkez', 263790, 310644, 46854, 6, 2, 16),
('Besni', 36476, 77732, 41256, 14, 2, 17),
('Çelikhan', 8556, 15530, 6974, 4, 2, 18),
('Gerger', 2852, 17234, 14382, -18, 2, 19),
('Gölbaşı', 33263, 50204, 16941, 19, 2, 20),
('Kahta', 84060, 126636, 42576, 22, 2, 21),
('Samsat', 4401, 7803, 3402, -22, 2, 22),
('Sincik', 4314, 16734, 12420, -7, 2, 23),
('Tut', 3453, 9942, 6489, 4, 2, 24),
('Merkez', 245405, 313063, 67658, 20, 3, 25),
('Başmakçı', 5034, 9617, 4583, -18, 3, 26),
('Bayat', 4096, 7573, 3477, -13, 3, 27),
('Bolvadin', 32475, 45133, 12658, -6, 3, 28),
('Çay', 14800, 31174, 16374, 0, 3, 29),
('Çobanlar', 9266, 14355, 5089, -1, 3, 30),
('Dazkırı', 5612, 11397, 5785, 17, 3, 31),
('Dinar', 26122, 47516, 21394, 2, 3, 32),
('Emirdağ', 20175, 39518, 19343, 56, 3, 33),
('Evciler', 3451, 7311, 3860, -8, 3, 34),
('Hocalar', 2287, 9245, 6958, -27, 3, 35),
('İhsaniye', 3876, 27807, 23931, -4, 3, 36),
('İscehisar', 13186, 25043, 11857, 14, 3, 37),
('Kızılören', 1442, 2269, 827, -26, 3, 38),
('Sandıklı', 33496, 55252, 21756, -1, 3, 39),
('Sinanpaşa', 3596, 39432, 35836, -8, 3, 40),
('Sultandağı', 5276, 14517, 9241, -3, 3, 41),
('Şuhut', 14857, 36690, 21833, -3, 3, 42),
('Merkez', 119154, 150263, 31109, -5, 4, 43),
('Diyadin', 20889, 41789, 20900, 7, 4, 44),
('Doğubayazıt', 80607, 119941, 39334, 1, 4, 45),
('Eleşkirt', 9969, 32316, 22347, -9, 4, 46),
('Hamur', 3293, 17908, 14615, -14, 4, 47),
('Patnos', 63786, 123203, 59417, 3, 4, 48),
('Taşlıçay', 6180, 20028, 13848, 0, 4, 49),
('Tutak', 7018, 29987, 22969, -6, 4, 50),
('Merkez', 114366, 147266, 32900, -24, 5, 51),
('Göynücek', 4166, 10033, 5867, -17, 5, 52),
('Gümüşhacıköy', 14819, 22764, 7945, -28, 5, 53),
('Hamamözü', 1613, 3680, 2067, -33, 5, 54),
('Merzifon', 59942, 73849, 13907, 22, 5, 55),
('Suluova', 39211, 47314, 8103, 14, 5, 56),
('Taşova', 11119, 30588, 19469, -2, 5, 57),
('Akyurt', 37456, 37456, 0, 36, 6, 58),
('Altındağ', 396165, 396165, 0, 17, 6, 59),
('Ayaş', 13686, 13686, 0, -16, 6, 60),
('Bala', 25780, 25780, 0, -161, 6, 61),
('Beypazarı', 48732, 48732, 0, 7, 6, 62),
('Çamlıdere', 8883, 8883, 0, -101, 6, 63),
('Çankaya', 925828, 925828, 0, -20, 6, 64),
('Çubuk', 91142, 91142, 0, 4, 6, 65),
('Elmadağ', 45122, 45122, 0, -10, 6, 66),
('Etimesgut', 595305, 595305, 0, 14, 6, 67),
('Evren', 3045, 3045, 0, -17, 6, 68),
('Gölbaşı', 140649, 140649, 0, 12, 6, 69),
('Güdül', 8438, 8438, 0, -52, 6, 70),
('Haymana', 28922, 28922, 0, -67, 6, 71),
('Kahramankazan', 56736, 56736, 0, 35, 6, 72),
('Kalecik', 12941, 12941, 0, -22, 6, 73),
('Keçiören', 938568, 938568, 0, -1, 6, 74),
('Kızılcahamam', 27507, 27507, 0, -30, 6, 75),
('Mamak', 669465, 669465, 0, 5, 6, 76),
('Nallıhan', 27434, 27434, 0, -5, 6, 77),
('Polatlı', 126623, 126623, 0, 12, 6, 78),
('Pursaklar', 157082, 157082, 0, 43, 6, 79),
('Sincan', 549108, 549108, 0, 25, 6, 80),
('Şereflikoçhisar', 33310, 33310, 0, -15, 6, 81),
('Yenimahalle', 695395, 695395, 0, 12, 6, 82),
('Akseki', 10957, 10957, 0, -47, 7, 83),
('Aksu', 74570, 74570, 0, 18, 7, 84),
('Alanya', 333104, 333104, 0, 17, 7, 85),
('Demre', 26896, 26896, 0, 20, 7, 86),
('Döşemealtı', 69300, 69300, 0, 52, 7, 87),
('Elmalı', 39365, 39365, 0, 10, 7, 88),
('Finike', 49307, 49307, 0, 16, 7, 89),
('Gazipaşa', 51555, 51555, 0, 20, 7, 90),
('Gündoğmuş', 7492, 7492, 0, -32, 7, 91),
('İbradı', 2947, 2947, 0, -28, 7, 92),
('Kaş', 60839, 60839, 0, 19, 7, 93),
('Kemer', 45082, 45082, 0, -23, 7, 94),
('Kepez', 574183, 574183, 0, 32, 7, 95),
('Konyaaltı', 189078, 189078, 0, -5, 7, 96),
('Korkuteli', 55588, 55588, 0, 4, 7, 97),
('Kumluca', 71931, 71931, 0, 21, 7, 98),
('Manavgat', 242490, 242490, 0, 6, 7, 99),
('Muratpaşa', 513035, 513035, 0, 5, 7, 100),
('Serik', 130589, 130589, 0, 9, 7, 101),
('Merkez', 25288, 34007, 8719, -34, 8, 102),
('Ardanuç', 5501, 11344, 5843, -9, 8, 103),
('Arhavi', 17111, 21544, 4433, 29, 8, 104),
('Borçka', 11395, 22684, 11289, -6, 8, 105),
('Hopa', 23336, 27631, 4295, 25, 8, 106),
('Kemalpaşa', 5832, 9120, 3288, -11, 8, 107),
('Murgul', 4930, 6315, 1385, -107, 8, 108),
('Şavşat', 6123, 17024, 10901, -5, 8, 109),
('Yusufeli', 7342, 19832, 12490, -16, 8, 110),
('Bozdoğan', 33056, 33056, 0, -17, 9, 111),
('Buharkent', 12796, 12796, 0, 0, 9, 112),
('Çine', 49128, 49128, 0, -4, 9, 113),
('Didim', 90427, 90427, 0, 42, 9, 114),
('Efeler', 292716, 292716, 0, -4, 9, 115),
('Germencik', 44255, 44255, 0, 7, 9, 116),
('İncirliova', 53999, 53999, 0, 27, 9, 117),
('Karacasu', 18129, 18129, 0, -14, 9, 118),
('Karpuzlu', 10928, 10928, 0, -2, 9, 119),
('Koçarlı', 22619, 22619, 0, -34, 9, 120),
('Köşk', 27828, 27828, 0, -1, 9, 121),
('Kuşadası', 121493, 121493, 0, 38, 9, 122),
('Kuyucak', 26624, 26624, 0, -2, 9, 123),
('Nazilli', 160877, 160877, 0, 8, 9, 124),
('Söke', 121940, 121940, 0, 4, 9, 125),
('Sultanhisar', 20030, 20030, 0, -21, 9, 126),
('Yenipazar', 12239, 12239, 0, -20, 9, 127),
('Altıeylül', 182073, 182073, 0, 4, 10, 128),
('Ayvalık', 71725, 71725, 0, 14, 10, 129),
('Balya', 12878, 12878, 0, -4, 10, 130),
('Bandırma', 158857, 158857, 0, 13, 10, 131),
('Bigadiç', 49486, 49486, 0, -9, 10, 132),
('Burhaniye', 61806, 61806, 0, 22, 10, 133),
('Dursunbey', 34840, 34840, 0, -8, 10, 134),
('Edremit', 161145, 161145, 0, 33, 10, 135),
('Erdek', 32319, 32319, 0, 6, 10, 136),
('Gömeç', 15207, 15207, 0, 70, 10, 137),
('Gönen', 74894, 74894, 0, 10, 10, 138),
('Havran', 27988, 27988, 0, 5, 10, 139),
('İvrindi', 32319, 32319, 0, -5, 10, 140),
('Karesi', 184197, 184197, 0, 6, 10, 141),
('Kepsut', 23017, 23017, 0, -5, 10, 142),
('Manyas', 18599, 18599, 0, -18, 10, 143),
('Marmara', 9973, 9973, 0, 25, 10, 144),
('Savaştepe', 17361, 17361, 0, -27, 10, 145),
('Sındırgı', 32925, 32925, 0, -10, 10, 146),
('Susurluk', 38676, 38676, 0, -1, 10, 147),
('Merkez', 65073, 78029, 12956, -6, 11, 148),
('Bozüyük', 70698, 76987, 6289, 19, 11, 149),
('Gölpazarı', 6092, 9463, 3371, -101, 11, 150),
('İnhisar', 1016, 2309, 1293, -44, 11, 151),
('Osmaneli', 15598, 21072, 5474, -2, 11, 152),
('Pazaryeri', 6274, 10077, 3803, -22, 11, 153),
('Söğüt', 13012, 17924, 4912, -13, 11, 154),
('Yenipazar', 1018, 2856, 1838, -7, 11, 155),
('Merkez', 125375, 165867, 40492, 6, 12, 156),
('Adaklı', 3122, 8509, 5387, -5, 12, 157),
('Genç', 20801, 33902, 13101, -8, 12, 158),
('Karlıova', 8732, 29313, 20581, 5, 12, 159),
('Kiğı', 2957, 4863, 1906, 60, 12, 160),
('Solhan', 20056, 34326, 14270, 20, 12, 161),
('Yayladere', 1157, 2160, 1003, 67, 12, 162),
('Yedisu', 1413, 2828, 1415, 4, 12, 163),
('Merkez', 52024, 70344, 18320, -5, 13, 164),
('Adilcevaz', 14894, 30530, 15636, 1, 13, 165),
('Ahlat', 26656, 41633, 14977, 23, 13, 166),
('Güroymak', 25339, 48654, 23315, 17, 13, 167),
('Hizan', 12114, 33345, 21231, 0, 13, 168),
('Mutki', 2378, 31791, 29413, -2, 13, 169),
('Tatvan', 76713, 94697, 17984, 16, 13, 170),
('Merkez', 179223, 212641, 33418, 1, 14, 171),
('Dörtdivan', 2730, 6585, 3855, -25, 14, 172),
('Gerede', 23044, 33561, 10517, -11, 14, 173),
('Göynük', 4278, 14917, 10639, -9, 14, 174),
('Kıbrıscık', 1152, 3112, 1960, -21, 14, 175),
('Mengen', 5449, 13748, 8299, -15, 14, 176),
('Mudurnu', 5209, 18690, 13481, -10, 14, 177),
('Seben', 2237, 4786, 2549, -60, 14, 178),
('Yeniçağa', 4402, 6762, 2360, -27, 14, 179),
('Merkez', 89897, 111984, 22087, -28, 15, 180),
('Ağlasun', 3740, 7854, 4114, -28, 15, 181),
('Altınyayla', 3083, 5422, 2339, -18, 15, 182),
('Bucak', 44769, 65051, 20282, -4, 15, 183),
('Çavdır', 4951, 12748, 7797, -4, 15, 184),
('Çeltikçi', 2010, 4974, 2964, -32, 15, 185),
('Gölhisar', 15136, 22180, 7044, -10, 15, 186),
('Karamanlı', 5800, 7982, 2182, -4, 15, 187),
('Kemer', 1520, 3129, 1609, -28, 15, 188),
('Tefenni', 7015, 10697, 3682, 76, 15, 189),
('Yeşilova', 5483, 15071, 9588, -10, 15, 190),
('Büyükorhan', 9485, 9485, 0, -19, 16, 191),
('Gemlik', 115404, 115404, 0, 17, 16, 192),
('Gürsu', 96985, 96985, 0, 34, 16, 193),
('Harmancık', 6145, 6145, 0, -38, 16, 194),
('İnegöl', 281384, 281384, 0, 27, 16, 195),
('İznik', 44102, 44102, 0, 13, 16, 196),
('Karacabey', 84666, 84666, 0, 9, 16, 197),
('Keles', 11499, 11499, 0, -42, 16, 198),
('Kestel', 70865, 70865, 0, 38, 16, 199),
('Mudanya', 102523, 102523, 0, 49, 16, 200),
('Mustafakemalpaşa', 101820, 101820, 0, 7, 16, 201),
('Nilüfer', 484832, 484832, 0, 40, 16, 202),
('Orhaneli', 19055, 19055, 0, -17, 16, 203),
('Orhangazi', 80118, 80118, 0, 12, 16, 204),
('Osmangazi', 881459, 881459, 0, 6, 16, 205),
('Yenişehir', 54315, 54315, 0, 7, 16, 206),
('Yıldırım', 657176, 657176, 0, -1, 16, 207),
('Merkez', 134478, 184184, 49706, -2, 17, 208),
('Ayvacık', 9343, 33751, 24408, 12, 17, 209),
('Bayramiç', 15643, 29302, 13659, -3, 17, 210),
('Biga', 55975, 90274, 34299, -2, 17, 211),
('Bozcaada', 3052, 3052, 0, 21, 17, 212),
('Çan', 30778, 48376, 17598, -2, 17, 213),
('Eceabat', 5726, 8863, 3137, 9, 17, 214),
('Ezine', 13617, 30723, 17106, 2, 17, 215),
('Gelibolu', 31041, 43581, 12540, -17, 17, 216),
('Gökçeada', 7429, 10106, 2677, 68, 17, 217),
('Lapseki', 14331, 28313, 13982, 17, 17, 218),
('Yenice', 7789, 31023, 23234, -26, 17, 219),
('Merkez', 87589, 97326, 9737, -6, 18, 220),
('Atkaracalar', 2349, 4904, 2555, -121, 18, 221),
('Bayramören', 507, 2611, 2104, -113, 18, 222),
('Çerkeş', 9479, 16805, 7326, 1, 18, 223),
('Eldivan', 3185, 5986, 2801, -76, 18, 224),
('Ilgaz', 7811, 13866, 6055, -17, 18, 225),
('Kızılırmak', 2148, 7130, 4982, -24, 18, 226),
('Korgun', 2538, 4546, 2008, -17, 18, 227),
('Kurşunlu', 4868, 8424, 3556, -5, 18, 228),
('Orta', 3336, 11450, 8114, -45, 18, 229),
('Şabanözü', 8680, 11661, 2981, -18, 18, 230),
('Yapraklı', 2176, 7719, 5543, -18, 18, 231),
('Merkez', 267701, 299315, 31614, 7, 19, 232),
('Alaca', 19956, 31264, 11308, 5, 19, 233),
('Bayat', 5785, 15775, 9990, -20, 19, 234),
('Boğazkale', 1198, 3648, 2450, -32, 19, 235),
('Dodurga', 2496, 5588, 3092, -60, 19, 236),
('İskilip', 18136, 31027, 12891, -27, 19, 237),
('Kargı', 5680, 15411, 9731, -3, 19, 238),
('Laçin', 1294, 4514, 3220, -19, 19, 239),
('Mecitözü', 4208, 14564, 10356, -25, 19, 240),
('Oğuzlar', 2791, 5080, 2289, -33, 19, 241),
('Ortaköy', 2157, 6691, 4534, -55, 19, 242),
('Osmancık', 29086, 43183, 14097, 5, 19, 243),
('Sungurlu', 30910, 47890, 16980, -6, 19, 244),
('Uğurludağ', 2852, 6176, 3324, -38, 19, 245),
('Acıpayam', 55359, 55359, 0, 0, 20, 246),
('Babadağ', 6438, 6438, 0, -1, 20, 247),
('Baklan', 5503, 5503, 0, -4, 20, 248),
('Bekilli', 6660, 6660, 0, -25, 20, 249),
('Beyağaç', 6320, 6320, 0, -12, 20, 250),
('Bozkurt', 12148, 12148, 0, -42, 20, 251),
('Buldan', 27223, 27223, 0, 2, 20, 252),
('Çal', 18579, 18579, 0, -15, 20, 253),
('Çameli', 18008, 18008, 0, -2, 20, 254),
('Çardak', 8574, 8574, 0, -19, 20, 255),
('Çivril', 60345, 60345, 0, 0, 20, 256),
('Güney', 9746, 9746, 0, -6, 20, 257),
('Honaz', 33765, 33765, 0, -17, 20, 258),
('Kale', 19978, 19978, 0, -16, 20, 259),
('Merkezefendi', 321546, 321546, 0, 33, 20, 260),
('Pamukkale', 342608, 342608, 0, -12, 20, 261),
('Sarayköy', 30872, 30872, 0, 2, 20, 262),
('Serinhisar', 14321, 14321, 0, -9, 20, 263),
('Tavas', 42922, 42922, 0, -9, 20, 264),
('Bağlar', 399499, 399499, 0, 9, 21, 265),
('Bismil', 118605, 118605, 0, 3, 21, 266),
('Çermik', 51058, 51058, 0, 5, 21, 267),
('Çınar', 76798, 76798, 0, 15, 21, 268),
('Çüngüş', 11293, 11293, 0, -22, 21, 269),
('Dicle', 37534, 37534, 0, -4, 21, 270),
('Eğil', 22381, 22381, 0, -14, 21, 271),
('Ergani', 134497, 134497, 0, 15, 21, 272),
('Hani', 33048, 33048, 0, 11, 21, 273),
('Hazro', 16779, 16779, 0, 10, 21, 274),
('Kayapınar', 400905, 400905, 0, 50, 21, 275),
('Kocaköy', 15974, 15974, 0, -8, 21, 276),
('Kulp', 35449, 35449, 0, 3, 21, 277),
('Lice', 25027, 25027, 0, -8, 21, 278),
('Silvan', 87639, 87639, 0, 10, 21, 279),
('Sur', 102114, 102114, 0, -38, 21, 280),
('Yenişehir', 214831, 214831, 0, 18, 21, 281),
('Merkez', 168680, 180901, 12221, -25, 22, 282),
('Enez', 4181, 10667, 6486, 8, 22, 283),
('Havsa', 8704, 18564, 9860, -5, 22, 284),
('İpsala', 8524, 26796, 18272, -17, 22, 285),
('Keşan', 63965, 83399, 19434, 0, 22, 286),
('Lalapaşa', 1596, 6442, 4846, -23, 22, 287),
('Meriç', 2944, 13535, 10591, -11, 22, 288),
('Süloğlu', 3558, 6851, 3293, -62, 22, 289),
('Uzunköprü', 39735, 60608, 20873, -8, 22, 290),
('Merkez', 381995, 440513, 58518, 2, 23, 291),
('Ağın', 1580, 2556, 976, -27, 23, 292),
('Alacakaya', 2500, 6076, 3576, -12, 23, 293),
('Arıcak', 3362, 14302, 10940, -22, 23, 294),
('Baskil', 4482, 12508, 8026, -96, 23, 295),
('Karakoçan', 14625, 28434, 13809, 10, 23, 296),
('Keban', 4216, 6546, 2330, -77, 23, 297),
('Kovancılar', 25134, 39793, 14659, 18, 23, 298),
('Maden', 3980, 10329, 6349, -88, 23, 299),
('Palu', 9509, 18754, 9245, -53, 23, 300),
('Sivrice', 3837, 8149, 4312, -89, 23, 301),
('Merkez', 145859, 160786, 14927, -3, 24, 302),
('Çayırlı', 4728, 8470, 3742, -13, 24, 303),
('İliç', 4454, 8878, 4424, 0, 24, 304),
('Kemah', 2736, 7305, 4569, 87, 24, 305),
('Kemaliye', 2082, 4844, 2762, -53, 24, 306),
('Otlukbeli', 2022, 2456, 434, 51, 24, 307),
('Refahiye', 4540, 11469, 6929, -11, 24, 308),
('Tercan', 5313, 16636, 11323, -14, 24, 309),
('Üzümlü', 8238, 13587, 5349, 7, 24, 310),
('Aşkale', 22842, 22842, 0, -13, 25, 311),
('Aziziye', 63366, 63366, 0, -2, 25, 312),
('Çat', 17035, 17035, 0, 19, 25, 313),
('Hınıs', 26028, 26028, 0, -7, 25, 314),
('Horasan', 38090, 38090, 0, -19, 25, 315),
('İspir', 14775, 14775, 0, -12, 25, 316),
('Karaçoban', 23610, 23610, 0, 12, 25, 317),
('Karayazı', 27612, 27612, 0, -5, 25, 318),
('Köprüköy', 15587, 15587, 0, -13, 25, 319),
('Narman', 13183, 13183, 0, -11, 25, 320),
('Oltu', 30255, 30255, 0, -8, 25, 321),
('Olur', 6509, 6509, 0, 6, 25, 322),
('Palandöken', 173268, 173268, 0, 5, 25, 323),
('Pasinler', 28513, 28513, 0, -6, 25, 324),
('Pazaryolu', 3828, 3828, 0, -38, 25, 325),
('Şenkaya', 17399, 17399, 0, -6, 25, 326),
('Tekman', 25649, 25649, 0, -3, 25, 327),
('Tortum', 21661, 21661, 0, 178, 25, 328),
('Uzundere', 7919, 7919, 0, -29, 25, 329),
('Yakutiye', 181150, 181150, 0, -32, 25, 330),
('Alpu', 10614, 10614, 0, -33, 26, 331),
('Beylikova', 6222, 6222, 0, -28, 26, 332),
('Çifteler', 14925, 14925, 0, 3, 26, 333),
('Günyüzü', 5455, 5455, 0, -39, 26, 334),
('Han', 2100, 2100, 0, -8, 26, 335),
('İnönü', 6355, 6355, 0, -25, 26, 336),
('Mahmudiye', 7740, 7740, 0, -9, 26, 337),
('Mihalgazi', 3099, 3099, 0, -13, 26, 338),
('Mihalıççık', 8011, 8011, 0, -20, 26, 339),
('Odunpazarı', 415230, 415230, 0, 4, 26, 340),
('Sarıcakaya', 4790, 4790, 0, -13, 26, 341),
('Seyitgazi', 12844, 12844, 0, -13, 26, 342),
('Sivrihisar', 20140, 20140, 0, -9, 26, 343),
('Tepebaşı', 371303, 371303, 0, 3, 26, 344),
('Araban', 33136, 33136, 0, 11, 27, 345),
('İslahiye', 67862, 67862, 0, 12, 27, 346),
('Karkamış', 9672, 9672, 0, -14, 27, 347),
('Nizip', 146528, 146528, 0, 17, 27, 348),
('Nurdağı', 40793, 40793, 0, 14, 27, 349),
('Oğuzeli', 32086, 32086, 0, 6, 27, 350),
('Şahinbey', 931116, 931116, 0, 5, 27, 351),
('Şehitkamil', 817412, 817412, 0, 28, 27, 352),
('Yavuzeli', 22552, 22552, 0, 16, 27, 353),
('Merkez', 120186, 140231, 20045, 10, 28, 354),
('Alucra', 4755, 9405, 4650, -86, 28, 355),
('Bulancak', 47366, 68557, 21191, 14, 28, 356),
('Çamoluk', 3492, 7507, 4015, -99, 28, 357),
('Çanakçı', 2394, 6222, 3828, -2, 28, 358),
('Dereli', 6036, 19369, 13333, -19, 28, 359),
('Doğankent', 4544, 6751, 2207, 21, 28, 360),
('Espiye', 25925, 36512, 10587, 24, 28, 361),
('Eynesil', 7756, 13226, 5470, -5, 28, 362),
('Görele', 19251, 31509, 12258, -11, 28, 363),
('Güce', 4473, 8492, 4019, 61, 28, 364),
('Keşap', 9400, 19372, 9972, -13, 28, 365),
('Piraziz', 8443, 14221, 5778, -6, 28, 366),
('Şebinkarahisar', 11021, 19715, 8694, -37, 28, 367),
('Tirebolu', 19750, 32055, 12305, 6, 28, 368),
('Yağlıdere', 7467, 15577, 8110, -14, 28, 369),
('Merkez', 37752, 51483, 13731, -91, 29, 370),
('Kelkit', 17018, 39123, 22105, -296, 29, 371),
('Köse', 5201, 7005, 1804, -176, 29, 372),
('Kürtün', 5285, 12792, 7507, -45, 29, 373),
('Şiran', 12512, 19874, 7362, -69, 29, 374),
('Torul', 6103, 11425, 5322, -90, 29, 375),
('Merkez', 59465, 78516, 19051, -2, 30, 376),
('Çukurca', 8864, 16137, 7273, 0, 30, 377),
('Derecik', 10563, 22988, 12425, -17, 30, 378),
('Şemdinli', 15504, 43311, 27807, -13, 30, 379),
('Yüksekova', 71705, 119562, 47857, 5, 30, 380),
('Altınözü', 60589, 60589, 0, -3, 31, 381),
('Antakya', 389377, 389377, 0, 16, 31, 382),
('Arsuz', 97217, 97217, 0, 47, 31, 383),
('Belen', 33896, 33896, 0, 17, 31, 384),
('Defne', 160066, 160066, 0, 33, 31, 385),
('Dörtyol', 127399, 127399, 0, 18, 31, 386),
('Erzin', 41769, 41769, 0, 7, 31, 387),
('Hassa', 57361, 57361, 0, 15, 31, 388),
('İskenderun', 250964, 250964, 0, 10, 31, 389),
('Kırıkhan', 119028, 119028, 0, 18, 31, 390),
('Kumlu', 13445, 13445, 0, -18, 31, 391),
('Payas', 43647, 43647, 0, 27, 31, 392),
('Reyhanlı', 103417, 103417, 0, 32, 31, 393),
('Samandağ', 124237, 124237, 0, 16, 31, 394),
('Yayladağı', 36908, 36908, 0, -2, 31, 395),
('Merkez', 240723, 262255, 21532, -8, 32, 396),
('Aksu', 1823, 4244, 2421, -71, 32, 397),
('Atabey', 4299, 5662, 1363, -17, 32, 398),
('Eğirdir', 16768, 31435, 14667, -6, 32, 399),
('Gelendost', 5338, 15149, 9811, -10, 32, 400),
('Gönen', 3224, 7157, 3933, -4, 32, 401),
('Keçiborlu', 6893, 13879, 6986, -19, 32, 402),
('Senirkent', 4759, 11231, 6472, -14, 32, 403),
('Sütçüler', 2243, 9979, 7736, -31, 32, 404),
('Şarkikaraağaç', 9533, 24889, 15356, -10, 32, 405),
('Uluborlu', 5218, 6184, 966, -17, 32, 406),
('Yalvaç', 21807, 46304, 24497, -8, 32, 407),
('Yenişarbademli', 1651, 1936, 285, -75, 32, 408),
('Akdeniz', 259381, 259381, 0, -11, 33, 409),
('Anamur', 66994, 66994, 0, 14, 33, 410),
('Aydıncık', 11289, 11289, 0, 24, 33, 411),
('Bozyazı', 26947, 26947, 0, 13, 33, 412),
('Çamlıyayla', 8225, 8225, 0, -12, 33, 413),
('Erdemli', 144548, 144548, 0, 21, 33, 414),
('Gülnar', 25296, 25296, 0, -5, 33, 415),
('Mezitli', 211538, 211538, 0, 35, 33, 416),
('Mut', 63269, 63269, 0, 10, 33, 417),
('Silifke', 125173, 125173, 0, 35, 33, 418),
('Tarsus', 346715, 346715, 0, 13, 33, 419),
('Toroslar', 310606, 310606, 0, 25, 33, 420),
('Yenişehir', 268776, 268776, 0, 10, 33, 421),
('Adalar', 16033, 16033, 0, 51, 34, 422),
('Arnavutköy', 296709, 296709, 0, 49, 34, 423),
('Ataşehir', 422594, 422594, 0, -6, 34, 424),
('Avcılar', 436897, 436897, 0, -27, 34, 425),
('Bağcılar', 737206, 737206, 0, -11, 34, 426),
('Bahçelievler', 592371, 592371, 0, -31, 34, 427),
('Bakırköy', 226229, 226229, 0, -13, 34, 428),
('Başakşehir', 469924, 469924, 0, 21, 34, 429),
('Bayrampaşa', 269950, 269950, 0, -18, 34, 430),
('Beşiktaş', 176513, 176513, 0, -34, 34, 431),
('Beykoz', 246110, 246110, 0, -9, 34, 432),
('Beylikdüzü', 365572, 365572, 0, 37, 34, 433),
('Beyoğlu', 226396, 226396, 0, -30, 34, 434),
('Büyükçekmece', 257362, 257362, 0, 13, 34, 435),
('Çatalca', 74975, 74975, 0, 17, 34, 436),
('Çekmeköy', 273658, 273658, 0, 34, 34, 437),
('Esenler', 446276, 446276, 0, -9, 34, 438),
('Esenyurt', 957398, 957398, 0, 3, 34, 439),
('Eyüpsultan', 405845, 405845, 0, 13, 34, 440),
('Fatih', 396594, 396594, 0, -111, 34, 441),
('Gaziosmanpaşa', 487778, 487778, 0, -9, 34, 442),
('Güngören', 280299, 280299, 0, -32, 34, 443),
('Kadıköy', 481983, 481983, 0, -2, 34, 444),
('Kağıthane', 442415, 442415, 0, -13, 34, 445),
('Kartal', 474514, 474514, 0, 8, 34, 446),
('Küçükçekmece', 789633, 789633, 0, -4, 34, 447),
('Maltepe', 515021, 515021, 0, 3, 34, 448),
('Pendik', 726481, 726481, 0, 20, 34, 449),
('Sancaktepe', 456861, 456861, 0, 45, 34, 450),
('Sarıyer', 335298, 335298, 0, -35, 34, 451),
('Silivri', 200215, 200215, 0, 33, 34, 452),
('Sultanbeyli', 343318, 343318, 0, 21, 34, 453),
('Sultangazi', 537488, 537488, 0, 5, 34, 454),
('Şile', 37904, 37904, 0, 6, 34, 455),
('Şişli', 266793, 266793, 0, -48, 34, 456),
('Tuzla', 273608, 273608, 0, 23, 34, 457),
('Ümraniye', 713803, 713803, 0, 5, 34, 458),
('Üsküdar', 520771, 520771, 0, -21, 34, 459),
('Zeytinburnu', 283657, 283657, 0, -34, 34, 460),
('Aliağa', 101242, 101242, 0, 43, 35, 461),
('Balçova', 78804, 78804, 0, -11, 35, 462),
('Bayındır', 40418, 40418, 0, 0, 35, 463),
('Bayraklı', 306988, 306988, 0, -17, 35, 464),
('Bergama', 104944, 104944, 0, 10, 35, 465),
('Beydağ', 12329, 12329, 0, -1, 35, 466),
('Bornova', 446927, 446927, 0, -9, 35, 467),
('Buca', 507773, 507773, 0, -6, 35, 468),
('Çeşme', 46093, 46093, 0, 38, 35, 469),
('Çiğli', 204549, 204549, 0, 21, 35, 470),
('Dikili', 45217, 45217, 0, 32, 35, 471),
('Foça', 33227, 33227, 0, 29, 35, 472),
('Gaziemir', 138519, 138519, 0, 5, 35, 473),
('Güzelbahçe', 36727, 36727, 0, 85, 35, 474),
('Karabağlar', 479592, 479592, 0, -3, 35, 475),
('Karaburun', 11329, 11329, 0, 52, 35, 476),
('Karşıyaka', 350100, 350100, 0, 2, 35, 477),
('Kemalpaşa', 110209, 110209, 0, 24, 35, 478),
('Kınık', 28691, 28691, 0, -4, 35, 479),
('Kiraz', 44105, 44105, 0, 4, 35, 480),
('Konak', 344678, 344678, 0, -20, 35, 481),
('Menderes', 101338, 101338, 0, 42, 35, 482),
('Menemen', 186182, 186182, 0, 34, 35, 483),
('Narlıdere', 65178, 65178, 0, -9, 35, 484),
('Ödemiş', 133679, 133679, 0, 6, 35, 485),
('Seferihisar', 48320, 48320, 0, 82, 35, 486),
('Selçuk', 37386, 37386, 0, 15, 35, 487),
('Tire', 86315, 86315, 0, 18, 35, 488),
('Torbalı', 194285, 194285, 0, 44, 35, 489),
('Urla', 69550, 69550, 0, 32, 35, 490),
('Merkez', 90523, 118201, 27678, 13, 36, 491),
('Akyaka', 2025, 10454, 8429, -12, 36, 492),
('Arpaçay', 2384, 16276, 13892, -22, 36, 493),
('Digor', 2473, 21490, 19017, -11, 36, 494),
('Kağızman', 20771, 45449, 24678, -1, 36, 495),
('Sarıkamış', 15557, 40158, 24601, -28, 36, 496),
('Selim', 5587, 22971, 17384, 3, 36, 497),
('Susuz', 2069, 9924, 7855, -12, 36, 498),
('Merkez', 124018, 151500, 27482, -7, 37, 499),
('Abana', 3321, 4049, 728, -16, 37, 500),
('Ağlı', 2121, 3045, 924, -16, 37, 501),
('Araç', 6445, 18149, 11704, -28, 37, 502),
('Azdavay', 3290, 7268, 3978, -8, 37, 503),
('Bozkurt', 5635, 9620, 3985, 16, 37, 504),
('Cide', 10630, 21919, 11289, -13, 37, 505),
('Çatalzeytin', 3173, 7299, 4126, 34, 37, 506),
('Daday', 2865, 8217, 5352, -12, 37, 507),
('Devrekani', 6144, 12341, 6197, -25, 37, 508),
('Doğanyurt', 1013, 5638, 4625, -2, 37, 509),
('Hanönü', 2134, 4137, 2003, 19, 37, 510),
('İhsangazi', 2762, 5219, 2457, -31, 37, 511),
('İnebolu', 10484, 20877, 10393, -5, 37, 512),
('Küre', 2614, 5669, 3055, -18, 37, 513),
('Pınarbaşı', 2436, 5756, 3320, -15, 37, 514),
('Seydiler', 2756, 4196, 1440, 44, 37, 515),
('Şenpazar', 1614, 4402, 2788, -27, 37, 516),
('Taşköprü', 16851, 37439, 20588, -10, 37, 517),
('Tosya', 28596, 39637, 11041, -7, 37, 518),
('Akkışla', 5999, 5999, 0, -41, 38, 519),
('Bünyan', 30113, 30113, 0, -16, 38, 520),
('Develi', 66250, 66250, 0, 8, 38, 521),
('Felahiye', 5569, 5569, 0, -51, 38, 522),
('Hacılar', 12443, 12443, 0, 2, 38, 523),
('İncesu', 28567, 28567, 0, 21, 38, 524),
('Kocasinan', 400726, 400726, 0, 10, 38, 525),
('Melikgazi', 582055, 582055, 0, 19, 38, 526),
('Özvatan', 3891, 3891, 0, -68, 38, 527),
('Pınarbaşı', 22900, 22900, 0, -50, 38, 528),
('Sarıoğlan', 14107, 14107, 0, -31, 38, 529),
('Sarız', 9537, 9537, 0, -5, 38, 530),
('Talas', 165127, 165127, 0, 8, 38, 531),
('Tomarza', 22028, 22028, 0, -6, 38, 532),
('Yahyalı', 36208, 36208, 0, 4, 38, 533),
('Yeşilhisar', 15935, 15935, 0, -10, 38, 534),
('Merkez', 79884, 101451, 21567, -16, 39, 535),
('Babaeski', 29119, 47065, 17946, -19, 39, 536),
('Demirköy', 3400, 8829, 5429, -3, 39, 537),
('Kofçaz', 610, 2282, 1672, -11, 39, 538),
('Lüleburgaz', 122635, 152192, 29557, 20, 39, 539),
('Pehlivanköy', 1621, 3484, 1863, -6, 39, 540),
('Pınarhisar', 10594, 17828, 7234, -35, 39, 541),
('Vize', 14990, 28606, 13616, 2, 39, 542),
('Merkez', 146242, 158954, 12712, 8, 40, 543),
('Akçakent', 814, 3702, 2888, -49, 40, 544),
('Akpınar', 2947, 7390, 4443, -10, 40, 545),
('Boztepe', 2771, 5410, 2639, -10, 40, 546),
('Çiçekdağı', 6313, 13921, 7608, -19, 40, 547),
('Kaman', 21285, 35246, 13961, -15, 40, 548),
('Mucur', 13098, 18419, 5321, -6, 40, 549),
('Başiskele', 108185, 108185, 0, 57, 41, 550),
('Çayırova', 140274, 140274, 0, 45, 41, 551),
('Darıca', 214796, 214796, 0, 35, 41, 552),
('Derince', 143884, 143884, 0, 7, 41, 553),
('Dilovası', 51060, 51060, 0, 10, 41, 554),
('Gebze', 392945, 392945, 0, 28, 41, 555),
('Gölcük', 170503, 170503, 0, 29, 41, 556),
('İzmit', 365893, 365893, 0, -6, 41, 557),
('Kandıra', 52268, 52268, 0, 7, 41, 558),
('Karamürsel', 58412, 58412, 0, 15, 41, 559),
('Kartepe', 125974, 125974, 0, 38, 41, 560),
('Körfez', 173064, 173064, 0, 22, 41, 561),
('Ahırlı', 4657, 4657, 0, -20, 42, 562),
('Akören', 5766, 5766, 0, -12, 42, 563),
('Akşehir', 93998, 93998, 0, 1, 42, 564),
('Altınekin', 14271, 14271, 0, -6, 42, 565),
('Beyşehir', 75532, 75532, 0, 14, 42, 566),
('Bozkır', 25832, 25832, 0, -2, 42, 567),
('Cihanbeyli', 52110, 52110, 0, 7, 42, 568),
('Çeltik', 9787, 9787, 0, 8, 42, 569),
('Çumra', 67901, 67901, 0, 9, 42, 570),
('Derbent', 4221, 4221, 0, -11, 42, 571),
('Derebucak', 5976, 5976, 0, -9, 42, 572),
('Doğanhisar', 15520, 15520, 0, -19, 42, 573),
('Emirgazi', 8459, 8459, 0, -9, 42, 574),
('Ereğli', 149346, 149346, 0, 16, 42, 575),
('Güneysınır', 9266, 9266, 0, -2, 42, 576),
('Hadim', 11628, 11628, 0, -33, 42, 577),
('Halkapınar', 3974, 3974, 0, -23, 42, 578),
('Hüyük', 15595, 15595, 0, -4, 42, 579),
('Ilgın', 54315, 54315, 0, 2, 42, 580),
('Kadınhanı', 31817, 31817, 0, -10, 42, 581),
('Karapınar', 50304, 50304, 0, 7, 42, 582),
('Karatay', 351422, 351422, 0, 36, 42, 583),
('Kulu', 51493, 51493, 0, 13, 42, 584),
('Meram', 344549, 344549, 0, 0, 42, 585),
('Sarayönü', 27542, 27542, 0, 19, 42, 586),
('Selçuklu', 663280, 663280, 0, 1, 42, 587),
('Seydişehir', 65385, 65385, 0, 9, 42, 588),
('Taşkent', 6001, 6001, 0, -48, 42, 589),
('Tuzlukçu', 6398, 6398, 0, -20, 42, 590),
('Yalıhüyük', 1573, 1573, 0, -35, 42, 591),
('Yunak', 22102, 22102, 0, 6, 42, 592),
('Merkez', 253335, 272513, 19178, 1, 43, 593),
('Altıntaş', 5322, 15835, 10513, -17, 43, 594),
('Aslanapa', 1934, 8834, 6900, -12, 43, 595),
('Çavdarhisar', 2084, 6110, 4026, -31, 43, 596),
('Domaniç', 5146, 14545, 9399, -7, 43, 597),
('Dumlupınar', 1205, 2945, 1740, 0, 43, 598),
('Emet', 11405, 19528, 8123, -17, 43, 599),
('Gediz', 24669, 49787, 25118, -10, 43, 600),
('Hisarcık', 4814, 11772, 6958, -25, 43, 601),
('Pazarlar', 2947, 4884, 1937, -41, 43, 602),
('Simav', 26436, 62237, 35801, -15, 43, 603),
('Şaphane', 2790, 5850, 3060, -30, 43, 604),
('Tavşanlı', 72723, 101848, 29125, 4, 43, 605),
('Akçadağ', 28709, 28709, 0, -12, 44, 606),
('Arapgir', 10028, 10028, 0, -24, 44, 607),
('Arguvan', 7315, 7315, 0, -42, 44, 608),
('Battalgazi', 303226, 303226, 0, -5, 44, 609),
('Darende', 25647, 25647, 0, -20, 44, 610),
('Doğanşehir', 38605, 38605, 0, -2, 44, 611),
('Doğanyol', 3932, 3932, 0, -30, 44, 612),
('Hekimhan', 16965, 16965, 0, -78, 44, 613),
('Kale', 5618, 5618, 0, -80, 44, 614),
('Kuluncak', 7513, 7513, 0, -35, 44, 615),
('Pütürge', 13663, 13663, 0, -16, 44, 616),
('Yazıhan', 13024, 13024, 0, -57, 44, 617),
('Yeşilyurt', 331911, 331911, 0, 38, 44, 618),
('Ahmetli', 16614, 16614, 0, 5, 45, 619),
('Akhisar', 174850, 174850, 0, 10, 45, 620),
('Alaşehir', 105145, 105145, 0, 5, 45, 621),
('Demirci', 39258, 39258, 0, -20, 45, 622),
('Gölmarmara', 15335, 15335, 0, 8, 45, 623),
('Gördes', 27363, 27363, 0, -12, 45, 624),
('Kırkağaç', 38245, 38245, 0, -6, 45, 625),
('Köprübaşı', 12958, 12958, 0, -17, 45, 626),
('Kula', 44035, 44035, 0, 1, 45, 627),
('Salihli', 164371, 164371, 0, 10, 45, 628),
('Sarıgöl', 35912, 35912, 0, 1, 45, 629),
('Saruhanlı', 55970, 55970, 0, 11, 45, 630),
('Selendi', 19728, 19728, 0, -7, 45, 631),
('Soma', 110935, 110935, 0, 9, 45, 632),
('Şehzadeler', 168110, 168110, 0, -18, 45, 633),
('Turgutlu', 169882, 169882, 0, 21, 45, 634),
('Yunusemre', 251905, 251905, 0, 22, 45, 635),
('Afşin', 80980, 80980, 0, 7, 46, 636),
('Andırın', 32377, 32377, 0, -4, 46, 637),
('Çağlayancerit', 23292, 23292, 0, 7, 46, 638),
('Dulkadiroğlu', 223277, 223277, 0, 3, 46, 639),
('Ekinözü', 10988, 10988, 0, -21, 46, 640),
('Elbistan', 142778, 142778, 0, 9, 46, 641),
('Göksun', 52136, 52136, 0, -2, 46, 642),
('Nurhak', 12399, 12399, 0, 10, 46, 643),
('Onikişubat', 441681, 441681, 0, 23, 46, 644),
('Pazarcık', 69686, 69686, 0, 8, 46, 645),
('Türkoğlu', 78569, 78569, 0, 19, 46, 646),
('Artuklu', 182400, 182400, 0, 24, 47, 647),
('Dargeçit', 27743, 27743, 0, 1, 47, 648),
('Derik', 62611, 62611, 0, 15, 47, 649),
('Kızıltepe', 261442, 261442, 0, 18, 47, 650),
('Mazıdağı', 36747, 36747, 0, 12, 47, 651),
('Midyat', 117364, 117364, 0, 22, 47, 652),
('Nusaybin', 111674, 111674, 0, 32, 47, 653),
('Ömerli', 14119, 14119, 0, 7, 47, 654),
('Savur', 26101, 26101, 0, -18, 47, 655),
('Yeşilli', 14515, 14515, 0, -12, 47, 656),
('Bodrum', 181541, 181541, 0, 34, 48, 657),
('Dalaman', 43036, 43036, 0, 24, 48, 658),
('Datça', 23711, 23711, 0, 57, 48, 659),
('Fethiye', 167114, 167114, 0, 27, 48, 660),
('Kavaklıdere', 10871, 10871, 0, 7, 48, 661),
('Köyceğiz', 37981, 37981, 0, 28, 48, 662),
('Marmaris', 95851, 95851, 0, 12, 48, 663),
('Menteşe', 113141, 113141, 0, -17, 48, 664),
('Milas', 143254, 143254, 0, 15, 48, 665),
('Ortaca', 51737, 51737, 0, 34, 48, 666),
('Seydikemer', 61306, 61306, 0, -6, 48, 667),
('Ula', 26058, 26058, 0, 25, 48, 668),
('Yatağan', 45172, 45172, 0, 7, 48, 669),
('Merkez', 114231, 197555, 83324, 11, 49, 670),
('Bulanık', 29528, 80570, 51042, -1, 49, 671),
('Hasköy', 14869, 26278, 11409, 3, 49, 672),
('Korkut', 3646, 24957, 21311, 5, 49, 673),
('Malazgirt', 20314, 50496, 30182, -8, 49, 674),
('Varto', 10691, 31261, 20570, 12, 49, 675),
('Merkez', 117598, 150267, 32669, 14, 50, 676),
('Acıgöl', 6042, 19362, 13320, 0, 50, 677),
('Avanos', 14361, 32932, 18571, 6, 50, 678),
('Derinkuyu', 10974, 20938, 9964, 8, 50, 679),
('Gülşehir', 12226, 21615, 9389, 7, 50, 680),
('Hacıbektaş', 5106, 10958, 5852, -31, 50, 681),
('Kozaklı', 7582, 13193, 5611, -14, 50, 682),
('Ürgüp', 23237, 35697, 12460, -3, 50, 683),
('Merkez', 161110, 230776, 69666, 7, 51, 684),
('Altunhisar', 3197, 12427, 9230, -42, 51, 685),
('Bor', 41116, 60233, 19117, -4, 51, 686),
('Çamardı', 3586, 12334, 8748, -30, 51, 687),
('Çiftlik', 4652, 26863, 22211, -19, 51, 688),
('Ulukışla', 5927, 19438, 13511, -40, 51, 689),
('Akkuş', 22118, 22118, 0, -3, 52, 690),
('Altınordu', 224100, 224100, 0, 29, 52, 691),
('Aybastı', 22326, 22326, 0, 13, 52, 692),
('Çamaş', 8643, 8643, 0, -47, 52, 693),
('Çatalpınar', 13658, 13658, 0, -11, 52, 694),
('Çaybaşı', 12398, 12398, 0, -23, 52, 695),
('Fatsa', 123008, 123008, 0, 32, 52, 696),
('Gölköy', 28084, 28084, 0, -9, 52, 697),
('Gülyalı', 8244, 8244, 0, -3, 52, 698),
('Gürgentepe', 13496, 13496, 0, -44, 52, 699),
('İkizce', 14126, 14126, 0, -31, 52, 700),
('Kabadüz', 8275, 8275, 0, 119, 52, 701),
('Kabataş', 10439, 10439, 0, -17, 52, 702),
('Korgan', 28520, 28520, 0, -3, 52, 703),
('Kumru', 29828, 29828, 0, -4, 52, 704),
('Mesudiye', 14489, 14489, 0, -149, 52, 705),
('Perşembe', 30997, 30997, 0, -17, 52, 706),
('Ulubey', 18187, 18187, 0, -67, 52, 707),
('Ünye', 130464, 130464, 0, 18, 52, 708),
('Merkez', 117321, 148735, 31414, 9, 53, 709),
('Ardeşen', 30577, 42395, 11818, 31, 53, 710),
('Çamlıhemşin', 1778, 6924, 5146, -32, 53, 711),
('Çayeli', 23860, 43801, 19941, -12, 53, 712),
('Derepazarı', 4299, 7279, 2980, -50, 53, 713),
('Fındıklı', 10977, 16850, 5873, 10, 53, 714),
('Güneysu', 6442, 15159, 8717, -28, 53, 715),
('Hemşin', 1324, 2447, 1123, -13, 53, 716),
('İkizdere', 1875, 6583, 4708, -81, 53, 717),
('İyidere', 5758, 9006, 3248, 51, 53, 718),
('Kalkandere', 6796, 13434, 6638, -20, 53, 719),
('Pazar', 17663, 31746, 14083, 11, 53, 720),
('Adapazarı', 279127, 279127, 0, 10, 54, 721),
('Akyazı', 92093, 92093, 0, 19, 54, 722),
('Arifiye', 46344, 46344, 0, 21, 54, 723),
('Erenler', 90855, 90855, 0, 19, 54, 724),
('Ferizli', 27399, 27399, 0, 2, 54, 725),
('Geyve', 50154, 50154, 0, 4, 54, 726),
('Hendek', 86612, 86612, 0, 12, 54, 727),
('Karapürçek', 13130, 13130, 0, 11, 54, 728),
('Karasu', 66852, 66852, 0, 31, 54, 729),
('Kaynarca', 24271, 24271, 0, 5, 54, 730),
('Kocaali', 22845, 22845, 0, -4, 54, 731),
('Pamukova', 29974, 29974, 0, 8, 54, 732),
('Sapanca', 43018, 43018, 0, 14, 54, 733),
('Serdivan', 148802, 148802, 0, 9, 54, 734),
('Söğütlü', 14203, 14203, 0, 8, 54, 735),
('Taraklı', 6970, 6970, 0, 5, 54, 736),
('Alaçam', 25123, 25123, 0, -12, 55, 737),
('Asarcık', 16706, 16706, 0, -4, 55, 738),
('Atakum', 221082, 221082, 0, 25, 55, 739),
('Ayvacık', 19843, 19843, 0, -30, 55, 740),
('Bafra', 143443, 143443, 0, 5, 55, 741),
('Canik', 101253, 101253, 0, 21, 55, 742),
('Çarşamba', 140245, 140245, 0, 12, 55, 743),
('Havza', 39221, 39221, 0, -11, 55, 744),
('İlkadım', 336501, 336501, 0, -6, 55, 745),
('Kavak', 21154, 21154, 0, 4, 55, 746),
('Ladik', 16391, 16391, 0, 1, 55, 747),
('19 Mayıs', 26044, 26044, 0, 6, 55, 748),
('Salıpazarı', 19709, 19709, 0, -14, 55, 749),
('Tekkeköy', 54363, 54363, 0, 27, 55, 750),
('Terme', 71938, 71938, 0, 6, 55, 751),
('Vezirköprü', 94360, 94360, 0, -8, 55, 752),
('Yakakent', 8703, 8703, 0, 2, 55, 753),
('Merkez', 157714, 169615, 11901, 6, 56, 754),
('Baykan', 5695, 25273, 19578, 0, 56, 755),
('Eruh', 8998, 18387, 9389, -29, 56, 756),
('Kurtalan', 35914, 60737, 24823, 9, 56, 757),
('Pervari', 6218, 30816, 24598, -1, 56, 758),
('Şirvan', 4054, 22003, 17949, -5, 56, 759),
('Tillo', 2219, 4239, 2020, -5, 56, 760),
('Merkez', 53813, 65489, 11676, -5, 57, 761),
('Ayancık', 13121, 23734, 10613, 2, 57, 762),
('Boyabat', 28691, 44443, 15752, 0, 57, 763),
('Dikmen', 1273, 4860, 3587, -32, 57, 764),
('Durağan', 7947, 17861, 9914, -104, 57, 765),
('Erfelek', 3905, 12024, 8119, 8, 57, 766),
('Gerze', 17605, 26191, 8586, 34, 57, 767),
('Saraydüzü', 1806, 5885, 4079, -74, 57, 768),
('Türkeli', 6296, 15973, 9677, 7, 57, 769),
('Merkez', 355570, 382520, 26950, 3, 58, 770),
('Akıncılar', 2598, 5067, 2469, -50, 58, 771),
('Altınyayla', 4513, 8989, 4476, -2, 58, 772),
('Divriği', 10623, 16195, 5572, -3, 58, 773),
('Doğanşar', 1289, 2780, 1491, -22, 58, 774),
('Gemerek', 10587, 22342, 11755, -22, 58, 775),
('Gölova', 1226, 3478, 2252, -52, 58, 776),
('Gürün', 11134, 18700, 7566, -4, 58, 777),
('Hafik', 3175, 9359, 6184, -48, 58, 778),
('İmranlı', 2896, 7412, 4516, -34, 58, 779),
('Kangal', 9279, 20760, 11481, -24, 58, 780),
('Koyulhisar', 4250, 12637, 8387, -23, 58, 781),
('Suşehri', 15418, 25392, 9974, 9, 58, 782),
('Şarkışla', 23834, 38314, 14480, -2, 58, 783),
('Ulaş', 3151, 8443, 5292, -49, 58, 784),
('Yıldızeli', 6830, 31748, 24918, -33, 58, 785),
('Zara', 11558, 21753, 10195, -12, 58, 786),
('Çerkezköy', 185234, 185234, 0, 60, 59, 787),
('Çorlu', 279251, 279251, 0, 30, 59, 788),
('Ergene', 64820, 64820, 0, 16, 59, 789),
('Hayrabolu', 31574, 31574, 0, -22, 59, 790),
('Kapaklı', 124609, 124609, 0, 34, 59, 791),
('Malkara', 52101, 52101, 0, -7, 59, 792),
('Marmaraereğlisi', 27061, 27061, 0, 40, 59, 793),
('Muratlı', 29892, 29892, 0, 29, 59, 794),
('Saray', 50248, 50248, 0, 13, 59, 795),
('Süleymanpaşa', 203617, 203617, 0, -2, 59, 796),
('Şarköy', 32658, 32658, 0, 12, 59, 797),
('Merkez', 158722, 203395, 44673, 18, 60, 798),
('Almus', 5159, 23825, 18666, -149, 60, 799),
('Artova', 4134, 8132, 3998, -29, 60, 800),
('Başçiftlik', 3027, 5530, 2503, -409, 60, 801),
('Erbaa', 70030, 98342, 28312, 28, 60, 802),
('Niksar', 36321, 61119, 24798, -66, 60, 803),
('Pazar', 4663, 13209, 8546, -9, 60, 804),
('Reşadiye', 9996, 34211, 24215, -249, 60, 805),
('Sulusaray', 4644, 7083, 2439, -70, 60, 806),
('Turhal', 63133, 79776, 16643, 2, 60, 807),
('Yeşilyurt', 5649, 8871, 3222, -11, 60, 808),
('Zile', 33513, 54368, 20855, 1, 60, 809),
('Akçaabat', 127331, 127331, 0, 12, 61, 810),
('Araklı', 48734, 48734, 0, 2, 61, 811),
('Arsin', 31525, 31525, 0, -17, 61, 812),
('Beşikdüzü', 23713, 23713, 0, 16, 61, 813),
('Çarşıbaşı', 15586, 15586, 0, 2, 61, 814),
('Çaykara', 13890, 13890, 0, -35, 61, 815),
('Dernekpazarı', 3948, 3948, 0, -10, 61, 816),
('Düzköy', 13815, 13815, 0, -7, 61, 817),
('Hayrat', 7883, 7883, 0, -74, 61, 818),
('Köprübaşı', 4652, 4652, 0, -42, 61, 819),
('Maçka', 24893, 24893, 0, -19, 61, 820),
('Of', 43754, 43754, 0, 15, 61, 821),
('Ortahisar', 330373, 330373, 0, 6, 61, 822),
('Sürmene', 26391, 26391, 0, -16, 61, 823),
('Şalpazarı', 10846, 10846, 0, -15, 61, 824),
('Tonya', 13914, 13914, 0, -14, 61, 825),
('Vakfıkebir', 27332, 27332, 0, -7, 61, 826),
('Yomra', 43321, 43321, 0, 43, 61, 827),
('Merkez', 33873, 38429, 4556, 0, 62, 828),
('Çemişgezek', 3037, 7602, 4565, -36, 62, 829),
('Hozat', 3717, 5761, 2044, -82, 62, 830),
('Mazgirt', 1347, 7560, 6213, -28, 62, 831),
('Nazımiye', 1336, 3142, 1806, -15, 62, 832),
('Ovacık', 3029, 6533, 3504, -25, 62, 833),
('Pertek', 6237, 11065, 4828, 0, 62, 834),
('Pülümür', 1343, 3351, 2008, -7, 62, 835),
('Akçakale', 118426, 118426, 0, 24, 63, 836),
('Birecik', 95683, 95683, 0, 6, 63, 837),
('Bozova', 54872, 54872, 0, -10, 63, 838),
('Ceylanpınar', 89826, 89826, 0, 9, 63, 839),
('Eyyübiye', 382974, 382974, 0, 8, 63, 840),
('Halfeti', 41258, 41258, 0, 9, 63, 841),
('Haliliye', 385881, 385881, 0, 10, 63, 842),
('Harran', 92549, 92549, 0, 30, 63, 843),
('Hilvan', 43216, 43216, 0, 11, 63, 844),
('Karaköprü', 237158, 237158, 0, 76, 63, 845),
('Siverek', 266369, 266369, 0, 20, 63, 846),
('Suruç', 102944, 102944, 0, 7, 63, 847),
('Viranşehir', 204100, 204100, 0, 19, 63, 848),
('Merkez', 228881, 256050, 27169, -2, 64, 849),
('Banaz', 16447, 35647, 19200, -4, 64, 850),
('Eşme', 15475, 34991, 19516, 3, 64, 851),
('Karahallı', 5729, 10046, 4317, -9, 64, 852),
('Sivaslı', 7093, 20349, 13256, -2, 64, 853),
('Ulubey', 6260, 12350, 6090, -24, 64, 854),
('Bahçesaray', 14379, 14379, 0, -22, 65, 855),
('Başkale', 49850, 49850, 0, 21, 65, 856),
('Çaldıran', 63133, 63133, 0, 10, 65, 857),
('Çatak', 20337, 20337, 0, -12, 65, 858),
('Edremit', 128557, 128557, 0, 8, 65, 859),
('Erciş', 176680, 176680, 0, 9, 65, 860),
('Gevaş', 28242, 28242, 0, 0, 65, 861),
('Gürpınar', 34956, 34956, 0, 16, 65, 862),
('İpekyolu', 334470, 334470, 0, 26, 65, 863),
('Muradiye', 50247, 50247, 0, 1, 65, 864),
('Özalp', 65495, 65495, 0, 3, 65, 865),
('Saray', 20843, 20843, 0, 17, 65, 866),
('Tuşba', 162153, 162153, 0, -4, 65, 867),
('Merkez', 90206, 104079, 13873, -21, 66, 868),
('Akdağmadeni', 22130, 42407, 20277, -5, 66, 869),
('Aydıncık', 3022, 9967, 6945, -11, 66, 870),
('Boğazlıyan', 18332, 34019, 15687, -7, 66, 871),
('Çandır', 3561, 4381, 820, -16, 66, 872),
('Çayıralan', 5320, 12457, 7137, -8, 66, 873),
('Çekerek', 9968, 19415, 9447, -3, 66, 874),
('Kadışehri', 4691, 10768, 6077, -46, 66, 875),
('Saraykent', 5873, 12651, 6778, 13, 66, 876),
('Sarıkaya', 18375, 32714, 14339, 7, 66, 877),
('Sorgun', 54743, 80525, 25782, 12, 66, 878),
('Şefaatli', 9032, 14749, 5717, -5, 66, 879),
('Yenifakılı', 2757, 5396, 2639, 2, 66, 880),
('Yerköy', 27925, 35567, 7642, 3, 66, 881),
('Merkez', 103417, 121157, 17740, -23, 67, 882),
('Alaplı', 20370, 43540, 23170, -7, 67, 883),
('Çaycuma', 27847, 90897, 63050, 4, 67, 884),
('Devrek', 26610, 57161, 30551, -7, 67, 885),
('Ereğli', 121237, 176642, 55405, 6, 67, 886),
('Gökçebey', 8265, 20996, 12731, -5, 67, 887),
('Kilimli', 20181, 34150, 13969, -20, 67, 888),
('Kozlu', 39831, 46661, 6830, -39, 67, 889),
('Merkez', 239002, 308393, 69391, 22, 68, 890),
('Ağaçören', 2899, 7827, 4928, -18, 68, 891),
('Eskil', 17955, 27238, 9283, 29, 68, 892),
('Gülağaç', 4793, 19644, 14851, 1, 68, 893),
('Güzelyurt', 2581, 10967, 8386, -23, 68, 894),
('Ortaköy', 20411, 32322, 11911, -10, 68, 895),
('Sarıyahşi', 3566, 5246, 1680, -76, 68, 896),
('Sultanhanı', 10690, 11374, 684, 20, 68, 897),
('Merkez', 43590, 66628, 23038, -32, 69, 898),
('Aydıntepe', 3240, 6434, 3194, -59, 69, 899),
('Demirözü', 3593, 8848, 5255, -44, 69, 900),
('Merkez', 168299, 199482, 31183, 11, 70, 901),
('Ayrancı', 2385, 7946, 5561, -2, 70, 902),
('Başyayla', 1973, 3608, 1635, -12, 70, 903),
('Ermenek', 11438, 28417, 16979, -5, 70, 904),
('Kazımkarabekir', 2890, 3956, 1066, -90, 70, 905),
('Sarıveliler', 5329, 11510, 6181, 1, 70, 906),
('Merkez', 191709, 199032, 7323, 3, 71, 907),
('Bahşılı', 6004, 7279, 1275, -16, 71, 908),
('Balışeyh', 2207, 6181, 3974, -47, 71, 909),
('Çelebi', 805, 2471, 1666, -64, 71, 910),
('Delice', 2280, 8532, 6252, -62, 71, 911),
('Karakeçili', 2990, 3277, 287, -28, 71, 912),
('Keskin', 9423, 16239, 6816, -82, 71, 913),
('Sulakyurt', 2115, 6513, 4398, -65, 71, 914),
('Yahşihan', 26473, 29179, 2706, -61, 71, 915),
('Merkez', 445874, 471498, 25624, 23, 72, 916),
('Beşiri', 9901, 29962, 20061, 10, 72, 917),
('Gercüş', 6093, 19660, 13567, -12, 72, 918),
('Hasankeyf', 4055, 7284, 3229, 60, 72, 919),
('Kozluk', 27299, 61100, 33801, 12, 72, 920),
('Sason', 12627, 30774, 18147, -4, 72, 921),
('Merkez', 64185, 96285, 32100, 24, 73, 922),
('Beytüşşebap', 5690, 16317, 10627, -1, 73, 923),
('Cizre', 128412, 151699, 23287, 20, 73, 924),
('Güçlükonak', 4386, 12139, 7753, -13, 73, 925),
('İdil', 29787, 76993, 47206, 1, 73, 926),
('Silopi', 101207, 138814, 37607, 15, 73, 927),
('Uludere', 9634, 45515, 35881, 19, 73, 928),
('Merkez', 77809, 156551, 78742, 5, 74, 929),
('Amasra', 6146, 14262, 8116, 8, 74, 930),
('Kurucaşile', 2067, 6475, 4408, -22, 74, 931),
('Ulus', 3857, 21691, 17834, -1, 74, 932),
('Merkez', 22190, 41658, 19468, -17, 75, 933),
('Çıldır', 2631, 9247, 6616, -10, 75, 934),
('Damal', 2891, 5172, 2281, -31, 75, 935),
('Göle', 5986, 24822, 18836, -2, 75, 936),
('Hanak', 2967, 8683, 5716, -11, 75, 937),
('Posof', 2074, 6579, 4505, -8, 75, 938),
('Merkez', 96887, 142559, 45672, 16, 76, 939),
('Aralık', 6313, 21097, 14784, -10, 76, 940),
('Karakoyunlu', 2740, 13908, 11168, -1, 76, 941),
('Tuzluca', 9472, 23750, 14278, -8, 76, 942),
('Merkez', 128933, 149330, 20397, 2, 77, 943),
('Altınova', 8217, 30780, 22563, 51, 77, 944),
('Armutlu', 7265, 9901, 2636, 37, 77, 945),
('Çınarcık', 18428, 34699, 16271, 10, 77, 946),
('Çiftlikköy', 37618, 44808, 7190, 68, 77, 947),
('Termal', 3167, 6532, 3365, -55, 77, 948),
('Merkez', 119226, 131186, 11960, -18, 78, 949),
('Eflani', 2110, 8576, 6466, -28, 78, 950),
('Eskipazar', 6419, 12586, 6167, -32, 78, 951),
('Ovacık', 569, 3905, 3336, -90, 78, 952),
('Safranbolu', 51904, 67245, 15341, -18, 78, 953),
('Yenice', 9306, 20116, 10810, -10, 78, 954),
('Merkez', 105218, 118725, 13507, 6, 79, 955),
('Elbeyli', 2034, 5841, 3807, -25, 79, 956),
('Musabeyli', 1190, 13123, 11933, -16, 79, 957),
('Polateli', 1124, 5103, 3979, -7, 79, 958),
('Merkez', 243490, 274420, 30930, 21, 80, 959),
('Bahçe', 15673, 22683, 7010, 24, 80, 960),
('Düziçi', 55233, 85499, 30266, 16, 80, 961),
('Hasanbeyli', 2541, 4780, 2239, 0, 80, 962),
('Kadirli', 97729, 127416, 29687, 18, 80, 963),
('Sumbas', 2038, 13722, 11684, -9, 80, 964),
('Toprakkale', 11100, 20036, 8936, -4, 80, 965),
('Merkez', 184040, 249695, 65655, 9, 81, 966),
('Akçakoca', 27245, 39229, 11984, 15, 81, 967),
('Cumayeri', 10630, 15002, 4372, 24, 81, 968),
('Çilimli', 10078, 19902, 9824, -4, 81, 969),
('Gölyaka', 10228, 20408, 10180, 11, 81, 970),
('Gümüşova', 8579, 16254, 7675, 26, 81, 971),
('Kaynaşlı', 9867, 20545, 10678, 4, 81, 972),
('Yığılca', 3061, 14644, 11583, -25, 81, 973);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `il_nufus_1`
--

DROP TABLE IF EXISTS `il_nufus_1`;
CREATE TABLE IF NOT EXISTS `il_nufus_1` (
  `iller` varchar(14) COLLATE utf8_turkish_ci DEFAULT NULL,
  `il_id` int(2) NOT NULL,
  `top_nuf_il` varchar(8) COLLATE utf8_turkish_ci DEFAULT NULL,
  `il_mer_nuf` varchar(8) COLLATE utf8_turkish_ci DEFAULT NULL,
  `bel_koy_nuf_il` varchar(6) COLLATE utf8_turkish_ci DEFAULT NULL,
  `nuf_art_hiz_il` varchar(4) COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`il_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `il_nufus_1`
--

INSERT INTO `il_nufus_1` (`iller`, `il_id`, `top_nuf_il`, `il_mer_nuf`, `bel_koy_nuf_il`, `nuf_art_hiz_il`) VALUES
('Adana', 1, '2258718', '2258718', '0', '9'),
('Adıyaman', 2, '632459', '441165', '191294', '10'),
('Afyonkarahisar', 3, '736912', '444452', '292460', '10'),
('Ağrı', 4, '535435', '310896', '224539', '-1'),
('Amasya', 5, '335494', '245236', '90258', '-7'),
('Ankara', 6, '5663322', '5663322', '0', '4'),
('Antalya', 7, '2548308', '2548308', '0', '14'),
('Artvin', 8, '169501', '106858', '62643', '-8'),
('Aydın', 9, '1119084', '1119084', '0', '7'),
('Balıkesir', 10, '1240285', '1240285', '0', '9'),
('Bilecik', 11, '218717', '178781', '39936', '-3'),
('Bingöl', 12, '281768', '183613', '98155', '7'),
('Bitlis', 13, '350994', '210118', '140876', '8'),
('Bolu', 14, '314802', '227724', '87078', '-4'),
('Burdur', 15, '267092', '183404', '83688', '-14'),
('Bursa', 16, '3101833', '3101833', '0', '15'),
('Çanakkale', 17, '541548', '329202', '212346', '-1'),
('Çankırı', 18, '192428', '134666', '57762', '-17'),
('Çorum', 19, '530126', '394250', '135876', '-1'),
('Denizli', 20, '1040915', '1040915', '0', '4'),
('Diyarbakır', 21, '1783431', '1783431', '0', '15'),
('Edirne', 22, '407763', '301887', '105876', '-15'),
('Elazığ', 23, '587960', '455220', '132740', '-5'),
('Erzincan', 24, '234431', '179972', '54459', '-1'),
('Erzurum', 25, '758279', '758279', '0', '-5'),
('Eskişehir', 26, '888828', '888828', '0', '2'),
('Gaziantep', 27, '2101157', '2101157', '0', '15'),
('Giresun', 28, '448721', '302259', '146462', '1'),
('Gümüşhane', 29, '141702', '83871', '57831', '-149'),
('Hakkari', 30, '280514', '166101', '114413', '19'),
('Hatay', 31, '1659320', '1659320', '0', '19'),
('Isparta', 32, '440304', '324279', '116025', '-10'),
('Mersin', 33, '1868757', '1868757', '0', '15'),
('İstanbul', 34, '15462452', '15462452', '0', '-4'),
('İzmir', 35, '4394694', '4394694', '0', '6'),
('Kars', 36, '284923', '141389', '143534', '-2'),
('Kastamonu', 37, '376377', '238902', '137475', '-8'),
('Kayseri', 38, '1421455', '1421455', '0', '10'),
('Kırklareli', 39, '361737', '262853', '98884', '0'),
('Kırşehir', 40, '243042', '193470', '49572', '0'),
('Kocaeli', 41, '1997258', '1997258', '0', '22'),
('Konya', 42, '2250020', '2250020', '0', '8'),
('Kütahya', 43, '576688', '414810', '161878', '-4'),
('Malatya', 44, '806156', '806156', '0', '7'),
('Manisa', 45, '1450616', '1450616', '0', '7'),
('Kahramanmaraş', 46, '1168163', '1168163', '0', '12'),
('Mardin', 47, '854716', '854716', '0', '19'),
('Muğla', 48, '1000773', '1000773', '0', '18'),
('Muş', 49, '411117', '193279', '217838', '6'),
('Nevşehir', 50, '304962', '197126', '107836', '6'),
('Niğde', 51, '362071', '219588', '142483', '-2'),
('Ordu', 52, '761400', '761400', '0', '10'),
('Rize', 53, '344359', '228670', '115689', '3'),
('Sakarya', 54, '1042649', '1042649', '0', '13'),
('Samsun', 55, '1356079', '1356079', '0', '6'),
('Siirt', 56, '331070', '220812', '110258', '2'),
('Sinop', 57, '216460', '134457', '82003', '-8'),
('Sivas', 58, '635889', '477931', '157958', '-5'),
('Tekirdağ', 59, '1081065', '1081065', '0', '24'),
('Tokat', 60, '597861', '398991', '198870', '-25'),
('Trabzon', 61, '811901', '811901', '0', '4'),
('Tunceli', 62, '83443', '53919', '29524', '-14'),
('Şanlıurfa', 63, '2115256', '2115256', '0', '20'),
('Uşak', 64, '369433', '279885', '89548', '-3'),
('Van', 65, '1149342', '1149342', '0', '11'),
('Yozgat', 66, '419095', '275935', '143160', '-5'),
('Zonguldak', 67, '591204', '367758', '223446', '-8'),
('Aksaray', 68, '423011', '301897', '121114', '16'),
('Bayburt', 69, '81910', '50423', '31487', '-35'),
('Karaman', 70, '254919', '192314', '62605', '6'),
('Kırıkkale', 71, '278703', '244006', '34697', '-15'),
('Batman', 72, '620278', '505849', '114429', '19'),
('Şırnak', 73, '537762', '343301', '194461', '15'),
('Bartın', 74, '198979', '89879', '109100', '4'),
('Ardahan', 75, '96161', '38739', '57422', '-12'),
('Iğdır', 76, '201314', '115412', '85902', '9'),
('Yalova', 77, '276050', '203628', '72422', '19'),
('Karabük', 78, '243614', '189534', '54080', '-20'),
('Kilis', 79, '142792', '109566', '33226', '2'),
('Osmaniye', 80, '548556', '427804', '120752', '18'),
('Düzce', 81, '395679', '263728', '131951', '9');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanici`
--

DROP TABLE IF EXISTS `kullanici`;
CREATE TABLE IF NOT EXISTS `kullanici` (
  `kullanici_id` int(3) NOT NULL,
  `kullanici_adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici_soyadi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici_yetki_ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici_yetki_id` int(6) NOT NULL,
  `sifre` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  PRIMARY KEY (`kullanici_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kullanici`
--

INSERT INTO `kullanici` (`kullanici_id`, `kullanici_adi`, `kullanici_soyadi`, `kullanici_yetki_ad`, `kullanici_yetki_id`, `sifre`, `email`) VALUES
(1, 'Hh', 'TT', 'ÜST DÜZEY YÖNETİCİ', 1, '1a', 'Hh@duzey.ust.bel.tr'),
(3, 'Hill', 'TRK', 'ORTA DÜZEY YÖNETİCİ', 2, 'fff', '@duzey.orta.bel.tr'),
(4, 'Hilal', 'HTHT', 'ÜST DÜZEY YÜNETİCİ', 1, 'hsks', '@duzey.ust.bel.tr'),
(5, 'Admin', 'ADMİN', 'ÜST DÜZEY YÖNETİCİ', 1, 'rerwq', '@duzey.ust.bel.tr');

--
-- Tetikleyiciler `kullanici`
--
DROP TRIGGER IF EXISTS `durum`;
DELIMITER $$
CREATE TRIGGER `durum` AFTER INSERT ON `kullanici` FOR EACH ROW INSERT INTO log_kullanici VALUES(new.kullanici_id,now(),(CONCAT(new.kullanici_adi,' ',new.kullanici_soyadi, ' yeni kullanici eklendi.')))
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `guncel_kullanici`;
DELIMITER $$
CREATE TRIGGER `guncel_kullanici` AFTER INSERT ON `kullanici` FOR EACH ROW INSERT INTO guncel_kullanici_sayisi VALUES ((SELECT COUNT(*) from kullanici), now())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `kullanici_isim`;
DELIMITER $$
CREATE TRIGGER `kullanici_isim` BEFORE INSERT ON `kullanici` FOR EACH ROW SET new.kullanici_adi=
concat(upper(substring(new.kullanici_adi,1,1)),lower(substring(new.kullanici_adi,2))), new.kullanici_soyadi=Upper(new.kullanici_soyadi),new.kullanici_yetki_ad=Upper(new.kullanici_yetki_ad)
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `silinen_kullanici`;
DELIMITER $$
CREATE TRIGGER `silinen_kullanici` AFTER DELETE ON `kullanici` FOR EACH ROW INSERT INTO silinen_kullanici VALUES(old.kullanici_adi, old.kullanici_soyadi, old.kullanici_yetki_ad,now())
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `silinen_kullanici_sonrasi_guncel`;
DELIMITER $$
CREATE TRIGGER `silinen_kullanici_sonrasi_guncel` AFTER DELETE ON `kullanici` FOR EACH ROW INSERT INTO guncel_kullanici_sayisi VALUES ((SELECT COUNT(*) from kullanici), now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `log_kullanici`
--

DROP TABLE IF EXISTS `log_kullanici`;
CREATE TABLE IF NOT EXISTS `log_kullanici` (
  `kullanici_id` int(3) NOT NULL,
  `tarih` datetime NOT NULL,
  `durum` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`kullanici_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `log_kullanici`
--

INSERT INTO `log_kullanici` (`kullanici_id`, `tarih`, `durum`) VALUES
(3, '2022-01-03 02:28:03', 'Hill TRK yeni kullanici eklendi.'),
(4, '2022-01-03 11:05:14', 'Hilal HTHT yeni kullanici eklendi.'),
(5, '2022-01-03 20:49:49', 'Admin ADMİN yeni kullanici eklendi.');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `memnuniyett`
--

DROP TABLE IF EXISTS `memnuniyett`;
CREATE TABLE IF NOT EXISTS `memnuniyett` (
  `iller` varchar(14) COLLATE utf8_turkish_ci DEFAULT NULL,
  `kanmem` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `kanorta` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `kanmdeg` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `kanfyok` varchar(1) COLLATE utf8_turkish_ci DEFAULT NULL,
  `kanhyok` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `sebmem` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `seborta` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `sebmdeg` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `sebfyok` varchar(1) COLLATE utf8_turkish_ci DEFAULT NULL,
  `sebhyok` varchar(2) COLLATE utf8_turkish_ci DEFAULT NULL,
  `il_id` int(2) NOT NULL,
  PRIMARY KEY (`il_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `memnuniyett`
--

INSERT INTO `memnuniyett` (`iller`, `kanmem`, `kanorta`, `kanmdeg`, `kanfyok`, `kanhyok`, `sebmem`, `seborta`, `sebmdeg`, `sebfyok`, `sebhyok`, `il_id`) VALUES
('Adana', '58', '11', '28', '1', '2', '68', '11', '20', '0', '0', 1),
('Adıyaman', '37', '13', '50', '1', '0', '42', '13', '44', '0', '0', 2),
('Afyonkarahisar', '76', '4', '15', '1', '4', '77', '4', '17', '1', '1', 3),
('Ağrı', '44', '10', '35', '1', '10', '42', '12', '41', '1', '3', 4),
('Amasya', '80', '5', '12', '1', '2', '74', '6', '18', '0', '1', 5),
('Ankara', '73', '6', '17', '4', '1', '74', '7', '17', '2', '0', 6),
('Antalya', '58', '5', '14', '5', '17', '66', '8', '25', '1', '0', 7),
('Artvin', '70', '5', '17', '1', '6', '66', '5', '24', '1', '3', 8),
('Aydın', '71', '6', '12', '3', '9', '77', '6', '16', '1', '0', 9),
('Balıkesir', '72', '9', '18', '1', '0', '74', '8', '16', '0', '2', 10),
('Bilecik', '80', '5', '13', '2', '0', '77', '5', '17', '0', '0', 11),
('Bingöl', '51', '10', '32', '4', '3', '43', '11', '46', '0', '0', 12),
('Bitlis', '54', '10', '32', '2', '2', '48', '10', '42', '0', '0', 13),
('Bolu', '79', '8', '8', '4', '0', '75', '9', '14', '1', '0', 14),
('Burdur', '73', '4', '11', '4', '7', '63', '7', '30', '0', '0', 15),
('Bursa', '73', '6', '18', '2', '0', '78', '6', '15', '1', '0', 16),
('Çanakkale', '67', '14', '17', '1', '2', '65', '16', '18', '0', '0', 17),
('Çankırı', '64', '10', '23', '3', '0', '62', '11', '27', '0', '0', 18),
('Çorum', '82', '7', '9', '1', '1', '65', '12', '22', '1', '0', 19),
('Denizli', '73', '6', '9', '3', '8', '81', '7', '11', '1', '0', 20),
('Diyarbakır', '63', '7', '20', '4', '5', '71', '6', '17', '2', '4', 21),
('Edirne', '74', '7', '14', '2', '2', '72', '8', '18', '1', '1', 22),
('Elazığ', '52', '8', '31', '5', '4', '46', '9', '42', '2', '1', 23),
('Erzincan', '69', '5', '20', '2', '4', '70', '7', '22', '1', '0', 24),
('Erzurum', '60', '7', '26', '4', '2', '37', '6', '53', '1', '2', 25),
('Eskişehir', '81', '5', '7', '3', '3', '72', '4', '20', '4', '0', 26),
('Gaziantep', '77', '5', '15', '3', '0', '78', '5', '16', '1', '0', 27),
('Giresun', '59', '8', '12', '1', '20', '65', '7', '13', '1', '14', 28),
('Gümüşhane', '65', '6', '22', '4', '2', '60', '12', '25', '0', '3', 29),
('Hakkari', '29', '6', '43', '0', '22', '31', '9', '53', '1', '7', 30),
('Hatay', '55', '6', '17', '3', '20', '59', '10', '29', '1', '1', 31),
('Isparta', '78', '5', '12', '3', '1', '75', '7', '16', '2', '0', 32),
('Mersin', '60', '7', '20', '1', '12', '72', '8', '19', '1', '1', 33),
('İstanbul', '81', '6', '10', '3', '0', '87', '5', '7', '1', '0', 34),
('İzmir', '64', '9', '24', '2', '0', '66', '10', '23', '1', '0', 35),
('Kars', '46', '9', '32', '2', '10', '48', '8', '42', '1', '1', 36),
('Kastamonu', '83', '6', '8', '2', '2', '79', '7', '12', '1', '1', 37),
('Kayseri', '75', '6', '15', '2', '2', '73', '7', '19', '1', '0', 38),
('Kırklareli', '75', '6', '17', '2', '0', '70', '7', '22', '1', '0', 39),
('Kırşehir', '76', '7', '11', '2', '4', '73', '8', '18', '1', '0', 40),
('Kocaeli', '72', '11', '15', '1', '1', '79', '10', '10', '0', '0', 41),
('Konya', '77', '4', '10', '1', '8', '84', '5', '11', '0', '0', 42),
('Kütahya', '64', '9', '25', '3', '0', '62', '10', '27', '2', '0', 43),
('Malatya', '66', '8', '21', '3', '2', '67', '9', '23', '1', '0', 44),
('Manisa', '80', '7', '11', '0', '1', '79', '8', '12', '0', '1', 45),
('Kahramanmaraş', '57', '11', '26', '1', '5', '62', '12', '24', '0', '3', 46),
('Mardin', '53', '10', '30', '4', '3', '52', '12', '32', '2', '1', 47),
('Muğla', '56', '6', '15', '3', '20', '75', '8', '16', '1', '0', 48),
('Muş', '45', '7', '27', '3', '18', '45', '9', '43', '1', '2', 49),
('Nevşehir', '75', '5', '15', '2', '3', '66', '7', '26', '1', '0', 50),
('Niğde', '66', '10', '15', '3', '6', '67', '9', '21', '2', '0', 51),
('Ordu', '49', '6', '17', '3', '25', '53', '9', '19', '2', '18', 52),
('Rize', '66', '7', '13', '3', '11', '65', '7', '14', '1', '12', 53),
('Sakarya', '60', '10', '21', '0', '9', '71', '12', '15', '0', '1', 54),
('Samsun', '62', '7', '20', '2', '9', '68', '7', '19', '1', '5', 55),
('Siirt', '55', '9', '33', '4', '0', '58', '8', '31', '2', '0', 56),
('Sinop', '68', '8', '18', '3', '2', '68', '8', '21', '2', '1', 57),
('Sivas', '80', '5', '11', '1', '2', '70', '6', '24', '0', '0', 58),
('Tekirdağ', '73', '7', '17', '2', '1', '67', '8', '24', '1', '0', 59),
('Tokat', '64', '7', '25', '4', '0', '61', '8', '30', '1', '1', 60),
('Trabzon', '62', '7', '18', '3', '9', '68', '9', '17', '1', '5', 61),
('Tunceli', '61', '7', '20', '4', '8', '67', '9', '22', '1', '0', 62),
('Şanlıurfa', '71', '5', '15', '3', '6', '72', '5', '15', '2', '6', 63),
('Uşak', '79', '6', '13', '2', '1', '79', '7', '12', '1', '0', 64),
('Van', '66', '7', '18', '1', '8', '52', '9', '37', '0', '2', 65),
('Yozgat', '75', '4', '14', '5', '1', '71', '6', '21', '2', '0', 66),
('Zonguldak', '58', '10', '26', '4', '2', '65', '10', '24', '1', '1', 67),
('Aksaray', '63', '5', '15', '3', '14', '44', '9', '46', '0', '0', 68),
('Bayburt', '59', '11', '28', '2', '0', '44', '9', '45', '2', '0', 69),
('Karaman', '77', '3', '7', '1', '12', '76', '4', '20', '0', '0', 70),
('Kırıkkale', '69', '7', '22', '2', '1', '53', '7', '39', '1', '0', 71),
('Batman', '59', '13', '19', '3', '6', '62', '11', '22', '1', '4', 72),
('Şırnak', '51', '13', '32', '2', '2', '53', '12', '31', '2', '2', 73),
('Bartın', '76', '6', '12', '2', '4', '64', '8', '25', '1', '2', 74),
('Ardahan', '46', '7', '36', '0', '11', '46', '7', '45', '0', '2', 75),
('Iğdır', '33', '9', '40', '1', '17', '33', '10', '49', '1', '7', 76),
('Yalova', '73', '11', '14', '1', '2', '76', '10', '11', '0', '2', 77),
('Karabük', '81', '5', '8', '5', '1', '71', '10', '19', '1', '0', 78),
('Kilis', '41', '6', '44', '8', '0', '42', '10', '46', '7', '1', 79),
('Osmaniye', '70', '4', '16', '4', '6', '84', '10', '10', '0', '0', 80),
('Düzce', '50', '12', '36', '1', '0', '47', '10', '40', '1', '0', 81);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `miktar_aritilan`
--

DROP TABLE IF EXISTS `miktar_aritilan`;
CREATE TABLE IF NOT EXISTS `miktar_aritilan` (
  `yilll` int(4) NOT NULL,
  `arit_top` int(7) DEFAULT NULL,
  `arit_de` int(7) DEFAULT NULL,
  `arit_gol` int(5) DEFAULT NULL,
  `arit_ak` int(7) DEFAULT NULL,
  `arit_ba` int(6) DEFAULT NULL,
  `arit_ar` int(5) DEFAULT NULL,
  `arit_dig` int(6) DEFAULT NULL,
  PRIMARY KEY (`yilll`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `miktar_aritilan`
--

INSERT INTO `miktar_aritilan` (`yilll`, `arit_top`, `arit_de`, `arit_gol`, `arit_ak`, `arit_ba`, `arit_ar`, `arit_dig`) VALUES
(1994, 150061, 87156, 3515, 47871, 9784, 1734, 0),
(1995, 169287, 89879, 10154, 56983, 10238, 2033, 0),
(1996, 201902, 103519, 16079, 66885, 13777, 1643, 0),
(1997, 365719, 186406, 20556, 143151, 13445, 2161, 0),
(1998, 589515, 282319, 18165, 273213, 13347, 2472, 0),
(2001, 1193975, 658594, 19276, 461237, 22922, 7973, 23973),
(2002, 1312380, 709816, 23634, 514165, 23849, 5834, 35082),
(2003, 1586551, 892638, 24880, 618694, 22613, 6081, 21645),
(2004, 1901040, 1003736, 25283, 713395, 52563, 6420, 99642),
(2006, 2140494, 1215440, 28166, 705561, 84015, 12011, 95301),
(2008, 2251581, 1231880, 48295, 778293, 84375, 14108, 94631),
(2010, 2719151, 1347977, 37881, 1180630, 83409, 9166, 60088),
(2012, 3260396, 1718588, 36748, 1276456, 63296, 8999, 156309),
(2014, 3483846, 1759461, 47893, 1409633, 61843, 8367, 196649),
(2016, 3842350, 1724792, 53262, 1728000, 76660, 14036, 245601),
(2018, 4236419, 1883205, 53363, 1911078, 104292, 13173, 271307);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ortam_atiksu_mik`
--

DROP TABLE IF EXISTS `ortam_atiksu_mik`;
CREATE TABLE IF NOT EXISTS `ortam_atiksu_mik` (
  `ortam_atiksu` varchar(9) COLLATE utf8_turkish_ci DEFAULT NULL,
  `atiksu_deniz` int(7) DEFAULT NULL,
  `atiksu_gol_golet` int(5) DEFAULT NULL,
  `atiksu_ak` int(7) DEFAULT NULL,
  `atiksu_ara` int(6) DEFAULT NULL,
  `atiksu_bar` int(6) DEFAULT NULL,
  `atiksu_dig` varchar(7) COLLATE utf8_turkish_ci DEFAULT NULL,
  `bel_atiksu_yil` int(4) NOT NULL,
  PRIMARY KEY (`bel_atiksu_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ortam_atiksu_mik`
--

INSERT INTO `ortam_atiksu_mik` (`ortam_atiksu`, `atiksu_deniz`, `atiksu_gol_golet`, `atiksu_ak`, `atiksu_ara`, `atiksu_bar`, `atiksu_dig`, `bel_atiksu_yil`) VALUES
('1509651', 556912, 53082, 796509, 40702, 58023, '4421', 1994),
('1632534', 579814, 76136, 864864, 42508, 64254, '4957', 1995),
('1679239', 593194, 63701, 907290, 50208, 59015, '5830', 1996),
('1920322', 599934, 88223, 1028470, 49773, 62593, '91328', 1997),
('2096714', 795402, 87240, 1007213, 55780, 54409, '96670', 1998),
('2301152', 836493, 37971, 1223002, 41353, 88942, '73390', 2001),
('2497657', 885981, 38403, 1356297, 37013, 96434, '83528', 2002),
('2860980', 1173734, 44571, 1407402, 43364, 96267, '95643', 2003),
('2922783', 1178001, 43006, 1380516, 40007, 99551, '181702', 2004),
('3366894', 1522695, 46415, 1410614, 120525, 121532, '145113', 2006),
('3261455', 1458461, 67193, 1404164, 50374, 115405, '165857', 2008),
('3582131', 1498728, 76024, 1741078, 35091, 130224, '100985', 2010),
('4072563', 1843115, 75116, 1817352, 35770, 114199, '187011', 2012),
('4296851', 1915294, 93595, 1898895, 17954, 120781, '250333', 2014),
('4 499 145', 1812650, 78551, 2153123, 20063, 126325, '308 434', 2016),
('4795130', 1949475, 67935, 2248589, 19052, 148735, '361346', 2018);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `silinen_kullanici`
--

DROP TABLE IF EXISTS `silinen_kullanici`;
CREATE TABLE IF NOT EXISTS `silinen_kullanici` (
  `kullanici_adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici_soyadi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici_yetki_ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `silinen_kullanici`
--

INSERT INTO `silinen_kullanici` (`kullanici_adi`, `kullanici_soyadi`, `kullanici_yetki_ad`, `tarih`) VALUES
('Ht', 'HTT', 'ORTA DÜZEY YÖNETİCİ', '2022-01-03 20:56:05'),
('Admin', 'ADMİN', 'ÜST DÜZEY', '2022-01-03 21:19:16'),
('Hello', 'HELLO', 'ÜST DÜZEY YÖNETİCİ', '2022-01-03 21:19:16');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yill`
--

DROP TABLE IF EXISTS `yill`;
CREATE TABLE IF NOT EXISTS `yill` (
  `yill_id` int(4) NOT NULL,
  `yil_tarih` int(4) NOT NULL,
  PRIMARY KEY (`yil_tarih`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yill`
--

INSERT INTO `yill` (`yill_id`, `yil_tarih`) VALUES
(1, 1994),
(2, 1995),
(3, 1996),
(4, 1997),
(5, 1998),
(6, 2001),
(7, 2002),
(8, 2003),
(9, 2004),
(10, 2005),
(11, 2006),
(12, 2007),
(13, 2008),
(14, 2009),
(15, 2010),
(25, 2011),
(16, 2012),
(17, 2013),
(18, 2014),
(19, 2015),
(20, 2016),
(22, 2017),
(21, 2018),
(23, 2019),
(24, 2020);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yil_nufus`
--

DROP TABLE IF EXISTS `yil_nufus`;
CREATE TABLE IF NOT EXISTS `yil_nufus` (
  `nu_yi` int(4) NOT NULL,
  `nufus` int(8) DEFAULT NULL,
  `yil_nuf_art_hiz` int(2) DEFAULT NULL,
  `ilce_sayi` int(3) DEFAULT NULL,
  `belde_bel_sayi` int(4) DEFAULT NULL,
  `koy_sayi` int(5) DEFAULT NULL,
  `nuf_yog` int(3) DEFAULT NULL,
  PRIMARY KEY (`nu_yi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yil_nufus`
--

INSERT INTO `yil_nufus` (`nu_yi`, `nufus`, `yil_nuf_art_hiz`, `ilce_sayi`, `belde_bel_sayi`, `koy_sayi`, `nuf_yog`) VALUES
(2007, 70586256, 0, 850, 2294, 34438, 92),
(2008, 71517100, 13, 892, 1981, 34349, 93),
(2009, 72561312, 14, 892, 1978, 34367, 94),
(2010, 73722988, 16, 892, 1977, 34402, 96),
(2011, 74724269, 13, 892, 1977, 34425, 97),
(2012, 75627384, 12, 892, 1977, 34434, 98),
(2013, 76667864, 14, 919, 394, 18214, 100),
(2014, 77695904, 13, 919, 396, 18340, 101),
(2015, 78741053, 13, 919, 397, 18362, 102),
(2016, 79814871, 14, 919, 397, 18373, 104),
(2017, 80810525, 12, 921, 396, 18380, 105),
(2018, 82003882, 15, 922, 386, 18275, 107),
(2019, 83154997, 14, 922, 386, 18280, 108),
(2020, 83614362, 6, 922, 386, 18287, 109);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yuzde_aritilan`
--

DROP TABLE IF EXISTS `yuzde_aritilan`;
CREATE TABLE IF NOT EXISTS `yuzde_aritilan` (
  `ariy_yil` int(4) NOT NULL,
  `ariy_top` int(2) DEFAULT NULL,
  `ariy_de` int(2) DEFAULT NULL,
  `ariy_gol` int(2) DEFAULT NULL,
  `ariy_ak` int(2) DEFAULT NULL,
  `ariy_ba` int(2) DEFAULT NULL,
  `ariy_ar` int(2) DEFAULT NULL,
  `ariy_dig` int(2) DEFAULT NULL,
  PRIMARY KEY (`ariy_yil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yuzde_aritilan`
--

INSERT INTO `yuzde_aritilan` (`ariy_yil`, `ariy_top`, `ariy_de`, `ariy_gol`, `ariy_ak`, `ariy_ba`, `ariy_ar`, `ariy_dig`) VALUES
(1994, 10, 16, 7, 6, 17, 4, 0),
(1995, 10, 16, 13, 7, 16, 5, 0),
(1996, 12, 18, 25, 7, 23, 3, 0),
(1997, 19, 31, 23, 14, 21, 4, 0),
(1998, 28, 35, 21, 27, 25, 4, 0),
(2001, 52, 79, 51, 38, 26, 19, 33),
(2002, 53, 80, 62, 38, 25, 16, 42),
(2003, 55, 76, 56, 44, 23, 14, 23),
(2004, 65, 85, 59, 52, 53, 16, 55),
(2006, 64, 80, 61, 50, 69, 10, 66),
(2008, 69, 84, 72, 55, 73, 28, 57),
(2010, 76, 90, 50, 68, 64, 26, 60),
(2012, 80, 93, 49, 70, 55, 25, 83),
(2014, 81, 92, 51, 74, 51, 47, 79),
(2016, 85, 95, 68, 80, 61, 70, 80),
(2018, 88, 97, 79, 85, 70, 69, 75);

-- --------------------------------------------------------

--
-- Görünüm yapısı `aritmayan`
--
DROP TABLE IF EXISTS `aritmayan`;

DROP VIEW IF EXISTS `aritmayan`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aritmayan`  AS  select (`aritmayan_miktar`.`arma_de` - `aritmayan_miktar`.`arma_ba`) AS `deniz baraj farkı arıtılmayan miktar`,(case when ((`aritmayan_miktar`.`arma_de` - `aritmayan_miktar`.`arma_ba`) > 0) then 'pozitif' when ((`aritmayan_miktar`.`arma_de` - `aritmayan_miktar`.`arma_ba`) < 0) then 'negatif' else 'sıfır' end) AS `durum` from `aritmayan_miktar` order by (case when ((`aritmayan_miktar`.`arma_de` - `aritmayan_miktar`.`arma_ba`) > 0) then 'pozitif' when ((`aritmayan_miktar`.`arma_de` - `aritmayan_miktar`.`arma_ba`) < 0) then 'negatif' else 'sıfır' end) ;

-- --------------------------------------------------------

--
-- Görünüm yapısı `atiksu_arit_mik_gedo`
--
DROP TABLE IF EXISTS `atiksu_arit_mik_gedo`;

DROP VIEW IF EXISTS `atiksu_arit_mik_gedo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `atiksu_arit_mik_gedo`  AS  select (`atiksu_arit_mik`.`atiksu_arit_mik_gel` - `atiksu_arit_mik`.`atiksu_arit_mik_dog`) AS `atıksu arıtma arıtılan atıksu miktarı gelişmiş doğal`,(case when ((`atiksu_arit_mik`.`atiksu_arit_mik_gel` - `atiksu_arit_mik`.`atiksu_arit_mik_dog`) > 0) then 'pozitif' when ((`atiksu_arit_mik`.`atiksu_arit_mik_gel` - `atiksu_arit_mik`.`atiksu_arit_mik_dog`) < 0) then 'negatif' else 'sıfır' end) AS `sonuc` from `atiksu_arit_mik` order by (case when ((`atiksu_arit_mik`.`atiksu_arit_mik_gel` - `atiksu_arit_mik`.`atiksu_arit_mik_dog`) > 0) then 'pozitif' when ((`atiksu_arit_mik`.`atiksu_arit_mik_gel` - `atiksu_arit_mik`.`atiksu_arit_mik_dog`) < 0) then 'negatif' else 'sıfır' end) ;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `aritimayan_yuz`
--
ALTER TABLE `aritimayan_yuz`
  ADD CONSTRAINT `arm_yi` FOREIGN KEY (`arm_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `aritmayan_miktar`
--
ALTER TABLE `aritmayan_miktar`
  ADD CONSTRAINT `arma_yi` FOREIGN KEY (`arma_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `atiksu_arit_mik`
--
ALTER TABLE `atiksu_arit_mik`
  ADD CONSTRAINT `atiksu` FOREIGN KEY (`bel_atiksu_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `atiksu_arit_tes_kap`
--
ALTER TABLE `atiksu_arit_tes_kap`
  ADD CONSTRAINT `tes` FOREIGN KEY (`bel_atiksu_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `belediye_nufus`
--
ALTER TABLE `belediye_nufus`
  ADD CONSTRAINT `bely` FOREIGN KEY (`bel_yi`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `bel_atiksu_gos`
--
ALTER TABLE `bel_atiksu_gos`
  ADD CONSTRAINT `yiii` FOREIGN KEY (`bel_atiksu_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `bel_su_gos`
--
ALTER TABLE `bel_su_gos`
  ADD CONSTRAINT `su` FOREIGN KEY (`bel_su_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `icme_arit_tes_kap`
--
ALTER TABLE `icme_arit_tes_kap`
  ADD CONSTRAINT `icme` FOREIGN KEY (`bel_su_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `icme_arit_tes_su_mik`
--
ALTER TABLE `icme_arit_tes_su_mik`
  ADD CONSTRAINT `tess` FOREIGN KEY (`bel_su_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ic_arit_tes_sayi`
--
ALTER TABLE `ic_arit_tes_sayi`
  ADD CONSTRAINT `ic` FOREIGN KEY (`bel_su_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ic_top_su_mik`
--
ALTER TABLE `ic_top_su_mik`
  ADD CONSTRAINT `top` FOREIGN KEY (`bel_su_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `il_ilce_nufus`
--
ALTER TABLE `il_ilce_nufus`
  ADD CONSTRAINT `ilce_nu` FOREIGN KEY (`il_id`) REFERENCES `iller` (`il_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `il_nufus_1`
--
ALTER TABLE `il_nufus_1`
  ADD CONSTRAINT `ill` FOREIGN KEY (`il_id`) REFERENCES `iller` (`il_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `log_kullanici`
--
ALTER TABLE `log_kullanici`
  ADD CONSTRAINT `kullanici` FOREIGN KEY (`kullanici_id`) REFERENCES `kullanici` (`kullanici_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `memnuniyett`
--
ALTER TABLE `memnuniyett`
  ADD CONSTRAINT `mem` FOREIGN KEY (`il_id`) REFERENCES `iller` (`il_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `miktar_aritilan`
--
ALTER TABLE `miktar_aritilan`
  ADD CONSTRAINT `mi` FOREIGN KEY (`yilll`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ortam_atiksu_mik`
--
ALTER TABLE `ortam_atiksu_mik`
  ADD CONSTRAINT `or` FOREIGN KEY (`bel_atiksu_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `yil_nufus`
--
ALTER TABLE `yil_nufus`
  ADD CONSTRAINT `nuu` FOREIGN KEY (`nu_yi`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `yuzde_aritilan`
--
ALTER TABLE `yuzde_aritilan`
  ADD CONSTRAINT `yuz` FOREIGN KEY (`ariy_yil`) REFERENCES `yill` (`yil_tarih`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
