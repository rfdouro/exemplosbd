/*exclusão das tabelas caso existam*/
drop table if exists registrobancario;
drop table if exists motorista;
drop table if exists locacao;
drop table if exists cliente;
drop table if exists carro;

/*criação da tabela cliente*/
create table cliente(
	id serial not null,
	nome varchar(250),
	cpf varchar(11),
	cnh varchar(20),
	constraint pkcliente primary key(id),
	constraint uniquecpf unique(cpf),
	constraint ckcpfcliente check(length(cpf) = 11),
	constraint uniquecnhcliente unique(cnh)
);

/* linhas de inserção de dados e consulta para cliente*/
insert into cliente (nome, cpf, cnh)
values('joao','12345678900','444444');
select * from cliente;

/*criação da tabela registro bancario*/
create table registrobancario(
	id serial not null,
	codinst integer,
	numreg integer,
	idcliente integer unique,
	constraint pkregistrobancario primary key(id),
	constraint fkclienteregbancario foreign key (idcliente) 
			references cliente(id)
);

/* linhas de inserção de dados e consulta para registro bancário*/
insert into registrobancario (codinst, numreg, idcliente)
values (101, 1005, 1);
select * from registrobancario r ;

/*criação da tabela motorista*/
create table motorista(
	id serial not null,
	nome varchar(250),
	cnh varchar(20),
	idcliente integer,
	constraint pkmotorista primary key(id),
	constraint uniquecnhmotorista unique(cnh),
	constraint fkclientemotorista foreign key (idcliente) 
			references cliente(id)
);

/* linhas de inserção de dados e consulta para motorista*/
insert into motorista (nome, cnh, idcliente)
values ('alberto roberto', '5565', 1);
select * from motorista m ;


/*criação da tabela carro*/
create table carro (
	id serial,
	modelo varchar(200),
	placa varchar(11),
	constraint pkcarro primary key(id),
	constraint uniqueplaca unique(placa)
);

/* linhas de teste para a tabela carro*/
insert into carro(modelo, placa)
values ('fusca','xxx7789');
select * from carro;

/*criação da tabela locacao*/
create table locacao(
	id serial,
	idcliente integer,
	idcarro integer,
	dtsaida date,
	dtretorno date,
	constraint pklocacao primary key (id),
	constraint fklocacaocliente foreign key (idcliente) references cliente(id),
	constraint fklocacaocarro foreign key (idcarro) references carro(id),
	constraint ckdtretornodtsaida check(dtretorno <= dtsaida)
);

alter table locacao 
	drop constraint ckdtretornodtsaida;
alter table locacao 
	add constraint ckdtretornodtsaida check(dtretorno >= dtsaida);

/* dados de teste para locacao */
insert into locacao(idcliente, idcarro, dtsaida, dtretorno)
values(1,1,'2024-04-01','2024-05-01');
select * from locacao;


/* alteração para inclusão de cascade ao excluir referência */
alter table locacao 
	drop constraint fklocacaocliente, drop constraint fklocacaocarro,
	add constraint fklocacaocliente foreign key (idcliente) references cliente(id)
		on delete cascade,
	add constraint fklocacaocarro foreign key (idcarro) references carro(id)
		on delete cascade;

/*teste de exclusão de carro*/
delete from carro where id = 1;
/* exclui também as alocações referentes*/
select * from locacao;




