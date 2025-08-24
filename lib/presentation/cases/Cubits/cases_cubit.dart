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

  // Form state variables
  int? selectedClientId;
  String? selectedClientName;
  String patientFullName = '';
  String patientPhone = '';
  DateTime patientBirthdate = DateTime.now();
  String patientGender = 'ذكر';
  bool isSmoker = false;
  String shade = '';
  bool needTrial = false;
  bool repeat = false;
  String notes = '';
  DateTime expectedDeliveryDate = DateTime.now();

  // Teeth selection data
  Map<String, List<String>> selectedTeeth = {
    'teeth_crown': [],
    'teeth_pontic': [],
    'teeth_implant': [],
    'teeth_veneer': [],
    'teeth_inlay': [],
    'teeth_denture': [],
    'bridges_crown': [],
    'bridges_pontic': [],
    'bridges_implant': [],
    'bridges_veneer': [],
    'bridges_inlay': [],
    'bridges_denture': [],
  };

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

  // Form state management methods
  void setSelectedClient(int id, String name) {
    selectedClientId = id;
    selectedClientName = name;
    emit(CasesInitial()); // Re-emit to update UI
  }

  void updatePatientFullName(String name) {
    patientFullName = name;
  }

  void updatePatientPhone(String phone) {
    patientPhone = phone;
  }

  void updatePatientBirthdate(DateTime date) {
    patientBirthdate = date;
  }

  void updatePatientGender(String gender) {
    patientGender = gender;
  }

  void updateIsSmoker(bool smoker) {
    isSmoker = smoker;
  }

  void updateShade(String shadeValue) {
    shade = shadeValue;
  }

  void updateNeedTrial(bool need) {
    needTrial = need;
  }

  void updateRepeat(bool repeatValue) {
    repeat = repeatValue;
  }

  void updateNotes(String notesValue) {
    notes = notesValue;
  }

  void updateExpectedDeliveryDate(DateTime date) {
    expectedDeliveryDate = date;
  }

  // Teeth data management
  void updateSelectedTeeth(String category, List<String> teeth) {
    selectedTeeth[category] = teeth;
  }

  // Format teeth data for API
  String formatTeethData(List<String> teeth) {
    if (teeth.isEmpty) return '';

    // Group teeth by material
    Map<String, List<String>> groupedByMaterial = {};
    for (String tooth in teeth) {
      List<String> parts = tooth.split(',');
      if (parts.length >= 2) {
        String toothNumber = parts[0].trim();
        String material = parts[1].trim();

        if (!groupedByMaterial.containsKey(material)) {
          groupedByMaterial[material] = [];
        }
        groupedByMaterial[material]!.add(toothNumber);
      }
    }

    // Format as "tooth1,tooth2,tooth3,material"
    List<String> formattedGroups = [];
    for (var entry in groupedByMaterial.entries) {
      String material = entry.key;
      List<String> toothNumbers = entry.value;
      formattedGroups.add('${toothNumbers.join(',')},$material');
    }

    return formattedGroups.join(';');
  }

  // Validation method
  bool validateForm() {
    if (selectedClientId == null) return false;
    if (patientFullName.trim().isEmpty) return false;
    if (patientPhone.trim().isEmpty) return false;
    if (shade.trim().isEmpty) return false;
    return true;
  }

  // Add medical case method
  Future<bool> addMedicalCase() async {
    if (!validateForm()) {
      emit(CasesError('Please fill all required fields'));
      return false;
    }

    emit(CasesLoading());

    try {
      // Format teeth data for API
      Map<String, dynamic> caseData = {
        'expected_delivery_date':
            expectedDeliveryDate.toIso8601String().split('T')[0],
        'notes': notes.isEmpty ? null : notes,
        'dentist_id': selectedClientId,
        'patient_full_name': patientFullName,
        'patient_phone': patientPhone,
        'patient_birthdate': patientBirthdate.toIso8601String().split('T')[0],
        'patient_gender': patientGender,
        'is_smoker': isSmoker ? 1 : 0,
        'shade': shade,
        'need_trial': needTrial ? 1 : 0,
        'repeat': repeat ? 1 : 0,
        'teeth_crown': formatTeethData(selectedTeeth['teeth_crown']!),
        'teeth_pontic': formatTeethData(selectedTeeth['teeth_pontic']!),
        'teeth_implant': formatTeethData(selectedTeeth['teeth_implant']!),
        'teeth_veneer': formatTeethData(selectedTeeth['teeth_veneer']!),
        'teeth_inlay': formatTeethData(selectedTeeth['teeth_inlay']!),
        'teeth_denture': formatTeethData(selectedTeeth['teeth_denture']!),
        'bridges_crown': formatTeethData(selectedTeeth['bridges_crown']!),
        'bridges_pontic': formatTeethData(selectedTeeth['bridges_pontic']!),
        'bridges_implant': formatTeethData(selectedTeeth['bridges_implant']!),
        'bridges_veneer': formatTeethData(selectedTeeth['bridges_veneer']!),
        'bridges_inlay': formatTeethData(selectedTeeth['bridges_inlay']!),
        'bridges_denture': formatTeethData(selectedTeeth['bridges_denture']!),
      };

      // Remove empty fields
      caseData.removeWhere((key, value) => value == null || value == '');

      final success = await repo.addMedicalCaseToLocalClient(caseData);

      if (success) {
        emit(CasesLoaded(casesList!)); // Return to loaded state
        return true;
      } else {
        emit(CasesError('Failed to add medical case'));
        return false;
      }
    } catch (e) {
      emit(CasesError("Error adding medical case: \\${e.toString()}"));
      return false;
    }
  }
}
