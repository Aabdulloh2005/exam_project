import 'package:exam_project/bloc/bloc/income_bloc.dart';
import 'package:exam_project/common/widgets/extensions/date_extension.dart';
import 'package:exam_project/views/add_screen/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overview"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 140,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(height: 10),
                      Text("income"),
                      SizedBox(height: 10),
                      Text("1234567"),
                    ],
                  ),
                );
              },
            ),
          ),
          const Text(
            "Latest entries",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: BlocBuilder<IncomeBloc, IncomeState>(
              bloc: context.read<IncomeBloc>()..add(GetIncomeEvent()),
              builder: (context, state) {
                if (state is IncomeError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is IncomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is IncomeLoaded) {
                  final budgets = state.budgets;
                  return budgets.isEmpty
                      ? const Center(
                          child: Text("You don't have any income and expenses"),
                        )
                      : ListView.builder(
                          itemCount: budgets.length,
                          itemBuilder: (context, index) {
                            final budget = budgets[index];
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddScreen(budget: budget,),));
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog.adaptive(
                                      content: Text(
                                          "Are you sure to delete ${budget.title}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<IncomeBloc>().add(
                                                  DeleteIncomeEvent(
                                                      index: budget.id!),
                                                );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Yes"),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              title: Text(budget.title),
                              subtitle: Text(budget.date.format()),
                              trailing: Text(
                                "\$${budget.amount}",
                                style: TextStyle(
                                  color: budget.isIncome
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        );
                }
                return const Center(
                  child: Text("Statelarga tushmadi"),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade600,
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
