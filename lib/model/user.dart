import 'package:metaprogramacao_estatica/annotation/getters.dart';

part 'user.g.dart';

@Getters()
class User {
  final String _name;
  final String _email;
  final int age;
  final bool isActive;
  User({
    required String name,
    required String email,
    required this.age,
    required this.isActive,
  }) : _name = name,
       _email = email;
}
