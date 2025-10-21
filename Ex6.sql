CREATE DATABASE db_desenvolvimento;
USE db_desenvolvimento;
CREATE TABLE tbProduto(
IdProp INT PRIMARY KEY,
NomeProd VARCHAR(50) NOT NULL,
Qtd SMALLINT,
DataValidade DATE NOT NULL,
Preco DECIMAL(5,2) NOT NULL
);
ALTER TABLE tbProduto ADD Peso DECIMAL(6,3);
ALTER TABLE tbProduto ADD Cor VARCHAR(50);
ALTER TABLE tbProduto ADD Marca VARCHAR(50);

ALTER TABLE tbProduto DROP Cor;
ALTER TABLE tbProduto MODIFY Peso DECIMAL(6,3) NOT NULL;
-- ALTER TABLE tbProduto DROP Cor; 
/*
	Não é possível apagar a coluna Cor pois ela não existe
*/
CREATE DATABASE dbLojaGrande;
ALTER TABLE tbProduto ADD Cor VARCHAR(50);
CREATE DATABASE dbLojica;
USE dbLojica;
CREATE TABLE tbCliente(
NomeCli VARCHAR(50) NOT NULL,
CodigoCli INT PRIMARY KEY,
DataCadastro DATETIME NOT NULL
);
USE dbLojaGrande;
CREATE TABLE tbFuncionarios(
NomeFunc VARCHAR(50) NOT NULL,
CodigoFunc INT PRIMARY KEY,
DataCadastro DATETIME NOT NULL
);
DROP DATABASE dbLojaGrande;

USE dbLojica; 
ALTER TABLE tbCliente ADD Cpf NUMERIC(11) UNIQUE NOT NULL;
