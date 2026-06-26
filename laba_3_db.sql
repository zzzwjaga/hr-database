DROP TABLE IF EXISTS actual_passport_data;
DROP TABLE IF EXISTS actual_contacts;
DROP TABLE IF EXISTS actual_status;
DROP TABLE IF EXISTS actual_FIO;
DROP TABLE IF EXISTS contract;
DROP TABLE IF EXISTS relative_of_employee;
DROP TABLE IF EXISTS employee_education;
DROP TABLE IF EXISTS hospital_record;
DROP TABLE IF EXISTS qualification_courses_of_employees;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS emp_locality;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS staff_list;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS penalities_of_post;
DROP TABLE IF EXISTS penalties;
DROP TABLE IF EXISTS duties_of_post;
DROP TABLE IF EXISTS duties;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS emp_relative;
DROP TABLE IF EXISTS type_of_kinship;
DROP TABLE IF EXISTS vacation_order;
DROP TABLE IF EXISTS type_of_vacation;
DROP TABLE IF EXISTS educational_institution;
DROP TABLE IF EXISTS dismissal_order;
DROP TABLE IF EXISTS admission_order;
DROP TABLE IF EXISTS time_off_order;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS qualification_courses;
DROP TABLE IF EXISTS course_location;


CREATE TABLE employee
(
	employee_id SERIAL PRIMARY KEY,
	gender CHAR(1) NOT NULL,
	date_of_birth DATE NOT NULL
);
ALTER TABLE employee ADD CONSTRAINT CH_employee_gender CHECK (gender IN ('M','F'));


CREATE TABLE actual_passport_data
(
	record_id SERIAL PRIMARY KEY,
	employee_id INTEGER NOT NULL,
	date_of_relevance SERIAL NOT NULL,
	series VARCHAR(4) NOT NULL,
	passport_number VARCHAR(6) NOT NULL,
	issued_by_whom TEXT NOT NULL,
	when_issued DATE NOT NULL
);
ALTER TABLE actual_passport_data ADD UNIQUE(series,passport_number);

CREATE TABLE country
(
	country_id SERIAL PRIMARY KEY,
	country_name TEXT NOT NULL
);
ALTER TABLE country ADD UNIQUE(country_name);

CREATE TABLE region
(
	region_id SERIAL PRIMARY KEY,
	region_name TEXT NOT NULL,
	country_id INTEGER NOT NULL	
);

CREATE TABLE emp_locality
(
	locality_id SERIAL PRIMARY KEY,
	locality_name TEXT NOT NULL,
	region_id INTEGER NOT NULL
);

CREATE TABLE status
(
	status_id SERIAL PRIMARY KEY,
	status_name VARCHAR(20) NOT NULL
);
ALTER TABLE status ADD UNIQUE(status_name);

CREATE TABLE actual_status
(
	record_id SERIAL PRIMARY KEY,
	date_of_relevance DATE NOT NULL,
	employee_id INTEGER NOT NULL,
	status_id INTEGER
);

CREATE TABLE actual_FIO
(
	record_id SERIAL PRIMARY KEY,
	date_of_relevance DATE NOT NULL,
	employee_id INTEGER NOT NULL,
	emp_lastname TEXT NOT NULL,
	emp_name TEXT NOT NULL,
	emp_patronymic TEXT
);

CREATE TABLE department
(
	department_id SERIAL PRIMARY KEY,
	department_name VARCHAR(255) NOT NULL,
	parent_department_id INTEGER
);
ALTER TABLE department ADD UNIQUE(department_name);


CREATE TABLE post
(
	post_id SERIAL PRIMARY KEY,
	post_name VARCHAR(50) NOT NULL,
	kpi TEXT
);
ALTER TABLE post ADD UNIQUE(post_name);


CREATE TABLE contract
(
	conract_number VARCHAR(30) PRIMARY KEY,
	employee_id SERIAL NOT NULL,
	post_id SERIAL NOT NULL,
	date_of_compilation DATE NOT NULL,
	date_of_admission DATE,
	date_of_expiration DATE
);


CREATE TABLE staff_list
(
	post_id INTEGER NOT NULL,
	department_id INTEGER NOT NULL,
	salary NUMERIC,
	number_of_bids INTEGER
);
ALTER TABLE staff_list ADD PRIMARY KEY(post_id,department_id);


CREATE TABLE penalties
(
	penalties_id SERIAL PRIMARY KEY,
	penalties_name VARCHAR(50) NOT NULL,
	penalties_definition TEXT,
	sanctions TEXT
);


CREATE TABLE penalities_of_post
(
	record_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	penalties_id INTEGER NOT NULL
);


CREATE TABLE duties
(
	duties_id SERIAL PRIMARY KEY,
	duties_name VARCHAR(50) NOT NULL,
	duties_definition TEXT
);


CREATE TABLE duties_of_post
(
	record_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	duties_id INTEGER NOT NULL
);


CREATE TABLE type_of_kinship
(
	type_of_kinship_id SERIAL PRIMARY KEY,
	type_of_kinship_name TEXT NOT NULL
);


CREATE TABLE emp_relative
(
	relative_id SERIAL PRIMARY KEY,
	emp_lastname VARCHAR(30) NOT NULL,
	emp_name VARCHAR(30) NOT NULL,
	emp_patronymic VARCHAR(30),
	phone_number VARCHAR(20),
	date_of_birth DATE NOT NULL,
	type_of_kinship_id INTEGER NOT NULL
);
ALTER TABLE emp_relative ADD UNIQUE(phone_number);


CREATE TABLE relative_of_employee
(
	record_id SERIAL PRIMARY KEY,
	employee_id INTEGER NOT NULL,
	relative_id INTEGER NOT NULL
);


CREATE TABLE educational_institution
(
	educational_institution_id SERIAL PRIMARY KEY,
	educational_institution_name TEXT NOT NULL
);
ALTER TABLE educational_institution ADD UNIQUE(educational_institution_name); 


CREATE TABLE employee_education
(
	record_id SERIAL PRIMARY KEY,
	specialization VARCHAR(50) NOT NULL,
	educational_institution_id INTEGER NOT NULL,
	end_year INTEGER,
	employee_id INTEGER NOT NULL
);
ALTER TABLE employee_education ADD CONSTRAINT CH_employee_education_end_year CHECK(end_year>=1900);

CREATE TABLE orders
(
	order_number SERIAL PRIMARY KEY,
	date_of_compilation DATE NOT NULL,
	type_of_order VARCHAR(20) NOT NULL
);

CREATE TABLE admission_order
(
	order_number INTEGER PRIMARY KEY,
	date_of_admission DATE NOT NULL
);

CREATE TABLE dismissal_order
(
	order_number INTEGER PRIMARY KEY,
	date_of_dismissal DATE NOT NULL,
	reason_of_dismissal TEXT NOT NULL
);

CREATE TABLE type_of_vacation
(
	type_of_vacation_id SERIAL PRIMARY KEY,
	name_type_of_vacation CHAR(100) NOT NULL
);

CREATE TABLE vacation_order
(
	order_number INTEGER PRIMARY KEY,
	date_of_begin DATE NOT NULL,
	date_of_end DATE,
	type_of_vacation_id INTEGER
);

CREATE TABLE time_off_order
(
	order_number INTEGER PRIMARY KEY,
	date_of_begin DATE NOT NULL,
	date_of_end DATE
);

CREATE TABLE hospital_record
(
	hospital_record_id SERIAL PRIMARY KEY,
	date_of_begin DATE NOT NULL,
	date_of_end DATE,
	disease TEXT NOT NULL,
	employee_id INTEGER NOT NULL
);


CREATE TABLE course_location
(
	course_location_id SERIAL PRIMARY KEY,
	course_location_name TEXT NOT NULL
);
ALTER TABLE course_location ADD UNIQUE(course_location_name); 


CREATE TABLE qualification_courses
(
	qualification_courses_id SERIAL PRIMARY KEY,
	qualification_courses_name TEXT NOT NULL,
	course_location_id INTEGER NOT NULL
);
ALTER TABLE qualification_courses ADD UNIQUE(qualification_courses_name); 


CREATE TABLE qualification_courses_of_employees
(
	record_id SERIAL PRIMARY KEY,
	date_of_begin DATE NOT NULL,
	date_of_end DATE NOT NULL,
	employee_id INTEGER NOT NULL,
	qualification_courses_id INTEGER NOT NULL
);

CREATE TABLE actual_contacts
(
	record_id SERIAL PRIMARY KEY,
	employee_id INTEGER NOT NULL,
	locality_id INTEGER NOT NULL,
	department_id INTEGER,
	family_status BOOLEAN,
	phone_number VARCHAR(20) NOT NULL,
	adress TEXT NOT NULL
);
ALTER TABLE actual_contacts ADD UNIQUE(phone_number);


ALTER TABLE actual_passport_data ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE region ADD FOREIGN KEY(country_id) REFERENCES country(country_id);
ALTER TABLE emp_locality ADD FOREIGN KEY(region_id) REFERENCES region(region_id);
ALTER TABLE actual_status ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE actual_status ADD FOREIGN KEY(status_id) REFERENCES status(status_id);
ALTER TABLE actual_fio ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE contract ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE contract ADD FOREIGN KEY(post_id) REFERENCES post(post_id);
ALTER TABLE staff_list ADD FOREIGN KEY(post_id) REFERENCES post(post_id);
ALTER TABLE staff_list ADD FOREIGN KEY(department_id) REFERENCES department (department_id);
ALTER TABLE penalities_of_post ADD FOREIGN KEY(post_id) REFERENCES post(post_id);
ALTER TABLE penalities_of_post ADD FOREIGN KEY(penalties_id) REFERENCES penalties(penalties_id);
ALTER TABLE duties_of_post ADD FOREIGN KEY(post_id) REFERENCES post(post_id);
ALTER TABLE duties_of_post ADD FOREIGN KEY(duties_id) REFERENCES duties(duties_id);
ALTER TABLE emp_relative ADD FOREIGN KEY(type_of_kinship_id) REFERENCES type_of_kinship(type_of_kinship_id);
ALTER TABLE relative_of_employee ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE relative_of_employee ADD FOREIGN KEY(relative_id) REFERENCES emp_relative(relative_id);
ALTER TABLE employee_education ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE employee_education ADD FOREIGN KEY(educational_institution_id) REFERENCES educational_institution(educational_institution_id);
ALTER TABLE admission_order ADD FOREIGN KEY(order_number) REFERENCES orders(order_number);
ALTER TABLE dismissal_order ADD FOREIGN KEY(order_number) REFERENCES orders(order_number);
ALTER TABLE vacation_order ADD FOREIGN KEY(order_number) REFERENCES orders(order_number);
ALTER TABLE vacation_order ADD FOREIGN KEY(type_of_vacation_id) REFERENCES type_of_vacation(type_of_vacation_id);
ALTER TABLE time_off_order ADD FOREIGN KEY(order_number) REFERENCES orders(order_number);
ALTER TABLE hospital_record ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE qualification_courses ADD FOREIGN KEY(course_location_id) REFERENCES course_location(course_location_id);
ALTER TABLE qualification_courses_of_employees ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE qualification_courses_of_employees ADD FOREIGN KEY(qualification_courses_id) REFERENCES qualification_courses(qualification_courses_id);
ALTER TABLE actual_contacts ADD FOREIGN KEY(employee_id) REFERENCES employee(employee_id);
ALTER TABLE actual_contacts ADD FOREIGN KEY(locality_id) REFERENCES emp_locality(locality_id);
ALTER TABLE actual_contacts ADD FOREIGN KEY(department_id) REFERENCES department(department_id);
	

