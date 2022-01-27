WITH id_table AS (
  SELECT 
    students_courses.id AS id
  FROM students 
  JOIN students_courses
  ON students_courses.student_id = students.id
  JOIN courses
  ON courses.id = students_courses.course_id
  WHERE 
    students.full_name = 'Danilo Ruiz' AND
  	courses.name = 'Numerical Methods'
)
INSERT INTO grades (id, grade, description)
SELECT id_table.id, 6.5, 'Tarea 4'
FROM id_table;