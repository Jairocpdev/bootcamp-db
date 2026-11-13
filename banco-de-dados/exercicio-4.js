//Adiciona comentários no primeiro post//
db.posts.updateOne(
  { titulo: "Meu primeiro post" },
  { $set: { comentarios: [
    { autor: "Laura", texto: "Muito bom!" },
    { autor: "Heitor", texto: "Top demais!" }
  ]}}
);

//Busca de posts com a tag "nosql"//
db.posts.find({ tags: "nosql" });

//Filtro de buscas de um autor específico//
db.posts.find({ autor: "Jairo" });

//Busca todos os posts//
db.posts.find();