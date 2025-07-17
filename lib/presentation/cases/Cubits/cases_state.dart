import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_commnets.dart';
import 'dart:typed_data';

abstract class CasesState {}

class CasesInitial extends CasesState {}

class CasesLoading extends CasesState {}

class CasesLoaded extends CasesState {
  final Map<String, List<MedicalCaseinList>> casesList;
  CasesLoaded(this.casesList);
}

class CaseDetailsLoading extends CasesState {}

class CaseDetailsLoaded extends CasesState {
  final MedicalCase medicalCase;
  CaseDetailsLoaded(this.medicalCase);
}

class CasesError extends CasesState {
  final String message;
  CasesError(this.message);
}

class CommentsLoading extends CasesState {}

class CommentsLoaded extends CasesState {
  final List<Comment> comments;
  CommentsLoaded(this.comments);
}

class ImagesLoaded extends CasesState {
  final List<Uint8List> images;
  ImagesLoaded(this.images);
}
