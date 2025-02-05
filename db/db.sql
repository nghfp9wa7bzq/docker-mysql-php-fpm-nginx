-- Done in Dockerfile.
-- SET NAMES utf8mb4;
-- USE dockerdb;

-- By default, tables are created in the default database, using the InnoDB storage engine.
-- https://dev.mysql.com/doc/refman/8.4/en/create-table.html

-- PRIMARY KEY is not also AUTO_INCREMENT, so you have to add that too!

CREATE TABLE IF NOT EXISTS company_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_type VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS company (
  id INT AUTO_INCREMENT PRIMARY KEY,
  c_name VARCHAR(50) NOT NULL,
  c_address VARCHAR(255) NOT NULL,
  c_type_id INT NOT NULL,
  CONSTRAINT `fk_company_type` FOREIGN KEY (c_type_id) REFERENCES company_type (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS person (
  id INT AUTO_INCREMENT PRIMARY KEY,
  p_name VARCHAR(50) NOT NULL,
  c_id INT NOT NULL,
  CONSTRAINT `fk_person_company` FOREIGN KEY (c_id) REFERENCES company (id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE OR REPLACE VIEW p_c_ct
AS
SELECT person.p_name AS person_name, company.c_name AS company_name, company_type.company_type AS company_type FROM person
LEFT JOIN company ON person.c_id = company.id
LEFT JOIN company_type ON company.c_type_id = company_type.id;

INSERT INTO company_type (company_type) VALUES ('Inc.'), ('Ltd.'), ('partnership');

INSERT INTO company (c_name, c_address, c_type_id) VALUES
('Bonefish Grill', '2202 North West Shore Boulevard, Suite 500
Tampa, Florida, U.S. 33607', 2),
("Checkers and Rally's", 'Louisville, Kentucky, U.S.', 2),
('Citrix Systems', 'Fort Lauderdale, Florida, U.S.', 1),
('Elkins Constructors', '	Jacksonville, Florida, United States', 2);

INSERT INTO person (p_name, c_id) VALUES
('Ryleigh Lang', 1),
('Valeria Cohen', 1),
('Keith Sutton', 3),
('Stefan Dominguez', 4),
('Marcus Lucero', 2);

