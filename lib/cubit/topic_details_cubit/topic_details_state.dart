part of 'topic_details_cubit.dart';

abstract class TopicDetailsState extends Equatable {
  const TopicDetailsState();
}

class TopicDetailsInitial extends TopicDetailsState {
  @override
  List<Object> get props => [];
}

class TopicDetailsLoading extends TopicDetailsState {
  @override
  List<Object> get props => [];
}

class TopicDetailsLoadSuccess extends TopicDetailsState {
  final Topic topic;

  TopicDetailsLoadSuccess(this.topic);

  @override
  List<Object> get props => [topic];
}

class TopicDetailsLoadError extends TopicDetailsState {
  final String error;
  final int code;
  final int id;

  TopicDetailsLoadError(this.error, {this.code, this.id});

  @override
  List<Object> get props => [error, code, id];
}