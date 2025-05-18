class CategoriesModel {
  String? categoryName;
  List<String>? items;

  CategoriesModel({this.categoryName, this.items});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['items'] = items;
    return data;
  }
}
