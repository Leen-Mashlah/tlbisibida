import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/cases/case_details.dart';

class CaseDetailsTable extends StatelessWidget {
  final MedicalCaseDetails? caseDetails;

  const CaseDetailsTable({
    super.key,
    this.caseDetails,
  });

  // Helper method to get material name from material code
  String _getMaterialName(String materialCode) {
    switch (materialCode) {
      case '1':
        return 'زيركون';
      case '2':
        return 'خزف';
      case '3':
        return 'شمع';
      case '4':
        return 'EMax';
      case '5':
        return 'اكريل مؤقت';
      case '6':
        return 'اكريل مبطن';
      case '7':
        return 'فليكس';
      default:
        return 'غير محدد';
    }
  }

  // Helper method to parse teeth string and get treatment type
  List<Map<String, String>> _parseTeethData() {
    List<Map<String, String>> teethData = [];

    if (caseDetails == null) return teethData;

    // Parse teeth crown data (skip bridges)
    if (caseDetails!.teethCrown != null &&
        caseDetails!.teethCrown!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethCrown!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'تاج',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    // Parse teeth pontic data (skip bridges)
    if (caseDetails!.teethPontic != null &&
        caseDetails!.teethPontic!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethPontic!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'دمية',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    // Parse teeth implant data (skip bridges)
    if (caseDetails!.teethImplant != null &&
        caseDetails!.teethImplant!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethImplant!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'زراعة',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    // Parse teeth veneer data (skip bridges)
    if (caseDetails!.teethVeneer != null &&
        caseDetails!.teethVeneer!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethVeneer!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'فينير',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    // Parse teeth inlay data (skip bridges)
    if (caseDetails!.teethInlay != null &&
        caseDetails!.teethInlay!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethInlay!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'حشوة',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    // Parse teeth denture data (skip bridges)
    if (caseDetails!.teethDenture != null &&
        caseDetails!.teethDenture!.trim().isNotEmpty) {
      List<String> teeth = caseDetails!.teethDenture!.split(',');
      for (String tooth in teeth) {
        if (tooth.trim().isNotEmpty) {
          // Extract tooth number and material
          List<String> parts = tooth.trim().split(',');
          String toothNumber = parts[0].trim();
          String materialCode =
              parts.length > 1 ? parts.last.trim() : '1'; // Default to زيركون

          teethData.add({
            'tooth': toothNumber,
            'treatment': 'طقم',
            'material': _getMaterialName(materialCode),
          });
        }
      }
    }

    return teethData;
  }

  @override
  Widget build(BuildContext context) {
    final teethData = _parseTeethData();

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: cyan200, width: .5),
          boxShadow: const [
            BoxShadow(offset: Offset(0, 6), color: Colors.grey, blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        // margin: const EdgeInsets.only(bottom: 30),
        child: DataTable2(
          columnSpacing: 12,
          dataRowHeight: 56,
          headingRowHeight: 40,
          horizontalMargin: 12,
          minWidth: 100,
          columns: const [
            DataColumn(
              label: Center(
                  child: Text(
                'رقم السن',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'العلاج',
                style: TextStyle(color: cyan300),
              )),
            ),
            DataColumn(
              label: Center(
                  child: Text(
                'مادة العلاج',
                style: TextStyle(color: cyan300),
              )),
            ),
          ],
          rows: teethData.isEmpty
              ? [
                  const DataRow(
                    cells: [
                      DataCell(
                          Center(child: CustomText(text: 'لا توجد بيانات'))),
                      DataCell(Center(child: CustomText(text: '—'))),
                      DataCell(Center(child: CustomText(text: '—'))),
                    ],
                  )
                ]
              : List<DataRow>.generate(
                  teethData.length,
                  (index) {
                    final tooth = teethData[index];
                    return DataRow(
                      cells: [
                        DataCell(Center(
                            child: CustomText(
                          text: tooth['tooth'] ?? '',
                        ))),
                        DataCell(Center(
                            child: CustomText(text: tooth['treatment'] ?? ''))),
                        DataCell(Center(
                            child: CustomText(text: tooth['material'] ?? ''))),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
