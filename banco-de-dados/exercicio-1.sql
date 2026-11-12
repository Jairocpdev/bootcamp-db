--Tabela cursos--
CREATE TABLE cursos (
  id SERIAL PRIMARY KEY,
  nome_curso VARCHAR(100) NOT NULL
);

--Tabela alunos--
CREATE TABLE alunos (
  id SERIAL PRIMARY KEY,
  nome_aluno VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  curso_id INT REFERENCES cursos(id)
);

--Cadastro de cursos disponíveis--
INSERT INTO cursos (nome_curso) VALUES ('Tecnologia');
INSERT INTO cursos (nome_curso) VALUES ('Direito');
INSERT INTO cursos (nome_curso) VALUES ('Biomedicina');
INSERT INTO cursos (nome_curso) VALUES ('Desenvolvimento Web');

--Cadastro de alunos--
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Tiago Costa', 'tiago.costa@email.com', 1);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Heitor Gomes', 'heitor.gomes@email.com', 2);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('Laura Silva', 'laura.silva@email.com', 3);
INSERT INTO alunos (nome_aluno, email, curso_id) VALUES ('João Andrade', 'joao.andrade@email.com', 4);

--Comandos de exexução das tabelas--
SELECT alunos.nome_aluno, cursos.nome_curso
FROM alunos INNER JOIN cursos ON alunos.curso_id = cursos.id;