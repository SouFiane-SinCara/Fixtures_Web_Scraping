// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String name;
  final String imageUrl;
  const Team({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  String printDetails() {
    return '''
      name: $name
      imageUrl: $imageUrl
      ''';
  }
}
