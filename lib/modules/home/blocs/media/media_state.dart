part of 'media_bloc.dart';

abstract class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object> get props => [];
}

class MediaLoading extends MediaState {}

class MediaLoaded extends MediaState {
  final List<Media> medias;
  const MediaLoaded(this.medias);
  @override
  List<Object> get props => [medias];
}

class MediaError extends MediaState {
  final String error;

  const MediaError(this.error);
  @override
  List<Object> get props => [error];
}

// ignore: must_be_immutable
// class SaveEvent extends MediaState {
//   int id;
//   int? spaceId;
//   int? type;
//   String? link;
//   File? fileId;
//   String? description;
//   SaveEvent(
//       {required this.id,
//       this.spaceId,
//       this.type,
//       this.link,
//       this.fileId,
//       this.description});
// }
