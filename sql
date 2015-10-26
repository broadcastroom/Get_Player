create table player(
name varchar(255),
position varchar(255),
age int,
national varchar(255),
team varchar(255),
team_national varchar(255),
division varchar(255),
minutes int,
primary key(name,national)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

create table transfer(
name varchar(255),
position varchar(255),
age int,
height varchar(255),
national varchar(255),
team varchar(255),
team_national varchar(255),
division varchar(255),
primary key(name,national)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;