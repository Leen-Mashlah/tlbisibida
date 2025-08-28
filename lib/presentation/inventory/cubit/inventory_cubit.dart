import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_cats.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/repeated_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_quants_for_items.dart';
import 'package:lambda_dent_dash/domain/models/inventory/show_subcats.dart';
import 'package:lambda_dent_dash/domain/repo/inv_repo.dart';
import 'package:lambda_dent_dash/presentation/inventory/cubit/inventory_states.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final InvRepo repo;
  String? lastError;

  InventoryCubit(this.repo) : super(InventoryInitial());

  // Data storage
  List<Category> categories = [];
  List<Item> items = [];
  List<RepeatedItem> repeatedItems = [];
  List<ItemQuantityHistory> itemQuantities = [];
  List<SubCategoryRepository> subCategories = [];

  // Selection state
  Category? selectedCategory;
  SubCategoryRepository? selectedSubCategory;

  // Get categories
  Future<void> getCats() async {
    if (isClosed) return;
    emit(InventoryLoading());
    lastError = null;
    categories.clear();

    try {
      await repo.getCats();
      if (repo.dbCategoriesResponse?.categories != null) {
        categories = repo.dbCategoriesResponse!.categories!
            .map((e) => e.toDomain())
            .toList();
        if (isClosed) return;
        emit(CategoriesLoaded(categories));
      } else {
        lastError = 'لا توجد فئات.';
        if (!isClosed) emit(InventoryError(lastError!));
      }
    } catch (e, stack) {
      lastError = e.toString();
      if (!isClosed) emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Get items by category ID
  Future<void> getItems(int categoryId) async {
    if (isClosed) return;
    emit(InventoryLoading());
    lastError = null;
    items.clear();

    try {
      await repo.getItems(categoryId);
      if (repo.dbItemsResponse?.items != null) {
        items = repo.dbItemsResponse!.items!.map((e) => e.toDomain()).toList();
        if (isClosed) return;
        emit(ItemsLoaded(items));
      } else {
        lastError = 'لا توجد عناصر في هذه الفئة.';
        if (!isClosed) emit(InventoryError(lastError!));
      }
    } catch (e, stack) {
      lastError = e.toString();
      if (!isClosed) emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Get repeated items log
  Future<void> getItemsLog() async {
    if (isClosed) return;
    emit(InventoryLoading());
    lastError = null;
    repeatedItems.clear();

    try {
      await repo.getItemsLog();
      if (repo.dbRepeatedItemsResponse?.repeatedItems != null) {
        // Convert DB models to domain models
        repeatedItems = repo.dbRepeatedItemsResponse!.repeatedItems!
            .map((e) => e.toDomain())
            .toList();
        if (isClosed) return;
        emit(RepeatedItemsLoaded(repeatedItems));
      } else {
        lastError = 'لا توجد سجلات للعناصر المتكررة.';
        if (!isClosed) emit(InventoryError(lastError!));
      }
    } catch (e, stack) {
      lastError = e.toString();
      if (!isClosed) emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Get item quantities by item ID
  Future<void> getQuantities(int itemId) async {
    if (isClosed) return;
    emit(InventoryLoading());
    lastError = null;
    itemQuantities.clear();

    try {
      await repo.getQuantities(itemId);
      if (repo.dbItemQuantityHistoryResponse?.items != null) {
        itemQuantities = repo.dbItemQuantityHistoryResponse!.items!
            .map((e) => e.toDomain())
            .toList();
        if (isClosed) return;
        emit(ItemQuantitiesLoaded(itemQuantities));
      } else {
        lastError = 'لا توجد سجلات للكميات.';
        if (!isClosed) emit(InventoryError(lastError!));
      }
    } catch (e, stack) {
      lastError = e.toString();
      if (!isClosed) emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Get subcategories by category ID
  Future<void> getSubCats(int categoryId) async {
    if (isClosed) return;
    emit(InventoryLoading());
    lastError = null;
    subCategories.clear();

    try {
      await repo.getSubCats(categoryId);
      if (repo.dbSubCategoryRepositoriesResponse?.subCategoryRepositories !=
          null) {
        subCategories = repo
            .dbSubCategoryRepositoriesResponse!.subCategoryRepositories!
            .map((e) => e.toDomain())
            .toList();
        if (isClosed) return;
        emit(SubCategoriesLoaded(subCategories));
      } else {
        lastError = 'لا توجد فئات فرعية.';
        if (!isClosed) emit(InventoryError(lastError!));
      }
    } catch (e, stack) {
      lastError = e.toString();
      if (!isClosed) emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Selection methods
  void selectCategory(Category category) {
    selectedCategory = category;
    selectedSubCategory = null;
    if (!isClosed) emit(CategoriesLoaded(categories));
  }

  void selectSubCategory(SubCategoryRepository subCategory) {
    selectedSubCategory = subCategory;
    if (!isClosed) emit(SubCategoriesLoaded(subCategories));
  }

  // Clear all data
  void clearData() {
    categories.clear();
    items.clear();
    repeatedItems.clear();
    itemQuantities.clear();
    subCategories.clear();
    selectedCategory = null;
    selectedSubCategory = null;
    if (!isClosed) emit(InventoryInitial());
  }

  // CRUD operations for Categories
  Future<void> addCategory(String name) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.addCategory(name);
      // Categories are automatically refreshed in the repo
      emit(CategoriesLoaded(categories));
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> updateCategory(int id, String name) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.updateCategory(id, name);
      // Categories are automatically refreshed in the repo
      emit(CategoriesLoaded(categories));
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> deleteCategory(int id) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.deleteCategory(id);
      // Categories are automatically refreshed in the repo
      emit(CategoriesLoaded(categories));
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // CRUD operations for Subcategories
  Future<void> addSubcategory(int categoryId, String name) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.addSubcategory(categoryId, name);
      // Refresh subcategories after adding
      await getSubCats(categoryId);
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> updateSubcategory(int id, String name) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.updateSubcategory(id, name);
      // Refresh subcategories manually since we need the categoryId
      if (selectedCategory != null) {
        await getSubCats(selectedCategory!.id!);
      }
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> deleteSubcategory(int id) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.deleteSubcategory(id);
      // Refresh subcategories manually since we need the categoryId
      if (selectedCategory != null) {
        await getSubCats(selectedCategory!.id!);
      }
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // CRUD operations for Items
  Future<void> addItem(int subcategoryId, Map<String, dynamic> itemData) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.addItem(subcategoryId, itemData);
      // Refresh items after adding
      await getItems(subcategoryId);
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> updateItem(int id, Map<String, dynamic> itemData) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.updateItem(id, itemData);
      // Refresh items manually since we need the subcategoryId
      if (selectedSubCategory != null) {
        await getItems(selectedSubCategory!.id!);
      }
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  Future<void> deleteItem(int id) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.deleteItem(id);
      // Refresh items manually since we need the subcategoryId
      if (selectedSubCategory != null) {
        await getItems(selectedSubCategory!.id!);
      }
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }

  // Item quantity history
  Future<void> addItemHistory(
      int itemId, Map<String, dynamic> historyData) async {
    emit(InventoryLoading());
    lastError = null;

    try {
      await repo.addItemHistory(itemId, historyData);
      // Item history is automatically refreshed in the repo
      emit(ItemQuantitiesLoaded(itemQuantities));
    } catch (e, stack) {
      lastError = e.toString();
      emit(InventoryError(lastError!, stackTrace: stack));
    }
  }
}
