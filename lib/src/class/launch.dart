class Launch {
  final String id;
  final String name;
  final String? thumbImage;
  final String? bigImage;
  final DateTime? launchDate;
  final String? details;
  final String? rocket;
  final bool success;
  final bool upcoming;

  const Launch(
      {required this.name,
      required this.id,
      required this.thumbImage,
      required this.bigImage,
      required this.launchDate,
      required this.success,
      required this.rocket,
      required this.upcoming,
      required this.details});

  factory Launch.fromAPIJson(Map<String, dynamic> json) {
    return Launch(
        id: json['id'],
        name: json['name'],
        launchDate: json['static_fire_date_utc'] != null
            ? DateTime.parse(json['static_fire_date_utc'])
            : null,
        upcoming: json['upcoming'],
        success: json['success'] ?? false,
        thumbImage: json['links']['patch']['small'],
        bigImage: json['links']['patch']['large'],
        details: json['details'],
        rocket: json['rocket']);
  }

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
        id: json['id'],
        name: json['name'],
        launchDate: json['launchDate'] != null
            ? DateTime.parse(json['launchDate'])
            : null,
        upcoming: json['upcoming'],
        success: json['success'] ?? false,
        thumbImage: json['thumbImage'],
        bigImage: json['bigImage'],
        details: json['details'],
        rocket: json['rocket']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'launchDate': launchDate?.toIso8601String(),
        'upcoming': upcoming,
        'success': success,
        'thumbImage': thumbImage,
        'bigImage': bigImage,
        'details': details,
        'rocket': rocket
      };
}
