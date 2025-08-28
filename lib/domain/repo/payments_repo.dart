import 'package:lambda_dent_dash/domain/models/payments/lab_item_history.dart';

abstract class PaymentsRepo {
  Future<List<LabItemHistory>> getLabItemsHistory();
}
