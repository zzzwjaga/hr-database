TRUNCATE region RESTART IDENTITY CASCADE;
TRUNCATE emp_locality RESTART IDENTITY CASCADE;
TRUNCATE country RESTART IDENTITY CASCADE;
TRUNCATE status RESTART IDENTITY CASCADE ;
TRUNCATE duties_of_post RESTART IDENTITY CASCADE;
TRUNCATE penalities_of_post RESTART IDENTITY CASCADE;
TRUNCATE post RESTART IDENTITY CASCADE;
TRUNCATE duties RESTART IDENTITY CASCADE;
TRUNCATE penalties RESTART IDENTITY CASCADE;
TRUNCATE department RESTART IDENTITY CASCADE;
TRUNCATE staff_list RESTART IDENTITY CASCADE;
TRUNCATE actual_FIO  RESTART IDENTITY CASCADE;
TRUNCATE employee RESTART IDENTITY CASCADE;
TRUNCATE contract RESTART IDENTITY CASCADE;
TRUNCATE actual_passport_data RESTART IDENTITY CASCADE;
TRUNCATE actual_contacts RESTART IDENTITY CASCADE;
TRUNCATE actual_status RESTART IDENTITY CASCADE;
TRUNCATE type_of_kinship  RESTART IDENTITY CASCADE;
TRUNCATE emp_relative RESTART IDENTITY CASCADE ;
TRUNCATE relative_of_employee RESTART IDENTITY CASCADE;
TRUNCATE educational_institution RESTART IDENTITY CASCADE;
TRUNCATE employee_education RESTART IDENTITY CASCADE;
TRUNCATE admission_order RESTART IDENTITY CASCADE;
TRUNCATE dismissal_order RESTART IDENTITY CASCADE;
TRUNCATE type_of_vacation RESTART IDENTITY CASCADE;
TRUNCATE vacation_order RESTART IDENTITY CASCADE;
TRUNCATE time_off_order RESTART IDENTITY CASCADE;
TRUNCATE hospital_record RESTART IDENTITY CASCADE;
TRUNCATE orders  RESTART IDENTITY CASCADE;
TRUNCATE qualification_courses_of_employees RESTART IDENTITY CASCADE;
TRUNCATE qualification_courses RESTART IDENTITY CASCADE;
TRUNCATE course_location RESTART IDENTITY CASCADE;

INSERT INTO country (country_name) 
VALUES ('Российская федерация'),
('Республика Беларусь'),
('Республика Казахстан');

INSERT INTO region(region_name, country_id) 
VALUES('Воронежская обл.', (SELECT country_id FROM country WHERE country_name='Российская федерация')),
('Республика Татарстан',(SELECT country_id FROM country WHERE country_name='Российская федерация')),
('Липецкая обл.',(SELECT country_id FROM country WHERE country_name='Российская федерация')),
('Краснодарский край',(SELECT country_id FROM country WHERE country_name='Российская федерация')),
('Республика Калмыкия',(SELECT country_id FROM country WHERE country_name='Российская федерация')),
('Минская обл.',(SELECT country_id FROM country WHERE country_name='Республика Беларусь')),
('Брестская обл.', (SELECT country_id FROM country WHERE country_name='Республика Беларусь')),
('Гродненская обл.', (SELECT country_id FROM country WHERE country_name='Республика Беларусь')),
('Павлодарская обл.',(SELECT country_id FROM country WHERE country_name='Республика Казахстан')),
('Абайская обл.',(SELECT country_id FROM country WHERE country_name='Республика Казахстан')),
('Акмолинская обл.',(SELECT country_id FROM country WHERE country_name='Республика Казахстан'));

INSERT INTO emp_locality (locality_name, region_id)
VALUES ('г. Воронеж', (SELECT region_id FROM region WHERE region_name='Воронежская обл.')),
('г. Новохоперск', (SELECT region_id FROM region WHERE region_name='Воронежская обл.')),
('г. Борисоглебск', (SELECT region_id FROM region WHERE region_name='Воронежская обл.')),
('г. Казань', (SELECT region_id FROM region WHERE region_name='Республика Татарстан')),
('г. Алметьевск', (SELECT region_id FROM region WHERE region_name='Республика Татарстан')),
('г. Нижнекамск', (SELECT region_id FROM region WHERE region_name='Республика Татарстан')),
('г. Липецк',(SELECT region_id FROM region WHERE region_name='Липецкая обл.')),
('г. Задонск',(SELECT region_id FROM region WHERE region_name='Липецкая обл.')),
('г. Елец',(SELECT region_id FROM region WHERE region_name='Липецкая обл.')),
('г. Краснодар',(SELECT region_id FROM region WHERE region_name='Краснодарский край')),
('г. Новороссийск', (SELECT region_id FROM region WHERE region_name='Краснодарский край')),
('г. Элиста',(SELECT region_id FROM region WHERE region_name='Республика Калмыкия')),
('г. Минск', (SELECT region_id FROM region WHERE region_name='Минская обл.')),
('г. Брест', (SELECT region_id FROM region WHERE region_name='Брестская обл.')),
('г. Гродно', (SELECT region_id FROM region WHERE region_name='Гродненская обл.')),
('г. Павлодар', (SELECT region_id FROM region WHERE region_name='Павлодарская обл.')),
('г. Cемей', (SELECT region_id FROM region WHERE region_name='Абайская обл.')),
('г. Кокшетау', (SELECT region_id FROM region WHERE region_name='Акмолинская обл.'));

INSERT INTO status (status_name)
VALUES ('main_job'),
('combination');

INSERT INTO post (post_name, kpi) 
VALUES ('Менеджер по продажам', 'Объем продаж: 1 млн руб/мес; Закрытие сделок: 15 в месяц'),
('Старший разработчик', 'Выполнение задач: 95% в срок; Code review: 10 пул-реквестов/неделю'),
('Маркетолог', 'ROI: 150%; CTR: 3%; Конверсия: 5%'),
('Системный администратор', 'Время безотказной работы: 99.9%; Время реакции на инциденты: <1 часа'),
('Бухгалтер', 'Своевременная сдача отчетности: 100%; Точность расчетов: 99.8%'),
('HR-специалист', 'Закрытие вакансий: 10 в месяц; Текучесть кадров: <5%'),
('Тестировщик', 'Покрытие тестами: 85%; Обнаружение багов: 95% до релиза'),
('Аналитик данных', 'Точность прогнозов: 90%; Время подготовки отчетов: <2 дней'),
('Дизайнер UX/UI', 'Удовлетворенность пользователей: 4.5/5; Время выполнения задач: 90% в срок'),
('Технический писатель', 'Объем документации: 100 страниц/месяц; Качество: <1 ошибка на страницу'),
('Специалист поддержки', 'Время решения обращений: <4 часов; Удовлетворенность клиентов: 4.7/5'),
('Продуктовый менеджер', 'Рост пользовательской базы: 20% в квартал; Retention: 80%'),
('Сетевой инженер', 'Доступность сети: 99.95%; Время простоя: <15 мин/месяц'),
('Контент-менеджер', 'Публикаций: 50 статей/месяц; Посещаемость: +25% к трафику'),
('Финансовый аналитик', 'Точность бюджетного планирования: 98%; Экономия: 5% от бюджета');

INSERT INTO duties (duties_name, duties_definition) 
VALUES ('Обеспечение выполнения плана продаж', 'Достижение установленных количественных и качественных показателей продаж'),
('Ведение клиентской базы', 'Систематическое обновление и пополнение базы данных клиентов'),
('Проведение переговоров', 'Организация и проведение встреч с потенциальными и текущими клиентами'),
('Подготовка коммерческих предложений', 'Разработка и оформление коммерческих предложений согласно стандартам компании'),
('Анализ рынка', 'Исследование рыночной ситуации и конкурентной среды'),
('Разработка новых функций', 'Создание и внедрение нового функционала продукта'),
('Code review', 'Проверка кода коллег на соответствие стандартам качества'),
('Техническая документация', 'Написание и поддержание актуальной технической документации'),
('Планирование рекламных кампаний', 'Разработка стратегии и плана рекламных активностей'),
('Анализ эффективности маркетинга', 'Мониторинг и оценка ROI маркетинговых кампаний'),
('Обслуживание серверов', 'Обеспечение стабильной работы серверного оборудования'),
('Резервное копирование', 'Организация и контроль системы резервного копирования данных'),
('Ведение бухгалтерского учета', 'Отражение хозяйственных операций в учете в соответствии с законодательством'),
('Подготовка отчетности', 'Своевременная подготовка и сдача налоговой и статистической отчетности'),
('Подбор персонала', 'Поиск, отбор и проведение собеседований с кандидатами');

INSERT INTO penalties (penalties_name, penalties_definition, sanctions) 
VALUES ('Невыполнение плана продаж', 'Систематическое невыполнение установленных плановых показателей', 'Штраф 15% от оклада; Выход в выходные дни'),
('Нарушение сроков сдачи проектов', 'Срыв дедлайнов по ключевым проектам более чем на 3 дня', 'Лишение премии за квартал'),
('Низкое качество кода', 'Многочисленные баги в production из-за некачественного кода', 'Штраф 10% от оклада'),
('Нарушение коммерческой тайны', 'Разглашение конфиденциальной информации третьим лицам', 'Возмещение ущерба в полном объеме'),
('Опоздания на работу', 'Систематические опоздания более чем на 15 минут', 'Лишение премии за месяц'),
('Потеря клиента', 'Утрата ключевого клиента по вине сотрудника', 'Понижение в должности'),
('Нарушение техники безопасности', 'Несоблюдение правил техники безопасности на рабочем месте', 'Штраф 5000 руб'),
('Непрохождение аттестации', 'Неудовлетворительные результаты ежегодной аттестации', 'Понижение в должности'),
('Конфликт на рабочем месте', 'Создание конфликтных ситуаций с коллегами или клиентами', 'Выговор'),
('Несоблюдение дресс-кода', 'Систематическое нарушение корпоративного дресс-кода', 'Предупреждение'),
('Использование ресурсов компании в личных целях', 'Нецелевое использование имущества или времени компании', 'Возмещение ущерба'),
('Нарушение процедуры отчетности', 'Неправильное оформление или срыв сроков отчетности', 'Лишение премии'),
('Несоблюдение SLA', 'Нарушение соглашений об уровне обслуживания клиентов', 'Штраф 10% от оклада'),
('Потеря важных данных', 'Утрата критически важной информации по неосторожности', 'Дисциплинарное взыскание; Возмещение ущерба'),
('Нарушение трудовой дисциплины', 'Систематическое несоблюдение правил внутреннего распорядка', 'Лишение премии на 3 месяца');

INSERT INTO duties_of_post (post_id, duties_id)
VALUES 
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Обеспечение выполнения плана продаж')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Ведение клиентской базы')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Проведение переговоров')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Разработка новых функций')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Code review')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Проведение переговоров')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Подготовка коммерческих предложений')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Анализ рынка')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Планирование рекламных кампаний')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Анализ эффективности маркетинга')),
((SELECT post_id FROM post WHERE post_name = 'Системный администратор'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Обслуживание серверов')),
((SELECT post_id FROM post WHERE post_name = 'Системный администратор'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Резервное копирование')),
((SELECT post_id FROM post WHERE post_name = 'Бухгалтер'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Ведение бухгалтерского учета')),
((SELECT post_id FROM post WHERE post_name = 'Бухгалтер'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Подготовка отчетности')),
((SELECT post_id FROM post WHERE post_name = 'HR-специалист'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Подбор персонала')),
((SELECT post_id FROM post WHERE post_name = 'Технический писатель'), 
(SELECT duties_id FROM duties WHERE duties_name = 'Техническая документация'));

INSERT INTO penalities_of_post (post_id, penalties_id)
VALUES 
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Невыполнение плана продаж')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Нарушение сроков сдачи проектов')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Низкое качество кода')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Нарушение коммерческой тайны')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Нарушение коммерческой тайны')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Опоздания на работу')),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Опоздания на работу')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Потеря клиента')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Непрохождение аттестации')),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Использование ресурсов компании в личных целях')),
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Несоблюдение SLA')),
((SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Потеря важных данных')),
((SELECT post_id FROM post WHERE post_name = 'Контент-менеджер'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Нарушение трудовой дисциплины')),
((SELECT post_id FROM post WHERE post_name = 'Специалист поддержки'), 
(SELECT penalties_id FROM penalties WHERE penalties_name = 'Конфликт на рабочем месте'));



INSERT INTO department(department_name,parent_department_id)
VALUES('IT отдел',NULL),
('Отдел клиентского сервиса',NULL),
('Финансовый отдел',NULL),
('Отдел разработки', (SELECT department_id FROM department WHERE department_name='IT отдел')),
('Отдел аналитики',(SELECT department_id FROM department WHERE department_name='IT отдел')),
('Отдел продаж', (SELECT department_id FROM department WHERE department_name='Отдел клиентского сервиса')),
('Техническая поддержка',(SELECT department_id FROM department WHERE department_name='Отдел клиентского сервиса')),
('Бухгалтерия',(SELECT department_id FROM department WHERE department_name='Финансовый отдел')),
('Бэк-офис',NULL);

ALTER TABLE department ADD director_id INTEGER;

UPDATE department SET director_id = 21
WHERE department_name='IT отдел';

UPDATE department SET director_id = 22
WHERE department_name='Отдел клиентского сервиса';

INSERT INTO staff_list (post_id, department_id, salary, number_of_bids)
VALUES 
((SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел продаж'), 50000.00, 20),
((SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел разработки'), 200000.00, 5),
((SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел продаж'), 100000.00, 8),
((SELECT post_id FROM post WHERE post_name = 'Системный администратор'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 70000.00, 10),
((SELECT post_id FROM post WHERE post_name = 'Бухгалтер'), 
(SELECT department_id FROM department WHERE department_name = 'Бухгалтерия'), 60000.00, 10),
((SELECT post_id FROM post WHERE post_name = 'HR-специалист'), 
(SELECT department_id FROM department WHERE department_name = 'Бэк-офис'), 60000.00, 5),
((SELECT post_id FROM post WHERE post_name = 'Тестировщик'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 150000.00, 4),
((SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 150000.00, 4),
((SELECT post_id FROM post WHERE post_name = 'Дизайнер UX/UI'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 150000.00, 1),
((SELECT post_id FROM post WHERE post_name = 'Технический писатель'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 100000.00, 1),
((SELECT post_id FROM post WHERE post_name = 'Специалист поддержки'), 
(SELECT department_id FROM department WHERE department_name = 'Техническая поддержка'), 50000.00, 10),
((SELECT post_id FROM post WHERE post_name = 'Продуктовый менеджер'), 
(SELECT department_id FROM department WHERE department_name = 'Бэк-офис'), 80000.00, 5),
((SELECT post_id FROM post WHERE post_name = 'Сетевой инженер'), 
(SELECT department_id FROM department WHERE department_name = 'Бэк-офис'), 80000.00, 3),
((SELECT post_id FROM post WHERE post_name = 'Контент-менеджер'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел продаж'), 100000.00, 3),
((SELECT post_id FROM post WHERE post_name = 'Финансовый аналитик'), 
(SELECT department_id FROM department WHERE department_name = 'Бэк-офис'), 150000.00, 4);


INSERT INTO employee(gender, date_of_birth) 
VALUES ('F', '1990-03-15'),  
('M', '1985-04-20'), 
('F', '2005-05-07'),  
('M', '1998-03-10'),  
('F', '1992-04-25'),  
('M', '1987-06-12'),  
('F', '1995-07-22'),  
('M', '2000-08-05'), 
('F', '1993-06-30'),
('M', '1989-07-15'), 
('F', '1991-09-18'),  
('M', '1996-10-08'),  
('F', '1988-11-25'),  
('M', '2002-09-01'),  
('F', '1994-10-20'),  
('M', '1997-12-14'),  
('F', '1999-01-28'),  
('M', '1986-02-03'),  
('F', '2001-12-25'),  
('M', '1993-01-15'); 

INSERT INTO actual_FIO (date_of_relevance, employee_id, emp_lastname, emp_name, emp_patronymic) 
VALUES ('2024-01-15', 1, 'Иванова', 'Анна', 'Сергеевна'),
('2024-02-01', 2, 'Петров', 'Дмитрий', 'Иванович'),
('2024-01-20', 3, 'Смирнова', 'Екатерина', 'Александровна'),
('2024-03-10', 4, 'Кузнецов', 'Михаил', 'Петрович'),
('2024-02-15', 5, 'Попова', 'Ольга', 'Владимировна'),
('2024-04-01', 6, 'Омаров', 'Ержан', NULL),
('2024-01-10', 7, 'Жусупова', 'Айгуль', 'Саматовна'),
('2024-05-20', 8, 'Каримов', 'Нурлан', 'Бахытжанович'),
('2024-03-01', 9, 'Ахметова', 'Гульнара', 'Рашидовна'),
('2024-06-15', 10, 'Садыков', 'Алим', 'Маратович'),
('2024-04-10', 11, 'Ковалёва', 'Надежда', 'Ивановна'),
('2024-07-01', 12, 'Новицкий', 'Александр', 'Петрович'),
('2024-05-05', 13, 'Семёнова', 'Виктория', 'Андреевна'),
('2024-08-12', 14, 'Григорьев', 'Артём', 'Сергеевич'),
('2024-06-20', 15, 'Павлова', 'Юлия', 'Николаевна'),
('2024-09-01', 16, 'Ибрагимов', 'Антон', 'Дмитриевич'),
('2024-07-15', 17, 'Петросян', 'Александра', 'Арменовна'),
('2024-10-10', 18, 'Козлов', 'Аид', 'Рашидович'),
('2024-08-25', 19, 'Нургалиева', 'Анна', NULL),
('2024-11-05', 20, 'Орлов', 'Айнур', 'Владимирович');

INSERT INTO contract (conract_number, employee_id, post_id, date_of_compilation, date_of_admission, date_of_expiration) 
VALUES 
('CTR-2024-001', 1, 
(SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
'2024-01-15', '2024-01-16', '2024-12-31'),
('CTR-2024-002', 2, 
(SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
'2024-02-01', '2024-02-02', '2024-12-31'),
('CTR-2024-003', 3, 
(SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
'2024-01-20', '2024-01-21', '2025-01-19'),
('CTR-2024-004', 4, 
(SELECT post_id FROM post WHERE post_name = 'Системный администратор'), 
'2024-03-10', '2024-03-11', '2025-03-09'),
('CTR-2024-005', 5, 
(SELECT post_id FROM post WHERE post_name = 'Бухгалтер'), 
'2024-02-15', '2024-02-16', '2024-12-15'),
('CTR-2024-006', 6, 
(SELECT post_id FROM post WHERE post_name = 'HR-специалист'), 
'2024-04-01', '2024-04-02', NULL),
('CTR-2024-007', 7, 
(SELECT post_id FROM post WHERE post_name = 'Тестировщик'), 
'2024-01-10', '2024-01-11', NULL),
('CTR-2024-008', 8, 
(SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
'2024-05-20', '2024-05-21', NULL),
('CTR-2024-009', 9, 
(SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
'2024-03-01', '2024-03-02', NULL),
('CTR-2024-010', 10, 
(SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
'2024-06-15', '2024-06-16', NULL),
('CTR-2024-011', 11,
(SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
'2024-04-10', NULL, '2025-04-09'),
('CTR-2024-012', 12, 
(SELECT post_id FROM post WHERE post_name = 'Продуктовый менеджер'), 
'2024-07-01', NULL, '2025-06-30'),
('CTR-2024-013', 13, 
(SELECT post_id FROM post WHERE post_name = 'Сетевой инженер'), 
'2024-05-05', NULL, '2025-05-04'),
('CTR-2024-014', 14, 
(SELECT post_id FROM post WHERE post_name = 'Аналитик данных'), 
'2024-08-12', NULL, '2025-08-11'),
('CTR-2024-015', 15, 
(SELECT post_id FROM post WHERE post_name = 'Финансовый аналитик'), 
'2024-06-20', NULL, '2025-06-19'),
('CTR-2024-016', 16, 
(SELECT post_id FROM post WHERE post_name = 'Менеджер по продажам'), 
'2024-09-01', NULL, NULL),
('CTR-2024-017', 17, 
(SELECT post_id FROM post WHERE post_name = 'Старший разработчик'), 
'2024-07-15', NULL, NULL),
('CTR-2024-018', 18, 
(SELECT post_id FROM post WHERE post_name = 'Маркетолог'), 
'2024-10-10', NULL, NULL),
('CTR-2024-019', 19, 
(SELECT post_id FROM post WHERE post_name = 'Системный администратор'), 
'2024-08-25', NULL, NULL),
('CTR-2024-020', 20, 
(SELECT post_id FROM post WHERE post_name = 'Бухгалтер'), 
'2024-11-05', NULL, NULL);

INSERT INTO actual_passport_data (employee_id, date_of_relevance, series, passport_number, issued_by_whom, when_issued) 
VALUES(1, 1, '4510', '123456', 'ОУФМС России по г. Воронеж', '2018-03-20'),
(2, 1, '4511', '234567', 'ОУФМС России по г. Липецк', '2019-05-15'),
(3, 1, '4512', '345678', 'ОУФМС России по Московской области', '2020-01-10'),
(4, 1, '4513', '456789', 'ОУФМС России по Элиста', '2017-08-25'),
(5, 1, '4514', '567890', 'ОУФМС России по г. Казань', '2021-02-14'),
(6, 1, '98AB', '123456', 'ДВД г. Астаны', '2019-06-30'),
(7, 1, '98AC', '234567', 'ДВД г. Алматы', '2020-03-22'),
(8, 1, '98AD', '345678', 'ДВД Алматинской области', '2018-11-15'),
(9, 1, '98AE', '456789', 'ДВД Восточно-Казахстанской области', '2021-01-08'),
(10, 1, '98AF', '567890', 'ДВД Карагандинской области', '2017-09-12'),
(11, 1, 'AB12', '123456', 'УВД Минского горисполкома', '2019-04-18'),
(12, 1, 'AB13', '234567', 'УВД Гомельского облисполкома', '2020-07-25'),
(13, 1, 'AB14', '345678', 'УВД Минского облисполкома', '2018-12-03'),
(14, 1, 'AB15', '456789', 'УВД Брестского облисполкома', '2021-03-30'),
(15, 1, 'AB16', '567890', 'УВД Витебского облисполкома', '2017-10-22'),
(16, 1, '4515', '678901', 'ОУФМС России по г. Новосибирску', '2020-09-15'),
(17, 1, '98AG', '678901', 'ДВД Атырауской области', '2019-08-20'),
(18, 1, 'AB17', '678901', 'УВД Могилевского облисполкома', '2021-05-10'),
(19, 1, '4516', '789012', 'ОУФМС России по г. Екатеринбургу', '2018-06-28'),
(20, 1, '98AH', '789012', 'ДВД Западно-Казахстанской области', '2020-11-17');

INSERT INTO actual_contacts (employee_id, locality_id, department_id, family_status, phone_number, adress)
VALUES 
(1, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Воронеж'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 
NULL, '79031234567', 'ул. Ленина, д. 15, кв. 24'),
(2, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Новохоперск'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел клиентского сервиса'), 
NULL, '79031234568', 'ул. Мира, д. 8, кв. 12'),
(3, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Борисоглебск'), 
(SELECT department_id FROM department WHERE department_name = 'Финансовый отдел'), 
true, '79031234569', 'ул. Советская, д. 45, кв. 7'),
(4, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Казань'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел разработки'), 
NULL, '79031234570', 'ул. Баумана, д. 23, кв. 15'),
(5, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Алметьевск'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел аналитики'), 
true, '79031234571', 'ул. Нефтяников, д. 17, кв. 9'),
(6, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Нижнекамск'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 
false, '79031234572', 'ул. Химиков, д. 34, кв. 18'),
(7, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Липецк'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел клиентского сервиса'), 
NULL, '79031234573', 'ул. Металлургов, д. 12, кв. 3'),
(8, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Задонск'), 
(SELECT department_id FROM department WHERE department_name = 'Финансовый отдел'), 
false, '79031234574', 'ул. Задонская, д. 5, кв. 11'),
(9, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Елец'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел разработки'), 
NULL, '79031234575', 'ул. Елецкая, д. 28, кв. 6'),
(10, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Краснодар'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел аналитики'), 
false, '79031234576', 'ул. Красная, д. 42, кв. 22'),
(11, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Новороссийск'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'),
true, '79031234577', 'ул. Набережная, д. 19, кв. 8'),
(12, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Элиста'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел клиентского сервиса'),
false, '79031234578', 'ул. Ленина, д. 7, кв. 14'),
(13, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Минск'), 
(SELECT department_id FROM department WHERE department_name = 'Финансовый отдел'), 
true, '375291234567', 'пр. Независимости, д. 125, кв. 33'),
(14, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Брест'),
(SELECT department_id FROM department WHERE department_name = 'Отдел разработки'), 
false, '375291234568', 'ул. Советская, д. 18, кв. 5'),
(15, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Гродно'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел аналитики'),
true, '375291234569', 'ул. Ожешко, д. 9, кв. 12'),
(16, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Павлодар'), 
(SELECT department_id FROM department WHERE department_name = 'IT отдел'), 
false, '77011234567', 'ул. Астана, д. 23, кв. 7'),
(17, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Cемей'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел клиентского сервиса'), 
true, '77011234568', 'ул. Абая, д. 14, кв. 19'),
(18, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Кокшетау'), 
(SELECT department_id FROM department WHERE department_name = 'Финансовый отдел'),
false, '77011234569', 'ул. Кокшетауская, д. 31, кв. 4'),
(19, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Воронеж'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел разработки'), 
true, '79031234580', 'ул. Воронежская, д. 11, кв. 2'),
(20, (SELECT locality_id FROM emp_locality WHERE locality_name = 'г. Казань'), 
(SELECT department_id FROM department WHERE department_name = 'Отдел аналитики'), 
false, '79031234581', 'ул. Татарстан, д. 26, кв. 16');

INSERT INTO actual_status (date_of_relevance, employee_id, status_id)
VALUES ('2024-01-01', 1, 1),
('2024-01-01', 2, 2),
('2024-01-01', 3, 1),
('2024-01-01', 4, 2),
('2024-01-01', 5, 1);

INSERT INTO type_of_kinship (type_of_kinship_name)
VALUES 
('супруг/супруга'),
('отец'),
('мать'),
('сын'),
('дочь'),
('брат'),
('сестра'),
('дедушка'),
('бабушка'),
('внук'),
('внучка'),
('дядя'),
('тетя');


INSERT INTO emp_relative (emp_lastname, emp_name, emp_patronymic, phone_number, date_of_birth, type_of_kinship_id)
VALUES 
('Иванов', 'Сергей', 'Петрович', '79051234501', '1970-05-15', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Иванова', 'Мария', 'Ивановна', '79051234502', '1972-08-20', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'мать')),
('Иванов', 'Алексей', 'Дмитриевич', '79051234503', '1995-12-10', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Петрова', 'Елена', 'Викторовна', '79051234504', '1980-03-25', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Петров', 'Иван', 'Дмитриевич', NULL, '1955-11-30', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Смирнов', 'Денис', 'Олегович', '79051234506', '2010-07-12', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын')),
('Смирнова', 'София', 'Дмитриевна', '79051234507', '2015-02-28', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дочь')),
('Кузнецова', 'Ольга', 'Владимировна', '79051234508', '1988-09-17', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Кузнецов', 'Петр', 'Михайлович', '79051234509', '1960-04-03', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Попов', 'Владимир', NULL, '79051234510', '1958-01-20', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Омарова', 'Айгуль', 'Каиржановна', '77051234512', '1990-12-05', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Омаров', 'Бахытжан', 'Ерланович', '77051234513', '1965-08-22', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дядя')),
('Жусупов', 'Нурлан', 'Алиевич', '77051234514', '1985-10-14', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Жусупова', 'Самал', 'Нурлановна', '77051234515', '2012-03-08', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дочь')),
('Каримова', 'Гульмира', NULL, '77051234516', '1988-07-19', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Каримов', 'Данияр', 'Нурланович', '77051234517', '2015-11-25', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын')),
('Ахметова', 'Алия', 'Рашидовна', '77051234519', '1992-09-30', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Садыков', 'Марат', 'Аскарович', NULL, '1968-12-03', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Ковалёв', 'Иван', 'Петрович', '79051234522', '1962-05-10', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Ковалёва', 'Елена', 'Ивановна', NULL, '1990-08-22', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дочь')),
('Новицкая', 'Ирина', 'Владимировна', '79051234524', '1987-03-15', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Новицкий', 'Петр', 'Александрович', '79051234525', '2010-06-20', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын')),
('Семёнов', 'Андрей', NULL, '375291234570', '1965-09-12', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Семёнова', 'Наталья', 'Андреевна', '375291234571', '1995-11-08', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Григорьева', 'Екатерина', 'Артёмовна', '375291234572', '2018-01-25', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дочь')),
('Григорьева', 'Ольга', 'Ивановна', '375291234573', '1989-07-30', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Павлов', 'Николай', 'Владимирович', '375291234574', '1960-12-05', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Павлова', 'Мария', 'Николаевна', NULL, '1988-02-14', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Ибрагимова', 'Алина', NULL, '77011234570', '1992-10-18', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'супруг/супруга')),
('Ибрагимов', 'Равиль', 'Фаритович', '77011234571', '1967-04-22', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Петросян', 'Армен', 'Григорьевич', '77011234572', '1963-08-15', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Петросян', 'Давид', 'Арменович', '77011234573', '2017-05-20', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сын')),
('Козлова', 'Айгуль', 'Рашидовна', '77011234574', '1990-03-12', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Козлов', 'Рашид', NULL, '77011234575', '1965-11-28', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец')),
('Нургалиев', 'Дмитрий', 'Сергеевич', '79051234580', '1988-06-10', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'брат')),
('Нургалиева', 'София', 'Дмитриевна', NULL, '2020-09-15', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'дочь')),
('Орлова', 'Елена', 'Владимировна', '79051234582', '1991-07-22', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'сестра')),
('Орлов', 'Владимир', 'Петрович', '79051234583', '1962-01-30', 
(SELECT type_of_kinship_id FROM type_of_kinship WHERE type_of_kinship_name = 'отец'));


INSERT INTO relative_of_employee (employee_id, relative_id)
VALUES (1, 1), 
(1, 2), 
(1, 3),  
(2, 4),  
(2, 5), 
(3, 6), 
(3, 7), 
(4, 8), 
(4, 9), 
(5, 10),
(6, 11), 
(6, 12),
(7, 13), 
(7, 14), 
(8, 15), 
(8, 16), 
(9, 17),
(10, 18),
(11, 19), 
(11, 20), 
(12, 21), 
(12, 22), 
(13, 23), 
(13, 24), 
(14, 25), 
(14, 26), 
(15, 27), 
(15, 28),
(16, 29), 
(16, 30), 
(17, 31), 
(17, 32), 
(18, 33), 
(18, 34), 
(19, 35), 
(19, 36), 
(20, 37), 
(20, 38); 


INSERT INTO educational_institution (educational_institution_name)
VALUES ('Московский государственный университет имени М.В. Ломоносова'),
('Московский государственный технический университет имени Н.Э. Баумана'),
('Казанский (Приволжский) федеральный университет'),
('Воронежский государственный университет'),
('Самарский национальный исследовательский университет имени академика С.П. Королева'),
('Саратовский национальный исследовательский государственный университет имени Н.Г. Чернышевского'),
('Казахский национальный университет имени аль-Фараби'),
('Евразийский национальный университет имени Л.Н. Гумилева'),
('Алматинский технологический университет'),
('Карагандинский государственный технический университет'),
('Белорусский государственный университет'),
('Белорусский национальный технический университет'),
('Белорусский государственный экономический университет');


INSERT INTO employee_education (specialization, educational_institution_id, end_year, employee_id)
VALUES 
('Экономика', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный университет имени М.В. Ломоносова'), 2015, 1), 
('Финансовый менеджмент', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный университет имени М.В. Ломоносова'), 2017, 1), 
('Информационные системы', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), 2018, 2), 
('Управление IT-проектами', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), NULL, 2), 
('Психология', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Казанский (Приволжский) федеральный университет'), 2014, 3),
('Клиническая психология', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Казанский (Приволжский) федеральный университет'), 2016, 3),
('Машиностроение', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), NULL, 4),
('Технологии производства', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), 2014, 4), 
('Менеджмент', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Воронежский государственный университет'), 2013, 5), 
('Нефтегазовое дело', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Казахский национальный университет имени аль-Фараби'), NULL, 6),
('Энергетика', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Карагандинский государственный технический университет'), 2013, 6),
('Финансы', 
(SELECT educational_institution_id
FROM educational_institution 
WHERE educational_institution_name = 'Казахский национальный университет имени аль-Фараби'), 2014, 7),
('Банковское дело', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Евразийский национальный университет имени Л.Н. Гумилева'), 2016, 7),
('Автоматизация', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Алматинский технологический университет'), 2012, 8), 
('Робототехника', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Карагандинский государственный технический университет'), 2014, 8),
('Лингвистика', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Казахский национальный университет имени аль-Фараби'), 2015, 9),
('Строительство', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Карагандинский государственный технический университет'), NULL, 10), 
('Проектирование', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Алматинский технологический университет'), 2012, 10), 
('Бухгалтерский учет', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Самарский национальный исследовательский университет имени академика С.П. Королева'), 2016, 11),  
('Аудит', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Самарский национальный исследовательский университет имени академика С.П. Королева'), 2018, 11),
('Электроника', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), 2011, 12),  
('Медицина', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский государственный университет'), 2014, 13), 
('Терапия', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский государственный университет'), NULL, 13),  
('Программирование', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский национальный технический университет'), 2015, 14), 
('Искусственный интеллект', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский национальный технический университет'), NULL, 14),  
('Маркетинг', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский государственный экономический университет'), 2013, 15), 
('Реклама', 
(SELECT educational_institution_id 
FROM educational_institution
WHERE educational_institution_name = 'Белорусский государственный экономический университет'), NULL, 15),  
('Электротехника', 
(SELECT educational_institution_id
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский национальный технический университет'), 2012, 16),  
('Энергосистемы', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Белорусский национальный технический университет'), 2014, 16), 
('Дизайн', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Саратовский национальный исследовательский государственный университет имени Н.Г. Чернышевского'), 2016, 17),  
('Химическая технология', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Карагандинский государственный технический университет'), 2011, 18), 
('Нефтехимия', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Казахский национальный университет имени аль-Фараби'), 2013, 18), 
('Педагогика', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Воронежский государственный университет'), NULL, 19), 
('Дошкольное образование', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Воронежский государственный университет'), 2019, 19),
('Энергосистемы', 
(SELECT educational_institution_id 
FROM educational_institution 
WHERE educational_institution_name = 'Московский государственный технический университет имени Н.Э. Баумана'), 2012, 20);


INSERT INTO orders (date_of_compilation, type_of_order)
VALUES ('2024-01-10', 'прием'),
('2024-01-12', 'прием'),
('2024-01-15', 'прием'),
('2024-02-01', 'прием'),
('2024-02-05', 'прием'),
('2024-02-10', 'прием'),
('2024-03-01', 'прием'),
('2024-03-05', 'прием'),
('2024-03-10', 'прием'),
('2024-04-01', 'прием'),
('2024-01-20', 'отпуск'),
('2024-01-25', 'отпуск'),
('2024-02-15', 'отпуск'),
('2024-02-20', 'отпуск'),
('2024-03-15', 'отпуск'),
('2024-03-20', 'отпуск'),
('2024-04-10', 'отпуск'),
('2024-04-15', 'отпуск'),
('2024-05-01', 'отпуск'),
('2024-05-10', 'отпуск'),
('2024-01-18', 'отгул'),
('2024-01-22', 'отгул'),
('2024-02-08', 'отгул'),
('2024-02-12', 'отгул'),
('2024-03-08', 'отгул'),
('2024-03-12', 'отгул'),
('2024-04-05', 'отгул'),
('2024-04-08', 'отгул'),
('2024-05-05', 'отгул'),
('2024-05-08', 'отгул'),
('2024-01-30', 'увольнение'),
('2024-02-28', 'увольнение'),
('2024-03-25', 'увольнение'),
('2024-04-20', 'увольнение'),
('2024-05-15', 'увольнение'),
('2024-06-10', 'увольнение'),
('2024-06-25', 'увольнение'),
('2024-07-15', 'увольнение'),
('2024-07-30', 'увольнение'),
('2024-08-10', 'увольнение');

INSERT INTO admission_order (order_number, date_of_admission)
VALUES (1, '2024-01-15'), 
(2, '2024-01-20'), 
(3, '2024-01-22'),  
(4, '2024-02-05'),  
(5, '2024-02-12'), 
(6, '2024-02-15'),  
(7, '2024-03-05'), 
(8, '2024-03-08'), 
(9, '2024-03-15'),  
(10, '2024-04-05');

INSERT INTO dismissal_order (order_number, date_of_dismissal, reason_of_dismissal)
VALUES (31, '2024-02-05', 'Увольнение по собственному желанию'),
(32, '2024-03-01', 'Увольнение по собственному желанию'),
(33, '2024-08-16', 'Увольнение в связи с истечением срока трудового договора'),
(34, '2024-08-30', 'Увольнение в связи с истечением срока трудового договора'),
(35, '2024-09-10', 'Увольнение в связи с сокращением штата'),
(36, '2024-09-10', 'Увольнение в связи с несоответствием занимаемой должности'),
(37, '2024-10-16', 'Увольнение в связи с систематическим нарушением трудовой дисциплины'),
(38, '2024-08-16', 'Увольнение в связи с прогулами'),
(39, '2024-09-10', 'Увольнение в связи с сокращением штата'),
(40, '2024-10-16', 'Увольнение в связи с прогулами');

INSERT INTO type_of_vacation(name_type_of_vacation)
VALUES ('Ежегодный оплачиваемый отпуск'),
('Дополнительный отпуск'),
('Учебный отпуск'),
('Отпуск без сохранения заработной платы'),
('Декретный отпуск');

INSERT INTO vacation_order (order_number, date_of_begin, date_of_end, type_of_vacation_id)
VALUES 
(11, '2024-01-25', '2024-02-07', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Ежегодный оплачиваемый отпуск')),  
(12, '2024-02-01', '2024-02-14', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Ежегодный оплачиваемый отпуск')),  
(13, '2024-02-20', '2024-03-05', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Ежегодный оплачиваемый отпуск')), 
(14, '2024-04-10', '2024-04-13', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Дополнительный отпуск')),  
(15, '2024-04-15', '2024-04-17', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Дополнительный отпуск')),  
(16, '2024-05-01', '2024-05-05', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Дополнительный отпуск')),  
(17, '2024-05-10', '2024-05-24', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Учебный отпуск')),  
(18, '2024-08-01', '2024-11-01', 
(SELECT type_of_vacation_id 
FROM type_of_vacation
WHERE name_type_of_vacation = 'Декретный отпуск')),  
(19, '2024-08-15', '2024-12-15', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Декретный отпуск')),  
(20, '2024-10-01', '2024-10-31', 
(SELECT type_of_vacation_id 
FROM type_of_vacation 
WHERE name_type_of_vacation = 'Отпуск без сохранения заработной платы'));

INSERT INTO time_off_order (order_number, date_of_begin, date_of_end)
VALUES (21, '2024-01-18', '2024-01-18'),
(22, '2024-01-22', '2024-01-22'),
(23, '2024-02-08', '2024-02-08'),
(24, '2024-02-12', '2024-02-12'),
(25, '2024-03-08', '2024-03-09'),  
(26, '2024-03-12', '2024-03-13'),  
(27, '2024-05-08', '2024-05-08'),
(28, '2024-06-10', '2024-06-11'),  
(29, '2024-07-15', '2024-07-16'),  
(30, '2024-08-20', '2024-08-21'); 

INSERT INTO hospital_record (date_of_begin, date_of_end, disease, employee_id)
VALUES ('2024-01-10', '2024-01-17', 'ОРВИ', 1),
('2024-02-05', '2024-02-12', 'Грипп', 3),
('2024-03-15', '2024-03-22', 'ОРВИ', 5),
('2024-11-20', '2024-11-27', 'Грипп', 7),
('2024-12-10', '2024-12-17', 'ОРВИ', 9),
('2024-01-20', '2024-02-05', 'COVID-19', 2),
('2024-04-10', '2024-04-25', 'COVID-19', 4),
('2024-09-01', '2024-09-16', 'COVID-19', 6),
('2024-02-15', '2024-03-01', 'Перелом руки', 8),
('2024-05-20', '2024-06-05', 'Растяжение связок', 10),
('2024-08-10', '2024-08-25', 'Ушиб позвоночника', 12),
('2024-10-05', '2024-10-20', 'Сотрясение мозга', 14),
('2024-03-01', '2024-03-10', 'Обострение гастрита', 11),
('2024-06-15', '2024-06-25', 'Гипертонический криз', 13),
('2024-09-20', '2024-09-30', 'Остеохондроз', 15),
('2024-12-01', '2024-12-10', 'Бронхиальная астма', 17),
('2024-04-01', '2024-04-15', 'Аппендицит (операция)', 16),
('2024-07-10', '2024-07-25', 'Холецистит (операция)', 18),
('2024-10-15', '2024-11-05', 'Грыжа позвоночника (операция)', 20),
('2024-01-25', '2024-02-05', 'Уход за больным ребенком (ОРВИ)', 1),
('2024-05-05', '2024-05-12', 'Уход за больным ребенком (ветрянка)', 3),
('2024-08-20', '2024-08-27', 'Уход за больным ребенком (ангина)', 5),
('2024-02-28', '2024-03-02', 'Мигрень', 7),
('2024-05-15', '2024-05-17', 'Пищевое отравление', 9),
('2024-08-05', '2024-08-07', 'Аллергическая реакция', 11),
('2024-11-10', '2024-11-12', 'Зубная боль', 13),
('2024-03-20', '2024-05-01', 'Реабилитация после операции', 2),
('2024-06-01', '2024-07-15', 'Лечение пневмонии', 4),
('2024-09-10', '2024-10-30', 'Восстановление после травмы', 6),
('2024-04-20', '2024-04-30', 'Профилактическое лечение в санатории', 8),
('2024-07-25', '2024-08-05', 'Медицинское обследование', 10),
('2024-10-25', '2024-11-05', 'Диспансеризация', 12);


INSERT INTO course_location (course_location_name)
VALUES ('Центр_повышения квалификации "Профессионал"'),
('Учебный центр "Кадры"'),
('Академия/современных технологий'),
('Институт развития персонала'),
('Центр бизнес-образования'),
('Корпоративный учебный центр'),
('Онлайн-платформа "SkillUp"'),
('Международный центр обучения'),
('Региональный учебный центр'),
('Центр дистанционного обучения');


INSERT INTO qualification_courses (qualification_courses_name, course_location_id)
VALUES 
('Курсы повышения квалификации менеджеров%', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр_повышения квалификации "Профессионал"')),
('Программа обучения IT-специалистов', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Учебный центр "Кадры"')),
('Курсы финансовой грамотности', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Академия/современных технологий')),
('Обучение технике безопасности', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Институт развития персонала')),
('Лидер', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр бизнес-образования')),
('Курсы иностранных языков', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Корпоративный учебный центр')),
('Обучение работе с CRM-системами', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Онлайн-платформа "SkillUp"')),
('Программа управления проектами', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Международный центр обучения')),
('Курсы по эффективным продажам', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Региональный учебный центр')),
('Обучение бережливому производству', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр дистанционного обучения')),
('Программа цифровой трансформации', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр_повышения квалификации "Профессионал"')),
('Большие данные или облачные технологии', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Учебный центр "Кадры"')),
('Обучение искусственному интеллекту', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Академия/современных технологий')),
('Программа кибербезопасности', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Институт развития персонала')),
('Курсы по управлению персоналом', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр бизнес-образования')),
('Обучение маркетингу и рекламе', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Корпоративный учебный центр')),
('Программа бухгалтерского учета', 
(SELECT course_location_id 
FROM course_location
WHERE course_location_name = 'Онлайн-платформа "SkillUp"')),
('Логистика', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Международный центр обучения')),
('Обучение клиентскому сервису', 
(SELECT course_location_id 
FROM course_location
WHERE course_location_name = 'Региональный учебный центр')),
('Программа управления изменениями', 
(SELECT course_location_id 
FROM course_location 
WHERE course_location_name = 'Центр дистанционного обучения'));

INSERT INTO qualification_courses_of_employees (date_of_begin, date_of_end, employee_id, qualification_courses_id)
VALUES 
('2025-01-15', '2025-01-26', 1, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа обучения IT-специалистов')),   
('2024-02-01', '2024-02-15', 6, 
(SELECT qualification_courses_id
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа обучения IT-специалистов')),   
('2024-02-10', '2025-02-24', 3, 
(SELECT qualification_courses_id
FROM qualification_courses 
WHERE qualification_courses_name = 'Курсы финансовой грамотности')),   
('2022-03-01', '2025-03-08', 4, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение технике безопасности')),   
('2025-03-15', '2025-03-29', 5, 
(SELECT qualification_courses_id 
FROM qualification_courses
WHERE qualification_courses_name = 'Лидер')),   
('2025-04-01', '2025-04-12', 5, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Курсы иностранных языков')),  
('2024-04-15', '2024-04-26', 7, 
(SELECT qualification_courses_id
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение работе с CRM-системами')),   
('2023-05-01', '2023-05-10', 8, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа управления проектами')),  
('2024-05-15', '2024-05-24', 9, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Курсы по эффективным продажам')),   
('2023-06-01', '2023-06-14', 10, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение бережливому производству')), 
('2024-06-15', '2025-06-28', 11, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа обучения IT-специалистов')), 
('2022-07-01', '2022-07-12', 11, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Большие данные или облачные технологии')), 
('2022-07-15', '2022-07-26', 13, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение искусственному интеллекту')), 
('2024-08-01', '2024-08-09', 14, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа кибербезопасности')), 
('2024-08-15', '2024-08-23', 15, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Курсы по управлению персоналом')), 
('2025-09-01', '2025-09-13', 16, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение маркетингу и рекламе')), 
('2025-09-15', '2025-09-27', 16, 
(SELECT qualification_courses_id 
FROM qualification_courses
WHERE qualification_courses_name = 'Программа бухгалтерского учета')), 
('2024-10-01', '2024-10-11', 18, 
(SELECT qualification_courses_id 
FROM qualification_courses WHERE qualification_courses_name = 'Логистика')), 
('2024-10-15', '2024-10-25', 18, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Обучение клиентскому сервису')), 
('2023-11-01', '2023-11-10', 20, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа управления изменениями')), 
('2025-11-15', '2025-11-22', 1, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Курсы иностранных языков')),   
('2022-12-01', '2022-12-08', 3, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа управления проектами')), 
('2025-02-01', '2025-02-15', 16, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Программа обучения IT-специалистов')),
('2024-12-10', '2024-12-17', 5, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Большие данные или облачные технологии')),  
('2023-12-15', '2023-12-22', 7, 
(SELECT qualification_courses_id 
FROM qualification_courses
WHERE qualification_courses_name = 'Курсы по управлению персоналом')),  
('2024-12-20', '2024-12-27', 9, 
(SELECT qualification_courses_id 
FROM qualification_courses 
WHERE qualification_courses_name = 'Логистика'));
