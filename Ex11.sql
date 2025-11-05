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
    rgDig NUMERIC(1) NOT NULL,
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
    codigo INT NOT NULL
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