class CategoriesModel {
  String? message;
  List<Categories>? categories;

  CategoriesModel({this.message, this.categories});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? categoryId;
  String? categoryPlu;
  String? name;
  String? description;
  String? image;
  bool? isActive;

  Categories(
      {this.categoryId,
      this.categoryPlu,
      this.name,
      this.description,
      this.image,
      this.isActive});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryPlu = json['categoryPlu'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryPlu'] = categoryPlu;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['is_active'] = isActive;
    return data;
  }
}