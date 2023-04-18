class UserProfileModel {
  final String id;
  final String displayName;
  final String profilePicture;
  // final dynamic contacts;

  UserProfileModel({
    required this.id,
    required this.displayName,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'profilePicture': profilePicture,
      };
}
