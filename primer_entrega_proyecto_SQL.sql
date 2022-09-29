create database proyecto;

use proyecto; 

create table tabla_prog(
subcentro varchar(10) NOT NULL,
maq varchar(6) NOT NULL,
fecha date NOT NULL,
elemento varchar(10) NOT NULL,
legajo_programador varchar(10) NOT NULL,
programado int NOT NULL,
primary key (subcentro,maq,fecha,elemento),
foreign key (maq)
references tabla_maq(maq),
foreign key (elemento)
references tabla_elemento(elemento),
foreign key (subcentro)
references tabla_subcentro(subcentro),
foreign key (legajo_programador)
references tabla_programadores(legajo_programador)
);

insert into tabla_prog values
('BANBY','BY01','2022-01-01','A1','F3001',20),
('BANBY','BY01','2022-01-01','B1','F3001',30),
('BANBY','BY02','2022-01-01','A1','F3001',5),
('BANBY','BY02','2022-01-01','C1','F3001',50),
('BANBY','BY02','2022-01-02','A1','F3002',100),
('BANBY','BY02','2022-01-02','D1','F3002',200),
('TOBDIA','TC02','2022-01-02','A2','F3002',200)
;

create table tabla_prod(
subcentro varchar(10) NOT NULL,
maq varchar(6) NOT NULL,
fecha date NOT NULL,
elemento varchar(10) NOT NULL,
legajo_operador varchar(10) NOT NULL,
producido int NOT NULL,
primary key (maq,fecha,elemento),
foreign key (maq)
references tabla_maq(maq),
foreign key (elemento)
references tabla_elemento(elemento),
foreign key (subcentro)
references tabla_subcentro(subcentro),
foreign key (legajo_operador)
references tabla_operadores(legajo_operador)
);

insert into tabla_prod values
('BANBY','BY01','2022-01-01','A1','F2001',20),
('BANBY','BY01','2022-01-01','B1','F2001',35),
('BANBY','BY02','2022-01-01','A1','F2001',5),
('BANBY','BY02','2022-01-01','C1','F2001',45),
('BANBY','BY02','2022-01-02','A1','F2002',150),
('BANBY','BY02','2022-01-02','E1','F2002',300),
('TOBDIA','TC02','2022-01-02','A2','F2002',200)
;

create table tabla_maq(
maq varchar(6) NOT NULL,
descripcion varchar(45) NOT NULL,
primary key (maq)
);

insert into tabla_maq values
('BY01','Banbyry1'),
('BY02','Banbury2'),
('TC02','Tobera Dual Farrel')
;

create table tabla_subcentro(
subcentro varchar(10) NOT NULL,
descripcion_subcentro varchar(30) NOT NULL,
primary key (subcentro)
);

insert into tabla_subcentro values
('BANBY','Area Banburys'),
('TOBDIA','Area Toberas')
;

create table tabla_elemento(
elemento varchar(10) NOT NULL,
desc_elemento varchar(20) NOT NULL,
tipo_elemento varchar(20) NOT NULL,
primary key (elemento)
);

insert into tabla_elemento values
('A1','elementoA1'),
('B1','elementoB1'),
('C1','elementoC1'),
('D1','elementoD1'),
('E1','elementoE1'),
('A2','elementoA2')
;

create table tabla_programadores(
legajo_programador varchar(10) NOT NULL,
nombre_programador varchar(30) NOT NULL,
apellido_programador varchar(30) NOT NULL,
primary key (legajo_programador)
);

insert into tabla_programadores values
('F3001','Nicolas','Perez'),
('F3002','Matias','Avellaneda')
;

create table tabla_operadores(
legajo_operador varchar(10) NOT NULL,
nombre_operador varchar(30) NOT NULL,
apellido_operador varchar(30) NOT NULL,
primary key (legajo_operador)
);

insert into tabla_operadores values
('F2001','Raul','Gonzalez'),
('F2002','Cristian','Sanchez')
;

create table tabla_interrupciones(
subcentro varchar(10) NOT NULL,
maq varchar(6) NOT NULL,
fecha date NOT NULL,
cod_raiz int NOT NULL,
legajo_operador varchar(10) NOT NULL,
tiempo_int int NOT NULL,
primary key (subcentro,maq,fecha,cod_raiz),
foreign key (maq)
references tabla_maq(maq),
foreign key (cod_raiz)
references tabla_cod_interrupciones(cod_raiz),
foreign key (subcentro)
references tabla_subcentro(subcentro),
foreign key (legajo_operador)
references tabla_operadores(legajo_operador)
);

create table tabla_cod_interrupciones(
cod_raiz int NOT NULL,
descripcion_cod_raiz VARCHAR(100) not null,
primary key (cod_raiz)
);

SELECT coalesce(tabla_prog.maq,prod.maq) maq,
coalesce(tabla_prog.fecha,prod.fecha) fecha,
coalesce(tabla_prog.elemento,prod.elemento) elemento,
tabla_prog.programado,
prod.producido
FROM tabla_prog
RIGHT JOIN (select * from tabla_prod) PROD ON tabla_prog.maq=prod.maq
AND tabla_prog.fecha=prod.fecha AND tabla_prog.elemento = prod.elemento
;

SELECT coalesce(tabla_prog.maq,prod.maq) maq,
coalesce(tabla_prog.fecha,prod.fecha) fecha,
SUM(tabla_prog.programado) programado,
SUM(prod.producido) producido,
(SUM(producido)/SUM(programado))*100 cump_programa 
FROM tabla_prog
RIGHT JOIN (select * from tabla_prod) PROD ON tabla_prog.maq=prod.maq
AND tabla_prog.fecha=prod.fecha AND tabla_prog.elemento = prod.elemento
group by maq,fecha
;




