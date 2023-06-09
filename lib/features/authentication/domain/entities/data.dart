import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;

  const Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });

  @override
  List<Object> get props => [id, name, email, phone, token];
}
