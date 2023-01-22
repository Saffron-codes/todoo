import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  InternetBloc({required this.connectivity}) : super(InternetLoading()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnected(connectionType: ConnectivityResult.wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected(connectionType: ConnectivityResult.mobile));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnected());
      }
    });
    on<ListenInternet>((event, emit) {
      emit(InternetInitial());
    });
  }
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
