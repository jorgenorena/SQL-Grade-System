/* Insert student */
INSERT INTO students_courses (student_id, course_id)
SELECT students.id, courses.id
FROM students, courses
WHERE 
  students.full_name = 'Danilo Ruiz' AND 
  courses.name = 'Numerical Methods' AND 
  courses.term = '2s2021';

/* Insert teaching assistant */
INSERT INTO assistants_courses (assistant_id, course_id)
SELECT assistants.id, courses.id
FROM assistants, courses
WHERE
	assistants.full_name = 'Joaquin Rolend' AND
  courses.name = 'Numerical Methods' AND
  courses.term = '2s2021';