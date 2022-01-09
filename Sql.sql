
CREATE TABLE IF NOT EXISTS `roda_modernhud` (
  `license` varchar(250) NOT NULL,
  `UID` int(250) NOT NULL,
  PRIMARY KEY (`license`,`UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
