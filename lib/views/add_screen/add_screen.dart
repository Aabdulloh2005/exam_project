import 'package:exam_project/bloc/bloc/income_bloc.dart';
import 'package:exam_project/common/theme/app_colors.dart';
import 'package:exam_project/common/widgets/custom_textfield.dart';
import 'package:exam_project/common/widgets/extensions/date_extension.dart';
import 'package:exam_project/core/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatefulWidget {
  final Budget? budget;
  const AddScreen({
    super.key,
    this.budget,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime? pickeDate;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dayController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeValues();
  }

  void initializeValues() {
    if (widget.budget != null) {
      _titleController.text = widget.budget!.title;
      _amountController.text = widget.budget!.amount.toString();
      _dayController.text = widget.budget!.date.format();
      _categoryController.text = widget.budget!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.budget != null ? "Edit expense" : "Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextfield(
                hintText: "Example",
                controller: _titleController,
                title: "Expense title",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "expense should not be empty";
                  }
                  return null;
                },
              ),
              CustomTextfield(
                hintText: "1263.32",
                controller: _amountController,
                title: "Amount",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return " Amount should not be empty";
                  }
                  return null;
                },
              ),
              CustomTextfield(
                suffixIcon: const Icon(Icons.calendar_month_outlined),
                hintText: "12.05.2005",
                controller: _dayController,
                title: "Date",
                readOnly: true,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Date should not be empty";
                  }
                  return null;
                },
                onTap: () async {
                  final response = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050),
                  );
                  if (response != null) {
                    pickeDate = response;
                    _dayController.value = TextEditingValue(
                      text: response.format(),
                    );
                    setState(() {});
                  }
                },
              ),
              CustomTextfield(
                hintText: "category",
                controller: _categoryController,
                title: "Expense category",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Category should not be empty";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            onPressed: _submitForm,
            child: Text(widget.budget != null ? "Edit expense" : "Add Expense"),
          ),
        ),
      ),
    );
  }

  _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      context.read<IncomeBloc>().add(
            widget.budget != null
                ? EditIncomeEvent(
                    budget: Budget(
                      title: _titleController.text,
                      date: widget.budget!.date,
                      amount: double.parse(_amountController.text),
                      category: _categoryController.text,
                      isIncome: true,
                    ),
                  )
                : AddIncomeEvent(
                    budget: Budget(
                      title: _titleController.text,
                      date: pickeDate!,
                      amount: double.parse(_amountController.text),
                      category: _categoryController.text,
                      isIncome: true,
                    ),
                  ),
          );
    }
    Navigator.of(context).pop();
  }
}
