import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/media.dart';
import 'package:crel_mobile/modules/profile/repos/media_repo.dart';
import 'package:equatable/equatable.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepo mediaRepo;
  MediaBloc({required this.mediaRepo}) : super(MediaLoading()) {
    // on<GetMediaRequested>(_onGetMediaRequested);
    // on<DeleteMedia>(_onDeleteMedia);
    on<GetMediaByProperyId>(_onGetMediaByProperyId);
  }
  // void _onGetMediaRequested(
  //     GetMediaRequested event, Emitter<MediaState> emit) async {
  //   emit(MediaLoading());
  //   try {
  //     var media = await mediaRepo.getMediaById();
  //     emit(MediaLoaded(media));
  //   } catch (e) {
  //     emit(MediaError(e.toString()));
  //   }
  // }

  // void _onDeleteMedia(DeleteMedia event, Emitter<MediaState> emit) async {
  //   // emit(MediaLoading());
  //   final state = this.state;
  //   try {
  //     if (state is MediaLoaded) {
  //       await mediaRepo.deleteMedia(event.id);
  //       var media = await mediaRepo.getMediaByPropertyId(event.propertyId);
  //       emit(MediaLoaded(media));
  //     }
  //   } catch (e) {
  //     emit(MediaError(e.toString()));
  //   }
  // }

  void _onGetMediaByProperyId(
      GetMediaByProperyId event, Emitter<MediaState> emit) async {
    emit(MediaLoading());
    try {
      var media = await mediaRepo.getMediaByPropertyId(event.id);
      emit(MediaLoaded(media));
    } catch (e) {
      emit(MediaError(e.toString()));
    }
  }
}
