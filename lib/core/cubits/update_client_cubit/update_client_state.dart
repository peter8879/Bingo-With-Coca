part of 'update_client_cubit.dart';

@immutable
sealed class UpdateClientState {}

final class UpdateClientInitial extends UpdateClientState {}
final class UpdateClientLoading extends UpdateClientState {}
final class UpdateClientSuccess extends UpdateClientState {}
final class UpdateClientFailure extends UpdateClientState {
  final String message;
  UpdateClientFailure(this.message);
}

