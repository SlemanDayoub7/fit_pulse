import 'package:json_annotation/json_annotation.dart';
part 'sport.g.dart';

@JsonSerializable()
class Sport {
  int id;
  @JsonKey(name: 'name_en')
  String? nameEn;
  @JsonKey(name: 'name_ar')
  String? nameAr;
  Sport({required this.id, this.nameAr, this.nameEn});
  Map<String, dynamic> toJson() => _$SportToJson(this);
  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
}
