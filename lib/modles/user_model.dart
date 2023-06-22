class UserModel {
  final int id;
  final String organiserName;
  final String bannerImage;
  final String dateTime;
  final String venueName;
  final String venueCity;
  final String venueCountry;
  final String organiserIcon;
  final String description;

  UserModel({
    required this.id,
    required this.organiserName,
    required this.bannerImage,
    required this.dateTime,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
    required this.organiserIcon,
    required this.description,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      organiserName: json['organiser_name'] as String,
      bannerImage: json['banner_image'] as String,
      dateTime: json['date_time'] as String,
      venueName: json['venue_name'] as String,
      venueCity: json['venue_city'] as String,
      venueCountry: json['venue_country'] as String,
      organiserIcon: json['organiser_icon'] as String,
      description: json['description'] as String,
    );
  }
    @override
  List<Object?> get props => [
        id,
        organiserName,
        bannerImage,
        dateTime,
        organiserName,
        venueName,
        venueCity,
        venueCountry,
        organiserIcon,
        description,
      ];
}
