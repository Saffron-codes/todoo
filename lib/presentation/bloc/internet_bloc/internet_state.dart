part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();
  
  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}
class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectivityResult connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
