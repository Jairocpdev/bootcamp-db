CREATE TABLE cursos (
  id SERIAL PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL
);

INSERT INTO cursos (nome_curso) VALUES ('Tecnologia');
INSERT INTO cursos (nome_curso) VALUES ('Direito');
INSERT INTO cursos (nome_curso) VALUES ('Biomedicina');

SELECT * FROM cursos;

CREATE TABLE alunos (
  id SERIAL PRIMARY KEY,
  nome_aluno VARCHAR(100) NOT null,
  email varchar (100) not null, 
  curso_id INT REFERENCES cursos(id)
);

INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Tiago Costa', 'tiago.costa@gmail.com', 1);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Heitor Gomes', 'heitor.gomes@email.com', 2);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Laura Silva', 'laura.silva@email.com', 3);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('João Andrade', 'joao.andrade@email.com', 4);

SELECT * FROM alunos;