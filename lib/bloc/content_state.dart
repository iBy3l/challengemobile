part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentModel contents;

  const ContentLoaded({required this.contents});

  @override
  List<Object> get props => [contents];
}

class ContentError extends ContentState {
  final String message;

  const ContentError({required this.message});

  @override
  List<Object> get props => [message];
}
