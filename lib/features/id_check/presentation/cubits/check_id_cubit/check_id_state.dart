part of 'check_id_cubit.dart';

@immutable
sealed class CheckIdState {}

final class CheckIdInitial extends CheckIdState {}
final class CheckIdSuccess extends CheckIdState {}
final class CheckIdFailure extends CheckIdState {
  final String errorMessage;

  CheckIdFailure(this.errorMessage);
}


