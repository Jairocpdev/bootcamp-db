//Primeiro post//
db.posts.insertOne({
  titulo: "Meu primeiro post",
  autor: "Jairo",
  conteudo: "Aprendendo MongoDB no bootcamp"
});

//Segundo post - Tag//
db.posts.insertOne({
  titulo: "Mongo é flexível",
  autor: "Jairo",
  conteudo: "Segundo post",
  tags: ["nosql", "flexivel"]
});

//Retorna as duas postagens//
db.posts.find();