import 'package:meta/meta.dart';

class User {
  final String token;

  User({
    @required this.token,
  });

  @override
  String toString() => 'User { token: $token }';
}
