// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      name: json['name'] as String?,
      catchPhrase: json['catch_phrase'] as String?,
      ps: json['ps'] as String?,
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catch_phrase': instance.catchPhrase,
      'ps': instance.ps,
    };
