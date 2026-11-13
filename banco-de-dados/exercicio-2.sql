--SELECT: nome do aluno e curso--
--Execução do segundo exercício apenas mediante conclusão do primeiro--
SELECT alunos.nome_aluno, cursos.nome_curso
FROM alunos
INNER JOIN cursos ON alunos.curso_id = cursos.id;

--SELECT: filtragem de alunos em um determinado curso--
SELECT alunos.nome_aluno, cursos.nome_curso
FROM alunos
INNER JOIN cursos ON alunos.curso_id = cursos.id
WHERE cursos.nome_curso = 'Ciência de Dados';

-- Criação para troca de curso do aluno--
INSERT INTO cursos (nome_curso) VALUES ('Ciência de Dados');

--UPDATE: mover aluno de curso--
UPDATE alunos
SET curso_id = 5
WHERE nome_aluno = 'João Andrade';

-- Confere se moveu
SELECT alunos.nome_aluno, cursos.nome_curso
FROM alunos
INNER JOIN cursos ON alunos.curso_id = cursos.id;

--Extra: cursos sem alunos vinculados--
SELECT cursos.nome_curso
FROM cursos
LEFT JOIN alunos ON alunos.curso_id = cursos.id
WHERE alunos.id IS NULL;