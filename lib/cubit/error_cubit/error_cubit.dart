import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'error_state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(ErrorInitial());

  Future<void> errorType1() async {
    emit(ErrorType1());
  }

  Future<void> resetError() async {
    emit(ErrorInitial());
  }

}

enum CubitType {
  Topics,
}
