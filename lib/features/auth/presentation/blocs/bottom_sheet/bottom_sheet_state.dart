part of 'bottom_sheet_cubit.dart';

sealed class BottomSheetState extends Equatable {
  const BottomSheetState();
}

final class BottomSheetInitial extends BottomSheetState {
  @override
  List<Object> get props => [];
}

final class BottomSheetLogin extends BottomSheetState {
  @override
  List<Object> get props => [];
}

final class BottomSheetRegister extends BottomSheetState{
  @override
  List<Object> get props => [];
}

final class BottomSheetOtp1 extends BottomSheetState{
  @override
  List<Object> get props => [];
}

final class BottomSheetChangePassword1 extends BottomSheetState{
  @override
  List<Object> get props => [];
}

final class BottomSheetChangePassword2 extends BottomSheetState{
  @override
  List<Object> get props => [];
}

final class BottomSheetChangePassword3 extends BottomSheetState{
  @override
  List<Object> get props => [];
}