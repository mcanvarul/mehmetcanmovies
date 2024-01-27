class MovieListModel {
  String? id;
  String? name;
  String? description;
  String? category;
  String? director;
  List<String>? actors;
  String? score;
  String? url;
  String? imageUrl;

  MovieListModel(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.director,
      this.actors,
      this.score,
      this.url,
      this.imageUrl});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    director = json['director'];
    actors = json['actors'].cast<String>();
    score = json['score'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['director'] = this.director;
    data['actors'] = this.actors;
    data['score'] = this.score;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
