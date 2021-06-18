import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mgmnt_ex1/client.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';
import 'package:state_mgmnt_ex1/model/topic.dart';

part 'topicspage_state.dart';

class TopicspageCubit extends Cubit<TopicspageState> {
  final Client _client;
  final ErrorCubit _errorCubit;

  TopicspageCubit(this._client, this._errorCubit) : super(TopicspageInitial());

  Future<void> getTopics() async {
    emit(TopicspageLoading());
    var result = await _client.getTopics();
    emit(TopicspageLoadSuccess(result.topics));
  }

}

