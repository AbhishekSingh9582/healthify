class Article {
  String? articleId;
  String? description;
  String? imageUrl;
  String? title;

  Article({this.articleId, this.description, this.imageUrl, this.title});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = this.articleId;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    return data;
  }
}
