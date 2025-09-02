import 'package:equatable/equatable.dart';

abstract class SportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSports extends SportEvent {}
