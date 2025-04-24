part of 'branches_cubit.dart';

@immutable
sealed class BranchesState {}

final class BranchesInitial extends BranchesState {}
final class BranchesLoading extends BranchesState {}
final class BranchesLoaded extends BranchesState {

}
final class BranchesError extends BranchesState {
  final String error;
  BranchesError(this.error);
}

