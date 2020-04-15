part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => null;
}

class InitializePost extends PostEvent {
  final String ticker;

  InitializePost(this.ticker);
}
