part of 'add_prizecubit_cubit.dart';

@immutable
sealed class AddPrizeState {}

final class AddPrizeInitial extends AddPrizeState {}
final class AddPrizeSuccess extends AddPrizeState {}
final class AddPrizeFailure extends AddPrizeState {
  final String errorMessage;
  AddPrizeFailure(this.errorMessage);
}
final class AddPrizeLoading extends AddPrizeState {}


