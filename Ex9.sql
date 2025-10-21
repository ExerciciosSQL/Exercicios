CREATE DATABASE dbBANCO;
USE dbBANCO;

CREATE TABLE tbcliente(
Cpf BIGINT PRIMARY KEY,
Nome VARCHAR(50),
Sexo CHAR(1),
Endereco VARCHAR(50)
);

CREATE TABLE tbtelefone_cliente(
Telefone INT PRIMARY KEY,
Cpf BIGINT,
FOREIGN KEY(Cpf) REFERENCES tbcliente(Cpf)
);

CREATE TABLE tbbanco(
Codigo INT PRIMARY KEY,
Nome VARCHAR(50)
);

CREATE TABLE tbagencia(
CodBanco INT,
NumAgencia INT PRIMARY KEY,
Endereco VARCHAR(50),
FOREIGN KEY(CodBanco) REFERENCES tbbanco(Codigo)
);

CREATE TABLE tbconta(
NumeroConta INT PRIMARY KEY,
Saldo DECIMAL(7,2),
TipoConta SMALLINT,
NumAgencia INT,
FOREIGN KEY(NumAgencia) REFERENCES tbagencia(NumAgencia)
);

CREATE TABLE tbhistorico(
Cpf BIGINT,
NumeroConta INT,
DataInicio DATE,
PRIMARY KEY(Cpf, NumeroConta),
FOREIGN KEY(Cpf) REFERENCES tbcliente(Cpf),
FOREIGN KEY(NumeroConta) REFERENCES tbconta(NumeroConta)
);

INSERT INTO tbbanco (Codigo, Nome)
VALUES
(1, 'Banco do Brasil'),
(104, 'Caixa Economica Federal'),
(801, 'Banco Escola');

INSERT INTO tbagencia (CodBanco, NumAgencia, Endereco)
VALUES
(1, 123, 'Av. Paulista, 78'),
(104, 159, 'Rua liberdade, 124'),
(801, 401, 'Rua Vinte Três, 23'),
(801, 485, 'Av. Marechal, 68');

INSERT INTO tbcliente (Cpf, Nome, Sexo, Endereco)
VALUES
(12345678910, 'Enildo', 'M', 'Rua Grande,75'),
(12345678911, 'Astrogildo', 'M', 'Rua Pequena, 789'),
(12345678912, 'Monica', 'F', 'Av. Larga, 148'),
(12345678913, 'Cascão', 'M', 'Av. Principal, 369');

INSERT INTO tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
VALUES
(9876, 456.05, 1, 123),
(9877, 321.00, 1, 123),
(9878, 100.00, 2, 485),
(9879, 5589.48, 1, 401);

INSERT INTO tbhistorico (Cpf, NumeroConta, DataInicio)
VALUES
(12345678910, 9876, '2001-04-15'),
(12345678911, 9877, '2011-03-10'),
(12345678912, 9878, '2021-03-11'),
(12345678913, 9879, '2000-07-05');

INSERT INTO tbtelefone_cliente (Cpf, Telefone)
VALUES
(12345678910, 912345678),
(12345678911, 912345679),
(12345678912, 912345680),
(12345678913, 912345681);

ALTER TABLE tbcliente ADD COLUMN Email VARCHAR(50);

SELECT Cpf, Endereco
FROM tbcliente
WHERE Nome = 'Monica';

SELECT NumAgencia, Endereco
FROM tbagencia
WHERE CodBanco = 801;

SELECT *
FROM tbcliente
WHERE Sexo = 'M';