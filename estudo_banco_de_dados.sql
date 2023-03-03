https://www.mikedane.com/databases/sql/company-database.pdf


/*Inserting Data:*/

Create table student (
	student_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	name VARCHAR (20),
major VARCHAR (20),
);
INSERT INTO student VALUES (‘Jack’, ‘Biology’);
INSERT INTO student VALUES (‘Kate’, ‘Sociology’);
INSERT INTO student VALUES (‘Clarie’, ‘Chemestry’);
INSERT INTO student VALUES (‘Mike’, ‘Computer Science’);
Update & Delete12  

SELECT * 
FROM Student
	UPDATE student
	SET major = ‘Bio’
	WHERE major = ‘Biology’;
SELECT * 
FROM Student
	UPDATE student
	SET major = ‘Biochemestry’
	WHERE major = ‘Bio’ OR major = ‘Chemestry’;

DELETE FROM student
	WHERE name = ‘Jack’ AND major = ‘Bio’;

/*Select */

SELECT student.name, student.major 
FROM student
ORDER BY name;

SELECT *
FROM student
ORDER by student_id DESC;

SELECT name, major
FROM student
WHERE major = ‘Chemestry’ OR name = ‘Kate’;

SELECT name, major
FROM student
WHERE major <> ‘Chemestry’ ;

SELECT *
FROM student
WHERE name IN (‘Clarie’, ‘Mike’, ‘Jack’);

SELECT *
FROM student
WHERE major IN (‘Biology’, ‘Chemestry’) AND student_id > 2 ;

SELECT COUNT(emp_id)
FROM employee;

SELECT *
FROM client
WHERE client_name LIKE ‘%LLC’;

SELECT*
FROM employee
WHERE birth_date LIKE ‘____-02%’;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = ‘F’ AND birth_date > ‘1970-01-01’;

SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

/*Sub-select*/

/*Achar o nome de todos os empregados que venderam mais de 30.000 para um único cliente*/

SELECT employee.firstname, employee.last_name
FROM employee
WHERE employee.emp_id IN ( SELECT works_with.emp_id
					FROM works_with
					WHERE works_with.total_sales > 30.000);

/*Achar todos os clientes que as filiais são administradas pelo emp_id = 102.*/
SELECT client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
FROM branch
WHERE branch.mgr_id = 102
LIMIT 1);
Join

/*Find all branches and the name of their managers  */

SELECT employee.first_name, employee.last_name, branch.name
FROM employee
JOIN branch
IN employee.emp_id = branch.mng_id;

/*Trigger*/
DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
ON employee
FOR EACH ROW BEGIN
IF NEW.sex = “M” THEN
INSERT INTO trigger_test VALUES (‘added male employee’);
ELSEIF NEW.sex = “F” THEN
INSERT INTO trigger_test VALUES (‘added female employee’);
ELSE
INSERT INTO trigger_test VALUES (‘added other employee’);
END IF;
END $$
DELIMITER ; 

SELECT * FROM trigger_test

/*Procedure */
DELIMITER $$
create procedure retorna_situação_aluno (IN  idDisciplinaP int, IN cpfP varchar(11))
BEGIN

	declare nota_aluno int default 0;
declare falta_aluno int default 0;
declare situação varchar (200);

select nota_final into nota_aluno from aluno_disciplina where idDisciplina = idDisciplinaP and cpf = cpfP;
if (nota_aluno >= 60) then
	set situação = ‘Aprovado’;
else
	set situação = ‘Reprovado’;
end if;



select faltas into falta_aluno from aluno_disciplina where idDisciplina = idDisciplinaP and cpf = cpfP;
if (falta_aluno >= 25) then
	set situação = concat(situacao, ‘Aprovado’);
else
	set situação = concat(situacao, ‘Reprovado’);
end if;
select situcao;
END $$
DELIMITER ;

—------------------------------------------------------------------------------------------------------------------------
create table Peca (
	PeNro int primary key not null auto_increment,
    PeNome varchar(50),
    PePreco int,
    PeCor varchar(50)
);

create table Fornecedor (
	FNro int primary key not null auto_increment,
    FNome varchar(50),
    FCidade varchar(50),
    FCateg varchar(1)
);

create table Projeto (
	PNro int primary key not null auto_increment,
    PNome varchar(50),
    PDuracao int,
    PCusto int
);

create table Fornece_para (
	id int primary key not null auto_increment,
	PeNro int,
    FNro int,
    PNro int,
    Quant int
);

insert into Peca values(1,'Cinto',22,'Azul');
insert into Peca values(2,'Volante',18,'Vermelho');
insert into Peca values(3,'Lanterna',14,'Preto');
insert into Peca values(4,'Limpador',9,'Amarelo');
insert into Peca values(5,'Painel',43,'Vermelho');

insert into Fornecedor values(1,'Plastec','Campinas','B');
insert into Fornecedor values(2,'CM','São Paulo','D');
insert into Fornecedor values(3,'Kirurgic','Campinas','A');
insert into Fornecedor values(4,'Piloto','Piracicaba','A');
insert into Fornecedor values(5,'Equipament','São Carlos','C');

insert into Projeto values(1,'Detroit',5,43000);
insert into Projeto values(2,'Pegasus',3,37000);
insert into Projeto values(3,'Alfa',2,26700);
insert into Projeto values(4,'Sea',3,21200);
insert into Projeto values(5,'Paraiso',1,17000);

insert into Fornece_para values(1,1,5,4,5);
insert into Fornece_para values(2,2,2,2,1);
insert into Fornece_para values(3,3,3,4,2);
insert into Fornece_para values(4,4,4,5,3);
insert into Fornece_para values(5,5,1,1,1);
insert into Fornece_para values(6,2,2,3,1);
insert into Fornece_para values(7,4,3,5,2);

select * from Peca;
select * from Fornecedor;
select * from Projeto;
select * from Fornece_para;

/* OBTER O NOME DAS PEÇAS UTILIZADAS NO PROJETO 4 */
select Peca.PeNome
from Peca,Fornece_para
where (Fornece_para.PNro = 4)
	and (Fornece_para.PeNro = Peca.PeNro);
    
/* OBTER O NOME DOS FORNECEDORES QUE 
FORNECERAM PEÇAS PARA O PROJETO 5 */
 select Fornecedor.FNome
 from Fornecedor,Fornece_para
 where (Fornece_para.PNro = 5)
	and (Fornecedor.FNro = Fornece_para.FNro);
    
/* OBTER OS NOMES DAS PEÇAS FORNECIDAS 
PARA O PROJETO 5 PELO FORNECEDOR 4*/
select Peca.PeNome
from Peca, Fornece_para
where ((Fornece_para.PNro = 5)
	and (Fornece_para.FNro = 4))
    and (Fornece_para.PeNro = Peca.PeNro);
    
/* SUB SELECTS */

/* OBTER O NOME DAS PEÇAS UTILIZADAS NO PROJETO 5 */
select PeNome
from Peca
where PeNro in (select PeNro
				from Fornece_para
				where (PNro = 5));
                

/* OBTER O NOME DAS PEÇAS CUJO PREÇO É SUPERIOR
AO PREÇO MÉDIO DAS PEÇAS */
select PeNome
from Peca
where PePreco > (select avg(PePreco)
				from Peca);
                
/* OBTER, SEM REPETIÇÃO E EM ORDEM CRESCENTE, 
O NOME DOS FORNECEDORES QUE FORNECERAM PEÇAS
PARA ALGUM PROJETO */
select distinct FNome
from Fornecedor
where FNro in (select FNro from Fornece_para)
order by FNome asc;

/* OBTER O NOME DAS PEÇAS UTILIZADAS
NOS PROJETOS COM DURAÇÃO MAIOR QUE 3 MESES */
select distinct PeNome
from Peca
where PeNro in (select PeNro
				from Fornece_para
				where PNro in (select PNro
								from Projeto
								where (PDuracao > 3)));
                                
       /*1) Faça as seguintes consultas utilizando múltiplas tabelas sem SUB SELECT:*/                         
/*a)OBTER OS NOMES DOS PROJETOS QUE UTILIZARAM A PEÇA 2 DO
FORNECEDOR 2*/
select Peca.PeNome
	from Peca, Fornece_para
	where ((Fornece_para.PNro = 2)
		and (Fornece_para.FNro = 2))
		and (Fornece_para.PeNro = Peca.PeNro);
    
/*b) OBTER OS NOMES DAS PEÇAS FORNECIDAS PARA OS PROJETOS COM
QUANTIDADE SUPERIOR A 2*/
select Peca.PeNome
	from Peca, Fornece_para
	where(Fornece_para.Quant > 2)
		and (Fornece_para.PeNro = Peca.PeNro)

/*c)OBTER O NOME DE CADA PEÇA E A QUANTIDADE DE CADA UMA DELAS
SOMADAS EM TODOS OS PROJETOS*/
select Peca.PeNome, SUM(Fornece_para.Quant)
from Peca, Fornece_para, Projeto
where (Fornece_para.PeNro = Peca.PeNro)
	and(Projeto.PNro = Fornece_para.PNro)
		Group by Peca.PeNome
        
/*d) OBTER O NOME DE CADA FORNECEDOR E A QUANTIDADE MÉDIA DE
PEÇAS FORNECIDAS PARA OS PROJETOS, MAS DESDE QUE ESSA MÉDIA
SEJA SUPERIOR A 1
*/
select Fornecedor.FNome, AVG (Fornece_para.Quant) as media
	from Fornecedor, fornece_para, projeto
	where (fornece_para.FNro = Fornecedor.FNro)
		and (Projeto.PNro = Fornece_para.PNro)
			group by (Fornecedor.FNome)
				having AVG(fornece_para.quant) > 1
                
/*e) OBTER O NOME DOS FORNECEDORES QUE TRABALHARAM NO PROJETO
Pegasus*/
select Fornecedor.FNome
	from Projeto, Fornecedor, fornece_para
    where Projeto.PNome = 'Pegasus'
		and ((Fornece_para.FNro = Fornecedor.FNro)
		and (Fornece_para.PNro = Projeto.PNro));
								
		/*2) Faça as seguintes consultas utilizando múltiplas tabelas com SUB SELECT:*/
/*a) OBTER OS NOMES DAS PEÇAS FORNECIDAS POR ALGUM FORNECEDOR DE
Piracicaba*/
select PeNome 
from Peca 
Where PeNro in (select PeNro 
				from Fornece_para 
				where FNro in (select FNro 
								from Fornecedor 
								where (FCidade = 'Piracicaba')));
                                
/*b) OBTER OS NOMES DAS PEÇAS QUE NÃO SÃO FORNECIDAS POR
FORNECEDORES DA CATEGORIA A*/
select PeNome
from Peca
where PeNro in (select Penro
				from Fornece_para
				where FNro in (select FNro
								from Fornecedor
								where (FCateg  <>  'A'  )));

/*c) OBTER O NOME DE CADA PROJETO E O TOTAL DE PEÇAS UTILIZADAS EM
CADA UM, MAS DESDE QUE ESSE TOTAL SEJA MAIOR QUE O TOTAL DE
PEÇAS UTILIZADAS NO PROJETO Paraiso*/
select PNome
from Projeto
where PNro in (select PNro
				from Fornece_para
				where Quant in (select SUM(Quant)
								from Fornece_para
								where PNro in (select PNro
												from Projeto
												where PNome = 'Paraiso' )))
/*d) ATUALIZE PARA 10 A QUANTIDADE DA PEÇA Volante FORNECIDA PELO
FORNECEDOR 2 PARA O PROJETO 2*/
update fornece_para set quant = 10 
where FNro = 2 and PNro = 2; 

/*e) ELIMINE DA TABELA Fornece_para TODAS AS INFORMAÇÕES REFERENTES
AO FORNECEDOR DE NOME CM*/
Delete from Fornece_para
where FNro = 2;


