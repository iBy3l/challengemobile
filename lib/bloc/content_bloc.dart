import 'package:bloc/bloc.dart';
import 'package:challengemobile/models/content_model.dart';
import 'package:equatable/equatable.dart';

import '../services/content_service.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentService contentService;
  ContentBloc(
    this.contentService,
  ) : super(ContentInitial()) {
    on<ContentEvent>(getContents);
  }
  getContents(event, emit) async {
    try {
      emit(ContentInitial());
      final contents = await contentService.getContent();
      emit(
        ContentLoaded(
          contents: contents,
        ),
      );
    } catch (e) {
      emit(const ContentError(message: 'failed to fetch data'));
    }
  }
}
