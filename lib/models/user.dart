import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String? bio;

  @HiveField(4)
  final String? phone;

  @HiveField(5)
  final String? profileImage;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime? lastLoginAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.bio,
    this.phone,
    this.profileImage,
    required this.createdAt,
    this.lastLoginAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? bio,
    String? phone,
    String? profileImage,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.bio == bio &&
        other.phone == phone &&
        other.profileImage == profileImage &&
        other.createdAt == createdAt &&
        other.lastLoginAt == lastLoginAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    email.hashCode ^
    name.hashCode ^
    bio.hashCode ^
    phone.hashCode ^
    profileImage.hashCode ^
    createdAt.hashCode ^
    lastLoginAt.hashCode;
  }
}
