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
    if (isClosed) return;
    emit(BillsLoading());
    try {
      billsList = await repo.getLabBills();
      if (billsList != null) {
        if (isClosed) return;
        emit(BillsLoaded(billsList!));
      } else {
        if (!isClosed) emit(BillsError('No bills found.'));
      }
    } catch (e) {
      if (!isClosed) emit(BillsError("Error loading bills: \\${e.toString()}"));
    }
  }

  DentistBillsList? dentistBillsList;
  Future<void> getDentistBills(int dentistId) async {
    if (isClosed) return;
    emit(DentistBillsLoading());
    try {
      dentistBillsList = await repo.getDentistBills(dentistId);
      if (dentistBillsList != null) {
        if (isClosed) return;
        emit(DentistBillsLoaded(dentistBillsList!));
      } else {
        if (!isClosed) emit(DentistBillsError('No dentist bills found.'));
      }
    } catch (e) {
      if (!isClosed)
        emit(DentistBillsError(
            "Error loading dentist bills: \\${e.toString()}"));
    }
  }

  BillDetailsResponse? billDetails;
  Future<void> getBillDetails(int billId) async {
    if (isClosed) return;
    emit(BillDetailsLoading());
    try {
      billDetails = await repo.getBillDetails(billId);
      if (billDetails != null) {
        if (isClosed) return;
        emit(BillDetailsLoaded(billDetails!));
      } else {
        if (!isClosed) emit(BillDetailsError('No bill details found.'));
      }
    } catch (e) {
      if (!isClosed)
        emit(BillDetailsError("Error loading bill details: \\${e.toString()}"));
    }
  }
}

