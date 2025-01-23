part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeFetchSolarEnergy extends HomeEvent {
  final String date;
  HomeFetchSolarEnergy({required this.date});
}
