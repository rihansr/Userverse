import 'package:json_annotation/json_annotation.dart';
part 'company_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyModel {
  String? name;
  String? catchPhrase;
  String? ps;

  CompanyModel({
    this.name,
    this.catchPhrase,
    this.ps,
  });

  factory CompanyModel.fromJson(json) =>
      _$CompanyModelFromJson(json);

  toJson() => _$CompanyModelToJson(this);
}