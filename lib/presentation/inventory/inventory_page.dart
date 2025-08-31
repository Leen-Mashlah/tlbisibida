import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/constants/constants.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/buttom_action_buttons.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/bottom_action_payments_log_buttons.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/percent_gauge.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/pie_chart.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/triangle_card.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/item_edit_quantity_card.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_cubit.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';
import 'package:lambda_dent_dash/presentation/inventory/components/dialogs/cat_management_dialog.dart';
import 'package:lambda_dent_dash/services/Cache/cache_helper.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
    // Initialize categories when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadCategories();
      }
    });
  }

  void _loadCategories() async {
    // Add a small delay to ensure token is properly stored
    await Future.delayed(const Duration(milliseconds: 100));

    final token = CacheHelper.get('token');
    if (token == null || token.toString().isEmpty) {
      // Try one more time after a longer delay
      await Future.delayed(const Duration(milliseconds: 500));
      final retryToken = CacheHelper.get('token');
      if (retryToken == null || retryToken.toString().isEmpty) {
        Navigator.pushReplacementNamed(context, '/auth');
        return;
      }
      context.read<InventoryCubit>().getCats(retryToken.toString());
      return;
    }

    context.read<InventoryCubit>().getCats(token.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryCubit, InventoryState>(
      builder: (context, state) {
        // Initialize categories when page loads if still in initial state
        if (state is InventoryInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _loadCategories();
            }
          });
        }

        // Handle loading state
        if (state is InventoryLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('جاري التحميل...'),
              ],
            ),
          );
        }

        // Handle error state
        if (state is InventoryError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  state.message.contains('Authentication token not found') ||
                          state.message.contains('401') ||
                          state.message.contains('Unauthorized')
                      ? 'يرجى تسجيل الدخول أولاً'
                      : 'خطأ: ${state.message}',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (state.message.contains('Authentication token not found') ||
                    state.message.contains('401') ||
                    state.message.contains('Unauthorized'))
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/auth');
                    },
                    child: const Text('تسجيل الدخول'),
                  )
                else
                  ElevatedButton(
                    onPressed: () => context.read<InventoryCubit>().getCats(),
                    child: const Text('إعادة المحاولة'),
                  ),
              ],
            ),
          );
        }

        // When there are no categories loaded, allow user to add categories
        if (state is CategoriesLoaded && state.categories.isEmpty) {
          return _buildEmptyCategoriesPrompt(context);
        }

        // When there are no subcategories loaded for a selected category
        if (state is SubCategoriesLoaded && state.subCategories.isEmpty) {
          return _buildEmptySubCategoriesPrompt(context);
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 700,
                child: const InteractiveDonutChart()
                    .animate()
                    .rotate(duration: const Duration(minutes: 60), begin: -20),
              ),
              // Show items grid only when items are loaded (subcategory selected)
              if (state is ItemsLoaded)
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    width: 600,
                    child: _buildItemsGrid(context, state),
                  ),
                ),
              // Show selection prompt when category is selected but no subcategory
              if (state is SubCategoriesLoaded &&
                  state.subCategories.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    width: 600,
                    child: _buildSubcategoryPrompt(context, state),
                  ),
                ),
              // Show category selection prompt when no category is selected
              if (state is CategoriesLoaded)
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SizedBox(
                    width: 600,
                    child: _buildCategoryPrompt(context, state),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryPrompt(BuildContext context, CategoriesLoaded state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.category_outlined,
            size: 80,
            color: cyan300,
          ),
          const SizedBox(height: 20),
          Text(
            'اختر فئة من الرسم البياني',
            style: TextStyle(
              fontSize: 24,
              color: cyan500,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'اضغط على أي فئة في الرسم البياني الخارجي لبدء التصفح',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 500));
  }

  Widget _buildSubcategoryPrompt(
      BuildContext context, SubCategoriesLoaded state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.subdirectory_arrow_right,
            size: 80,
            color: cyan400,
          ),
          const SizedBox(height: 20),
          Text(
            'اختر فئة فرعية',
            style: TextStyle(
              fontSize: 24,
              color: cyan500,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'اضغط على أي فئة فرعية في الرسم البياني الداخلي لعرض العناصر',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => context.read<InventoryCubit>().clearData(),
            icon: Icon(Icons.arrow_back, color: cyan500),
            label: Text(
              'اختيار فئة أخرى',
              style: TextStyle(color: cyan500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: cyan50,
              side: BorderSide(color: cyan200),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 500));
  }

  Widget _buildEmptyCategoriesPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category_outlined, size: 80, color: cyan300),
          const SizedBox(height: 20),
          Text('لا توجد فئات بعد',
              style: TextStyle(
                  fontSize: 24, color: cyan500, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('أضف فئة جديدة للبدء',
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CatManagementDialog(context),
              );
            },
            icon: Icon(Icons.add, color: cyan500),
            label: Text('إدارة الفئات', style: TextStyle(color: cyan500)),
            style: ElevatedButton.styleFrom(
                backgroundColor: cyan50, side: BorderSide(color: cyan200)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySubCategoriesPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.subdirectory_arrow_right, size: 80, color: cyan400),
          const SizedBox(height: 20),
          Text('لا توجد فئات فرعية',
              style: TextStyle(
                  fontSize: 24, color: cyan500, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('أضف فئة فرعية جديدة',
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CatManagementDialog(context),
              );
            },
            icon: Icon(Icons.add, color: cyan500),
            label: Text('إدارة الفئات/الفئات الفرعية',
                style: TextStyle(color: cyan500)),
            style: ElevatedButton.styleFrom(
                backgroundColor: cyan50, side: BorderSide(color: cyan200)),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.read<InventoryCubit>().clearData(),
            icon: Icon(Icons.arrow_back, color: cyan500),
            label: Text('اختيار فئة أخرى', style: TextStyle(color: cyan500)),
            style: ElevatedButton.styleFrom(
                backgroundColor: cyan50, side: BorderSide(color: cyan200)),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsGrid(BuildContext context, ItemsLoaded state) {
    if (state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'لا توجد عناصر في هذه الفئة الفرعية',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'لا توجد عناصر في هذه الفئة الفرعية',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with category and subcategory info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cyan50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cyan200, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.category, color: cyan500),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'العناصر',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: cyan600,
                      ),
                    ),
                    Text(
                      '${state.items.length} عنصر متاح',
                      style: TextStyle(
                        fontSize: 16,
                        color: cyan600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: cyan100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${state.items.length} عنصر',
                      style: TextStyle(
                        color: cyan600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => context.read<InventoryCubit>().clearData(),
                    icon: Icon(Icons.refresh, color: cyan500),
                    tooltip: 'اختيار فئة أخرى',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Items grid
        Expanded(
          child: GridView.count(
            childAspectRatio: 1,
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 15,
            children: List.generate(
              state.items.length,
              (index) => _buildItemCard(context, state.items[index], index),
            )
                .animate(
                  interval: const Duration(milliseconds: 50),
                )
                .slide(duration: const Duration(milliseconds: 300))
                .fadeIn(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 250),
                )
                .flip(duration: const Duration(milliseconds: 200)),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(BuildContext context, Item item, int index) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      front: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: cyan200, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    item.name ?? 'Unknown Item',
                    style: const TextStyle(color: cyan500, fontSize: 18),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: .5,
                    width: 100,
                    color: cyan200,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 170,
                    child: _buildPercentCircle(context, item),
                  ),
                ],
              ),
            ),
            bottomActionPaymentsLogButtons(context, item),
          ],
        ),
      ),
      back: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: cyan200, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    item.name ?? 'Unknown Item',
                    style: const TextStyle(color: cyan500, fontSize: 18),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: .5,
                    width: 100,
                    color: cyan200,
                  ),
                  const SizedBox(height: 10),
                  ClipPath(
                    clipper: TriangleCard(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 170,
                      width: 250,
                      color: cyan50,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('الكمية الحالية'),
                            Text(
                              '${item.quantity ?? 0}',
                              style: const TextStyle(color: cyan400),
                            ),
                            const Text('الكمية القياسية'),
                            Text(
                              '${item.standardQuantity ?? 0}',
                              style: const TextStyle(color: cyan300),
                            ),
                            const Text('الحد الأدنى'),
                            Text(
                              '${item.minimumQuantity ?? 0}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _getQuantityColor(item),
                              ),
                            ),
                            if (item.unit != null) ...[
                              const Text('الوحدة'),
                              Text(
                                item.unit!,
                                style: const TextStyle(color: cyan300),
                              ),
                            ],
                            const SizedBox(height: 10),
                            itemEditQuantityCard(context, item),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomActionButtons(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentCircle(BuildContext context, Item item) {
    return percentCircle(context, item);
  }

  Color _getQuantityColor(Item item) {
    final quantity = item.quantity ?? 0;
    final minimum = item.minimumQuantity ?? 0;

    if (quantity <= minimum) {
      return const Color.fromARGB(255, 228, 132, 132); // Red for low quantity
    } else if (quantity <= (item.standardQuantity ?? 0)) {
      return Colors.orange; // Orange for below standard
    } else {
      return Colors.green; // Green for good quantity
    }
  }
}
