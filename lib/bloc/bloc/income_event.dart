part of 'income_bloc.dart';

sealed class IncomeEvent {}

class AddIncomeEvent extends IncomeEvent {
  final Budget budget;

  AddIncomeEvent({required this.budget});
}

class EditIncomeEvent extends IncomeEvent {
  final Budget budget;

  EditIncomeEvent({required this.budget});
}

class GetIncomeEvent extends IncomeEvent {}

class DeleteIncomeEvent extends IncomeEvent {
  final int index;

  DeleteIncomeEvent({required this.index});
}
