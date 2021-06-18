import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';

class ErrorObserver extends StatelessWidget {
  final Widget child;
  bool displaysErrorScreen = false;
  ErrorObserver({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorCubit, ErrorState>(
      listenWhen: (prev, curr) {
        return true;
      },
      listener: (context, state) async {
      },
      child: child,
    );
  }
}
