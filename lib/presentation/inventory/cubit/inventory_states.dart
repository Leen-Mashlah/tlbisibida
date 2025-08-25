import 'package:lambda_dent_dash/domain/models/inventory/repeated_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_quants_for_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_subcats.dart';

abstract class InventoryState {
  const InventoryState();
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class CategoriesLoaded extends InventoryState {
  final List<Category> categories;
  const CategoriesLoaded(this.categories);
}

class ItemsLoaded extends InventoryState {
  final List<Item> items;
  const ItemsLoaded(this.items);
}

class RepeatedItemsLoaded extends InventoryState {
  final List<RepeatedItem> repeatedItems;
  const RepeatedItemsLoaded(this.repeatedItems);
}

class ItemQuantitiesLoaded extends InventoryState {
  final List<ItemQuantityHistory> itemQuantities;
  const ItemQuantitiesLoaded(this.itemQuantities);
}

class SubCategoriesLoaded extends InventoryState {
  final List<SubCategoryRepository> subCategories;
  const SubCategoriesLoaded(this.subCategories);
}

class InventoryError extends InventoryState {
  final String message;
  final StackTrace? stackTrace;
  const InventoryError(this.message, {this.stackTrace});
}
