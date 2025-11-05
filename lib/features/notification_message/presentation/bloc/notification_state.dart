part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationForegroundMessage extends NotificationState {
  final NotificationMessage message;
  NotificationForegroundMessage(this.message);
}
class NotificationNavigatedFromTap extends NotificationState {
  final NotificationMessage message;
  NotificationNavigatedFromTap(this.message);
}