import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockandsentiment/blocs/post_bloc/post_bloc.dart';
import 'package:stockandsentiment/models/post_model.dart';

class PostStates extends StatelessWidget {
  final Post post;
  PostStates({this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(post: post)..add(InitializePost(post.symbol)),
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) => state.props.first,
      ),
    );
  }
}
