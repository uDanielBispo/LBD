Drop table TB_item_pedido;
drop table tb_pedido;
drop table tb_vendedor;
drop table tb_cliente;
drop table tb_produto;

create table tb_cliente
( codcliente number(5) not null,
  nomecliente varchar2(30) not null,
  endereco varchar2(30),
  cidade varchar2(20),
  cep varchar2(10),
  uf char(2));


create table tb_vendedor
( codvendedor number(5) not null,
  nomevendedor varchar2(30) not null,
  faixa_com    number(4,2),
  salario_fixo number(7,2));


create table tb_produto
( codproduto   number(5) not null,
  descricao varchar(20),
  unid       char(2),
  valor_unit number(6,2));

Create table TB_PEDIDO
( NUMPEDIDO     number(5) NOT NULL,
  PRAZO_ENTREGA DATE,
  CODCLIENTE     number(5),
  CODVENDEDOR   number(5));

CREATE TABLE TB_ITEM_PEDIDO
(NUMPEDIDO   number(5) NOT NULL,
 CODPRODUTO  number(5) NOT NULL,
 QTDE        number(5));


-- DEFININDO AS RESTRIÇÕES

-- Criando as PK´s

ALTER TABLE TB_CLIENTE 
 ADD CONSTRAINT PK_CLIENTE_CODCLIENTE PRIMARY KEY(CODCLIENTE);


ALTER TABLE TB_PRODUTO 
 ADD CONSTRAINT PK_PRODUTO_CODPRODUTO PRIMARY KEY(CODPRODUTO);
 
 
 ALTER TABLE TB_VENDEDOR 
 ADD CONSTRAINT PK_VENDEDOR_CODVENDEDOR PRIMARY KEY(CODVENDEDOR);
 

ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT PK_PEDIDO_NUMPEDIDO PRIMARY KEY(NUMPEDIDO);


ALTER TABLE TB_ITEM_PEDIDO ADD CONSTRAint  PK_ITEMPEDIDO_PEDPROD 
 PRIMARY KEY(NUMPEDIDO,CODPRODUTO);
 
 
----
ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT FK_PEDIDO_CODCLI FOREIGN KEY(CODCLIENTE) REFERENCES TB_CLIENTE;

ALTER TABLE TB_PEDIDO 
 ADD CONSTRAINT FK_PEDIDO_CODVENDEDOR FOREIGN KEY(CODVENDEDOR) REFERENCES TB_VENDEDOR;

--- ITEM PEDIDO

ALTER TABLE TB_ITEM_PEDIDO 
    ADD CONSTRAINT FK_ITEMPEDIDO_NUMPEDIDO FOREIGN KEY(NUMPEDIDO) REFERENCES TB_PEDIDO;

ALTER TABLE TB_ITEM_PEDIDO 
    ADD CONSTRAINT FK_ITEMPEDIDO_CODPRODUTO FOREIGN KEY(CODPRODUTO) REFERENCES TB_PRODUTO;

----

-- INSERINDO DADOS
insert into TB_vendedor values (5,'Antonio Pedro',5.0,400);
insert into TB_vendedor values (15,'Carlos Sola',0.0,400);
insert into tb_vendedor values (25,'Ana Carolina',1.0,200);
insert into TB_vendedor values (35,'Solange Almeida',1.0,300);

SELECT * FROM TB_VENDEDOR;

INSERT INTO TB_CLIENTE 
VALUES ( 30, 'João da Silva', 'AV. MATT HOFFMANN, 1100', 'SÃO PAULO', '97056-001', 'SP')
/

INSERT INTO TB_CLIENTE 
VALUES ( 31, 'LUCAS ANTUNES', 'RUA TRODANI, 120', 'SOROCABA', '19658-023', 'SP')
/

INSERT INTO Tb_CLIENTE 
VALUES ( 32, 'LAURA STRAUSS', 'RUA TULIPAS, 650', 'PRIMAVERA', '18556-025', 'SP')
/


INSERT INTO TB_PRODUTO 
VALUES ( 11, 'APPLE DISPLAY', 'UN', 975.99)
/

INSERT INTO TB_PRODUTO VALUES ( 12, 'IBM THINK PAD R61', 'UN', 999.70)
/

INSERT INTO TB_PRODUTO VALUES ( 13, 'PÓ PARA TONER', 'KG', 85.60)
/

INSERT INTO TB_PEDIDO VALUES ( 7, '26/02/2019', 31, 15)
/

INSERT INTO TB_PEDIDO VALUES ( 8, '23/05/2019', 32, 25)
/

INSERT INTO TB_PEDIDO VALUES ( 9, '21/02/2019', 32, 5)
/

INSERT INTO TB_PEDIDO VALUES ( 10, '20/02/2019', 30, 5)
/

SELECT * FROM TB_PEDIDO;

INSERT INTO TB_ITEM_PEDIDO VALUES (7, 11, 3);

INSERT INTO TB_ITEM_PEDIDO VALUES (7, 12, 3);

INSERT INTO TB_ITEM_PEDIDO VALUES (8, 13, 3);
INSERT INTO TB_ITEM_PEDIDO VALUES (9, 11, 3);
INSERT INTO TB_ITEM_PEDIDO VALUES (10, 11, 3);
INSERT INTO TB_ITEM_PEDIDO VALUES (10, 12, 3);
INSERT INTO TB_ITEM_PEDIDO VALUES (10, 13, 3);

---
SELECT * FROM TB_CLIENTE;
SELECT * FROM TB_VENDEDOR;
SELECT * FROM TB_PRODUTO;
SELECT * FROM TB_PEDIDO;
SELECT * FROM TB_ITEM_PEDIDO;

--
--Exemplo1: Listar a descrição do produto que tem o preço unitário maior que a média.

forma 1: com 2 selects isolados

(select avg(valor_unit) from TB_PRODUTO);
678,97

select * from tb_produto
where valor_unit > 678,97;

forma 2: usando subconsulta

select * from tb_produto
where valor_unit > (select avg(valor_unit) from TB_PRODUTO);

ou com subconsulta:

        select descricao from tb_produto 
        where valor_unit > (select avg(valor_unit) from TB_PRODUTO);

	>   <    >=   <=   <>


--Exemplo2: Listar o nome dos clientes que moram na mesma cidade do 'João da Silva';


    select nomecliente from Tb_cliente
    where nomecliente <> 'João da Silva'  
    and cidade = (select cidade from Tb_cliente where nomecliente = 'João da Silva');	

    x in (x,y,z)
    
--Exemplo3: Listar o nome dos clientes que tem pedidos


** Pode ser feito usando junção:

select nomecliente from TB_cliente inner join tb_pedido
on tb_pedido.codcliente = tb_cliente.codcliente;

dar preferência a junção, pois é mais rápida a execução e o SGBD pode usar os índices criados


** usando subconsultas:

exibir o nome dos clientes que tem pedidos:

 select nomecliente from TB_cliente
 where codcliente in ( select codcliente from TB_pedido);
--não é tão eficiente.	

Exemplo4: Listar o nome dos clientes que não tem pedidos

select codcliente, nomecliente from tb_cliente
 where codcliente not in ( select codcliente from TB_pedido);

-- usando operador da algebra relacional(mais restrita a exibição)
select codcliente from TB_cliente
minus 
select  codcliente  from TB_pedido


select nome_cliente from cliente,pedido
where pedido.cod_cliente <> cliente.cod_cliente; --- não funciona

Exemplo 5: Listar o nome do vendedor que não tem pedidos com prazo de entrega em fevereiro/2020.
========


 select tb_vendedor.codvendedor,nomevendedor
 from Tb_vendedor, tb_pedido
 where Tb_pedido.codvendedor = tb_vendedor.codvendedor and 
 to_char(prazo_entrega,'mm/yyyy') <> '02/2020'; 


A consulta acima não contempla o vendedor que nunca fez pedidos

select nomevendedor from tb_vendedor
where codvendedor not in (select codvendedor from tb_pedido
                            where to_char(prazo_entrega,'mm/yyyy') = '02/2020')



para se filtrar  02 de 2020 podemos usar:


where to_char(prazo_entrega,'mm/yyyy') = '08/2020'

ou
 where prazo_entrega between '01/08/2020' and '31/08/2020';


 --year(prazo_entrega) = 2020 and month(prazo_entrega) = 08 sql server

(extract year from prazo_entrega)  = 2020 and (extract month from prazo_entrega) 



