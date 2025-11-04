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