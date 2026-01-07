import "package:hive/hive.dart";

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  List<Map<String, dynamic>> chats;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.chats,
  });
}
