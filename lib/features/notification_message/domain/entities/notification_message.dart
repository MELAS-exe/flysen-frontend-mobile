import 'package:equatable/equatable.dart';

class NotificationMessage extends Equatable {
  const NotificationMessage({
    required this.title,
    required this.body,
    this.data,
  });

  final String title;
  final String body;
  final Map<String, dynamic>? data; // For custom data payload

  @override
  List<Object?> get props => [title, body, data];
}