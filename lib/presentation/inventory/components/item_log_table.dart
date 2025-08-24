import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/components/custom_text.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_quants_for_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

/// Item quantity history table
class ItemLogTable extends StatelessWidget {
  const ItemLogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        // Load quantities when component builds
        if (state is ItemsLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Get the first item from the loaded items to show its history
            final items = state.items;
            if (items.isNotEmpty) {
              final item = items.first;
              if (item.id != null) {
                context.read<InventoryCubit>().getQuantities(item.id!);
              }
            }
          });
        }

        if (state is InventoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is InventoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'خطأ في تحميل البيانات: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<InventoryCubit>().getCats(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is ItemQuantitiesLoaded) {
          final quantities = state.itemQuantities;

          if (quantities.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'لا يوجد سجل للكميات',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: cyan200, width: .5),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 6), color: Colors.grey, blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
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
                      'القيمة السابقة',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                  DataColumn(
                    label: Center(
                        child: Text(
                      'الفرق',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                  DataColumn(
                    label: Center(
                        child: Text(
                      'القيمة الجديدة',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                  DataColumn(
                    label: Center(
                        child: Text(
                      'السعر',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                  DataColumn(
                    label: Center(
                        child: Text(
                      'التاريخ',
                      style: TextStyle(color: cyan300),
                    )),
                  ),
                ],
                rows: List<DataRow>.generate(
                  quantities.length,
                  (index) {
                    final quantity = quantities[index];
                    final previousValue = quantity.recentValue ?? 0;
                    final newValue = quantity.newValue ?? 0;
                    final difference = newValue - previousValue;

                    return DataRow(
                      cells: [
                        DataCell(Center(
                            child: CustomText(
                          text: '$previousValue',
                        ))),
                        DataCell(Center(
                          child: CustomText(
                            text: difference >= 0
                                ? '+$difference'
                                : '$difference',
                            color: difference >= 0 ? Colors.green : Colors.red,
                          ),
                        )),
                        DataCell(Center(child: CustomText(text: '$newValue'))),
                        DataCell(Center(
                            child:
                                CustomText(text: '${quantity.quantity ?? 0}'))),
                        DataCell(Center(
                            child: CustomText(
                                text: quantity.createdAt
                                        ?.toString()
                                        .split(' ')[0] ??
                                    'غير محدد'))),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }

        // Default state - show message
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inventory_2_outlined,
                  size: 60, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'اختر فئة فرعية لعرض العناصر',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
