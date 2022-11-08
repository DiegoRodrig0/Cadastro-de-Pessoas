use db_cadastro;
-- -----------------------------------------------------
-- Table pessoa
-- -----------------------------------------------------
CREATE TABLE pessoa (
  `cpf` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `idade` INTEGER NOT NULL,
  PRIMARY KEY (`cpf`)
  );

-- -----------------------------------------------------
-- Table funcionario
-- -----------------------------------------------------
CREATE TABLE funcionario (
  `cpf_pessoa` VARCHAR(15) NOT NULL,
  `setor` VARCHAR(100) NOT NULL,
    FOREIGN KEY (`cpf_pessoa`)
    REFERENCES pessoa (`cpf`)
);

-- -----------------------------------------------------
-- Table auditoria
-- -----------------------------------------------------
CREATE TABLE auditoria (
	`id` int primary key auto_increment,
    `usuario` varchar(45),
    `datahora` datetime default current_timestamp,
    `operacao` varchar(45)
);

DROP TRIGGER IF EXISTS `db_cadastro`.`auditoria_pessoa_WRONG_SCHEMA`;

DELIMITER $$
USE `db_cadastro`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_cadastro`.`auditoria_pessoa` BEFORE INSERT ON `pessoa` FOR EACH ROW
BEGIN
	insert into auditoria(usuario, datahora, operacao) 
		values(current_user, current_timestamp, "insert");
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `db_cadastro`.`auditoria_pessoa2`;

DELIMITER $$
USE `db_cadastro`$$
CREATE DEFINER = CURRENT_USER TRIGGER `db_cadastro`.`auditoria_pessoa2` BEFORE DELETE ON `pessoa` FOR EACH ROW
BEGIN
	insert into auditoria(usuario, datahora, operacao) 
		values(current_user, current_timestamp, "delete");
END$$
DELIMITER ;

-- Procedure de Insert

USE `db_cadastro`;
DROP procedure IF EXISTS `insert_funcionario`;

USE `db_cadastro`;
DROP procedure IF EXISTS `db_cadastro`.`insert_funcionario`;
;

DELIMITER $$
USE `db_cadastro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_funcionario`(cpf_pessoa varchar(15), nome_pessoa varchar(100), 
				idade_pessoa integer, setor_fun varchar(100))
BEGIN
		insert into pessoa (cpf, nome, idade) 
			values (cpf_pessoa, nome_pessoa, idade_pessoa);
		insert into funcionario (cpf_pessoa, setor)
			values (cpf_pessoa, setor_fun);
END$$

DELIMITER ;
;

-- Procedure de Delete

USE `db_cadastro`;
DROP procedure IF EXISTS `delete_pessoa`;

USE `db_cadastro`;
DROP procedure IF EXISTS `db_cadastro`.`delete_pessoa`;
;

DELIMITER $$
USE `db_cadastro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_pessoa`(cpf_pessoa varchar(100))
BEGIN
	DELETE FROM funcionario WHERE funcionario.cpf_pessoa = cpf_pessoa;
    DELETE FROM pessoa WHERE pessoa.cpf = cpf_pessoa;
END$$

DELIMITER ;
;