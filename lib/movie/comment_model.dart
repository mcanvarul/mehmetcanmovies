import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? movieName;
  String? comment;
  String? userName;
  Timestamp? createdDate;

  CommentModel({this.movieName, this.comment, this.userName, this.createdDate});

  CommentModel.fromJson(Map<String, dynamic> json) {
    movieName = json['movie_name'];
    comment = json['comment'];
    userName = json['user_name'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_name'] = this.movieName;
    data['comment'] = this.comment;
    data['user_name'] = this.userName;
    data['created_date'] = this.createdDate;
    return data;
  }
}
