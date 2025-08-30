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
    if (isClosed) return;
    emit(CasesLoading());
    try {
      casesList = await repo.getcaseList();
      if (casesList != null) {
        if (isClosed) return;
        emit(CasesLoaded(casesList!));
      } else {
        if (!isClosed) emit(CasesError('No cases found.'));
      }
    } on Exception catch (e) {
      if (!isClosed)
        emit(CasesError("Error loading cases list: \\${e.toString()}"));
    }
  }

  MedicalCase? medicalCase;
  Future<void> getCaseDetails(int id) async {
    print('CasesCubit - getCaseDetails called with ID: $id');
    if (isClosed) return;
    emit(CaseDetailsLoading());
    try {
      print('CasesCubit - Calling repo.getCaseDetails');
      medicalCase = await repo.getCaseDetails(id);
      print(
          'CasesCubit - Repo returned: ${medicalCase != null ? 'success' : 'null'}');
      if (medicalCase != null) {
        if (isClosed) return;
        emit(CaseDetailsLoaded(medicalCase!));
      } else {
        if (!isClosed) emit(CasesError('No case details found.'));
      }
    } on Exception catch (e) {
      print('CasesCubit - Error in getCaseDetails: $e');
      if (!isClosed) emit(CasesError("Error loading case: \\${e.toString()}"));
    }
  }

  List<Uint8List> imgList = [];
  Future<void> getCaseImages(int id) async {
    if (isClosed) return;
    try {
      var imageFuture = repo.getCasesimage(id);
      if (imageFuture != null) {
        var image = await imageFuture;
        if (image != null) {
          imgList.add(image);
          if (!isClosed) emit(ImagesLoaded(imgList));
        }
      }
    } catch (e) {
      print('Error loading case images: $e');
    }
  }

  List<Comment>? comments = [];
  Future<void> getcomment(int id) async {
    if (isClosed) return;
    emit(CommentsLoading());
    try {
      comments = await repo.getCaseComments(id);
      if (comments != null) {
        if (isClosed) return;
        emit(CommentsLoaded(comments!));
      } else {
        if (!isClosed) emit(CommentsError('No comments found.'));
      }
    } on Exception catch (e) {
      if (!isClosed)
        emit(CommentsError("Error loading comments list: ${e.toString()}"));
    }
  }

  Future<bool> sendCaseComment(
      {required int caseId, required String comment}) async {
    if (isClosed) return false;
    try {
      final ok = await repo.postCaseComment(caseId, comment);
      if (ok) {
        // Reload comments after successful post
        await getcomment(caseId);
      }
      return ok;
    } catch (e) {
      if (!isClosed)
        emit(CommentsError('Error sending comment: ${e.toString()}'));
      return false;
    }
  }

  // Change case status method
  Future<bool> changeCaseStatus(int newStatusIndex, int cost) async {
    if (isClosed) return false;

    try {
      final caseId = medicalCase?.medicalCaseDetails?.id;
      if (caseId == null) {
        if (!isClosed) emit(CasesError('No case ID found'));
        return false;
      }

      final success = await repo.changeCaseStatus(caseId, cost);
      if (success) {
        // Update the local case status
        if (medicalCase?.medicalCaseDetails != null) {
          medicalCase!.medicalCaseDetails!.status = newStatusIndex;
          // Emit the updated state
          if (!isClosed) emit(CaseDetailsLoaded(medicalCase!));
        }
        return true;
      } else {
        if (!isClosed) emit(CasesError('Failed to change case status'));
        return false;
      }
    } catch (e) {
      if (!isClosed)
        emit(CasesError('Error changing case status: ${e.toString()}'));
      return false;
    }
  }

  // Form state management methods
  void setSelectedClient(int id, String name) {
    if (isClosed) return;
    selectedClientId = id;
    selectedClientName = name;
    emit(CasesInitial()); // Re-emit to update UI
  }

  void updatePatientFullName(String name) {
    patientFullName = name;
    if (!isClosed) emit(CasesInitial());
  }

  void updatePatientPhone(String phone) {
    patientPhone = phone;
    if (!isClosed) emit(CasesInitial());
  }

  void updatePatientBirthdate(DateTime date) {
    patientBirthdate = date;
    if (!isClosed) emit(CasesInitial());
  }

  void updatePatientGender(String gender) {
    patientGender = gender;
    if (!isClosed) emit(CasesInitial());
  }

  void updateIsSmoker(bool smoker) {
    isSmoker = smoker;
    if (!isClosed) emit(CasesInitial());
  }

  void updateShade(String shadeValue) {
    shade = shadeValue;
    if (!isClosed) emit(CasesInitial());
  }

  void updateNeedTrial(bool need) {
    needTrial = need;
    if (!isClosed) emit(CasesInitial());
  }

  void updateRepeat(bool repeatValue) {
    repeat = repeatValue;
    if (!isClosed) emit(CasesInitial());
  }

  void updateNotes(String notesValue) {
    notes = notesValue;
    if (!isClosed) emit(CasesInitial());
  }

  void updateExpectedDeliveryDate(DateTime date) {
    expectedDeliveryDate = date;
    if (!isClosed) emit(CasesInitial());
  }

  // Teeth data management
  void updateSelectedTeeth(String category, List<String> teeth) {
    selectedTeeth[category] = teeth;
    // Emit state to update UI when teeth data changes
    if (!isClosed) emit(CasesInitial());
  }

  // Getter for teeth data
  Map<String, List<String>> get getSelectedTeeth => selectedTeeth;

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

    // Format as "tooth1,tooth2,tooth3,material" (simple format like in Postman)
    List<String> formattedGroups = [];
    for (var entry in groupedByMaterial.entries) {
      String material = entry.key;
      List<String> toothNumbers = entry.value;
      // Map Arabic material names to numbers (1=خزف على معدن, 2=خزف على زركون, 3=خزف على معدن)
      String materialNumber = _getMaterialNumber(material);
      formattedGroups.add('${toothNumbers.join(',')},$materialNumber');
    }

    String result = formattedGroups.join(';');
    print('Formatted teeth data: $result');
    return result;
  }

  // Map Arabic material names to numbers
  String _getMaterialNumber(String material) {
    switch (material.trim()) {
      case 'زيركون':
        return '1';
      case 'خزف على معدن':
        return '2';
      case 'شمع':
        return '3';
      case 'أكريل مؤقت':
        return '4';
      default:
        return '1'; // Default to 1 if unknown
    }
  }

  // Validation method
  bool validateForm() {
    if (selectedClientId == null) return false;
    if (patientFullName.trim().isEmpty) return false;
    if (patientPhone.trim().isEmpty) return false;
    if (shade.trim().isEmpty) return false;
    return true;
  }

  // Add teeth screenshot to images list
  void addTeethScreenshot(Uint8List screenshotBytes) {
    // Clear existing images and add screenshot as the first image
    imgList.clear();
    imgList.add(screenshotBytes);
    if (!isClosed) emit(ImagesLoaded(imgList));
    print('Teeth screenshot added to cubit: ${screenshotBytes.length} bytes');
  }

  // Add manual image to images list
  void addManualImage(Uint8List imageBytes) {
    imgList.add(imageBytes);
    if (!isClosed) emit(ImagesLoaded(imgList));
    print('Manual image added to cubit: ${imageBytes.length} bytes');
  }

  // Get total image count
  int get totalImageCount => imgList.length;

  // Clear images list
  void clearImages() {
    imgList.clear();
    if (!isClosed) emit(ImagesLoaded(imgList));
  }

  // Add medical case method
  Future<bool> addMedicalCase() async {
    if (!validateForm()) {
      if (!isClosed) emit(CasesError('Please fill all required fields'));
      return false;
    }

    if (isClosed) return false;
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

      // Add images to case data if they exist
      if (imgList.isNotEmpty) {
        caseData['images'] = imgList;
      }

      // Remove only null values, keep empty strings for teeth data
      caseData.removeWhere((key, value) => value == null);

      final success = await repo.addMedicalCaseToLocalClient(caseData);

      if (success) {
        if (isClosed) return true;
        emit(CasesLoaded(casesList!)); // Return to loaded state
        return true;
      } else {
        if (!isClosed) emit(CasesError('Failed to add medical case'));
        return false;
      }
    } catch (e) {
      if (!isClosed)
        emit(CasesError("Error adding medical case: \\${e.toString()}"));
      return false;
    }
  }
}
