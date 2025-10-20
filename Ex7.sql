-- Maria Alice de Sillos
CREATE DATABASE  dbescola;
USE dbescola;

CREATE TABLE tbcliente(
IdCli INT PRIMARY KEY,
NomeCli VARCHAR(50) NOT NULL,
NumEnd SMALLINT,
DataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP()
);

ALTER TABLE tbcliente ADD CPF NUMERIC(11) UNIQUE NOT NULL;
ALTER TABLE tbcliente ADD Cep NUMERIC(5);

CREATE DATABASE dbempresa;

CREATE TABLE tbendereco(
Cep NUMERIC(5) PRIMARY KEY,
Logradouro VARCHAR(250) NOT NULL,
IdUf TINYINT 
);

ALTER TABLE tbcliente ADD CONSTRAINT Fk_Cep_tbcliente FOREIGN KEY(Cep) REFERENCES tbendereco(Cep);

DESCRIBE TABLE tbcliente;

/* 1-) Dificuldade para criar a CONSTRAINT 
   2-) Criação da chave estrangeira
 */
 
 SHOW DATABASES;
 DROP DATABASE dbempresa;