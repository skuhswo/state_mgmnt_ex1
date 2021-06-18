import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';
import 'package:state_mgmnt_ex1/client.dart';


import 'package:state_mgmnt_ex1/model/topic.dart';part 'topic_details_state.dart';

class TopicDetailsCubit extends Cubit<TopicDetailsState> {
  final Client _client;
  final ErrorCubit _errorCubit;
  final int _topicId;

  TopicDetailsCubit(this._client, this._errorCubit, this._topicId)
      : super(TopicDetailsInitial());

  Future<void> getTopic({BuildContext context}) async {
    emit(TopicDetailsLoading());

    var result = await _client.getTopic(
      _topicId,
    );

    emit(TopicDetailsLoadSuccess(result));
  }
}
