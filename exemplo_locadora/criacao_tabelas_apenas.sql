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

/*criação da tabela registro bancario*/
create table registrobancario(
	id serial not null,
	codinst integer,
	numreg integer,
	idcliente integer,
	constraint pkregistrobancario primary key(id),
	constraint fkclienteregbancario foreign key (idcliente) 
			references cliente(id)
);

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


/*criação da tabela carro*/
create table carro (
	id serial,
	modelo varchar(200),
	placa varchar(11),
	constraint pkcarro primary key(id),
	constraint uniqueplaca unique(placa)
);

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
	constraint ckdtretornodtsaida check(dtretorno >= dtsaida)
);
