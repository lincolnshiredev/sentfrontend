part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  @override
  List<Object> get props => null;
  const RootEvent();
}

class AppStarted extends RootEvent {}

class PostDelete extends RootEvent {
  final int index;
  final String ticker;
  PostDelete(this.index, this.ticker);
}

class PostAdded extends RootEvent {
  final List<Post> posts;
  PostAdded(this.posts);
}
