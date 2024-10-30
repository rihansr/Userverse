import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel {
  String? street;
  String? suite;
  String? city;
  String? zipcode;

  AddressModel({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  });

  factory AddressModel.fromJson(json) =>
      _$AddressModelFromJson(json);

  toJson() => _$AddressModelToJson(this);
}