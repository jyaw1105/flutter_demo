import 'package:json_annotation/json_annotation.dart';

part 'tip.g.dart';

@JsonSerializable()
class Tip {
  final String title, desc;
  Tip({
    required this.title,
    required this.desc
  });
  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

  Map<String, dynamic> toJson() => _$TipToJson(this);
}