INSERT INTO students_courses (student_id, course_id)
SELECT students.id, courses.id
FROM students, courses
WHERE 
  students.full_name = 'Danilo Ruiz' AND 
  courses.name = 'Numerical Methods' AND 
  courses.term = '2s2021';