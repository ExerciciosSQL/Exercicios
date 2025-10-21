create database dbDiego;

use dbDiego;
 
create table tbProdutos(
	idProp int primary key,
    nomeProd varchar (50) not null,
    qtd smallint,
    dataValidade date not null,
    preco decimal (6,2) not null
);
 
create table tbCliente(
	codigoCli int primary key,
	nomeCli varchar (50) not null,
    dataNascimento date
);