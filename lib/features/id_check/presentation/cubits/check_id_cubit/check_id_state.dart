part of 'check_id_cubit.dart';

@immutable
sealed class CheckIdState {}

final class CheckIdInitial extends CheckIdState {}
final class CheckIdSuccess extends CheckIdState {}
final class CheckIdFailure extends CheckIdState {
  final String errorMessage;

  CheckIdFailure(this.errorMessage);
}
final class GetClientSuccess extends CheckIdState {
  final ClientEntity client;

  GetClientSuccess(this.client);
}
final class GetClientFailure extends CheckIdState {
  final String errorMessage;

  GetClientFailure(this.errorMessage);
}
final class GetClientLoading extends CheckIdState {}


