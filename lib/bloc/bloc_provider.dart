import 'package:article_finder/bloc/bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  });

  @override
  State createState() => _BlocProviderState();

  static T of<T extends Bloc>(BuildContext context){
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider>{
  @override
  Widget build(BuildContext context){
    return widget.child;
  }
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }
}
