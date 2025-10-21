create database dbVera;

use dbVera;

create table tbProduto (
	idProp int primary key,
    nomeProd varchar (50) not null,
    qtdProd smallint,
    dataValidade date not null,
    precoProd decimal(6, 2) not null
);

alter table tbProduto add column pesoProd decimal(6, 3);
alter table tbProduto add column corProd varchar(50);
alter table tbProduto add column marcaProd varchar(50) not null;

describe tbProduto;

alter table tbProduto drop column corProd;

describe tbProduto;

alter table tbProduto modify column pesoProd decimal(6, 3) not null;

describe tbProduto;

alter table tbProduto drop column dataValidade;

describe tbProduto;