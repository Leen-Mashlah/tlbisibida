import 'package:lambda_dent_dash/data/models/inventory/db_repeated_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_cats.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_quants_for_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_subcats.dart';

abstract class InvRepo {
  //inventory
  DBCategoriesResponse? dbCategoriesResponse;
  DBItemsResponse? dbItemsResponse;
  DBRepeatedItemsResponse? dbRepeatedItemsResponse;
  DBItemQuantityHistoryResponse? dbItemQuantityHistoryResponse;
  DBSubCategoryRepositoriesResponse? dbSubCategoryRepositoriesResponse;

  //inventory
  Future<void> getCats([String? token]);
  Future<void> getItemsLog([String? token]);
  Future<void> getItems(int id, [String? token]);
  Future<void> getQuantities(int id, [String? token]);
  Future<void> getSubCats(int id, [String? token]);

  // CRUD operations for Categories
  Future<void> addCategory(String name);
  Future<void> updateCategory(int id, String name);
  Future<void> deleteCategory(int id);

  // CRUD operations for Subcategories
  Future<void> addSubcategory(int categoryId, String name);
  Future<void> updateSubcategory(int id, String name);
  Future<void> deleteSubcategory(int id);

  // CRUD operations for Items
  Future<void> addItem(int subcategoryId, Map<String, dynamic> itemData);
  Future<void> updateItem(int id, Map<String, dynamic> itemData);
  Future<void> deleteItem(int id);

  // Item quantity history
  Future<void> addItemHistory(int itemId, Map<String, dynamic> historyData);
}
