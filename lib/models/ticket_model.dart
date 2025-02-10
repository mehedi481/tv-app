import 'dart:convert';

class TicketModel {
  int? id;
  int? token;
  String? type;

  TicketModel({this.id, this.token, this.type});

  factory TicketModel.fromMap(Map<String, dynamic> data) => TicketModel(
        id: data['id'] as int?,
        token: data['token'] as int?,
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'token': token,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TicketModel].
  factory TicketModel.fromJson(String data) {
    return TicketModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TicketModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
