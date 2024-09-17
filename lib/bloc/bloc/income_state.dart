part of 'income_bloc.dart';

sealed class IncomeState {}

final class IncomeInitial extends IncomeState {}

final class IncomeLoading extends IncomeState {}

final class IncomeLoaded extends IncomeState {
  final List<Budget> budgets;

  IncomeLoaded({required this.budgets});
}

final class IncomeError extends IncomeState {
  final String errorMessage;

  IncomeError({required this.errorMessage});
}
