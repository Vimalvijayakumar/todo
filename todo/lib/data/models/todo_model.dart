import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? _id;
  Timestamp? _date;
  String? _todoHeading;
  String? _todoContent;
  TodoModel(
      {String? id, String? todoHeading, String? todoContent, Timestamp? date}) {
    _date = date;
    _todoHeading = todoHeading;
    _todoContent = todoContent;
    _id = id;
  }
  TodoModel.fromJson(dynamic json, String id) {
    _id = id;
    _date = json["date"];
    _todoHeading = json["heading"];
    _todoContent = json["content"];
  }
  String? get id => _id;
  Timestamp? get date => _date;
  String? get todoHeading => _todoHeading;
  String? get todoContent => _todoContent;

  Map<String, dynamic> tojson() {
    final map = <String, dynamic>{};
    map["date"] = _date;
    map["heading"] = _todoHeading;
    map["content"] = _todoContent;
    return map;
  }
}
