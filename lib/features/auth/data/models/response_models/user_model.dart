import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? email, access, refresh;
  int? id;
  UserModel({this.email, this.id, this.access, this.refresh});
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
