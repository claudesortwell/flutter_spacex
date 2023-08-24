class Rocket {
  final String id;
  final String name;
  final String? company;
  final String? country;

  const Rocket(
      {required this.name,
      required this.id,
      required this.company,
      required this.country});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
        id: json['id'],
        name: json['name'],
        company: json['company'],
        country: json['country']);
  }
}
