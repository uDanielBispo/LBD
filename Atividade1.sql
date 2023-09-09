CREATE TABLE livro (
    codigolivro  NUMBER(5) PRIMARY KEY,
    titulo       VARCHAR2(30),
    editora      VARCHAR2(20),
    cidade       VARCHAR2(30),
    dataedicao   DATE,
    versao       NUMBER(3),
    codassunto   NUMBER(5),
    preco        NUMBER(5, 2),
    datacadastro DATE,
    lancamento   CHAR(1)
);

CREATE TABLE autorlivro (
    codigolivro NUMBER(5) NOT NULL,
    codautor    NUMBER(5) NOT NULL
);

CREATE TABLE autor (
    codautor       NUMBER(5) PRIMARY KEY,
    nomeautor      VARCHAR2(20),
    datanascimento DATE,
    cidadenasc     VARCHAR2(20),
    sexo           CHAR(1)
);

CREATE TABLE assunto (
    codassunto       NUMBER(5) PRIMARY KEY,
    descricao        VARCHAR2(40),
    descontopromocao CHAR(1)
);

ALTER TABLE AUTORLIVRO ADD CONSTRAINT PK_AUTORLIVRO PRIMARY KEY (codigolivro, codautor);
ALTER TABLE AUTORLIVRO ADD CONSTRAINT FK_AUTOR FOREIGN KEY (codautor) REFERENCES AUTOR;
ALTER TABLE AUTORLIVRO ADD CONSTRAINT FK_LIVRO FOREIGN KEY (codigolivro) REFERENCES LIVRO

--2)
--LIVROS
INSERT INTO LIVRO VALUES (1, 'titulo', 'editora', 'cidade', '01/02/2000', 1, 1, 20, '02/04/2020', 'n');
INSERT INTO LIVRO VALUES (2, 'titulo', 'editora', 'cidade', '01/03/2000', 1, 1, 10, '03/04/2020', '2');

--ASSUNTOS
INSERT INTO ASSUNTO VALUES (1, 'BANCO DE DADOS', 'n');
INSERT INTO ASSUNTO VALUES (2, 'POO', 'n');

--AUTOR
INSERT INTO AUTOR VALUES (1, 'DANIEL', '04/02/2003', 'SOROCABA', 'm');
INSERT INTO AUTOR VALUES (2, 'BERNARDO', '17/01/2000', 'SAO PAULO', 'm');

--AUTORLIVRO
INSERT INTO AUTORLIVRO VALUES (1,1);
INSERT INTO AUTORLIVRO VALUES (2,2);

--RESPOSTA: SIM, POIS HÁ A NECESSIDADE DE POSSUIR-SE OS DADOS DO AUTOR E DO LIVRO ANTES DE ADICIONAR NA 
--TABELA AUTORLIVRO

--3)
ALTER TABLE AUTOR ADD Nacionalidade VARCHAR(20);

--4)
ALTER TABLE LIVRO MODIFY Titulo VARCHAR (40);

--5)
ALTER TABLE ASSUNTO ADD CONSTRAINT chk_descontopromocao CHECK (descontopromocao IN ('s', 'n'));

--6)
UPDATE LIVRO SET editora = 'Editora LTC' WHERE codigolivro = 3;

--7)
DELETE FROM LIVRO WHERE codassunto = 10 AND EXTRACT(YEAR FROM DATAEDICAO) < 1980;

--8)
SELECT titulo FROM LIVRO WHERE titulo = '%Banco de Dados%';

--9)
SELECT nomeautor 
FROM AUTOR 
WHERE EXTRACT(YEAR FROM datanascimento) BETWEEN 1950 AND 1970
ORDER BY cidadenasc, nomeautor;

--10)
SELECT A.codassunto, A.descricao, COUNT(L.codigolivro)
FROM LIVRO L
INNER JOIN assunto A
ON l.codassunto = A.codassunto
GROUP BY a.codassunto, a.descricao;

--11)
SELECT l.titulo, a.descricao
FROM Livro l
INNER JOIN ASSUNTO a
ON l.codassunto = a.codassunto;

--12)
SELECT L.CODIGOLIVRO, L.TITULO, A.CODAUTOR, A.NOMEAUTOR
FROM LIVRO L
LEFT JOIN AUTORLIVRO AL ON L.CODIGOLIVRO = AL.CODIGOLIVRO
LEFT JOIN AUTOR A ON AL.CODAUTOR = A.CODAUTOR
GROUP BY L.CODIGOLIVRO, L.TITULO, A.CODAUTOR, A.NOMEAUTOR;

--13)
SELECT al.codautor
FROM autorlivro al
INNER JOIN autor a 
ON al.codautor = a.codautor
GROUP BY al.codautor
HAVING COUNT(al.codigolivro) > 3;

DROP TABLE LIVRO;
DROP TABLE AUTOR;
DROP TABLE ASSUNTO;
DROP TABLE AUTORLIVRO;
