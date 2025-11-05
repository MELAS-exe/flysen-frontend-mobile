part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}
class InitializeFCM extends NotificationEvent {}
class _OnMessageReceived extends NotificationEvent {
  final NotificationMessage message;
  _OnMessageReceived(this.message);
}
class _OnMessageOpened extends NotificationEvent {
  final NotificationMessage message;
  _OnMessageOpened(this.message);
}
