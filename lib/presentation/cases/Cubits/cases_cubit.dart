import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_commnets.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';
import 'package:lambda_dent_dash/domain/models/cases/cases_list.dart';
import 'package:lambda_dent_dash/domain/repo/cases_repo.dart';
import 'cases_state.dart';

class CasesCubit extends Cubit<CasesState> {
  CasesCubit(this.repo) : super(CasesInitial()) {
    getCases();
  }

  final CasesRepo repo;

  Map<String, List<MedicalCaseinList>>? casesList;
  Future<void> getCases() async {
    emit(CasesLoading());
    try {
      casesList = await repo.getcaseList();
      if (casesList != null) {
        emit(CasesLoaded(casesList!));
      } else {
        emit(CasesError('No cases found.'));
      }
    } on Exception catch (e) {
      emit(CasesError("Error loading cases list: \\${e.toString()}"));
    }
  }

  MedicalCase? medicalCase;
  Future<void> getCaseDetails(int id) async {
    emit(CaseDetailsLoading());
    try {
      medicalCase = await repo.getCaseDetails(id);
      if (medicalCase != null) {
        emit(CaseDetailsLoaded(medicalCase!));
      } else {
        emit(CasesError('No case details found.'));
      }
    } on Exception catch (e) {
      emit(CasesError("Error loading case: \\${e.toString()}"));
    }
  }

  List<Uint8List> imgList = [];
  Future<void> getCaseImages(int id) async {
    var image = await repo.getCasesimage(id);
    if (image != null) imgList.add(image);
    emit(ImagesLoaded(imgList));
  }

  List<Comment>? comments = [];
  Future<void> getcomment(int id) async {
    emit(CommentsLoading());
    try {
      comments = await repo.getCaseComments(id);
      if (comments != null) {
        emit(CommentsLoaded(comments!));
      } else {
        emit(CasesError('No comments found.'));
      }
    } on Exception catch (e) {
      emit(CasesError("Error loading comments list: \\${e.toString()}"));
    }
  }
}
