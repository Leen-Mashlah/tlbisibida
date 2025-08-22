import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/bills/bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/dentist_bills_list.dart';
import 'package:lambda_dent_dash/domain/models/bills/bill_details.dart';
import 'package:lambda_dent_dash/domain/repo/bills_repo.dart';
import 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  BillsCubit(this.repo) : super(BillsInitial()) {
    getBills();
  }

  final BillsRepo repo;

  LabBillsList? billsList;
  Future<void> getBills() async {
    emit(BillsLoading());
    try {
      billsList = await repo.getLabBills();
      if (billsList != null) {
        emit(BillsLoaded(billsList!));
      } else {
        emit(BillsError('No bills found.'));
      }
    } catch (e) {
      emit(BillsError("Error loading bills: \\${e.toString()}"));
    }
  }

  DentistBillsList? dentistBillsList;
  Future<void> getDentistBills(int dentistId) async {
    emit(DentistBillsLoading());
    try {
      dentistBillsList = await repo.getDentistBills(dentistId);
      if (dentistBillsList != null) {
        emit(DentistBillsLoaded(dentistBillsList!));
      } else {
        emit(DentistBillsError('No dentist bills found.'));
      }
    } catch (e) {
      emit(DentistBillsError("Error loading dentist bills: \\${e.toString()}"));
    }
  }

  BillDetailsResponse? billDetails;
  Future<void> getBillDetails(int billId) async {
    emit(BillDetailsLoading());
    try {
      billDetails = await repo.getBillDetails(billId);
      if (billDetails != null) {
        emit(BillDetailsLoaded(billDetails!));
      } else {
        emit(BillDetailsError('No bill details found.'));
      }
    } catch (e) {
      emit(BillDetailsError("Error loading bill details: \\${e.toString()}"));
    }
  }
}
