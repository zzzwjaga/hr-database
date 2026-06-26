/*1. Выбрать все данные о видах родства.*/
--+
SELECT * FROM type_of_kinship;

/*2. Выбрать имена сотрудников без повторений. Результат
отсортировать в порядке обратном лексикографическому.*/
--+
SELECT DISTINCT emp_name FROM actual_FIO
ORDER BY emp_name DESC;

/*3. Выбрать данные о сотрудниках, рожденных зимой. 
Результат отсортировать по возрасту в убывающем порядке.*/
--+
SELECT 
    e.employee_id,
    a_FIO.emp_lastname, 
    a_FIO.emp_name,
    a_FIO.emp_patronymic,
    e.gender,
    e.date_of_birth,
    a_pas_data.series,
    a_pas_data.passport_number,
    a_pas_data.issued_by_whom,
    a_pas_data.when_issued,
    a_cont.locality_id,
    a_cont.adress,
    a_cont.department_id,
    a_cont.family_status,
    a_cont.phone_number 
FROM employee AS e 
INNER JOIN actual_passport_data AS a_pas_data 
    ON a_pas_data.employee_id = e.employee_id
INNER JOIN actual_FIO AS a_FIO
    ON a_FIO.employee_id = e.employee_id
INNER JOIN actual_contacts AS a_cont
    ON a_cont.employee_id = e.employee_id
WHERE EXTRACT(MONTH FROM e.date_of_birth) IN (1, 2, 12)
ORDER BY e.date_of_birth;

/*4. Выбрать id, название и место проведения курсов повышения квалификации, 
названия которых состоят только из одного
слова или в названии которых есть «или». 
Результат отсортировать по длине названия.*/
--+
SELECT * 
FROM qualification_courses
WHERE TRIM(qualification_courses_name) NOT LIKE '% %' 
	OR qualification_courses_name LIKE '% или %'
ORDER BY LENGTH(qualification_courses_name);

/*5. Выбрать названия курсов повышения квалификации, 
которые начинаются на букву «А», «И», «Ф», «З», «Д», «К», 
и, если id курсов не равно 5 или 6, то во втором столбце вывести место проведения.*/
--+
SELECT c.qualification_courses_id, c.qualification_courses_name,
CASE 
	WHEN c.qualification_courses_id NOT IN (5,6)
		THEN l.course_location_name
	ELSE NULL 
END AS course_location
FROM qualification_courses c INNER JOIN course_location l 
ON c.course_location_id = l.course_location_id
WHERE LEFT(qualification_courses_name, 1) IN ('А', 'И', 'Ф', 'З', 'Д', 'К');

/*6. Выбрать табельные номера сотрудников без повторений,
прошедших курсы повышения квалификации в прошлом и текущем годах.*/
--+
SELECT DISTINCT employee_id 
FROM qualification_courses_of_employees
WHERE EXTRACT(YEAR FROM CURRENT_DATE)= EXTRACT(YEAR FROM date_of_end)
OR EXTRACT(YEAR FROM CURRENT_DATE) - 1 = EXTRACT(YEAR FROM date_of_end);

/*7. Выбрать все данные сотрудниках, для которых не определено семейное положение. 
Результат отсортировать по фамилии в порядке обратном лексикографическому, 
по имени в лексикографическом порядке и по табельному номеру в возрастающем порядке.*/
--+
SELECT e.employee_id,
	emp_lastname, 
	emp_name,
	emp_patronymic
	gender,
	date_of_birth,
	series,passport_number,
	issued_by_whom,
	when_issued,
	locality_id,
	adress,
	department_id,
	family_status,
	phone_number 
FROM employee AS e 
INNER JOIN actual_passport_data AS a_pas_data 
ON a_pas_data.employee_id=e.employee_id
INNER JOIN actual_FIO AS a_FIO
ON a_FIO.employee_id=e.employee_id
INNER JOIN actual_contacts AS a_cont
ON a_cont.employee_id=e.employee_id
WHERE family_status IS NULL
ORDER BY employee_id;

/*8. Выбрать табельный номер, фамилию и инициалы, дату
рождения сотрудников в возрасте от 18 до 29 лет. Результат отсортировать в порядке возрастания возраста и по фамилии, имени,
отчеству в лексикографическом порядке.*/
--+
SELECT e.employee_id,fio.emp_lastname,
CASE
	WHEN fio.emp_patronymic IS NOT NULL
		THEN SUBSTRING(fio.emp_name,1,1)|| '. ' || SUBSTRING(fio.emp_patronymic,1,1)||'. '
	ELSE
		SUBSTRING(fio.emp_name,1,1)|| '. '
END AS initials, e.date_of_birth
FROM employee AS e INNER JOIN actual_FIO AS fio
ON e.employee_id=fio.employee_id
WHERE EXTRACT(YEAR FROM AGE(date_of_birth)) >= 18
AND EXTRACT(YEAR FROM AGE(date_of_birth)) <= 29
ORDER BY e.date_of_birth DESC, fio.emp_lastname,fio.emp_name,fio.emp_patronymic;

/*9. Выбрать названия курсов повышения квалификации, 
в названии которых нет символов «/», «_», «%» и «-». 
Результат отсортировать следующим образом: в первую очередь вывести названия
с id = 1, 3, 4, 7, 22, 15, 6, а затем все остальные, и по названию.*/
--+
SELECT qualification_courses_name, qualification_courses_id
FROM qualification_courses
WHERE qualification_courses_name 
	NOT LIKE '%/%'
	AND qualification_courses_name NOT LIKE '%!_%' ESCAPE '!'
	AND qualification_courses_name NOT LIKE '%!%%' ESCAPE '!'
	AND qualification_courses_name NOT LIKE '%-%'
ORDER BY 
CASE
	WHEN qualification_courses_id IN (1,3,4,7,22,15,6)
		THEN 0
	ELSE 1
END, qualification_courses_name;
	
/*10. Выбрать название первого отдела в списке,
упорядоченном в лексикографическом порядке.*/
--+
SELECT MIN(department_name) FROM department;

/*11.Выбрать фамилию и инициалы сотрудника, а также его
семейное положение. */
--+
SELECT fio.emp_lastname,
CASE
	WHEN fio.emp_patronymic IS NOT NULL
		THEN SUBSTRING(fio.emp_name,1,1)|| '. ' || SUBSTRING(fio.emp_patronymic,1,1)||'. '
	ELSE
		SUBSTRING(fio.emp_name,1,1)|| '. '
END AS initials, cont.family_status
FROM actual_FIO AS fio INNER JOIN actual_contacts AS cont 
ON fio.employee_id = cont.employee_id;


/*12. Выбрать фамилию, имя, отчество сотрудника, название
его должности, оклад, наименование статуса сотрудника, дату
приема, вид работы, названия курсов повышения квалификации и
года прохождения курсов. В результат включить только данные об
актуальных на данный момент видах работ. Результат отсортировать по фамилии в порядке обратном лексикографическому, по
имени в порядке обратном лексикографическому, по отчеству в
порядке обратном лексикографическому.*/
--+
SELECT f.emp_lastname, f.emp_name, f.emp_patronymic, p.post_name, st.salary, 
ss.status_name, c.date_of_expiration, qc.qualification_courses_name, EXTRACT(YEAR FROM q.date_of_end)
FROM actual_FIO f
	INNER JOIN contract c
	ON c.employee_id = f.employee_id
	INNER JOIN post p
	ON c.post_id=p.post_id
	INNER JOIN staff_list st
	ON p.post_id = st.post_id
	LEFT JOIN actual_status s
	ON f.employee_id = s.employee_id
	LEFT JOIN status ss
	ON s.status_id = ss.status_id
	LEFT JOIN qualification_courses_of_employees q
	ON f.employee_id = q.employee_id
	LEFT JOIN qualification_courses qc
	ON q.qualification_courses_id = qc.qualification_courses_id
ORDER BY 1 DESC, 2 DESC;

/*13. Выбрать общее количество сотрудников в БД*/
--+
SELECT COUNT(employee_id) 
FROM employee;

/*14. Выбрать количество различных месяцев рождения сотрудников*/
--+
SELECT COUNT(DISTINCT EXTRACT(MONTH FROM date_of_birth))
FROM employee;

/*15. Выбрать самый большой оклад для сотрудников, 
проходивших курсы повышения квалификации.*/
--+
SELECT MAX(salary) AS max_salary 
FROM staff_list AS s
	INNER JOIN contract AS c 
		ON s.post_id = c.post_id
	INNER JOIN qualification_courses_of_employees AS q
		ON q.employee_id=c.employee_id;

/*16. Выбрать фамилию и инициалы сотрудника, 
а также название времени года его рождения.*/

--+
SELECT e.employee_id, CONCAT(fio.emp_lastname, ' ', SUBSTRING(fio.emp_name,1,1)||'.', SUBSTRING(fio.emp_patronymic,1,1)||'.') AS initials ,
	CASE
		WHEN EXTRACT(MONTH FROM e.date_of_birth) IN (12,1,2)
			THEN 'Зима'
		WHEN EXTRACT(MONTH FROM e.date_of_birth) IN (3,4,5)
			THEN 'Весна'
		WHEN EXTRACT(MONTH FROM e.date_of_birth) IN (6,7,8)
			THEN 'Лето'
		WHEN EXTRACT(MONTH FROM e.date_of_birth) IN (9,10,11)
			THEN 'Осень'
	END AS year_period
FROM employee AS e 
	INNER JOIN actual_FIO AS fio
ON e.employee_id=fio.employee_id;

/*17. Выбрать название курсов повышения квалификации и
количество сотрудников, их прошедших.*/
--+
SELECT c.qualification_courses_name, COUNT(e.employee_id)
FROM qualification_courses AS c 
	INNER JOIN qualification_courses_of_employees AS e
		ON e.qualification_courses_id=c.qualification_courses_id
GROUP BY c.qualification_courses_id, c.qualification_courses_name;

/*18. Выбрать для каждого семейного сотрудника количество
дочерей, количество сыновей и общее количество детей. Результат
отсортировать по фамилии в лексикографическом порядке.*/
--+
SELECT f.emp_lastname, f.emp_name, f.emp_patronymic,
	SUM(CASE WHEN t.type_of_kinship_name = 'сын' THEN 1 ELSE 0 END) AS count_of_sons,
	SUM(CASE WHEN t.type_of_kinship_name = 'дочь' THEN 1 ELSE 0 END) AS count_of_daughters,
	SUM(CASE WHEN t.type_of_kinship_name IN ('сын', 'дочь') THEN 1 ELSE 0 END) AS count_of_children
FROM relative_of_employee AS e 
	INNER JOIN emp_relative AS r
		ON r.relative_id=e.relative_id
	RIGHT JOIN actual_fio AS f
		ON f.employee_id=e.employee_id
	RIGHT JOIN actual_contacts c
		ON f.employee_id=c.employee_id
	RIGHT JOIN type_of_kinship t
		ON t.type_of_kinship_id = r.type_of_kinship_id
WHERE c.family_status = true
GROUP BY e.employee_id, f.emp_lastname, f.emp_name, f.emp_patronymic
ORDER BY f.emp_lastname;

/*19. Выбрать название отдела и среднюю зарплату сотрудников отдела. 
В результат включить отделы, в которых больше 3 человек. Результат отсортировать по средней зарплате в порядке
возрастания.*/
--+
SELECT d.department_name, AVG(s.salary * 1.0) AS avg_salary
FROM department AS d
	LEFT JOIN staff_list AS s 
		ON d.department_id = s.department_id
	LEFT JOIN actual_contacts c 
		ON c.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(c.employee_id) > 3
ORDER BY avg_salary;

/*20. Для каждого времени года вывести количество сотрудников, 
рожденных в соответствующее время года.*/

/* в подзапрос выборку по кейсу, а группировку во внешний запрос, который будет считать*/
--+
SELECT 'Зима', COUNT(employee_id)
FROM employee
	WHERE EXTRACT(MONTH FROM date_of_birth) IN (12,1,2)
UNION ALL
SELECT 'Весна', COUNT(employee_id)
FROM employee
	WHERE EXTRACT(MONTH FROM date_of_birth) IN (3,4,5)
UNION ALL
SELECT 'Лето', COUNT(employee_id)
FROM employee
	WHERE EXTRACT(MONTH FROM date_of_birth) IN (6,7,8)
UNION ALL
SELECT 'Осень', COUNT(employee_id)
FROM employee
	WHERE EXTRACT(MONTH FROM date_of_birth) IN (9,10,11);


/*21.Выбрать названия курсов повышения квалификации, 
которые прошло несколько сотрудников в текущем году, но все они
из одного отдела. Результат отсортировать по названию в лексикографическом порядке.*/
/* все они из одного отдела*/
--+
SELECT c.qualification_courses_name
FROM qualification_courses AS c
	INNER JOIN qualification_courses_of_employees AS e
		ON c.qualification_courses_id = e.qualification_courses_id
	INNER JOIN actual_contacts AS a
		ON e.employee_id = a.employee_id
WHERE EXTRACT(YEAR FROM e.date_of_end) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY c.qualification_courses_name
HAVING COUNT(e.employee_id) > 1 AND COUNT(DISTINCT a.department_id) = 1
ORDER BY 1;

/*22. Выбрать названия всех отделов и, если есть сотрудники,
работающие в отделе, то их табельный номер, фамилию и инициалы. 
Предполагается, что есть отделы без сотрудников.*/
--+
INSERT INTO department (department_name,parent_department_id)
VALUES('Отдел контроля качества', NULL),
('Отдел маркетинга', (SELECT department_id FROM department WHERE department_name = 'Отдел продаж'));

SELECT d.department_name, f.employee_id, CONCAT(f.emp_lastname,' ', SUBSTRING(f.emp_name,1,1)||'.', SUBSTRING(f.emp_patronymic,1,1)||'.') AS initials
FROM department AS d
	LEFT JOIN actual_contacts AS c
		ON d.department_id = c.department_id
	LEFT JOIN actual_fio AS f
		ON f.employee_id = c.employee_id
ORDER BY 1;

/*23. Выбрать названия всех отделов и, если есть сотрудники,
работающие в отделе, то их количество.*/
--+
SELECT d.department_name, COUNT(c.employee_id)
FROM department AS d
LEFT JOIN actual_contacts AS c
	ON d.department_id = c.department_id
GROUP BY  d.department_name;

/*24. Выбрать названия всех дней недели (без повторений), в
которые увольняли сотрудников. Учитывать только те дни недели,
в которые увольняли более одного сотрудника.*/
--+
SELECT DISTINCT TO_CHAR(date_of_dismissal, 'Day')
FROM dismissal_order
GROUP BY date_of_dismissal
HAVING COUNT(*) > 1;
	
/*25. Выбрать для каждого сотрудника названия всех мест
проведения курсов повышения квалификации.*/
--+
SELECT f.emp_lastname, f.emp_name, f.emp_patronymic, c.course_location_name
FROM actual_fio AS f CROSS JOIN course_location AS c;

/*26. Выбрать для каждого сотрудника названия всех мест
проведения курсов повышения квалификации; если сотрудник
проходил курсы повышения квалификации в соответствующем
месте, то период прохождения последних курсов.*/
--+
SELECT f.emp_lastname, f.emp_name, f.emp_patronymic, l.course_location_name, MAX(e.date_of_begin), MAX(e.date_of_end)
FROM actual_fio AS f 
	CROSS JOIN course_location AS l
	LEFT JOIN qualification_courses AS c
		ON l.course_location_id = c.course_location_id
	LEFT JOIN qualification_courses_of_employees AS e
		ON f.employee_id = e.employee_id AND e.qualification_courses_id = c.qualification_courses_id
GROUP BY f.emp_lastname, f.emp_name, f.emp_patronymic, l.course_location_name, f.employee_id;

/*27. Выбрать все данные тех сотрудников, которые имеют тезок однофамильцев среди директоров.*/
/* подзапрос на макс дату*/
--+
INSERT INTO post (post_name, kpi) 
VALUES ('Директор', 'Корреткное выполнение всех процессов отдела, повышение выручки');

INSERT INTO staff_list (post_id, department_id, salary, number_of_bids)
VALUES 
((SELECT post_id FROM post WHERE post_name = 'Директор'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 500000.00, 1);

INSERT INTO employee(gender, date_of_birth) 
VALUES ('M', '1980-03-15'),
('M', '1970-08-15');

INSERT INTO actual_FIO (date_of_relevance, employee_id, emp_lastname, emp_name, emp_patronymic) 
VALUES ('2024-01-15', 21, 'Петров', 'Алексей', 'Сергеевич'),
('2024-01-15', 22, 'Каримов', 'Алим', 'Маратович');

INSERT INTO contract (conract_number, employee_id, post_id, date_of_compilation, date_of_admission, date_of_expiration) 
VALUES 
('CTR-2024-021', 21, 
(SELECT post_id FROM post WHERE post_name = 'Директор'), 
'2024-01-15', '2024-01-16', '2024-12-31'),
('CTR-2024-022', 22, 
(SELECT post_id FROM post WHERE post_name = 'Директор'), 
'2024-01-15', '2024-01-16', '2024-12-31');

SELECT 
    e.employee_id,
    a_FIO.emp_lastname, 
    a_FIO.emp_name,
    a_FIO.emp_patronymic,
    e.gender,
    e.date_of_birth,
    a_pas_data.series,
    a_pas_data.passport_number,
    a_pas_data.issued_by_whom,
    a_pas_data.when_issued,
    a_cont.locality_id,
    a_cont.adress,
    a_cont.department_id,
    a_cont.family_status,
    a_cont.phone_number 
FROM employee AS e 
	LEFT JOIN actual_passport_data AS a_pas_data 
	    ON a_pas_data.employee_id = e.employee_id
	LEFT JOIN actual_FIO AS a_FIO
	    ON a_FIO.employee_id = e.employee_id
	LEFT JOIN actual_contacts AS a_cont
	    ON a_cont.employee_id = e.employee_id
	JOIN actual_FIO AS d_FIO
		ON d_FIO.emp_lastname = a_FIO.emp_lastname 
	JOIN department d
		ON d_FIO.employee_id = d.director_id
WHERE d_FIO.employee_id > e.employee_id 
	AND a_FIO.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa_FIO
		WHERE aa_FIO.employee_id=a_FIO.employee_id
		);

/*28. Выбрать данные самого пожилого сотрудника.*/
--+
SELECT e.employee_id,
	emp_lastname, 
	emp_name,
	emp_patronymic
	gender,
	date_of_birth,
	series,passport_number,
	issued_by_whom,
	when_issued,
	locality_id,
	adress,
	department_id,
	family_status,
	phone_number 
FROM employee AS e 
JOIN actual_passport_data AS a_pas_data 
ON a_pas_data.employee_id=e.employee_id
JOIN actual_FIO AS a_FIO
ON a_FIO.employee_id=e.employee_id
JOIN actual_contacts AS a_cont
ON a_cont.employee_id=e.employee_id
WHERE e.date_of_birth = (SELECT MIN(date_of_birth) FROM employee)
AND EXISTS (SELECT 1 
	FROM contract AS c
	WHERE EXTRACT(YEAR FROM date_of_expiration) > EXTRACT(YEAR FROM CURRENT_DATE) OR date_of_expiration IS NULL
	AND e.employee_id = c.employee_id);

/*29. Выбрать данные самого молодого и самого пожилого сотрудников.*/
--+
SELECT e.employee_id,
	emp_lastname, 
	emp_name,
	emp_patronymic
	gender,
	date_of_birth,
	series,passport_number,
	issued_by_whom,
	when_issued,
	locality_id,
	adress,
	department_id,
	family_status,
	phone_number 
FROM employee AS e 
INNER JOIN actual_passport_data AS a_pas_data 
ON a_pas_data.employee_id=e.employee_id
INNER JOIN actual_FIO AS a_FIO
ON a_FIO.employee_id=e.employee_id
INNER JOIN actual_contacts AS a_cont
ON a_cont.employee_id=e.employee_id
WHERE (e.date_of_birth = (SELECT MIN(date_of_birth) FROM employee)
OR e.date_of_birth = (SELECT MAX(date_of_birth) FROM employee))
AND EXISTS (SELECT 1 
	FROM contract AS c
	WHERE EXTRACT(YEAR FROM date_of_expiration) > EXTRACT(YEAR FROM CURRENT_DATE) OR date_of_expiration IS NULL
	AND e.employee_id = c.employee_id);

/*30. Выбрать фамилии, имена, отчества сотрудников, 
которые старше среднего возраста сотрудников в той же должности.*/
--+
SELECT a_FIO.emp_lastname,a_FIO.emp_name, a_FIO.emp_patronymic
FROM actual_FIO AS a_FIO 
JOIN employee AS e
ON e.employee_id = a_FIO.employee_id
JOIN contract AS c
ON c.employee_id = e.employee_id
WHERE EXTRACT(YEAR FROM(AGE(e.date_of_birth))) > (
	SELECT AVG(EXTRACT(YEAR FROM(AGE(ee.date_of_birth))))
	FROM employee AS ee
	JOIN contract AS cc
	ON cc.employee_id = ee.employee_id
	WHERE cc.post_id = c.post_id)
AND a_FIO.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa_FIO
		WHERE aa_FIO.employee_id =a_FIO.employee_id
);


WITH avg_age AS(
	SELECT post_id, 
	AVG(EXTRACT(YEAR FROM(AGE(ee.date_of_birth)))) AS age_avg 
	FROM employee AS ee
	JOIN contract AS cc
	ON cc.employee_id = ee.employee_id
	GROUP BY post_id)

SELECT a_FIO.emp_lastname,a_FIO.emp_name, a_FIO.emp_patronymic
FROM actual_FIO AS a_FIO 
JOIN employee AS e
ON e.employee_id = a_FIO.employee_id
JOIN contract AS c
ON c.employee_id = e.employee_id
JOIN avg_age AS ag
ON ag.post_id = c.post_id
WHERE ag.age_avg < EXTRACT(YEAR FROM(AGE(e.date_of_birth)))
AND a_FIO.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa_FIO
		WHERE aa_FIO.employee_id =a_FIO.employee_id
);

SELECT a_FIO.emp_lastname,a_FIO.emp_name, a_FIO.emp_patronymic
FROM actual_FIO AS a_FIO 
JOIN employee AS e
ON e.employee_id = a_FIO.employee_id
JOIN contract AS c
ON c.employee_id = e.employee_id
JOIN (
	SELECT post_id, 
	AVG(EXTRACT(YEAR FROM(AGE(ee.date_of_birth)))) AS age_avg 
	FROM employee AS ee
	JOIN contract AS cc
	ON cc.employee_id = ee.employee_id
	GROUP BY post_id) AS ag 
ON ag.post_id = c.post_id
WHERE ag.age_avg < EXTRACT(YEAR FROM(AGE(e.date_of_birth)))
AND a_FIO.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa_FIO
		WHERE aa_FIO.employee_id =a_FIO.employee_id
);



/*31. Выбрать название должности, в которой никто не работал.*/
---+
SELECT post_name
FROM post AS p
WHERE NOT EXISTS (SELECT 1
					FROM contract c
					WHERE c.post_id = p.post_id
					);

/*32. Выбрать название самой высокооплачиваемой должности.*/
--+
SELECT p.post_name 
FROM post AS p
JOIN staff_list AS s
ON p.post_id = s.post_id
WHERE s.salary = (
	SELECT MAX(salary) FROM staff_list
);

/*33. Выбрать для каждого отдела фамилию, имя, отчество самого высокооплачиваемого сотрудника.*/
--+
SELECT d.department_name, a.emp_lastname,a.emp_name, a.emp_patronymic
FROM department AS d
LEFT JOIN staff_list AS s
ON s.department_id = d.department_id
LEFT JOIN contract c
ON c.post_id = s.post_id
LEFT JOIN actual_fio AS a
ON c.employee_id = a.employee_id
WHERE (s.salary = (
	SELECT MAX(ss.salary)
		FROM staff_list ss
		WHERE ss.department_id = s.department_id) OR s.salary IS NULL)
AND (a.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa
		WHERE aa.employee_id =a.employee_id) OR a.date_of_relevance IS NULL);
		
/*34. Выбрать отделы, в которых работают только семейные
сотрудники.*/
--+
UPDATE actual_contacts 
SET family_status = true
WHERE department_id IN (3,2);

SELECT d.department_name
FROM department d
JOIN actual_contacts AS c
	ON c.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(c.employee_id) = COUNT(CASE WHEN c.family_status = true THEN 1 ELSE NULL END);

/*35. Выбрать место проведения курсов повышения квалификации, 
где проходило повышение квалификации большинство сотрудников.*/
--+
SELECT course_location_name
FROM course_location AS c
JOIN qualification_courses AS qc
	ON c.course_location_id = qc.course_location_id
JOIN qualification_courses_of_employees AS qe
	ON qe.qualification_courses_id = qc.qualification_courses_id
GROUP BY c.course_location_name, c.course_location_id
HAVING COUNT(qe.employee_id) = (SELECT MAX(cnt)
								FROM (SELECT COUNT(qe.employee_id) AS cnt		
									FROM course_location AS c
									JOIN qualification_courses AS qc
										ON c.course_location_id = qc.course_location_id
									JOIN qualification_courses_of_employees AS qe
										ON qe.qualification_courses_id = qc.qualification_courses_id
									GROUP BY c.course_location_name, c.course_location_id)`
								);

/*36. Выбрать название самых длительных курсов повышения
квалификации.*/
--+
SELECT DISTINCT q.qualification_courses_name, AGE(qe.date_of_end, qe.date_of_begin)
FROM qualification_courses AS q
JOIN qualification_courses_of_employees AS qe
ON qe.qualification_courses_id = q.qualification_courses_id
WHERE AGE(qe.date_of_end, qe.date_of_begin) = (
	SELECT MAX(AGE(date_of_end, date_of_begin)) FROM qualification_courses_of_employees
);

/*37. Выбрать табельный номер и фамилии, имена, отчества
сотрудников, у которых больше всего сыновей*/
--+
INSERT INTO emp_relative (emp_lastname, emp_name, emp_patronymic, phone_number, date_of_birth, type_of_kinship_id)
VALUES 
('Cмирнов', 'Александр', 'Петрович', '79051234511', '2005-05-15', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын')),
('Cмирнов', 'Дмитрий', 'Петрович', '79051234521', '2010-12-07', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын'));

INSERT INTO relative_of_employee(employee_id, relative_id)
VALUES
(3,41),
(3,40);

SELECT a.employee_id, a.emp_lastname, a.emp_name, a.emp_patronymic
FROM actual_FIO AS a
INNER JOIN relative_of_employee AS re
	ON a.employee_id = re.employee_id
INNER JOIN emp_relative AS r
	ON r.relative_id = re.relative_id
INNER JOIN type_of_kinship AS t
	ON t.type_of_kinship_id = r.type_of_kinship_id 
WHERE type_of_kinship_name = 'сын'
GROUP BY a.employee_id, a.emp_lastname, a.emp_name, a.emp_patronymic
HAVING COUNT(*) >= ALL(SELECT COUNT(*) AS cnt
		FROM actual_contacts AS a
		INNER JOIN relative_of_employee AS re
			ON a.employee_id = re.employee_id
		INNER JOIN emp_relative AS r
			ON r.relative_id = re.relative_id
		INNER JOIN type_of_kinship AS t
			ON t.type_of_kinship_id = r.type_of_kinship_id 
		WHERE type_of_kinship_name = 'сын'
		GROUP BY a.employee_id);



/*38. Выбрать сотрудников с самыми редкими именами по
всей БД.*/

--оконки
--+
SELECT a.emp_lastname, a.emp_name, a.emp_patronymic
FROM actual_FIO AS a
JOIN (SELECT a.emp_name
	FROM actual_FIO AS a
	GROUP BY a.emp_name
	HAVING COUNT(a.employee_id) <= ALL(SELECT COUNT(aa.employee_id)
									FROM actual_FIO AS aa
									GROUP BY aa.emp_name)) AS rare_names
ON a.emp_name = rare_names.emp_name;

/*39. Выбрать названия дней недели, в которые чаще увольняют, 
чем принимают на работу.*/
---
/*SELECT DISTINCT TO_CHAR(date_of_compilation, 'Day')
FROM orders AS o
WHERE (SELECT COUNT(*)
		FROM orders AS oo
		WHERE type_of_order = 'увольнение' AND TO_CHAR(oo.date_of_compilation, 'Day') = TO_CHAR(o.date_of_compilation, 'Day'))
		> 
		(SELECT COUNT(*)
		FROM orders AS ooo
		WHERE type_of_order = 'прием' AND TO_CHAR(ooo.date_of_compilation, 'Day') = TO_CHAR(o.date_of_compilation, 'Day'));*/


/*SELECT layoffs.day_of_week
FROM (SELECT TO_CHAR(o.date_of_compilation, 'Day') AS day_of_week, COUNT(*) AS layoffs_cnt
		FROM orders AS o
		WHERE o.type_of_order = 'увольнение'
		GROUP BY TO_CHAR(o.date_of_compilation, 'Day'))  AS layoffs
LEFT JOIN (SELECT TO_CHAR(oo.date_of_compilation, 'Day') day_of_week, COUNT(*) AS hirings_cnt
		FROM orders AS oo
		WHERE oo.type_of_order = 'прием'
		GROUP BY TO_CHAR(oo.date_of_compilation, 'Day')) AS hirings
ON layoffs.day_of_week = hirings.day_of_week
WHERE layoffs_cnt > COALESCE(hirings_cnt, 0);*/


SELECT TO_CHAR(date_of_compilation, 'Day')
FROM orders
GROUP BY TO_CHAR(date_of_compilation, 'Day')
HAVING COUNT(*) FILTER (WHERE type_of_order = 'увольнение') > COUNT(*) FILTER (WHERE type_of_order = 'прием');

/*40. Выбрать общее количество людей в БД.
Чем отличается от 13-ой, где формулировка такая: Выбрать общее количество сотрудников в БД
*/
--+

/*41. Выбрать фамилию, имя, отчество сотрудника, количество детей до 14 лет, 
общее количество человек в его семье.*/
--count от case для сравнения 
--подзапрос во from 
--оконки
--актуальные ФИО во from
--+
SELECT a.emp_lastname, a.emp_name, a.emp_patronymic,
(SELECT COUNT(*) 
	FROM relative_of_employee AS re
	JOIN emp_relative AS r
	ON re.relative_id = r.relative_id
	JOIN type_of_kinship AS t
	ON r.type_of_kinship_id = t.type_of_kinship_id
	WHERE re.employee_id = a.employee_id
		AND t.type_of_kinship_name IN ('cын', 'дочь')
		AND EXTRACT( YEAR FROM AGE(r.date_of_birth)) < 14) AS count_children,
(SELECT COUNT(*) 
	FROM relative_of_employee AS re
	JOIN emp_relative AS r
	ON re.relative_id = r.relative_id
	JOIN type_of_kinship AS t
	ON r.type_of_kinship_id = t.type_of_kinship_id
	WHERE re.employee_id = a.employee_id) AS count_relative
FROM actual_FIO AS a
WHERE a.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS a_FIO
		WHERE a.employee_id =a_FIO.employee_id); 

/*42. Выбрать название отдела, количество мужчин в отделе,
количество женщин в отделе. В результат должны войти только
отделы, в которых есть сотрудники мужчины и женщины, работающие в одной и той же должности.*/
--самоединение
--from
--count от case 
--+
UPDATE employee SET gender = 'F' WHERE employee_id = 3; 
UPDATE contract SET post_id = (SELECT post_id FROM post WHERE post_name = 'Бухгалтер') 
WHERE employee_id = 3;

SELECT department_name,
(SELECT COUNT(*) 
	FROM actual_contacts AS a
	JOIN employee AS e
	ON e.employee_id = a.employee_id
	WHERE gender = 'M'
		AND a.department_id = d.department_id) AS count_men,
(SELECT COUNT(*) 
	FROM actual_contacts AS a
	JOIN employee AS e
	ON e.employee_id = a.employee_id
	WHERE gender = 'F'
		AND a.department_id = d.department_id) AS count_women
FROM department AS d
WHERE EXISTS (SELECT 1
				FROM actual_contacts AS a
				JOIN employee AS e
					ON e.employee_id = a.employee_id
				JOIN contract AS c
					ON c.employee_id = a.employee_id
				WHERE EXISTS (SELECT gender 
							FROM actual_contacts AS aa
							JOIN employee AS ee
								ON ee.employee_id = aa.employee_id
							JOIN contract AS cc
								ON cc.employee_id = aa.employee_id
							WHERE cc.post_id = c.post_id 
								AND aa.department_id = a.department_id
								AND e.gender != ee.gender)
				AND d.department_id = a.department_id);


WITH department_CTE
AS (
SELECT 
	d.department_name AS d_name,
	d.department_id, 
	c.post_id, 
	e.employee_id, 
	e.gender,
	COUNT(*) FILTER (WHERE gender = 'F') OVER (PARTITION BY d.department_id, c.post_id) AS count_women_on_post,
	COUNT(*) FILTER (WHERE gender = 'M') OVER (PARTITION BY d.department_id, c.post_id) AS count_man_on_post,
	COUNT(*) FILTER (WHERE gender = 'F') OVER (PARTITION BY d.department_id) AS count_women,
	COUNT(*) FILTER (WHERE gender = 'M') OVER (PARTITION BY d.department_id) AS count_man
FROM actual_contacts AS a
	JOIN employee AS e
		ON e.employee_id = a.employee_id
	JOIN contract AS c
		ON c.employee_id = a.employee_id 
	JOIN department AS d
		ON a.department_id = d.department_id
)

SELECT DISTINCT d_name, count_women, count_man
FROM department_CTE
WHERE count_women_on_post != 0 AND count_man_on_post != 0;


CREATE TABLE employee_orders (
    employee_id INTEGER,
    order_id INTEGER,
	PRIMARY KEY(employee_id, order_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_number)
);

INSERT INTO employee_orders (employee_id, order_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(1, 31),
(1, 32),
(1, 33),
(4, 34),
(4, 35),
(4, 36),
(4, 37),
(4, 38),
(17, 39),
(19, 40);

DELETE FROM contract WHERE employee_id IN (1, 4);

INSERT INTO contract (conract_number, employee_id, post_id, date_of_compilation, date_of_admission, date_of_expiration) VALUES 
('CTR-2024-001', 1, (SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), '2025-01-15', '2025-01-16', '2025-03-31'),
('CTR-2024-021', 1, (SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), '2025-08-01', '2025-08-02', '2025-12-31'),
('CTR-2024-022', 1, (SELECT post_id FROM post WHERE post_name = 'Маркетолог'), '2025-04-01', '2025-04-02', '2025-06-30'),
('CTR-2024-023', 1, (SELECT post_id FROM post WHERE post_name = 'Маркетолог'), '2025-10-01', '2025-10-02', '2025-12-31'),
('CTR-2024-004', 4, (SELECT post_id FROM post WHERE post_name = 'Системный администратор'), '2025-01-10', '2025-01-11', '2025-04-30'),
('CTR-2024-025', 4, (SELECT post_id FROM post WHERE post_name = 'Системный администратор'), '2025-09-01', '2025-09-02', '2025-12-31'),
('CTR-2024-026', 4, (SELECT post_id FROM post WHERE post_name = 'Тестировщик'), '2025-05-01', '2025-05-02', '2025-07-31'),
('CTR-2024-027', 4, (SELECT post_id FROM post WHERE post_name = 'Тестировщик'), '2025-11-01', '2025-11-02', '2025-12-31'),
('CTR-2024-028', 4, (SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), '2025-02-01', '2025-02-02', '2025-04-30'),
('CTR-2024-029', 4, (SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), '2025-08-01', '2025-08-02', '2025-10-31');

UPDATE orders 
SET date_of_compilation = MAKE_DATE(2026, EXTRACT(MONTH FROM date_of_compilation)::INTEGER, EXTRACT(DAY FROM date_of_compilation)::INTEGER)
WHERE type_of_order = 'прием';

UPDATE orders 
SET date_of_compilation = MAKE_DATE(2026, EXTRACT(MONTH FROM date_of_compilation)::INTEGER, EXTRACT(DAY FROM date_of_compilation)::INTEGER)
WHERE type_of_order = 'увольнение';

/*43. Выбрать сотрудников, которые несколько раз в текущем
году принимались и увольнялись с работы, поменяли несколько
должностей, причем в каждой должности сотрудник был как минимум два раза.*/
--группировка
--CTE 
--+
WITH employee_move AS 
(SELECT a.employee_id, a.emp_lastname, a.emp_name, a.emp_patronymic, hirings.post_id, hirings_cnt, layoffs_cnt
FROM actual_FIO AS a
JOIN (SELECT eo.employee_id, c.post_id, COUNT(*) AS hirings_cnt
			FROM employee_orders AS eo
			JOIN orders AS o
				ON o.order_number = eo.order_id
			JOIN contract AS c
				ON c.employee_id = eo.employee_id
			WHERE o.type_of_order = 'прием'
			AND EXTRACT(YEAR FROM o.date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE)
			GROUP BY eo.employee_id,c.post_id) AS hirings
ON hirings.employee_id = a.employee_id
JOIN (SELECT eo.employee_id,c.post_id, COUNT(*) AS layoffs_cnt
			FROM employee_orders AS eo
			JOIN orders AS o
				ON o.order_number = eo.order_id
			JOIN contract AS c
				ON c.employee_id = eo.employee_id
			WHERE o.type_of_order = 'увольнение'
			AND EXTRACT(YEAR FROM o.date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE)
			GROUP BY eo.employee_id,c.post_id) AS layoffs
ON layoffs.employee_id = a.employee_id AND hirings.post_id = layoffs.post_id)

SELECT DISTINCT em.employee_id, emp_lastname, emp_name, emp_patronymic
FROM employee_move AS em
JOIN (SELECT employee_id, COUNT(DISTINCT post_id) AS post_cnt
		FROM employee_move
		GROUP BY employee_id) AS posts
ON posts.employee_id = em.employee_id
WHERE hirings_cnt > 1 AND layoffs_cnt > 1 AND post_cnt > 1;


/*SELECT a.employee_id, a.emp_lastname, a.emp_name, a.emp_patronymic 
FROM actual_FIO AS a
WHERE 1 < (SELECT COUNT(*) 
			FROM employee_orders AS eo
			JOIN orders AS o
				ON o.order_number = eo.order_id
			WHERE o.type_of_order = 'прием'
			AND a.employee_id = eo.employee_id
			AND EXTRACT(YEAR FROM date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE))
AND
	  1 < (SELECT COUNT(*)
		 	FROM employee_orders AS eo
			JOIN orders AS o
				ON o.order_number = eo.order_id
			WHERE o.type_of_order = 'увольнение'
			AND a.employee_id = eo.employee_id
			AND EXTRACT(YEAR FROM date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE))
AND 
	  2 <= ALL(SELECT COUNT(c.conract_number)
				FROM contract AS c
				WHERE EXTRACT(YEAR FROM date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE)
					AND a.employee_id = c.employee_id
				GROUP BY c.post_id)
AND 
	  2 <= (SELECT COUNT(DISTINCT post_id)
	  			FROM contract AS c
				WHERE EXTRACT(YEAR FROM date_of_compilation) = EXTRACT(YEAR FROM CURRENT_DATE)
					AND a.employee_id = c.employee_id)
AND a.date_of_relevance = 
	(SELECT MAX(date_of_relevance)
		FROM actual_FIO AS aa_FIO
		WHERE a.employee_id =aa_FIO.employee_id
);*/

/*44. Выбрать название должности, название отдела, количество человек, 
работающих в соответствующей должности в соответствующем отделе, и общее количество человек, работающих в
должности.*/
--оконки
--расширения group by 
--+
SELECT DISTINCT p.post_name, d.department_name,
       (SELECT COUNT(*) 
        FROM contract c 
        JOIN actual_contacts AS a 
			ON a.employee_id = c.employee_id
        WHERE c.post_id = p.post_id
          AND a.department_id = d.department_id
          AND (c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL)
       ) AS count_dep,
       (SELECT COUNT(*) 
        FROM contract c 
        WHERE c.post_id = p.post_id
          AND (c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL)
       ) AS total_count
FROM post AS p
JOIN contract AS c
	ON p.post_id = c.post_id
JOIN actual_contacts AS a 
	ON a.employee_id = c.employee_id
JOIN department AS d 
	ON a.department_id = d.department_id;

SELECT DISTINCT p.post_name, d.department_name,
COUNT(c.conract_number) OVER (PARTITION BY d.department_id, p.post_id),
COUNT(c.conract_number) OVER (PARTITION BY p.post_id)
FROM post AS p
JOIN contract AS c
	ON p.post_id = c.post_id
JOIN actual_contacts AS a 
	ON a.employee_id = c.employee_id
JOIN department AS d 
	ON a.department_id = d.department_id
WHERE c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL; 



/*45. Выбрать пары сотрудников, имеющих пересекающиеся
периоды трудовых договоров о приеме на работу.*/
--+
SELECT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic, 
	aa.employee_id, 
	aa.emp_lastname, 
	aa.emp_name, 
	aa.emp_patronymic
FROM actual_FIO AS a
CROSS JOIN actual_FIO AS aa
WHERE EXISTS (SELECT 1
		FROM contract c
		JOIN contract cc
		ON c.employee_id = a.employee_id AND cc.employee_id = aa.employee_id
		WHERE (c.date_of_admission <= cc.date_of_admission AND (c.date_of_expiration >= cc.date_of_admission
																OR c.date_of_expiration IS NULL
																OR cc.date_of_expiration IS NULL))
		AND cc.conract_number != c.conract_number AND a.employee_id < aa.employee_id); 


SELECT DISTINCT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic, 
	aa.employee_id, 
	aa.emp_lastname, 
	aa.emp_name, 
	aa.emp_patronymic
FROM actual_FIO AS a
JOIN contract AS c
	ON c.employee_id = a.employee_id
JOIN contract AS cc
	ON c.date_of_admission <= cc.date_of_admission AND (c.date_of_expiration >= cc.date_of_admission
																OR c.date_of_expiration IS NULL
																OR cc.date_of_expiration IS NULL)
JOIN actual_FIO AS aa
	ON cc.employee_id = aa.employee_id
WHERE cc.conract_number != c.conract_number AND a.employee_id < aa.employee_id;


/*46. Выбрать трех самых низкооплачиваемых сотрудников из
отдела X (значение подставьте сами).*/
--+
SELECT DISTINCT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic
FROM actual_FIO AS a
JOIN actual_contacts AS ac 
	ON a.employee_id = ac.employee_id
JOIN contract AS c
	ON c.employee_id = ac.employee_id
JOIN (SELECT s.post_id, 
		DENSE_RANK() OVER (ORDER BY s.salary) AS r
		FROM staff_list s
		JOIN department d
		ON s.department_id = d.department_id
		WHERE d.department_name = 'IT отдел'
		) AS salary_top
	ON	c.post_id = salary_top.post_id
WHERE (c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL) AND r <= 3;


/*47. Вывести сообщение «Есть вакантные должности», если
есть незанятые должности, и вывести «Вакантных должностей
нет», если свободных должностей нет.*/
--+
SELECT CASE 
    WHEN SUM(CASE WHEN real_bids.real_cnt< s.number_of_bids 
                THEN 1 
                ELSE 0 
             END) > 0 
    THEN 'Есть вакантные должности'
    ELSE 'Вакантных должностей нет'
END AS mess
FROM staff_list s
LEFT JOIN (
		SELECT post_id, COUNT(*) AS real_cnt
		FROM contract c 
		WHERE c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL
		GROUP BY post_id) AS real_bids
ON s.post_id = real_bids.post_id; 

/*48. Для каждого сотрудника выбрать название его текущей
должности.*/
--+
SELECT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic,
	p.post_name
FROM actual_FIO AS a
JOIN contract AS c
	ON c.employee_id = a.employee_id
JOIN post AS p
	ON p.post_id = c.post_id
WHERE c.date_of_expiration > CURRENT_DATE OR c.date_of_expiration IS NULL;


/*49. Для каждого сотрудника выбрать название его актуальной на дату N (значение подставьте сами) должности.*/
--+
SELECT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic,
	p.post_name
FROM actual_FIO AS a
JOIN contract AS c
	ON c.employee_id = a.employee_id
JOIN post AS p
	ON p.post_id = c.post_id
WHERE c.date_of_expiration > MAKE_DATE(2026,12,5) OR (c.date_of_admission <= MAKE_DATE(2026,12,5) AND c.date_of_expiration IS NULL);

/*50. Выбрать сотрудников, которые имели перерыв в своей
карьере в организации, т. е. были уволены, а затем через некоторое время приняты.*/
--+
SELECT DISTINCT a.employee_id, 
	a.emp_lastname, 
	a.emp_name, 
	a.emp_patronymic
FROM actual_FIO AS a
JOIN employee_orders AS eo 
	ON a.employee_id = eo.employee_id
JOIN orders AS o
	ON eo.order_id = o.order_number
WHERE EXISTS (SELECT 1
				FROM orders oo
				JOIN employee_orders AS eeo 
					ON eeo.order_id = oo.order_number
				JOIN actual_FIO AS aa
					ON aa.employee_id = eeo.employee_id
				WHERE oo.type_of_order = 'прием'
					AND o.date_of_compilation > oo.date_of_compilation
					AND a.employee_id = aa.employee_id )
AND o.type_of_order = 'увольнение'; 

/*51. Выбрать все данные об уволенных, но не принятых на
работу повторно на данный момент сотрудниках.*/
--+
SELECT e.employee_id,
	emp_lastname, 
	emp_name,
	emp_patronymic
	gender,
	date_of_birth,
	series,passport_number,
	issued_by_whom,
	when_issued,
	locality_id,
	adress,
	department_id,
	family_status,
	phone_number 
FROM employee AS e 
JOIN actual_passport_data AS a_pas_data 
	ON a_pas_data.employee_id=e.employee_id
JOIN actual_FIO AS a_FIO
	ON a_FIO.employee_id=e.employee_id
JOIN actual_contacts AS a_cont
	ON a_cont.employee_id=e.employee_id
JOIN employee_orders AS eo 
	ON e.employee_id = eo.employee_id
JOIN orders AS o
	ON eo.order_id = o.order_number
WHERE NOT EXISTS (SELECT 1
				FROM orders oo
				JOIN employee_orders AS eeo 
					ON eeo.order_id = oo.order_number
				JOIN actual_FIO AS aa
					ON aa.employee_id = eeo.employee_id
				WHERE oo.type_of_order = 'прием'
					AND o.date_of_compilation > oo.date_of_compilation
					AND a_FIO.employee_id = aa.employee_id )
AND o.type_of_order = 'увольнение'; 

/*52. Выбрать иерархию структурных подразделений организации.*/
--+
UPDATE department 
SET parent_department_id = (SELECT department_id FROM department WHERE department_name = 'IT отдел')
WHERE department_name IN ('Отдел разработки', 'Отдел аналитики');

UPDATE department 
SET parent_department_id = (SELECT department_id FROM department WHERE department_name = 'Отдел клиентского сервиса')
WHERE department_name IN ('Отдел продаж', 'Техническая поддержка');

UPDATE department 
SET parent_department_id = (SELECT department_id FROM department WHERE department_name = 'Финансовый отдел')
WHERE department_name = 'Бухгалтерия';

WITH RECURSIVE departments_tree AS 
(
	SELECT
	department_id,
	department_name,
	parent_department_id,
	1 AS lev
	FROM department
	WHERE parent_department_id IS NULL

UNION ALL

	SELECT 	
	d.department_id,
	d.department_name,
	d.parent_department_id,
	t.lev+1
	FROM department d
	JOIN departments_tree t
	ON t.department_id = d.	parent_department_id
)

SELECT * FROM departments_tree;



