//Package Imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//In File Imports
import '../../components/loading.dart';
import '../../models/post_model.dart';
import '../../repository.dart';
import '../../screens/posts_screen.dart';
import '../../screens/splash_screen.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  Repository repository;
  RootBloc(this.repository);

  @override
  RootState get initialState => RootInitial(Loading());

  List<Post> posts;
  @override
  Stream<RootState> mapEventToState(
    RootEvent event,
  ) async* {
    if (event is AppStarted) {
     
      final isFirstRun = await repository.isNewRun();
      if (isFirstRun) {
      
        yield InitialTutorial(SplashScreen());
      } else {
     
        posts = await repository.getPosts();
        yield Home(PostsPage(posts: posts));
      }
    } else if (event is PostDelete) {
  

      posts.removeAt(event.index);
      yield Home(PostsPage(posts: posts));
      await repository.removeTickerFromLocal(event.ticker);
    } else if (event is PostAdded) {
      

      posts = event.posts;
      yield Home(PostsPage(posts: posts));
    }
  }
}
