import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Dog {
  final String name;
  final String location;
  final String description;
  String imageUrl;
  String photoUrl;

  int rating = 10;

  Dog(this.name, this.location, this.description, this.photoUrl);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    try {
      imageUrl = photoUrl;
    } catch (exception) {
      print(exception);
    }
  }
}
