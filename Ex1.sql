CREATE DATABASE dbLucas;

USE dbLucas;

CREATE TABLE tbUsuario (
	idUsuario INT PRIMARY KEY,
    nomeUsuario VARCHAR(45),
    dataNascimento DATE
);
CREATE TABLE tbEstado (
	idEstado SMALLINT PRIMARY KEY,
    uf CHAR(2)
);
CREATE TABLE tbCliente (
	codigoCli INT PRIMARY KEY,
    CHECK(codigoCli <= 65000),
    nomeCli VARCHAR (50),
    enderecoCli VARCHAR(60)
);
CREATE TABLE tbProduto (
	codigoBarras NUMERIC(13) PRIMARY KEY,
    valorProduto DECIMAL(8, 4),
    descricaoProduto VARCHAR (100)
);
    
describe table tbCliente;

show tables;    

show databases;

alter table tbCliente modify nomeCli varchar (58);

describe tbCliente;

alter table tbProduto add column qtd smallint;

describe tbProduto;

drop table tbEstado;

alter table tbUsuario drop column dataNascimento;

describe tbUsuario;