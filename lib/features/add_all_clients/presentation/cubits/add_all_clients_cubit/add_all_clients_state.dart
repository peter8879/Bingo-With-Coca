part of 'add_all_clients_cubit.dart';

@immutable
sealed class AddAllClientsState {}

final class AddAllClientsInitial extends AddAllClientsState {}
final class AddAllClientsLoading extends AddAllClientsState {}
final class AddAllClientsSuccess extends AddAllClientsState {
}
final class AddAllClientsFailure extends AddAllClientsState {
  final String message;
  AddAllClientsFailure(this.message);
}

