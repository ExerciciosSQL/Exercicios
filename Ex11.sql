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
	qtd SMALLINT
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
CREATE PROCEDURE inserirCidade(IN nomeCidade VARCHAR(200))
BEGIN
    INSERT INTO tbCidade (cidade) VALUES (nomeCidade);
END $$
DELIMITER ;
CALL inserirCidade('Rio de Janeiro');
CALL inserirCidade('São Carlos');
CALL inserirCidade('Campinas');
CALL inserirCidade('Franco da Rocha');
CALL inserirCidade('Osasco');
CALL inserirCidade('Pirituba');
CALL inserirCidade('Lapa');
CALL inserirCidade('Ponta Grossa');

DESCRIBE tbEstado;
DELIMITER $$
CREATE PROCEDURE inserirEstado(IN estado CHAR(2))
BEGIN
	INSERT INTO tbEstado (uf) VALUES (estado);
END $$
DELIMITER ;
CALL inserirEstado("SP");
CALL inserirEstado("RJ");
CALL inserirEstado("RS");

DESCRIBE tbBairro;
DELIMITER $$
CREATE PROCEDURE inserirBairro(IN nomeBairro VARCHAR(200))
BEGIN
	INSERT INTO tbBairro (bairro) VALUES (nomeBairro);
END $$
DELIMITER ;
CALL inserirBairro("Aclimação");
CALL inserirBairro("Capão Redondo");
CALL inserirBairro("Pirituba");
CALL inserirBairro("Liberdade");

DESCRIBE tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirProduto(
	IN _codBarras NUMERIC(14),
    IN _nome VARCHAR(200),
    IN _valor DECIMAL(7, 2),
    IN _qtd SMALLINT
)
BEGIN
	INSERT INTO tbProduto (codBarras, nome, valor, qtd) VALUES
		(_codBarras, _nome, _valor, _qtd);
END $$
DELIMITER ;
CALL inserirProduto(12345678910111, "Rei de Papel Mache", 54.61, 120);
CALL inserirProduto(12345678910112, "Bolinha de Sabão", 100.45, 120);
CALL inserirProduto(12345678910113, "Carro Bate", 44.00, 120);
CALL inserirProduto(12345678910114, "Bola Furada", 10.00, 120);
CALL inserirProduto(12345678910115, "Maçã Laranja", 99.44, 120);
CALL inserirProduto(12345678910116, "Boneco do Hitler", 124.00, 200);
CALL inserirProduto(12345678910117, "Farinha de Suruí", 50.00, 200);
CALL inserirProduto(12345678910118, "Zelador de Cemitério", 24.50, 100);

DESCRIBE tbEndereco;
SELECT * FROM tbBairro;
SELECT * FROM tbCidade;
SELECT * FROM tbEstado;
CALL inserirBairro("Lapa");
CALL inserirBairro("Consolação");
CALL inserirBairro("Penha");
CALL inserirBairro("Barra Funda");
CALL inserirCidade("São Paulo");
CALL inserirCidade("Barra Mansa");
DELIMITER $$
CREATE PROCEDURE inserirEndereco(
	IN _cep NUMERIC(8),
    IN _logradouro VARCHAR(200),
	IN _bairro INT,
    IN _cidade INT,
    IN _uf INT
)
BEGIN
	INSERT INTO tbEndereco (cep, logradouro, bairroId, cidadeId, ufId) VALUES
		(_cep, _logradouro, _bairro, _cidade, _uf);
END $$
DELIMITER ;
CALL inserirEndereco(12345050, "Rua da Federal", 5, 9, 1);
CALL inserirEndereco(12345051, "Av. Brasil", 5, 3, 1);
CALL inserirEndereco(12345052, "Rua Liberdade", 6, 9, 1);
CALL inserirEndereco(12345053, "Av. Paulista", 7, 1, 2);
CALL inserirEndereco(12345054, "Rua Ximbú", 7, 1, 2);
CALL inserirEndereco(12345055, "Rua Piu XI", 7, 3, 1);
CALL inserirEndereco(12345056, "Rua Chocolate", 1, 10, 2);
CALL inserirEndereco(12345057, "Rua Pão na Chapa", 8, 8, 3);

DESCRIBE tbCliente;
DESCRIBE tbClientePF;
SELECT * FROM tbEndereco;
CALL inserirBairro("Jardim Santa Isabel");
CALL inserirCidade("Cuiabá");
CALL inserirEstado("MT");
CALL inserirEndereco(12345058, "Rua Veia", 9, 9, 4);
CALL inserirEndereco(12345059, "Av Nova", 9, 9, 4);
DELIMITER $$
CREATE PROCEDURE inserirClientePF(
	IN _nomeCli VARCHAR(200),
    IN _numEnd NUMERIC(6),
    IN _compEnd VARCHAR(50),
    IN _cepCli NUMERIC(8),
    IN _cpf NUMERIC(11),
    IN _rg NUMERIC(9),
    IN _rgDig CHAR(1),
    IN _nasc DATE
)
BEGIN
	DECLARE _id INT;
	INSERT INTO tbCliente (nomeCli, numEnd, compEnd, cepCli) VALUES
		(_nomeCli, _numEnd, _compEnd, _cepCli);
	SELECT id INTO _id
    FROM tbCliente
    WHERE nomeCli = _nomeCli;
	INSERT INTO tbClientePF (cpf, rg, rgDig, nasc, id) VALUES
		(_cpf, _rg, _rgDig, _nasc, _id);
END $$
DELIMITER ;
CALL inserirClientePF("Pimpão", 325, Null, 12345051, 12345678911, 12345678, "0", "2000-10-12");
CALL inserirClientePF("Disney Chaplin", 89, "Ap. 12", 12345053, 12345678912, 12345679, "0", "2001-11-21");
CALL inserirClientePF("Marciano", 744, Null, 12345054, 12345678913, 12345680, "0", "2001-06-01");
CALL inserirClientePF("Lança Perfume", 128, Null, 12345059, 12345678914, 12345681, "X", "2004-04-05");
CALL inserirClientePF("Remédio Amargo", 2585, Null, 12345058, 12345678915, 12345682, "0", "2002-07-15");

DESCRIBE tbCliente;
DESCRIBE tbClientePJ;
SELECT * FROM tbEndereco;
INSERT INTO tbBairro (bairro) VALUES ("Sei Lá");
INSERT INTO tbCidade (cidade) VALUES ("Recife");
INSERT INTO tbEstado (uf) VALUES ("PE");
INSERT INTO tbEndereco (cep, logradouro, bairroId, cidadeId, ufId) VALUES (12345060, "Rua dos Amores", 10, 12, 5);
DELIMITER $$
CREATE PROCEDURE inserirClientePJ(
	IN _nomeCli VARCHAR(200),
    IN _numEnd NUMERIC(6),
    IN _compEnd VARCHAR(50),
    IN _cepCli NUMERIC(8),
    IN _cnpj NUMERIC(14),
    IN _ie NUMERIC(11)
)
BEGIN
	DECLARE _id INT;
	INSERT INTO tbCliente (nomeCli, numEnd, compEnd, cepCli) VALUES
		(_nomeCli, _numEnd, _compEnd, _cepCli);
	SELECT id INTO _id
    FROM tbCliente
    WHERE nomeCli = _nomeCli;
	INSERT INTO tbClientePJ (cnpj, ie, id) VALUES
		(_cnpj, _ie, _id);
END $$
DELIMITER ;
CALL inserirClientePJ("Paganada", 159, Null, 12345051, 12345678912345, 98765432198);
CALL inserirClientePJ("Caloteando", 69, Null, 12345053, 12345678912346, 98765432199);
CALL inserirClientePJ("Semgrana", 189, Null, 12345060, 12345678912347, 98765432100);
CALL inserirClientePJ("Cemreais", 5024, "Sala 23", 12345060, 12345678912348, 98765432101);
CALL inserirClientePJ("Durango", 1254, Null, 12345060, 12345678912349, 98765432102);

DESCRIBE tbCompra;
DESCRIBE tbItemCompra;
SELECT * FROM tbFornecedor;
SELECT * FROM tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirCompra(
	IN _notaFiscal INT,
    IN _dataCompra CHAR(10),
    IN _valorTotal DECIMAL(7, 2),
    IN _qtdTotal SMALLINT,
    IN _fornecedor INT,
    IN _qtd SMALLINT,
    IN _valorItem DECIMAL(7, 2),
    IN _codBarras NUMERIC(14)
)
BEGIN
	DECLARE procurarNf INT;
    SELECT notaFiscal INTO procurarNf
    FROM tbCompra WHERE notaFiscal = _notaFiscal;
    IF procurarNf IS NULL THEN
		INSERT INTO tbCompra (notaFiscal, dataCompra, valorTotal, qtdTotal, codigo) VALUES
			(_notaFiscal, STR_TO_DATE(_dataCompra, "%d/%m/%Y"), _valorTotal, _qtdTotal, _fornecedor);
	END IF;
	INSERT INTO tbItemCompra (qtd, valorItem, notaFiscal, codBarras) VALUES
		(_qtd, _valorItem, _notaFiscal, _codBarras);
END $$
DELIMITER ;
CALL inserirCompra(8459, "01/05/2018", 21944.00, 700, 5, 200, 22.22, 12345678910111);
CALL inserirCompra(2482, "22/04/2020", 7290.00, 180, 1, 180, 40.50, 12345678910112);
CALL inserirCompra(21563, "12/07/2020", 900.00, 300, 6, 300, 3.00, 12345678910113);
CALL inserirCompra(156354, "23/11/2021", 18900.00, 350, 1, 500, 35.00, 12345678910114);
CALL inserirCompra(8459, Null, Null, Null, Null, 350, 54.00, 12345678910115);

DESCRIBE tbVenda;
DESCRIBE tbItemVenda;
SELECT * FROM tbCliente;
SELECT * FROM tbProduto;
DELIMITER $$
CREATE PROCEDURE inserirVenda(
	IN _numVenda INT,
    IN _totalVenda DECIMAL(7, 2),
    IN _idCli INT,
    IN _codBarras NUMERIC(14),
    IN _valorItem DECIMAL(7, 2),
    IN _qtd SMALLINT
)
BEGIN
	INSERT INTO tbVenda (numeroVenda, dataVenda, totalVenda, idCli) VALUES
		(_numVenda, NOW(), _totalVenda, _idCli);
	INSERT INTO tbItemVenda (numeroVenda, codBarras, valorItem, qtd) VALUES
		(_numVenda, _codBarras, _valorItem, _qtd);
END $$
DELIMITER ;
CALL inserirVenda(1, 54.61, 1, 12345678910111, 54.61, 1);
CALL inserirVenda(2, 200.90, 4, 12345678910112, 100.45, 2);
CALL inserirVenda(3, 44.00, 1, 12345678910113, 44.00, 1);

DESCRIBE tbNotaFiscal;
DESCRIBE tbCliente;
DESCRIBE tbVenda;
DELIMITER $$
CREATE PROCEDURE emitirNota(
	IN codNota INT,
    IN nomeCliente VARCHAR(200)
)
BEGIN
	DECLARE idCliente INT;
    DECLARE valorNota DECIMAL(7, 2);
    SELECT id INTO idCliente
    FROM tbcliente
    WHERE nomeCli = nomeCliente;
    IF idCliente IS NOT NULL THEN
		SELECT SUM(totalVenda) INTO valorNota FROM tbVenda
        WHERE idCli = idCliente;
        IF valorNota IS NOT NULL THEN
			INSERT INTO tbNotaFiscal (nf, totalNota, dataEmissao) VALUES (codNota, valorNota, NOW());
            UPDATE tbVenda SET nf = codNota
            WHERE idCli = idCliente;
		END IF;
    END IF ;
END $$
DELIMITER ;
CALL emitirNota(359, "Pimpão");
CALL emitirNota(360, "Lança Perfume");

DESCRIBE tbProduto;
CALL inserirProduto(12345678910130, "Camisa de Poliéster", 35.61, 100);
CALL inserirProduto(12345678910131, "Blusa Frio Moletom", 200.00, 100);
CALL inserirProduto(12345678910132, "Vestido Decote Redondo", 144.00, 50);

SELECT * FROM tbProduto;
DELETE FROM tbProduto WHERE codBarras = 12345678910116;
DELETE FROM tbProduto WHERE codBarras = 12345678910117;

DESCRIBE tbProduto;
DELIMITER $$
CREATE PROCEDURE atualizarProdutos(
	IN novoValor DECIMAL(7, 2),
    IN codItem NUMERIC(14)
)
BEGIN
	UPDATE tbProduto SET valor = novoValor
    WHERE codBarras = codItem;
END $$
DELIMITER ;
CALL atualizarProdutos(64.50, 12345678910111);
CALL atualizarProdutos(120.00, 12345678910112);
CALL atualizarProdutos(64.00, 12345678910113);

DELIMITER $$
CREATE PROCEDURE mostrarProdutos()
BEGIN
	SELECT * FROM tbProduto;
END $$
DELIMITER ;
CALL mostrarProdutos;

CREATE TABLE tbProdutoHistorico LIKE tbProduto;
ALTER TABLE tbProdutoHistorico ADD ocorrencia VARCHAR(20);
ALTER TABLE tbProdutoHistorico ADD atualizacao DATETIME;
ALTER TABLE tbProdutoHistorico DROP PRIMARY KEY;
ALTER TABLE tbProdutoHistorico ADD PRIMARY KEY (codBarras, ocorrencia, atualizacao);

DESCRIBE tbProdutoHistorico;
DELIMITER $$
CREATE TRIGGER novoHistorico
AFTER INSERT ON tbProduto FOR EACH ROW
BEGIN
	INSERT INTO tbProdutoHistorico (codBarras, nome, valor, qtd, ocorrencia, atualizacao) VALUES
		(NEW.codBarras, NEW.nome, NEW.valor, NEW.qtd, "Novo", NOW());
END $$
DELIMITER ;
INSERT INTO tbProduto (codBarras, nome, valor, qtd) VALUES
	(12345678910119, "Água Mineral", 1.99, 500);
SELECT * FROM tbProdutoHistorico;

DELIMITER $$
CREATE TRIGGER atualizarHistorico
AFTER UPDATE ON tbProduto FOR EACH ROW
BEGIN
	INSERT INTO tbProdutoHistorico (codBarras, nome, valor, qtd, ocorrencia, atualizacao) VALUES
		(NEW.codBarras, NEW.nome, NEW.valor, NEW.qtd, "Atualizado", NOW());
END $$
DELIMITER ;
UPDATE tbProduto SET valor = 2.99
WHERE nome = "Água Mineral";
SELECT * FROM tbProdutoHistorico;

SELECT * FROM tbProduto;

SELECT * FROM tbCliente;
CALL inserirVenda(4, 64.50, 2, 12345678910111, 64.50, 1);

SELECT * FROM tbVenda ORDER BY numeroVenda DESC LIMIT 1;

SELECT * FROM tbItemVenda ORDER BY numeroVenda DESC, codBarras DESC LIMIT 1;

DELIMITER  $$
CREATE PROCEDURE pesquisarCliente(IN nome VARCHAR(200))
BEGIN
	SELECT * FROM tbCliente WHERE nomeCli = nome;
END $$
DELIMITER ;
CALL pesquisarCliente("Disney Chaplin");