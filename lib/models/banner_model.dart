import 'dart:convert';

class BannerModel {
  String? title;
  String? image;

  BannerModel({this.title, this.image});

  factory BannerModel.fromMap(Map<String, dynamic> data) => BannerModel(
        title: data['title'] as String?,
        image: data['image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerModel].
  factory BannerModel.fromJson(String data) {
    return BannerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
