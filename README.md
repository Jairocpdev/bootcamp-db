# bootcamp-db — Banco de Dados | Orion Bootcamp

Pré-requisito do bootcamp: subir PostgreSQL + MongoDB com Docker e fazer os 4 exercícios de Banco de Dados.

## Stack

- PostgreSQL 16-alpine — banco relacional
- MongoDB latest — banco não-relacional (NoSQL)
- Docker + Docker Compose
- DBeaver (Postgres) + MongoDB Compass (Mongo)

## Como subir

```bash
# Na raiz do projeto
docker compose up -d

# Ver se subiram
docker ps
# orion_postgres_db -> 5432
# orion_mongo_db    -> 27017

# Ver logs
docker logs orion_postgres_db
docker logs orion_mongo_db

# Parar sem perder dados (volumes persistem)
docker compose down
```

## Dados de conexão

### PostgreSQL — DBeaver / Beekeeper / pgAdmin

| Campo | Valor |
| :--- | :--- |
| Host | `localhost` |
| Porta | `5432` |
| Banco | `orion_db` |
| Usuário | `orion_user` |
| Senha | `orion_password` |

### MongoDB — MongoDB Compass / mongosh

Connection String (URI):

```
mongodb://orion_admin:orion_admin_pass@localhost:27017/
```

> No `docker-compose.yml` o usuário é `orion_admin` (não `admin` como no print do bootcamp). Use a string acima.

## Estrutura

```
bootcamp-db/
├── docker-compose.yml
└── banco-de-dados/
    ├── exercicio-1.sql  # Postgres - CREATE + FOREIGN KEY
    ├── exercicio-2.sql  # Postgres - JOIN + WHERE + UPDATE
    ├── exercicio-3.js   # Mongo - insertOne + schema flexível
    └── exercicio-4.js   # Mongo - updateOne + find com filtros
```

## Ordem de execução — IMPORTANTE

Rode na ordem, porque cada exercício depende do anterior:

1. `exercicio-1.sql` → cria `cursos` e `alunos`
2. `exercicio-2.sql` → pressupõe que o 1 já rodou
3. `exercicio-3.js` → cria a coleção `posts`
4. `exercicio-4.js` → pressupõe que o 3 já rodou

Não rode o 2 sem o 1, nem o 4 sem o 3. Se precisar recomeçar do zero no Postgres:

```sql
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS cursos;

## Exercício 1 — Postgres: CREATE + FOREIGN KEY

Cria `cursos` e `alunos`, com `alunos.curso_id` apontando para `cursos.id`.

Arquivo: `banco-de-dados/exercicio-1.sql`

Critérios de sucesso:
- `CREATE TABLE` executa sem erros.
- A FOREIGN KEY impede inserir aluno com `curso_id` que não existe. Ex: `curso_id = 99` retorna `ERROR 23503: insert violates foreign key constraint`.
- `SELECT * FROM alunos` retorna os alunos inseridos.

## Exercício 2 — Postgres: JOINs e Filtros

Usa o esquema do Exercício 1 para responder com JOIN.

Arquivo: `banco-de-dados/exercicio-2.sql`

O que o arquivo faz:
1. `INNER JOIN` — nome do aluno + nome do curso.
2. `JOIN + WHERE` — só alunos de `Ciência de Dados`.
3. `INSERT` do curso `Ciência de Dados` (vira o id 5) + `UPDATE` movendo `João Andrade` para ele.
4. `LEFT JOIN + WHERE alunos.id IS NULL` — cursos sem nenhum aluno.

Critérios de sucesso:
- JOIN retorna nomes corretos.
- WHERE filtra corretamente.
- UPDATE funciona e o novo SELECT com JOIN reflete a mudança.

## Exercício 3 — Mongo: CRUD Básico + Schema Flexível

Cria a coleção `posts` (ela é criada sozinha no primeiro `insertOne`).

Arquivo: `banco-de-dados/exercicio-3.js`

- Post 1: `titulo, autor, conteudo` — sem `tags`.
- Post 2: `titulo, autor, conteudo, tags: ["nosql", "flexivel"]` — com campo novo.
- `db.posts.find()` retorna os 2.

Isso prova o schema flexível: na mesma coleção, um documento tem `tags` e o outro não. No Postgres isso daria erro.

## Exercício 4 — Mongo: Consultas Avançadas

Usa os posts do Exercício 3.

Arquivo: `banco-de-dados/exercicio-4.js`

- `updateOne` — adiciona `comentarios` (array de documentos) no post `Meu primeiro post`. Retorna `matchedCount: 1, modifiedCount: 1`.
- `find({ tags: "nosql" })` — só o post com a tag `nosql`.
- `find({ autor: "Jairo" })` — posts de um autor específico.
- `find()` — confere tudo.

## Erros que apareceram e o que significam

| Erro | Significado |
| :--- | :--- |
| `23503: violates foreign key constraint` | Tentou usar `curso_id` que não existe em `cursos`. É sucesso, não falha — a FK bloqueou. |
| `2BP01: cannot drop table cursos because other objects depend on it` | Tentou apagar `cursos` antes de `alunos`. Apague filho primeiro, pai depois. |
| `42P01: relation does not exist` | Tentou usar tabela que ainda não foi criada ou que foi apagada com `DROP`. |
| `SyntaxError` no mongosh por colar só `db.posts.insertOne({` | Faltou fechar o `{`. Cole o bloco inteiro antes de dar Enter. |
| `version is obsolete` no `docker compose` | A linha `version: '3.8'` no topo do compose não é mais necessária. Pode apagar. |
| `failed to connect to the docker API` | Docker Desktop não estava rodando. Abra o Docker Desktop e espere `Engine running`. |

## Fluxo de trabalho usado

1. Testar no DBeaver / Compass.
2. Quando funcionar, salvar no VS Code em `banco-de-dados/`.
3. Commitar na `develop`.
4. Abrir PR `develop -> main` só no final, após revisão.

## Gitflow

- `main` — estável, só recebe via PR de `develop`.
- `develop` — integração, recebe PRs de `feature/*`.
- PRs de feature sempre abrem para `develop`, nunca direto para `main`.