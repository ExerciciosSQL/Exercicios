CREATE DATABASE dbDistribuidora;
USE dbDistribuidora;
CREATE TABLE tbCliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nomeCli VARCHAR(200) NOT NULL,
    numEnd NUMERIC(6) NOT NULL,
    compEnd VARCHAR(50),
    cepCli NUMERIC(8) NOT NULL
);
CREATE TABLE tbClientePF (
	cpf NUMERIC(11) PRIMARY KEY,
    rg NUMERIC(9) NOT NULL,
    rgDig CHAR(1) NOT NULL,
    nasc DATE NOT NULL,
    id INT NOT NULL,
    FOREIGN KEY (id) REFERENCES tbCliente(id)
);
CREATE TABLE tbClientePJ (
	cnpj NUMERIC(14) PRIMARY KEY,
    ie NUMERIC(11) UNIQUE,
    id INT NOT NULL,
    FOREIGN KEY (id) REFERENCES tbCliente(id)
);
CREATE TABLE tbBairro (
	bairroId INT PRIMARY KEY AUTO_INCREMENT,
    bairro VARCHAR(200) NOT NULL
);
CREATE TABLE tbCidade (
	cidadeId INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(200) NOT NULL
);
CREATE TABLE tbEstado (
	ufId INT PRIMARY KEY AUTO_INCREMENT,
    uf CHAR(2) NOT NULL
);
CREATE TABLE tbEndereco (
	cep NUMERIC(8) PRIMARY KEY,
    logradouro VARCHAR(200) NOT NULL,
    bairroId INT NOT NULL,
    cidadeId INT NOT NULL,
    ufId INT NOT NULL,
    FOREIGN KEY (bairroId) REFERENCES tbBairro(bairroId),
    FOREIGN KEY (cidadeId) REFERENCES tbCidade(cidadeId),
    FOREIGN KEY (ufId) REFERENCES tbEstado(ufId)
);
ALTER TABLE tbCliente ADD FOREIGN KEY (cepCli) REFERENCES tbEndereco(cep);
CREATE TABLE tbFornecedor (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
    cnpj NUMERIC(14) UNIQUE,
    nome VARCHAR(200) NOT NULL,
    telefone NUMERIC(11)
);
CREATE TABLE tbProduto (
	codBarras NUMERIC(14) PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    valor DECIMAL(7, 2) NOT NULL,
	qtd SMALLINT,
    codigo INT,
    FOREIGN KEY (codigo) REFERENCES tbFornecedor(codigo)
);
CREATE TABLE tbCompra (
	notaFiscal INT PRIMARY KEY,
    dataCompra DATE NOT NULL,
    valorTotal DECIMAL(7, 2) NOT NULL,
    qtdTotal SMALLINT NOT NULL,
    codigo INT NOT NULL,
    FOREIGN KEY (codigo) REFERENCES tbFornecedor(codigo)
);
CREATE TABLE tbItemCompra (
	qtd INT NOT NULL,
    valorItem DECIMAL (7, 2) NOT NULL,
    notaFiscal INT,
    codBarras NUMERIC(14),
    PRIMARY KEY (notaFiscal, codBarras),
    FOREIGN KEY (notaFiscal) REFERENCES tbCompra(notaFiscal),
    FOREIGN KEY (codBarras) REFERENCES tbProduto(codBarras)
);
CREATE TABLE tbVenda (
	numeroVenda INT PRIMARY KEY,
    dataVenda DATE NOT NULL,
    totalVenda DECIMAL(7, 2) NOT NULL,
    idCli INT NOT NULL,
    nf INT,
    FOREIGN KEY (idCli) REFERENCES tbCliente(id)
);
CREATE TABLE tbItemVenda (
	numeroVenda INT,
    codBarras NUMERIC(14),
    valorItem DECIMAL(7, 2) NOT NULL,
    qtd SMALLINT NOT NULL,
    PRIMARY KEY (numeroVenda, codBarras),
    FOREIGN KEY (numeroVenda) REFERENCES tbVenda(numeroVenda),
    FOREIGN KEY (codBarras) REFERENCES tbProduto(codBarras)
);
CREATE TABLE tbNotaFiscal (
	nf INT PRIMARY KEY,
    totalNota DECIMAL(7, 2) NOT NULL,
    dataEmissao DATE NOT NULL
);
ALTER TABLE tbVenda ADD FOREIGN KEY (nf) REFERENCES tbNotaFiscal(nf);

DESCRIBE tbFornecedor;
INSERT INTO tbFornecedor (cnpj, nome, telefone)
VALUES 
	(1245678937123, "Revenda Chico Loco", 11934567897),
	(1345678937123, "José Faz Tudo S/A", 11934567898),
    (1445678937123, "Vadalto Entregas", 11934567899),
    (1545678937123, "Astrogildo das Estrela", 11934567800),
    (1645678937123, "Amoroso e Doce", 11934567801),
    (1745678937123, "Marcelo Dedal", 11934567802),
    (1845678937123, "Franciscano Cachaça", 11934567803),
    (1945678937123, "Joãozinho Chupeta", 11934567804);
    
DESCRIBE tbCidade;
DELIMITER $$
CREATE PROCEDURE inserirCidades()
BEGIN
    INSERT INTO tbCidade (cidade) VALUES 
        ('Rio de Janeiro'),
        ('São Carlos'),
        ('Campinas'),
        ('Franco da Rocha'),
        ('Osasco'),
        ('Pirituba'),
        ('Lapa'),
        ('Ponta Grossa');
END $$
DELIMITER ;
CALL inserirCidades();

DESCRIBE tbEstado;
DELIMITER $$
CREATE PROCEDURE inserirEstados()
BEGIN
	INSERT INTO tbEstado (uf) VALUES
		("SP"),
		("RJ"),
		("RS");
END $$
DELIMITER ;
CALL inserirEstados();

DESCRIBE tbBairro;
DELIMITER $$
CREATE PROCEDURE inserirBairros()
BEGIN
	INSERT INTO tbBairro (bairro) VALUES
		("Aclimação"),
		("Capão Redondo"),
		("Pirituba"),
        ("Liberdade");
END $$
DELIMITER ;
CALL inserirBairros();

DESCRIBE tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirProdutos()
BEGIN
	INSERT INTO tbProduto (codBarras, nome, valor, qtd) VALUES
		(12345678910111, "Rei de Papel Mache", 54.61, 120),
        (12345678910112, "Bolinha de Sabão", 100.45, 120),
        (12345678910113, "Carro Bate", 44.00, 120),
        (12345678910114, "Bola Furada", 10.00, 120),
        (12345678910115, "Maçã Laranja", 99.44, 120),
        (12345678910116, "Boneco do Hitler", 124.00, 200),
        (12345678910117, "Farinha de Suruí", 50.00, 200),
        (12345678910118, "Zelador de Cemitério", 24.50, 100);
END $$
DELIMITER ;
CALL inserirProdutos();

DESCRIBE tbEndereco;
SELECT * FROM tbBairro;
SELECT * FROM tbCidade;
SELECT * FROM tbEstado;
INSERT INTO tbBairro (bairro) VALUES
	("Lapa"),
    ("Consolação"),
    ("Penha"),
    ("Barra Funda");
INSERT INTO tbCidade (cidade) VALUES
	("São Paulo"),
    ("Barra Mansa");
DELIMITER $$
CREATE PROCEDURE inserirEnderecos()
BEGIN
	INSERT INTO tbEndereco (cep, logradouro, bairroId, cidadeId, ufId) VALUES
		(12345050, "Rua da Federal", 5, 9, 1),
        (12345051, "Av. Brasil", 5, 3, 1),
        (12345052, "Rua Liberdade", 6, 9, 1),
        (12345053, "Av. Paulista", 7, 1, 2),
        (12345054, "Rua Ximbú", 7, 1, 2),
        (12345055, "Rua Piu XI", 7, 3, 1),
        (12345056, "Rua Chocolate", 1, 10, 2),
        (12345057, "Rua Pão na Chapa", 8, 8, 3);
END $$
DELIMITER ;
CALL inserirEnderecos();

DESCRIBE tbCliente;
DESCRIBE tbClientePF;
SELECT * FROM tbEndereco;
INSERT INTO tbBairro (bairro) VALUE ("Jardim Santa Isabel");
INSERT INTO tbCidade (cidade) VALUE ("Cuiabá");
INSERT INTO tbEstado (uf) VALUE ("MT");
INSERT INTO tbEndereco (cep, logradouro, bairroId, cidadeId, ufId) VALUES
	(12345058, "Rua Veia", 9, 9, 4),
	(12345059, "Av Nova", 9, 9, 4);
DELIMITER $$
CREATE PROCEDURE inserirClientesPF()
BEGIN
	INSERT INTO tbCliente (nomeCli, numEnd, compEnd, cepCli) VALUES
		("Pimpão", 325, Null, 12345051),
        ("Disney Chaplin", 89, "Ap. 12", 12345053),
        ("Marciano", 744, Null, 12345054),
        ("Lança Perfume", 128, Null, 12345059),
        ("Remédio Amargo", 2585, Null, 12345058);
	INSERT INTO tbClientePF (cpf, rg, rgDig, nasc, id) VALUES
		(12345678911, 12345678, "0", "2000-10-12", 1),
        (12345678912, 12345679, "0", "2001-11-21", 2),
        (12345678913, 12345680, "0", "2001-06-01", 3),
        (12345678914, 12345681, "X", "2004-04-05", 4),
        (12345678915, 12345682, "0", "2002-07-15", 5);
END $$
DELIMITER ;
CALL inserirClientesPF();

DESCRIBE tbCliente;
DESCRIBE tbClientePJ;
SELECT * FROM tbEndereco;
INSERT INTO tbBairro (bairro) VALUE ("Sei Lá");
INSERT INTO tbCidade (cidade) VALUE ("Recife");
INSERT INTO tbEstado (uf) VALUE ("PE");
INSERT INTO tbEndereco (cep, logradouro, bairroId, cidadeId, ufId) VALUE (12345060, "Rua dos Amores", 10, 12, 5);
DELIMITER $$
CREATE PROCEDURE inserirClientesPJ()
BEGIN
	INSERT INTO tbCliente (nomeCli, numEnd, compEnd, cepCli) VALUES
		("Paganada", 159, Null, 12345051),
        ("Disney Chaplin", 69, Null, 12345053),
        ("Marciano", 189, Null, 12345060),
        ("Lança Perfume", 5024, "Sala 23", 12345060),
        ("Remédio Amargo", 1254, Null, 12345060);
	INSERT INTO tbClientePJ (cnpj, ie, id) VALUES
		(12345678912345, 98765432198, 6),
        (12345678912346, 98765432199, 7),
        (12345678912347, 98765432100, 8),
        (12345678912348, 98765432101, 9),
        (12345678912349, 98765432102, 10);
END $$
DELIMITER ;
CALL inserirClientesPJ();

DESCRIBE tbCompra;
DESCRIBE tbItemCompra;
SELECT * FROM tbFornecedor;
SELECT * FROM tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirCompras()
BEGIN
	INSERT INTO tbCompra (notaFiscal, dataCompra, valorTotal, qtdTotal, codigo) VALUES
		(8459, STR_TO_DATE("01/05/2018", "%d/%m/%Y"), 21944.00, 700, 5),
		(2482, STR_TO_DATE("22/04/2020", "%d/%m/%Y"), 7290.00, 180, 1),
		(21563, STR_TO_DATE("12/07/2020", "%d/%m/%Y"), 900.00, 300, 6),
		(156354, STR_TO_DATE("23/11/2021", "%d/%m/%Y"), 18900.00, 350, 1);
	INSERT INTO tbItemCompra (qtd, valorItem, notaFiscal, codBarras) VALUES
		(200, 22.22, 8459, 12345678910111),
        (180, 40.50, 2482, 12345678910112),
        (300, 3.00, 21563, 12345678910113),
        (500, 35.00, 8459, 12345678910114),
        (350, 54.00, 156354, 12345678910115);
END $$
DELIMITER ;
CALL inserirCompras();

DESCRIBE tbVenda;
DESCRIBE tbItemVenda;
SELECT * FROM tbCliente;
SELECT * FROM tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirVendas()
BEGIN
	INSERT INTO tbVenda (numeroVenda, dataVenda, totalVenda, idCli) VALUES
		(1, NOW(), 54.61, 1),
        (2, NOW(), 200.90, 4),
        (3, NOW(), 44.00, 1);
	INSERT INTO tbItemVenda (numeroVenda, codBarras, valorItem, qtd) VALUES
		(1, 12345678910111, 54.61, 1),
        (2, 12345678910112, 100.45, 2),
        (3, 12345678910113, 44.00, 1);
END $$
DELIMITER ;
CALL inserirVendas();