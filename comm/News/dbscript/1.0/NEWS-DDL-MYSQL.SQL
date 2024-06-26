DROP TABLE IF EXISTS `T_NEWS`;
CREATE TABLE `T_NEWS` (
  `UUID` varchar(32) NOT NULL,
  `TITLE` varchar(128) NOT NULL COMMENT '标题',
  `CONTENT` longtext COMMENT '公告内容',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `LANGUAGE` varchar(32) DEFAULT NULL COMMENT '语言',
  `INDEX_TOP`  char(1) DEFAULT NULL ;
  PRIMARY KEY (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

