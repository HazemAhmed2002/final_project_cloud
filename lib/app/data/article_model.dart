class ArticleModel {
  String? name;
  String? details;
  String? image;

  dynamic idOfCategories;
  dynamic idOfArticle;
  dynamic tokonofDoctor;
  ArticleModel(this.name, this.details, this.image, this.idOfCategories,
      this.tokonofDoctor,
      {this.idOfArticle});
  ArticleModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    details = json['details'];
    image = json['image'];

    idOfCategories = json['idOfCategories'];
    idOfArticle = json['idOfArticle'];
    tokonofDoctor = json['tokonofDoctor'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
      'image': image,
      'idOfCategories': idOfCategories,
      'idOfArticle': idOfArticle,
      'tokonofDoctor': tokonofDoctor
    };
  }
}
