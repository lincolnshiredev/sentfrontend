//Packages Import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//In File Imports
import '../blocs/root_bloc/root_bloc.dart';
import '../repository.dart';

class RootsStates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return BlocProvider<RootBloc>(
      create: (context) => RootBloc(Repository())..add(AppStarted()),
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          return state.props.first;
        },
      ),
    );
  }
}
