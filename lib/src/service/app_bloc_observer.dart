import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log(" ");
    log(
        "************ STATE CHANGE START IN \"${bloc.runtimeType}\" ******************");
    log('${bloc.runtimeType} $change');
    log('${bloc.runtimeType} ${change.currentState.toString()}');
    log(
        "************* STATE CHANGE END IN \"${bloc.runtimeType}\" *******************");
    log(" ");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(" ");
    log(
        "++++++++++++++++++ STATE TRANSITION START IN \"${bloc.runtimeType}\" +++++++++++++++++++");
    log('${bloc.runtimeType} $transition');
    log('${bloc.runtimeType} ${transition.currentState.toString()}');
    log(
        "++++++++++++++++++ STATE TRANSITION END IN \"${bloc.runtimeType}\" +++++++++++++++++++");
    log(" ");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    log(
        "============================================================================");
    log(
        "===================== BLOC ERROR IN ${bloc.runtimeType} ===================");
    log(
        "============================================================================");

    log(
        '\nSTACK TRACE START ->>>>>>>\n ${bloc.runtimeType} $error $stackTrace  \n<<<<<<<<- STACK TRACE ENDS\n');
  }
}
