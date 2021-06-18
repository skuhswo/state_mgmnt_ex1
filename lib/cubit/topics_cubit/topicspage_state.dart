part of 'topicspage_cubit.dart';


abstract class TopicspageState extends Equatable {
  const TopicspageState();
}

class TopicspageInitial extends TopicspageState {
  @override
  List<Object> get props => [];
}

class TopicspageLoading extends TopicspageState {
  @override
  List<Object> get props => [];
}

class TopicspageLoadError extends TopicspageState {
  final String message;
  final int code;

  TopicspageLoadError(this.message, {this.code});

  @override
  List<Object> get props => [message, code];
}

class TopicspageLoadSuccess extends TopicspageState {
  final List<Topic> topics;

  TopicspageLoadSuccess(this.topics);

  @override
  List<Object> get props => [topics];
}