

class RamadanModel {
  final String? code;
  final String? logo;
  final String? startDate;
  final String? endDate;
  final int? points;
  final bool? returning;

  static RamadanModel $UserFromJson(Map<dynamic, dynamic> json) {
    return RamadanModel(
      code: json['code'] as String?,
      logo: json['logo'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      points: json['points'] as int?,
      returning: json['returning'] as bool?,
    );
  }

  static Map<dynamic, dynamic> $UserToJson(RamadanModel instance) =>
      <dynamic, dynamic>{
        'code': instance.code,
        'logo': instance.logo,
        'startDate': instance.startDate,
        'endDate': instance.endDate,
        'points': instance.points,
        'returning': instance.returning,
      };

  RamadanModel(
      {required this.code,
        required this.logo,
        required this.startDate,
        required this.endDate,
        required this.points,
        required this.returning});
}