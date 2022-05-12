/* 
CLIENTE(id_cliente, nome_cliente, data_nasc, endereco);


DONO_DE_NEGOCIO(id_dono(CLIENTE.id_cliente), linkedin);


PIZZARIA(id_pizzaria, id_dono(DONO_DE_NEGOCIO.id_dono), cep, endereco, web_site, abertura, fechamento);

TELEFONE(pizzaria(PIZZARIA.id_pizzaria), telefone);


PIZZA(pizzaria(PIZZARIA.id_pizzaria), nome_pizza, preco);


TIPO_PIZZA(id_tipo, pizzaria(PIZZA.pizzaria), nome_pizza(PIZZA.nome_pizza), nome_tipo,descricao);


TRADICIONAL(tipo(TIPO_PIZZA.id_tipo));


ESPECIAL(tipo(TIPO_PIZZA.id_tipo));


ACOMPANHAMENTO(id_acompa, pizzaria(PIZZARIA.id_pizzaria), nome_acompa, descricao, tipo_acompa, preco_acompa);


CONSUMIDOR_FAMINTO(cliente(CLIENTE.id_cliente), endereco_entrega);


PEDIDO(id_pedido, cliente(CONSUMIDOR_FAMINTO.cliente),qtd_pessoas, horario_entrega, custo_total, data_pedido, horario_pedido);


ACOMPA_PEDIDO(id_acompa(ACOMPANHAMENTO.id_acompa), pedido(PEDIDO.id_pedido), qtd_acomp);


PREPARACAO_PEDIDO(pedido(PEDIDO.id_pedido), pizzaria(PIZZA.pizzaria), nome_pizza(PIZZA.nome_pizza ), tipo_massa, borda, qtd_molho);


INGREDIENTE_EXTRA(pedido(PEDIDO.id_pedido), nome_ingre, preco_ingre, id_extra);


PEDIDOS_COMBOS(pedido(PEDIDO.id_pedido));

COMBOS(id_combo, nome_combo)

TEM_COMBO(combos(COMBOS.id_combo), pedido(PEDIDO_COMBOS.pedido), qtd_combo)




ANIMADOR(id_animador(CLIENTE.id_cliente), nome_artistico, biografia, preco_30m);


TRABALHO( id_animador(ANIMADOR.id_animador), pizzaria(PIZZARIA.id_pizzaria),disponibilidade)


PIZZA_COMBO(combo(COMBOS.id_combo ), pizzaria(PIZZARIA.id_pizzaria), nome_pizza(PIZZA.nome_pizza));


RETIRADA(pedido(PEDIDO.id_pedido), horario_retirada);




ENTRETENIMENTO(pedido(PEDIDO.id_pedido), id_animador(ANIMADOR.id_animador), duracao);
*/







/* 
SQL…………………………….………………………..SQL
*/



SET search_path TO pizzaria, dmy;


CREATE TABLE CLIENTE(
	id_cliente smallint NOT NULL,
	nome_cliente varchar(100) NOT NULL,
	data_nasc date NOT NULL,
	endereco varchar(200) NOT NULL,
	CONSTRAINT clientepk PRIMARY KEY (id_cliente)


);


CREATE TABLE DONO_DE_NEGOCIO(
	id_dono smallint NOT NULL,
	linkedin varchar(100) NOT NULL,	
	CONSTRAINT donopk PRIMARY KEY (id_dono),
	CONSTRAINT donofk FOREIGN KEY (id_dono) REFERENCES CLIENTE(id_cliente)


);


CREATE TABLE PIZZARIA(
	id_pizzaria smallint NOT NULL,
	id_dono smallint NOT NULL,
	cep varchar(15) NOT NULL,
	endereco varchar(200) NOT NULL,
	web_site varchar(100) NOT NULL,
	abertura time NOT NULL,
	fechamento time NOT NULL,
	CONSTRAINT pizzariapk PRIMARY KEY (id_pizzaria),
	CONSTRAINT pizzariafk FOREIGN KEY (id_dono) REFERENCES DONO_DE_NEGOCIO(id_dono)
	


);


CREATE TABLE TELEFONE(
	pizzaria smallint NOT NULL,
	telefone varchar(15) NOT NULL,
	CONSTRAINT telefonefk FOREIGN KEY (pizzaria) REFERENCES PIZZARIA(id_pizzaria)
);


CREATE TABLE PIZZA(
	pizzaria smallint NOT NULL,
	nome_pizza varchar(50) NOT NULL,
	preco float NOT NULL,
	CONSTRAINT pizzapk PRIMARY KEY (pizzaria, nome_pizza),	
	CONSTRAINT pizzafk FOREIGN KEY (pizzaria) REFERENCES PIZZARIA(id_pizzaria)
);


CREATE TABLE TIPO_PIZZA(
	id_tipo smallint NOT NULL,
	pizzaria smallint NOT NULL,
	descricao varchar(30) NOT NULL,
	nome_pizza varchar(50) NOT NULL,
	nome_tipo varchar(50) NOT NULL,
	CONSTRAINT tipo_pizzapk PRIMARY KEY (id_tipo),
	CONSTRAINT tipo_pizzafk FOREIGN KEY (pizzaria , nome_pizza) REFERENCES PIZZA(pizzaria,nome_pizza)
	
	
	
);


CREATE TABLE TRADICIONAL(
	tipo smallint NOT NULL,
	CONSTRAINT tradiconalpk PRIMARY KEY (tipo),
	CONSTRAINT tradiconalfk FOREIGN KEY (tipo) REFERENCES TIPO_PIZZA(id_tipo)
	
);
CREATE TABLE ESPECIAL(
	tipo smallint NOT NULL,
	CONSTRAINT especialpk PRIMARY KEY (tipo),
	CONSTRAINT especialfk FOREIGN KEY (tipo) REFERENCES TIPO_PIZZA(id_tipo)
	
);
CREATE TABLE ACOMPANHAMENTO(
	id_acompa smallint NOT NULL,
	pizzaria smallint NOT NULL,
	nome_acompa varchar(50) NOT NULL,
	descricao varchar(200) NOT NULL,
	tipo_acompa varchar(30) NOT NULL,
	preco_acompa float NOT NULL,
	CONSTRAINT acompanhamentolpk PRIMARY KEY (id_acompa),
	CONSTRAINT acompanhamentolfk FOREIGN KEY (pizzaria) REFERENCES PIZZARIA(id_pizzaria)
	
);


CREATE TABLE CONSUMIDOR_FAMINTO(
	cliente smallint NOT NULL,
	endereco_entrega varchar(100),
	CONSTRAINT consumidor_famintopk PRIMARY KEY (cliente),
	CONSTRAINT consumidor_famintofk FOREIGN KEY (cliente) REFERENCES CLIENTE(id_cliente)
);
CREATE TABLE PEDIDO(
	id_pedido smallint NOT NULL,
	cliente smallint NOT NULL,
	qtd_pessoas int2 DEFAULT 1,
	horario_entrega time,
	custo_total float NOT NULL,
	data_pedido date NOT NULL,
	horario_pedido time NOT NULL,
	CONSTRAINT pedidopk PRIMARY KEY (id_pedido),
	CONSTRAINT pedidofk FOREIGN KEY (cliente) REFERENCES CONSUMIDOR_FAMINTO(cliente)
);
CREATE TABLE ACOMPA_PEDIDO(
	id_acompa smallint NOT NULL,
	pedido smallint NOT NULL,
	qtd_acomp int2 NOT NULL,
	CONSTRAINT acompa_pedidopk PRIMARY KEY (id_acompa, pedido),
	CONSTRAINT acompa_pedidofk FOREIGN KEY (id_acompa) REFERENCES ACOMPANHAMENTO(id_acompa),
	CONSTRAINT acompa_pedidofk2 FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido)
);
CREATE TABLE PREPARACAO_PEDIDO(
	pedido smallint NOT NULL,
	pizzaria smallint NOT NULL,
	nome_pizza varchar(50) NOT NULL,
tipo_massa varchar(50) NOT NULL,
	borda varchar(50) NOT NULL,
qtd_molho varchar(50) NOT NULL,
	
	CONSTRAINT preparacao_pedidopk PRIMARY KEY (pedido,pizzaria,nome_pizza),
	CONSTRAINT preparacao_pedidofk FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido),
	CONSTRAINT preparacao_pedidofk2 FOREIGN KEY ( pizzaria ,nome_pizza) REFERENCES PIZZA(pizzaria,nome_pizza)
	
);




CREATE TABLE INGREDIENTE_EXTRA(
	pedido smallint NOT NULL,
	nome_ingre varchar(50) NOT NULL,
	preco_ingre varchar(50) NOT NULL,
	id_extra smallint NOT NULL,
	CONSTRAINT ingrediente_extrapk PRIMARY KEY (pedido),
	CONSTRAINT ingrediente_extrafk FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido)
);

CREATE TABLE PEDIDOS_COMBOS(
	pedido smallint NOT NULL,
	CONSTRAINT pedidos_combospk PRIMARY KEY (pedido),
	CONSTRAINT pedidos_combosfk FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido)
);


CREATE TABLE COMBOS(
	id_combo smallint NOT NULL,
	nome_combo varchar(50),
	CONSTRAINT combospk PRIMARY KEY (id_combo)
);


CREATE TABLE TEM_COMBO(
	combos smallint NOT NULL,
	pedido smallint NOT NULL,
	qtd_combo int2 NOT NULL,
	CONSTRAINT tem_combopk PRIMARY KEY (combos,pedido),
	CONSTRAINT tem_combofk FOREIGN KEY (combos) REFERENCES COMBOS(id_combo),
	CONSTRAINT tem_combofk2 FOREIGN KEY (pedido) REFERENCES PEDIDOS_COMBOS(pedido)
	
);




CREATE TABLE PIZZA_COMBO(
	combo smallint NOT NULL,
	pizzaria smallint NOT NULL,
	nome_pizza varchar(50) NOT NULL,
	CONSTRAINT pizza_combopk PRIMARY KEY (combo,pizzaria,nome_pizza),
	CONSTRAINT pizza_combofk FOREIGN KEY (combo) REFERENCES COMBOS(id_combo),
	CONSTRAINT pizza_combofk2 FOREIGN KEY (pizzaria, nome_pizza) REFERENCES PIZZA(pizzaria ,nome_pizza)
	
);
CREATE TABLE ANIMADOR(
	id_animador smallint NOT NULL,
	nome_artistico varchar(50) NOT NULL,
	biografia varchar(100) NOT NULL,
	preco_30m float NOT NULL,
	CONSTRAINT animadorpk PRIMARY KEY (id_animador),
	CONSTRAINT animadorfk FOREIGN KEY (id_animador) REFERENCES CLIENTE(id_cliente)
	
);
CREATE TABLE RETIRADA(
	pedido smallint NOT NULL,
	horario_retirada time NOT NULL,
	CONSTRAINT retiradapk PRIMARY KEY (pedido),
	CONSTRAINT retiradafk FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido)
);




CREATE TABLE ENTRETENIMENTO(
	pedido smallint NOT NULL,
	id_animador smallint NOT NULL,
	duracao int2 NOT NULL,
	CONSTRAINT entretenimentopk PRIMARY KEY (pedido),
	CONSTRAINT entretenimentofk FOREIGN KEY (pedido) REFERENCES PEDIDO(id_pedido),
	CONSTRAINT entretenimentofk2 FOREIGN KEY (id_animador) REFERENCES ANIMADOR(id_animador)
	
);
CREATE TABLE TRABALHA(
	id_animador smallint NOT NULL,
	pizzaria smallint NOT NULL,
	disponibilidade varchar(50),
	CONSTRAINT trabalhapk PRIMARY KEY (id_animador,pizzaria),
	CONSTRAINT trabalhafk FOREIGN KEY (id_animador) REFERENCES	ANIMADOR(id_animador),
	CONSTRAINT trabalhafk2 FOREIGN KEY (pizzaria) REFERENCES PIZZARIA(id_pizzaria)
);


/* 
Inserts

    Coisas que precisam ser analisadas ainda:
    - Pelo fato da tabela de pedidos não ter o atributo de pizzaria,
    vc vai ter que olhar em cada tabela que tá relacionada com cada pedido
    (pizzas, combos, animadores, etc) se a pizzaria relacionada com esse pedido
    tem aquelas coisas. Se não tiver, vc vai ter que mudar atributos do pedido. Além 
    disso, vc também tem que calcular o preço total dos pedidos.

    - precisa adicionar preço nos combos, pq cada combo, por ser como uma promoção,
    tem que ter um preço diferente do que a simples soma dos itens.
    (eu fiz os combos sendo em vez de combos de várias pizzas, serem
    combos de uma pizza com outra coisa, pra eu não ter que fazer uns 20
    inserts em outra tabela relacionada a isso, e isso também mostra
    que é preciso um atributo preço na tabela de combos).


*/


/* 
    Inserts de clientes
*/

INSERT INTO CLIENTE VALUES (1, 'Vitor Teixeira', '03/07/2000', 'Rua Bergamo, 1840, Jardim Europa'),
                           (2, 'Luiz Felipe', '04/11/1987', 'Rua Manoel Machado Filho, 206, Chácaras Tubalina e Quartel'),
                           (3, 'Amélia Ribeiro', '09/12/1999', 'Rua Siomara Carla de Jesus, 764, Shopping Park'),
                           (4, 'Camila Cabello', '15/03/2003', 'Rua Bergamo, 190, Jardim Europa'),
                           (5, 'Bartolomeu Seixas', '23/12/2001', 'Praça dos Araújos, 2043, Mansões Aeroporto'),
                           (6, 'João Foguetes',  '24/07/1995', 'Rua do Estivador, 203, Jardim das Palmeiras'),
                           (7, 'Maria Felipe', '12/12/2000', 'Rua Francino Vieira de Barros, 1530, Tocantins'),
                           (8, 'Ramon Seixas', '12/11/2001', 'Rua Bergamo, 1856, Jardim Europa'),
                           (9, 'Ramona Flowers', '03/04/2005', 'Praça dos Araújos, 1989, Mansões Aeroporto'),
                           (10, 'Madalena Elise', '07/08/1982', 'Rua Dirceu Alves Pereira, 1326, Chácaras Tubalina e Quartel'),
                           (11, 'Vitor Daniel', '03/07/2000', 'Rua Bergamo, 1832, Jardim Europa'),
                           (12, 'Haroldo Felipe', '04/11/1987', 'Rua Manoel Machado Filho, 236, Chácaras Tubalina e Quartel'),
                           (13, 'Camila Ribeiro', '09/12/1999', 'Rua Siomara Carla de Jesus, 564, Shopping Park'),
                           (14, 'Camila Antônia', '15/03/2003', 'Rua Bergamo, 208, Jardim Europa'),
                           (15, 'Raul Seixas', '23/12/2001', 'Praça dos Araújos, 243, Mansões Aeroporto'),
                           (16, 'João Guedes',  '24/07/1995', 'Rua do Estivador, 303, Jardim das Palmeiras'),
                           (17, 'Maria Bonita', '12/12/2000', 'Rua Francino Vieira de Barros, 1670, Tocantins'),
                           (18, 'Ramon Orlinda', '12/11/2001', 'Rua Bergamo, 1976, Jardim Europa'),
                           (19, 'Carlos Flowers', '03/04/2005', 'Praça dos Araújos, 2349, Mansões Aeroporto'),
                           (20, 'Tietê Elise', '07/08/1982', 'Rua Dirceu Alves Pereira, 1674, Chácaras Tubalina e Quartel'),
                           (21, 'Viktor Dmitri', '03/07/2000', 'Rua Bergamo, 2354, Jardim Europa'),
                           (22, 'Luiz Fernando', '04/11/1987', 'Rua Manoel Machado Filho, 386, Chácaras Tubalina e Quartel'),
                           (23, 'Armando Ribeiro', '09/12/1999', 'Rua Siomara Carla de Jesus, 984, Shopping Park'),
                           (24, 'Ortízio Cabello', '15/03/2003', 'Rua Bergamo, 540, Jardim Europa'),
                           (25, 'Eliseu Seixas', '23/12/2001', 'Praça dos Araújos, 2865, Mansões Aeroporto'),
                           (26, 'João Menezes',  '24/07/1995', 'Rua do Estivador, 1233, Jardim das Palmeiras'),
                           (27, 'Humberto Felipe', '12/12/2000', 'Rua Francino Vieira de Barros, 2430, Tocantins'),
                           (28, 'Gabriel Seixas', '12/11/2001', 'Rua Bergamo, 3256, Jardim Europa'),
                           (29, 'Ramona Elise', '03/04/2005', 'Praça dos Araújos, 1629, Mansões Aeroporto'),
                           (30, 'Madalena Manoela', '07/08/1982', 'Rua Dirceu Alves Pereira, 2126, Chácaras Tubalina e Quartel');

/* 
    Inserts de donos de negocios
*/

INSERT INTO DONO_DE_NEGOCIO VALUES (1, 'teixeira-eof'),
                                   (2, 'felipe-lu206'),
                                   (3, 'rib-amelia99'),
                                   (4, 'hairr-camila'),
                                   (5, 'six-bart243'),
                                   (6, 'firejohn203'),
                                   (7, 'phil-mary'),
                                   (8,'six-ramon001'),
                                   (9, 'flores-ram'),
                                   (10, 'madelyne-her');

/* 
    Inserts de pizzarias
*/
INSERT INTO PIZZARIA VALUES (1, 2, '38410-190', 'Rua Francisco Basílio Neto, 206, São Jorge', 'batepapopizza.com', '18:00', '02:00'),
                            (2, 7, '38408-784', 'Rua Cornélio Arantes, 340, Santa Luzia', 'pizzaboa.com', '20:00', '00:00'),
                            (3, 4, '38406-265', 'Rua Adeostia Amélia Pereira, 1286, Jardim Ipanema', 'martepizza.com', '06:00', '00:00'),
                            (4, 3, '38406-265', 'Rua Adeostia Amélia Pereira, 347, Jardim Ipanema', 'venuspizza.com', '06:00', '02:00'),
                            (5, 1, '38406-784', 'Rua Cornélio Arantes, 293, Santa Luzia', 'pizzatop.com', '06:00', '00:00'),
                            (6, 2, '38400-603', 'Travessa Professor Macedo, 874, Nossa Senhora Aparecida', 'batepapopizza.com', '18:00', '02:00'),
                            (7, 6, '38412-506', 'Rua Nupotira, 113, Bela Vista', 'loucapizza.com', '20:00', '00:00'),
                            (8, 4, '38412-796', 'Rua Guatemala, 512, Parque das Américas', 'martepizza.com', '06:00', '00:00'),
                            (9, 3, '38412-796', 'Rua Guatemala, 528, Parque das Américas', 'venuspizza.com', '06:00', '02:00'),
                            (10, 9, '38410235', 'Rua Julieta Ferreira de Lima, 773, Laranjeiras', 'pizzamara.com', '06:00', '00:00');

/* 
    Inserts de telefones
*/

INSERT INTO TELEFONE VALUES (1, '(34)3752-3638'),
                            (2, '(34)7849-0828'),
                            (3, '(34)6805-5516'),
                            (4, '(34)2730-5812'),
                            (5, '(34)1059-5832'),
                            (6, '(34)5248-8838'),
                            (7, '(34)1062-0495'),
                            (8, '(34)2737-3334'),
                            (9, '(34)6060-1800'),
                            (10, '(34)6519-2723');

/* 
    Inserts de pizzas
*/

INSERT INTO PIZZA VALUES (1, 'marguerita-g', 32.90),
                         (1, 'calabresa-m', 20.50),
                         (2, 'napolitana-g', 38.99),
                         (2, 'marguerita-p', 18.00),
                         (3, 'brasileira-g', 28.90),
                         (3, 'marguerita-g', 44.90),
                         (4, 'espanhola-g', 42.90),
                         (4, 'bacon-m', 29.90),
                         (5, 'frango&catupiry-g', 32.90),
                         (5, 'alemã-g', 32.90),
                         (6, 'atum-g', 32.90),
                         (6, 'quatro-queijos-g', 32.90),
                         (7, 'muçarela-g', 32.90),
                         (7, 'presunto-p', 32.90),
                         (8, 'banana-g', 32.90),
                         (8, 'mineira-g', 32.90),
                         (9, 'prestigio-m', 32.90),
                         (9, 'lombo-canadense-g', 32.90),
                         (10, 'escandinava-m', 32.90),
                         (10, 'carne-seca-g', 32.90);

/* 
    Inserts de tipos de pizzas
*/

INSERT INTO TIPO_PIZZA VALUES (1, 1, 'pizza de marguerita grande', 'marguerita-g', 'tradicional-salgada'),
                              (2, 1, 'pizza de calabresa média', 'calabresa-m', 'especial-salgada'),
                              (3, 2, 'pizza napolitana grande', 'napolitana-g', 'tradicional-salgada'),
                              (4, 2, 'pizza de marguerita pequena', 'marguerita-p', 'especial-salgada'),
                              (5, 3, 'pizza brasileira grande', 'brasileira-g', 'tradicional-salgada'),
                              (6, 3, 'pizza de marguetira grande', 'marguerita-g', 'especial-salgada'),
                              (7, 4, 'pizza espanhola grande', 'espanhola-g', 'tradicional-salgada'),
                              (8, 4, 'pizza de bacon média', 'bacon-m', 'especial-salgada'),
                              (9, 5, 'pizza de frango com catupiry grande', 'frango&catupiry-g', 'tradicional-salgada'),
                              (10, 5, 'pizza alemã grande', 'alemã-g', 'especial-salgada'),
                              (11, 6, 'pizza de atum grande', 'atum-g', 'tradicional-salgada'),
                              (12, 6, 'pizza quatro queijos grande', 'quatro-queijos-g', 'especial-salgada'),
                              (13, 7, 'pizza de muçarela grande', 'muçarela-g', 'tradicional-salgada'),
                              (14, 7, 'pizza de presunto pequena', 'presunto-p', 'especial-salgada'),
                              (15, 8, 'pizza de banana grande', 'banana-g', 'tradicional-doce'),
                              (16, 8, 'pizza mineira grande', 'mineira-g', 'especial-salgada'),
                              (17, 9, 'pizza de prestígio média', 'prestigio-m', 'tradicional-doce'),
                              (18, 9, 'pizza de lombo canadense grande', 'lombo-canadense-g', 'especial-salgada'),
                              (19, 10, 'pizza escandinava média', 'escandinava-m', 'tradicional-salgada'),
                              (20, 10, 'pizza de carne seca grande', 'carne-seca-g', 'especial-salgada');


/* 
    Inserts de TRADICIONAIS
*/

INSERT INTO TRADICIONAL VALUES (1),
                               (3),
                               (5),
                               (7),
                               (9),
                               (11),
                               (13),
                               (15),
                               (17),
                               (19);

/* 
    Inserts de ESPECIAIS
*/

INSERT INTO ESPECIAL VALUES (2),
                            (4),
                            (6),
                            (8),
                            (10),
                            (12),
                            (14),
                            (16),
                            (18),
                            (20);


/* 
    Inserts de ACOMPANHAMENTOS
*/

INSERT INTO ACOMPANHAMENTO VALUES (1, 1, 'molho-barbecue', 'molho barbecue para pizza', 'molho', 3.90),
                                  (2, 1, 'bread-stick', 'pãozinho crocante para aperitivo', 'salgadinho', 1.50),
                                  (3, 1, 'coxinha', 'coxinha de frango', 'salgadinho', 1.00),
                                  (4, 2, 'doce-leite-ninho', 'docinho de leite ninho', 'sobremesa', 2.50),
                                  (5, 2, 'brigadeiro', 'brigadeiro de sobremesa', 'sobremesa',2.00),
                                  (6, 4, 'refri lata', 'refrigerante lata de 350ml', 'bebida', 3.50),
                                  (7, 6, 'croquete', 'salgadinho frito com recheio de queijo', 'salgadinho', 3.00),
                                  (8, 8, 'espetinho', 'espetinho de churrasco 5 pedaços', 'aperitivo', 5.90),
                                  (9, 8, 'doce de leite', 'doce de leite em barrinha', 'sobremesa', 4.00),
                                  (10, 4, 'salada de folhas', 'salada com couve, alface e outras folhas', 'salada', 6.90);

/* 
    Inserts de CONSUMIDORES famintos
*/

INSERT INTO CONSUMIDOR_FAMINTO VALUES (11, 'Rua Bergamo, 1832, Jardim Europa'),
                                      (12, 'Rua Manoel Machado Filho, 236, Chácaras Tubalina e Quartel'),
                                      (13, 'Rua Siomara Carla de Jesus, 564, Shopping Park'),
                                      (14, 'Rua Bergamo, 208, Jardim Europa'),
                                      (15, 'Praça dos Araújos, 243, Mansões Aeroporto'),
                                      (16, 'Rua do Estivador, 303, Jardim das Palmeiras'),
                                      (17, 'Rua Francino Vieira de Barros, 1670, Tocantins'),
                                      (18, 'Rua Bergamo, 1976, Jardim Europa'),
                                      (19, 'Praça dos Araújos, 2349, Mansões Aeroporto'),
                                      (20, 'Rua Dirceu Alves Pereira, 1674, Chácaras Tubalina e Quartel');


/* 
    Inserts de pedidos
*/

INSERT INTO PEDIDO VALUES (1, 11, 1, '18:30', 38.90, '03/09/2019', '17:00'),
                          (2, 14, 1, '20:00', 44.00, '04/09/2019', '16:07'),
                          (3, 19, 2, '22:30', 56.90, '23/10/2019', '20:40'),
                          (4, 11, 1, '08:30', 22.60, '07/11/2019', '6:03'),
                          (5, 13, 2, '18:00', 38.60, '08/11/2019', '16:00'),
                          (6, 14, 1, '21:30', 27.50, '08/11/2019', '19:30'),
                          (7, 11, 1, '19:45', 54.90, '09/11/2019', '16:30'),
                          (8, 19, 3, '18:30', 67.80, '15/11/2019', '17:00'),
                          (9, 13, 1, '12:00', 29.90, '25/11/2019', '6:55'),
                          (10, 20, 1, NULL, 34.90, '25/12/2019', '18:00'),
                          (11, 12, 1, '20:00', 34.90, '25/12/2019', '19:00'),
                          (12, 15, 1, '16:30', 34.90, '27/12/2019', '19:00'),
                          (13, 16, 1, NULL, 34.90, '28/12/2019', '06:30'),
                          (14, 12, 1, NULL, 34.90, '28/12/2019', '09:00'),
                          (15, 17, 1, NULL, 34.90, '28/12/2019', '10:00'),
                          (16, 19, 1, NULL, 34.90, '28/12/2019', '10:15'),
                          (17, 18, 1, NULL, 34.90, '28/12/2019', '10:30'),
                          (18, 11, 1, NULL, 34.90, '28/12/2019', '11:30'),
                          (19, 17, 1, NULL, 34.90, '29/12/2019', '19:00'),
                          (20, 14, 1, NULL, 34.90, '29/12/2019', '20:45');



/* 
    Inserts de acompa_pedido
*/

INSERT INTO ACOMPA_PEDIDO VALUES (1, 2, 2),
                                 (1, 2, 2),
                                 (1, 3, 2),
                                 (1, 3, 2),
                                 (1, 5, 2),
                                 (1, 7, 2),
                                 (1, 7, 2),
                                 (1, 7, 2),
                                 (1, 9, 2),
                                 (1, 10, 2);

/* 
    Inserts de preparacao_pedido
*/

INSERT INTO PREPARACAO_PEDIDO VALUES (1, 1, 'marguerita-g', 'fina', 'normal', 'pouco' ),
                                     (2, 1, 'calabresa-m', 'média', 'recheada com catupiry', 'extra'),
                                     (3, 1, 'napolitana-g', 'grossa', 'recheada com catupiry', 'extra'),
                                     (4, 2, 'marguerita-p','média', 'recheada com catupiry', 'pouco'),
                                     (5, 2, 'brasileira-g', 'fina', 'normal', 'extra'),
                                     (6, 4, 'marguerita-g', 'grossa', 'normal', 'pouco'),
                                     (7, 6, 'espanhola-g','média', 'recheada com catupiry', 'normal'),
                                     (8, 8, 'bacon-m', 'fina',  'normal', 'pouco'),
                                     (9, 8, 'frango&catupiry-g', 'grossa', 'recheada com catupiry', 'normal'),
                                     (10, 4, 'alemã-g', 'fina',  'normal', 'pouco');

/* 
    Inserts de ingrediente_extra
*/

INSERT INTO INGREDIENTE_EXTRA VALUES (1, '10 fatias de calabresa', 6.50, 1),
                                     (2, 'cobertura de cheddar na borda', 4.90, 2),
                                     (3, 'frango desfiado', 5.75, 3),
                                     (4, 'frango desfiado', 5.75, 3),
                                     (5, 'cobertura de cheddar na borda', 4.90, 2),
                                     (6, '10 fatias de calabresa', 6.50, 1),
                                     (7, '6 ovos de codorna', 5.50, 4),
                                     (8, '5 camarões', 12.50, 5),
                                     (9, '6 ovos de codorna', 5.50, 4),
                                     (10, 'pedacinhos de abacaxi', 8.60, 6);


/* 
    Inserts de pedidos de combo (falta editar e adicionar mais pedidos na tabela de pedidos)
*/

INSERT INTO PEDIDOS_COMBOS VALUES (1),
                                  (3),
                                  (5),
                                  (7),
                                  (9),
                                  (11),
                                  (13),
                                  (15),
                                  (17),
                                  (19);


/* 
    Inserts de combos
*/

INSERT INTO COMBOS VALUES (1, 'marguerita-g + refri 2L'),
                          (2, 'calabresa-m + 1 pizza doce especial m'),
                          (3, 'napolitana-g + acompanhamento'),
                          (4, 'marguerita-p + refri 2L'),
                          (5, 'brasileira-g + refri 3L'),
                          (6, 'marguerita-g + refri 600ml'),
                          (7, 'espanhola-g + 2 refris 2L'),
                          (8, 'bacon-m + 3 docinhos'),
                          (9, 'frango&catupiry-g + suco de laranja natural 900ml'),
                          (10, 'alemã-g + 5 breadsticks');

/* 
    Inserts de tem_combo
*/

INSERT INTO TEM_COMBO VALUES (1, 1, 1),
                             (2, 3, 2),
                             (3, 5, 1),
                             (4, 7, 1),
                             (5, 9, 3),
                             (6, 11, 2),
                             (7, 13, 1),
                             (8, 15, 4),
                             (9, 17, 1),
                             (10, 19, 1);


/* 
    Inserts de pizza_combo
*/

INSERT INTO PIZZA_COMBO VALUES (1, 1, 'marguerita-g'),
                               (2, 1, 'calabresa-m'),
                               (3, 2, 'napolitana-g'),
                               (4, 2, 'marguerita-p'),
                               (5, 3, 'brasileira-g'),
                               (6, 3, 'marguerita-g'),
                               (7, 4, 'espanhola-g'),
                               (8, 4, 'bacon-m'),
                               (9, 5, 'frango&catupiry-g'),
                               (10, 5, 'alemã-g');


/* 
    Inserts de animadores
*/

INSERT INTO ANIMADOR VALUES (21, 'O Russo', 'Imigrante russo, cuspo fogo com vodka', 15.60),
                            (22, 'Dom Fernand', 'Monarquista, herdeiro do trono do Brasil', 12.90),
                            (23, 'O Cobrador', 'Eu me finjo de agiota', 15.00),
                            (24, 'Ernesto Cabreiro', 'Nasci e cresci no circo, hoje te trago alegria', 18.60),
                            (25, 'Everest', 'Escalei o monte everest e hoje compartilho a história com você', 22.00),
                            (26, 'John Luck', 'Sou o homem mais sortudo do mundo', 10.30),
                            (27, 'Felipão', 'Me fantasio de técnico da seleção', 11.60),
                            (28, 'Sextador', 'Te trago a alegria da sexta-feira independente do dia', 19.90),
                            (29, 'Valquíria', 'Me fantasio de valquíria nórdica', 25.40),
                            (30, 'Madelyne Star', 'Sou cantora e dançarina formada pela', 45.60);


/* 
    Inserts de retiradas 
    (todos os pedidos de retirada também serão de combo)
*/

INSERT INTO RETIRADA VALUES (1, '18:30'),
                            (3, '22:30'),
                            (5, '19:45'),
                            (7, '18:30'),
                            (9, '18:30'),
                            (11, '18:30'),
                            (13, '18:30'),
                            (15, '18:30'),
                            (17, '18:30'),
                            (19, '18:30');


/* 
    Inserts de entretenimento 
*/

INSERT INTO ENTRETENIMENTO VALUES (2, 21, 2),
                                  (4, 27, 1),
                                  (6, 22, 3),
                                  (8, 22, 4),
                                  (10, 24, 7),
                                  (12, 21, 8),
                                  (14, 27, 10),
                                  (16, 23, 2),
                                  (18, 27, 1),
                                  (20, 26, 2);


/* 
    Inserts de trabalha
*/

INSERT INTO TRABALHA VALUES (21, 1, 'segunda e terça'),
                            (27, 2, 'segunda e quarta'),
                            (22, 4, 'segunda e quinta'),
                            (22, 7, 'terça e quarta'),
                            (22, 8, 'sexta e sábado'),
                            (24, 10, 'segunda à sexta'),
                            (23, 3, 'segunda à sábado'),
                            (26, 1, 'segunda à sexta'),
                            (21, 2, 'quarta à sexta'),
                            (27, 3, 'quarta e quinta');





