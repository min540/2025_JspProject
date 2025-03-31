DROP TABLE IF EXISTS tblBoard;

CREATE TABLE `tblBoard` (
	`num`               int(11)              NOT NULL  auto_increment  ,
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                                ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	PRIMARY KEY ( `num` )
);

DROP TABLE IF EXISTS tblBcomment;

CREATE TABLE `tblBcomment` (
	`cnum` INT(11) NOT NULL AUTO_INCREMENT,
	`num` INT(11) NULL DEFAULT NULL,
	`name` VARCHAR(20) NULL DEFAULT NULL,
	`comment` VARCHAR(200) NULL DEFAULT NULL,
	`regdate` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`cnum`)
);
