CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  full_name varchar(100) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  identity_number varchar(100) UNIQUE
);

CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  name varchar(100) NOT NULL,
  code varchar(100) UNIQUE NOT NULL
);

CREATE TABLE students_courses (
  id SERIAL PRIMARY KEY,
  student_id int REFERENCES students(id),
  course_id int REFERENCES courses(id),
  active bool DEFAULT TRUE
);

CREATE TABLE grades (
  inscription_id int REFERENCES students_courses(id),
  grade float DEFAULT 1.0,
  weight float DEFAULT 1.0
);