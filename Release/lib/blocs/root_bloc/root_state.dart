part of 'root_bloc.dart';

abstract class RootState extends Equatable {
  const RootState();
  @override
  List<Object> get props => [];
}

class RootInitial extends RootState {
  final Widget widget;
  RootInitial(this.widget);

  @override
  List<Object> get props => [widget];
}

class InitialTutorial extends RootState {
  final Widget widget;
  InitialTutorial(this.widget);
  @override
  List<Object> get props => [widget];
}

class Home extends RootState {
  final Widget widget;
  Home(this.widget);
  @override
  List<Object> get props => [widget];
}
