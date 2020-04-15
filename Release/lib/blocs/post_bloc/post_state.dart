part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [
        Loading(),
      ];
}

class PostScreenInFront extends PostState {
  final Widget widget;
  PostScreenInFront(this.widget);
  @override
  List<Object> get props => [widget];
}
