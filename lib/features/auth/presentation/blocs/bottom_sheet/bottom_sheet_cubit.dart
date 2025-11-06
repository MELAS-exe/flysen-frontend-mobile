
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'bottom_sheet_state.dart';

@LazySingleton()
class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetInitial());
  void login(){
    emit(BottomSheetLogin());
  }
  void register() {
    emit(BottomSheetRegister());
  }
  void otp1() {
    emit(BottomSheetOtp1());
  }
  void changePassword1() {
    emit(BottomSheetChangePassword1());
  }
  void changePassword2() {
    emit(BottomSheetChangePassword2());
  }

  void changePassword3() {
    emit(BottomSheetChangePassword3());
  }

  void initial() {
    emit(BottomSheetInitial());
  }
}
