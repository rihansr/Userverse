import 'package:json_annotation/json_annotation.dart';
import 'address_model.dart';
import 'company_model.dart';
part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  AddressModel? address;
  String? phone;
  String? website;
  CompanyModel? company;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(json) =>
      _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);

  static List<UserModel> fromJsonList(List? json) {
    return json?.map((e) => UserModel.fromJson(e)).toList() ?? [];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is UserModel) {
      return other.id == id;
    }

    return false;
  }

  @override
  int get hashCode => id.hashCode;
}