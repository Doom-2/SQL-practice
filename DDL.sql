-- DB testdb
-- part 1
CREATE TABLE teacher
(
	teacher_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar,
	title varchar
);

ALTER TABLE teacher
ADD COLUMN middle_name varchar;

ALTER TABLE teacher
DROP COLUMN middle_name;

ALTER TABLE teacher
RENAME birthday TO birth_date;

ALTER TABLE teacher
ALTER COLUMN phone SET DATA TYPE varchar(32);

CREATE TABLE exam
(
	exam_id serial,
	exam_name varchar(256),
	exam_date date
);

INSERT INTO exam (exam_name, exam_date)
VALUES
('math', '2001-06-05'),
('physics', '2001-06-15'),
('literature', '2001-06-25');

SELECT * FROM exam;

TRUNCATE TABLE exam RESTART IDENTITY;

-- part 2
CREATE TABLE exam
(
	exam_id serial UNIQUE NOT NULL,
	exam_name varchar(256),
	exam_date date
);

-- Drop UNIQUE constraint
ALTER TABLE exam
DROP CONSTRAINT exam_exam_id_key;

SELECT *
FROM exam

ALTER TABLE exam
ADD PRIMARY KEY(exam_id);

ALTER TABLE exam
DROP CONSTRAINT exam_pkey;

CREATE TABLE person
(
	person_id int PRIMARY KEY,
	first_name varchar(30),
	last_name varchar(30)
);

CREATE TABLE passport
(
	passport_id int,
	serial_number int NOT NULL,
	registration text,
	person_id int,
	
	CONSTRAINT PK_passport_passport_id PRIMARY KEY(passport_id),
	CONSTRAINT FK_passport_person FOREIGN KEY(person_id) REFERENCES person(person_id)
);

SELECT *
FROM passport;

ALTER TABLE book
ADD COLUMN weight int CONSTRAINT CHK_book_weight CHECK (weight BETWEEN 0 AND 100);

INSERT INTO book
VALUES (4, '1984', '978-5-9925-0563-4', 2, 87)

CREATE TABLE student
(
	student_id serial,
	full_name varchar(50),
	course int DEFAULT 1,
	
	CONSTRAINT PK_student_student_id PRIMARY KEY(student_id)
);

INSERT INTO student
VALUES
(1, 'Louis Armstrong', 1),
(2, 'Tom Waits', 3);

TRUNCATE TABLE student RESTART IDENTITY;

ALTER TABLE student
ALTER COLUMN student_id DROP DEFAULT,
ALTER COLUMN student_id ADD GENERATED ALWAYS AS IDENTITY
(START WITH 3);

ALTER TABLE student
ALTER COLUMN student_id DROP IDENTITY



ALTER TABLE student
ALTER COLUMN course DROP DEFAULT;

INSERT INTO student (full_name)
VALUES 
('Ella Fitzgerald');


-- DB Northwind
ALTER TABLE products
ADD CONSTRAINT CHK_products_unit_price CHECK (unit_price > 0);

SELECT *
FROM products;

SELECT max(product_id)
FROM products;

ALTER TABLE products
ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY
SELECT setval(pg_get_serial_sequence('products', 'product_id'), (SELECT MAX(product_id) FROM products));

INSERT INTO products (product_name, discontinued)
VALUES
('Christmas Tree', 0)
RETURNING product_id
