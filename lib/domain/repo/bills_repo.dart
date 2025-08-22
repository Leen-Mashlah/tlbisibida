import 'package:lambda_dent_dash/domain/models/bills/bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/bill_details.dart';

abstract class BillsRepo {
  Future<LabBillsList> getLabBills();
  Future<DentistBillsList> getDentistBills(int dentistId);
  Future<BillDetailsResponse> getBillDetails(int billId);
}
