create database dbComercio;

use dbComercio;

create table tbCliente (
	idCli int primary key,
    nomeCli varchar (200) not null,
    numEnd numeric (6) not null,
    compEnd varchar (50)
);

create table tbClientePF (
	cpf numeric (11) primary key,
    rg numeric (9),
    rgDig char (1),
    dataNascimento date not null
);