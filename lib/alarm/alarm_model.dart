import 'package:cloud_firestore/cloud_firestore.dart';

class AlarmModel {
  String? movieName;
  String? imageUrl;
  Timestamp? date;

  AlarmModel({this.movieName, this.imageUrl, this.date});

  AlarmModel.fromJson(Map<String, dynamic> json) {
    movieName = json['movie_name'];
    imageUrl = json['image_url'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_name'] = this.movieName;
    data['image_url'] = this.imageUrl;
    data['date'] = this.date;
    return data;
  }
}
