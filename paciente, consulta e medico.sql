-- Scripts das tabelas do Modelo Paciente - Consulta - medico
---
---
SELECT * FROM PACIENTE;

Create table Paciente
( Codpaciente      number(4,0)    not null,
   Nompaciente     varchar2(30)   not null,
   Datanasc        date,
   Sexo            char( 1 ) check (sexo in ( 'F',  'M' )),
   Endereco        varchar2(25),
   constraint pk_codpaciente Primary Key (codpaciente));

Create table Medico
(  Codmedico           number(4,0)     not null,
   nommedico           varchar2(30)    not null,
   constraint pk_codmedico Primary Key (codmedico));

Create table Consulta
(   Codconsulta          number(3,0)    not null,
    Dataconsulta         date,
    Codpaciente          number(4,0)    Not Null,                   
    Codmedico            number(4,0)    Not Null,
    Valconsulta          number(5,0)    Not Null,
    constraint pk_codconsulta Primary Key (codconsulta));

Alter table Consulta
ADD (constraint fk_codpaciente Foreign Key (codpaciente)
     references Paciente (codpaciente) on delete cascade);

Alter table Consulta
ADD (constraint fk_codmedico Foreign Key (codmedico)
     references Medico (codmedico) on delete cascade);
 
ALTER TABLE  Paciente  ADD (cidpaciente varchar2( 15 )   Not   Null ) ;

ALTER TABLE  Paciente  MODIFY (cidpaciente varchar2( 20 )) ;

ALTER TABLE  Paciente  ADD (desconto varchar2( 01 ) check 
                                          (desconto in ('S','N' ) ) );

ALTER TABLE  Consulta  ADD (Tipoconsulta char (1) check 
					  (tipoconsulta in ('C', 'P')));

ALTER TABLE  Consulta  MODIFY (Valconsulta number(7,2));




insert into Paciente
values (001, 'Joao da Silva','01-09-1957','M','Rua das Flores, 301',
	'Sorocaba','S');

insert into Paciente
values (002, 'Henrique Matias','25-01-1960','M','Av. das Margaridas, 112',
	'Sorocaba','S');

insert into Paciente
values (003, 'Clara das Neves','20-01-1978','F','Rua Manoel Bandeira, 1100',
	'Itu','S');

insert into Paciente
values (004, 'Joao Pessoa','15-10-1945','M','Rua Maria Machado, 800',
	'Salto','N');

insert into Paciente
values (005, 'Karla da Cruz','29-12-1939','F','Av. Brasil, 701',
	'Avare','S');

insert into Paciente
values (006, 'Jandira Gomes','18-02-1940','F','Rua Jardim Florido, 1152',
	'Sorocaba','N');

insert into Paciente
values (007, 'Ana Maria Faracco','13-08-1980','F','Rua Jose Vieira, 65',
	'Sorocaba','S');

insert into Paciente
values (008, 'Roberto Faracco','01-01-1978','M','Rua Jose Vieira, 65',
	'Sorocaba','S');

insert into Paciente
values (009, 'Barbara Moreira','30-09-1969','F','Rua das Pedras, 127',
	'Sao Paulo','N');

insert into Paciente
values (010, 'Norberto Almeida','27-11-1937','M','Rua Capitao Pereira, 170',
	'Itapetininga','S');



insert into Medico
values (001, 'Roanldo Bueno');

insert into Medico
values (002, 'Helena Ziglio');

insert into Medico
values (003, 'Paulo Cesar Oliveira');

insert into Medico
values (004, 'Roberto Sinatura');




insert into Consulta
values (001, '20-01-2020',001,003,80.00,'C');

insert into Consulta
values (002, '22-02-2020',001,003,80.00,'C');

insert into Consulta
values (003, '15-10-2020',002,001,75.50,'P');

insert into Consulta
values (004, '07-12-2020',003,002,60.75,'P');

insert into Consulta
values (005, '18-11-2020',004,004,57.80,'C');

insert into Consulta
values (006, '27-06-2020',005,001,60.00,'C');

insert into Consulta
values (007, '30-07-2020',005,001,60.00,'C');

insert into Consulta
values (008, '15-08-2020',006,003,75.20,'P');

insert into Consulta
values (009, '17-08-2020',007,003,80.00,'P');

insert into Consulta
values (010, '20-08-98',008,002,70.00,'C');

insert into Consulta
values (011, '21-08-2020',008,004,81.00,'C');

insert into Consulta
values (012, '30-08-2020',009,004,85.00,'P');

insert into Consulta
values (013, '30-08-98',001,004,35.60,'C');

insert into Consulta
values (014, '01-01-2020',007,002,80.00,'P');

insert into Consulta
values (015, '10-02-2020',008,001,74.35,'P');

insert into Consulta
values (016, '11-02-2020',010,003,71.21,'C');

insert into Consulta
values (017,'12-04-2020',002,002,84.00,'C');




