///https://app.quicktype.io/
///Para generar el modelo
//import 'dart:html';

class BookModel{

  int? id;
  String title;
  String description;
  String image;
  String author;

  BookModel({
   this.id,
   required this.title,
   required this.author,
   required this.description,
   required this.image
  });

  factory BookModel.fromJson(Map<String, dynamic> mapa ) => BookModel(
      id: mapa["id"],
      title: mapa["title"],
      author: mapa["author"],
      description: mapa["description"],
      image: mapa["image"]
  );

 Map<String, dynamic> toJson() => {
    "id":this.id,
    "title": this.title,
    "author": this.author,
   "description" : this.description,
   "image" : this.image
  };

}