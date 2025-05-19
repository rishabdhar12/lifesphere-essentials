import 'package:equatable/equatable.dart';

class AddCategoriesDto extends Equatable {
  const AddCategoriesDto({
    required this.id,
    required this.name,
    required this.desc,
    required this.amount,
    required this.duration,
    required this.txnHistory,
    required this.totalDeducted,
    required this.amountLeft,
    required this.stateDate,
    required this.reset,
  });

  final String? id;
  final String? name;
  final String? desc;
  final double? amount;
  final String? duration;
  final List<int> txnHistory;
  final double? totalDeducted;
  final double? amountLeft;
  final String? stateDate;
  final int? reset;

  @override
  String toString() {
    return "$id, $name, $desc, $amount, $duration, $txnHistory, $totalDeducted, $amountLeft, $stateDate, $reset, ";
  }

  @override
  List<Object?> get props => [
    id,
    name,
    desc,
    amount,
    duration,
    txnHistory,
    totalDeducted,
    amountLeft,
    stateDate,
    reset,
  ];
}
