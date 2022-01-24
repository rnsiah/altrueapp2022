import 'package:json_annotation/json_annotation.dart';
part 'altrue_action_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AltrueAction {
  String name;
  int pointsAwarded;

  AltrueAction({required this.name, required this.pointsAwarded});

  factory AltrueAction.fromJson(Map<String, dynamic> data) =>
      _$AltrueActionFromJson(data);

  Map<String, dynamic> toJson() => _$AltrueActionToJson(this);
}
