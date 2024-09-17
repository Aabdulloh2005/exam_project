import 'package:bloc/bloc.dart';
import 'package:exam_project/core/models/budget.dart';
import 'package:exam_project/core/services/database_helper.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  IncomeBloc() : super(IncomeInitial()) {
    on<GetIncomeEvent>(_getEvents);
    on<AddIncomeEvent>(_addIncomeEvent);
    on<DeleteIncomeEvent>(_deleteIncomeEvent);
    on<EditIncomeEvent>(_editIncomeEvent);
  }

  _getEvents(GetIncomeEvent event, Emitter<IncomeState> emit) async {
    emit(IncomeLoading());
    try {
      final res = await databaseHelper.getBudgets();
      emit(IncomeLoaded(budgets: res));
    } catch (e) {
      emit(IncomeError(errorMessage: e.toString()));
    }
  }

  _addIncomeEvent(AddIncomeEvent event, Emitter<IncomeState> emit) async {
    emit(IncomeLoading());
    try {
      await databaseHelper.addBudget(event.budget);
      add(GetIncomeEvent());
    } catch (e) {
      emit(IncomeError(errorMessage: e.toString()));
    }
  }

  _editIncomeEvent(EditIncomeEvent event, Emitter<IncomeState> emit) async {
    emit(IncomeLoading());
    try {
      print('keldi');
      await databaseHelper.updateBudget(event.budget);
      add(GetIncomeEvent());
    } catch (e) {
      emit(IncomeError(errorMessage: e.toString()));
    }
  }

  _deleteIncomeEvent(DeleteIncomeEvent event, Emitter<IncomeState> emit) async {
    emit(IncomeLoading());
    try {
      await databaseHelper.deleteBudget(event.index);
      add(GetIncomeEvent());
    } catch (e) {
      emit(IncomeError(errorMessage: e.toString()));
    }
  }
}
