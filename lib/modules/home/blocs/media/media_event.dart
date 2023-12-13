part of 'media_bloc.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class GetMediaRequested extends MediaEvent {}

class GetMediaByProperyId extends MediaEvent {
  final int id;

  const GetMediaByProperyId(this.id);
  @override
  List<Object> get props => [id];
}

class DeleteMedia extends MediaEvent {
  final int id;
  final int propertyId;

  const DeleteMedia(this.id, this.propertyId);
  @override
  List<Object> get props => [id];
}
