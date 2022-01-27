CREATE ROLE teacher WITH LOGIN NOSUPERUSER;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT USAGE, SELECT, INSERT, UPDATE, DELETE ON TABLES TO teacher;

CREATE ROLE assistant WITH LOGIN NOSUPERUSER;

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  full_name varchar(100) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  identity_number varchar(100) UNIQUE
);

CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  code varchar(100) NOT NULL,
  term varchar(100),
  UNIQUE(code, term)
);

CREATE TABLE students_courses (
  id SERIAL PRIMARY KEY,
  student_id int REFERENCES students(id),
  course_id int REFERENCES courses(id),
  active bool DEFAULT TRUE /* Is the student still in the course */
);

CREATE TABLE grades (
  inscription_id int REFERENCES students_courses(id),
  grade float DEFAULT 1.0, /* Grade obtained */
  weight float DEFAULT 1.0, /* Weight of the grade when computing final grade */
  description text /* Which evaluation gave this grade */
);

CREATE TABLE assistants (
  id SERIAL PRIMARY KEY,
  full_name varchar(100) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  identity_number varchar(100) UNIQUE,
  username varchar(100) UNIQUE NOT NULL
);

CREATE TABLE assistants_courses (
  assistant_id int REFERENCES assistants(id),
  course_id int REFERENCES courses(id)
);

ALTER TABLE grades ENABLE ROW LEVEL SECURITY;

CREATE POLICY assistant_grades_rls ON grades
TO assistant
USING (inscription_id IN (
	SELECT students_courses.id
  FROM students_courses
  JOIN assistants_courses
  ON students_courses.course_id = assistants_courses.course_id
  JOIN assistants
  ON assistants.id = assistants_courses.assistant_id
  WHERE assistants.username = current_user
));

GRANT SELECT ON students, courses, students_courses TO assistant;

GRANT SELECT, INSERT, UPDATE, DELETE ON grades TO assistant;