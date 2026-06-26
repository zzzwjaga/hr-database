# hr-database


База данных для управления кадровым учетом организации.

## Файлы проекта
- `laba_3_db.sql` - структура базы данных
- `laba_3_db_data.sql` - тестовые данные
- `laba_3_db_queries.sql` - примеры запросов

### Основные таблицы
- **employee** - основная информация о сотрудниках
- **actual_FIO** - актуальные ФИО сотрудников
- **actual_passport_data** - паспортные данные
- **actual_contacts** - контактная информация

### Кадровое делопроизводство
- **contract** - трудовые договоры
- **orders** - кадровые приказы
- **admission_order** - приказы о приеме
- **dismissal_order** - приказы об увольнении

### Структура организации
- **department** - структурные подразделения
- **post** - должности
- **staff_list** - штатное расписание

### Пример запроса 

```sql
SELECT 
    e.employee_id,
    a_FIO.emp_lastname, 
    a_FIO.emp_name,
    a_FIO.emp_patronymic,
    e.date_of_birth
FROM employee AS e 
INNER JOIN actual_FIO AS a_FIO
    ON a_FIO.employee_id = e.employee_id
WHERE EXTRACT(MONTH FROM e.date_of_birth) IN (1, 2, 12)
ORDER BY e.date_of_birth;
```
