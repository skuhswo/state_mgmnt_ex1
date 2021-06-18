part of 'error_cubit.dart';

abstract class ErrorState extends Equatable {
  const ErrorState();
}

class ErrorInitial extends ErrorState {
  DateTime now = DateTime.now();
  @override
  List<Object> get props => [now];
}

class ErrorType1 extends ErrorState {
  DateTime now = DateTime.now();
  @override
  List<Object> get props => [now];
}

