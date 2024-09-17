import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Budget {
  int? id;
String title;
DateTime date;
num amount;
String category;
bool isIncome;
  Budget({
    this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    required this.isIncome,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'amount': amount,
      'category': category,
      'isIncome': isIncome ? 1 :0,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as num,
      category: map['category'] as String,
      isIncome: map['isIncome'] == 1 ? true :false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Budget.fromJson(String source) => Budget.fromMap(json.decode(source) as Map<String, dynamic>);
}
