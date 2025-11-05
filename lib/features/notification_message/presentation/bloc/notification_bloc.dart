
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flysen_frontend_mobile/core/domain/usecases/use_case.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/entities/notification_message.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/repositories/notification_repository.dart';
import 'package:flysen_frontend_mobile/features/notification_message/domain/usecases/initialize_notifications.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';


@lazySingleton
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final InitializeNotifications _initializeNotifications;
  final NotificationRepository _notificationRepository;
  StreamSubscription? _onMessageSubscription;
  StreamSubscription? _onMessageOpenedSubscription;

  NotificationBloc(this._initializeNotifications, this._notificationRepository)
      : super(NotificationInitial()) {
    on<InitializeFCM>(_onInitializeFCM);
    on<_OnMessageReceived>((event, emit) => emit(NotificationForegroundMessage(event.message)));
    on<_OnMessageOpened>((event, emit) => emit(NotificationNavigatedFromTap(event.message)));
  }

  Future<void> _onInitializeFCM(InitializeFCM event, Emitter<NotificationState> emit) async {
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedSubscription?.cancel();

    final result = await _initializeNotifications(NoParams());
    result.fold(
          (failure) => print('FCM Initialization Failed: ${failure.message}'),
          (_) {
        print('FCM Initialized Successfully');
        _onMessageSubscription = _notificationRepository.onMessage.listen((message) {
          add(_OnMessageReceived(message));
        });
        _onMessageOpenedSubscription = _notificationRepository.onMessageOpenedApp.listen((message) {
          add(_OnMessageOpened(message));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _onMessageSubscription?.cancel();
    _onMessageOpenedSubscription?.cancel();
    return super.close();
  }
}