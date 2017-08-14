package main

var (
	campainSchema = `CREATE TABLE IF NOT EXISTS campains (
id int NOT NULL AUTO_INCREMENT,
source varchar(64) DEFAULT "PTNH",
package varchar(64) DEFAULT "VIP",
msisdn varchar(16) DEFAULT "",
transactionid varchar(64) DEFAULT "",
status int(4) DEFAULT 0,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (id),
CONSTRAINT campain UNIQUE (msisdn, package, source, transactionid),
INDEX(source, id, msisdn)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;`
)
