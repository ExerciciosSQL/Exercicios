DELETE
FROM tbtelefone_cliente
WHERE Cpf = 12345678911;

UPDATE tbconta
SET TipoConta = 2
WHERE NumeroConta = 9879;

SELECT Cpf
FROM tbcliente
WHERE Nome = 'Monica';

UPDATE tbcliente
SET Email = 'Astro@Escola.com'
WHERE Cpf = 12345678912;

UPDATE tbconta
SET Saldo = 501.75
WHERE NumeroConta = 9876;

SELECT Nome, Email, Endereco
FROM tbcliente
WHERE Nome = 'Monica';

SELECT Cpf
FROM tbcliente
WHERE Nome = 'Enildo';

UPDATE tbcliente 
SET Nome = 'Enildo Candido', Email = 'enildo@escola.com'
WHERE Cpf = 12345678910;

UPDATE tbconta
SET Saldo = Saldo - 30;

/*
DELETE 
FROM tbconta
WHERE NumeroConta = 9878;


NÃO FOI POSSÍVEL REALIZAR ESTE COMANDO, POIS HÁ REFERÊNCIAS NAS TABELAS tbhistorico QUE DEPENDEM DESTE REFERENCIAL
*/