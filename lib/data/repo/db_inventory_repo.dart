import 'package:lambda_dent_dash/data/models/inventory/db_repeated_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_cats.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_quants_for_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_subcats.dart';
import 'package:lambda_dent_dash/domain/repo/inv_repo.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';
import 'package:lambda_dent_dash/services/cache/cache_helper.dart';

class DbInventoryRepo implements InvRepo {
  @override
  DBCategoriesResponse? dbCategoriesResponse;

  @override
  DBItemQuantityHistoryResponse? dbItemQuantityHistoryResponse;

  @override
  DBItemsResponse? dbItemsResponse;

  @override
  DBRepeatedItemsResponse? dbRepeatedItemsResponse;

  @override
  DBSubCategoryRepositoriesResponse? dbSubCategoryRepositoriesResponse;

  @override
  Future<void> getCats() async {
    try {
      final token = CacheHelper.get('token');
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found');
      }
      final response =
          await DioHelper.getData('inventory/categories', token: token);
      dbCategoriesResponse = DBCategoriesResponse.fromJson(response?.data);
    } catch (error) {
      print('error in getCats: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> getItems(int id) async {
    try {
      final response = await DioHelper.getData('inventory/items/$id',
          token: CacheHelper.get('token'));
      dbItemsResponse = DBItemsResponse.fromJson(response?.data);
    } catch (error) {
      print('error in getItems: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> getItemsLog() async {
    try {
      final response = await DioHelper.getData(
          'inventory/Repeated_item_histories',
          token: CacheHelper.get('token'));
      dbRepeatedItemsResponse =
          DBRepeatedItemsResponse.fromJson(response?.data);
    } catch (error) {
      print('error in getItemsLog: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> getQuantities(int id) async {
    try {
      final response = await DioHelper.getData('inventory/itemhistories/$id',
          token: CacheHelper.get('token'));
      dbItemQuantityHistoryResponse =
          DBItemQuantityHistoryResponse.fromJson(response?.data);
    } catch (error) {
      print('error in getQuantities: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> getSubCats(int id) async {
    try {
      final response = await DioHelper.getData('inventory/subcategories/$id',
          token: CacheHelper.get('token'));
      dbSubCategoryRepositoriesResponse =
          DBSubCategoryRepositoriesResponse.fromJson(response?.data);
    } catch (error) {
      print('error in getSubCats: ' + error.toString());
      rethrow;
    }
  }

  // CRUD operations for Categories
  @override
  Future<void> addCategory(String name) async {
    try {
      await DioHelper.postData(
        'inventory/addcategory',
        {
          'name': name,
        },
        token: CacheHelper.get('token'),
      );
      // Refresh categories after adding
      getCats();
    } catch (error) {
      print('error in addCategory: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    try {
      await DioHelper.updateData(
        'inventory/updateCategory/$id?name=$name',
        {},
        token: CacheHelper.get('token'),
      );
      // Refresh categories after updating
      getCats();
    } catch (error) {
      print('error in updateCategory: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    try {
      await DioHelper.deleteData('inventory/deletecategory/$id',
          token: CacheHelper.get('token'));
      // Refresh categories after deleting
      getCats();
    } catch (error) {
      print('error in deleteCategory: ' + error.toString());
      rethrow;
    }
  }

  // CRUD operations for Subcategories
  @override
  Future<void> addSubcategory(int categoryId, String name) async {
    try {
      await DioHelper.postData(
        'inventory/addsubcategory/$categoryId',
        {
          'name': name,
        },
        token: CacheHelper.get('token'),
      );
      // Refresh subcategories after adding
      getSubCats(categoryId);
    } catch (error) {
      print('error in addSubcategory: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateSubcategory(int id, String name) async {
    try {
      await DioHelper.updateData(
        'inventory/updateSubCategory/$id?name=$name',
        {},
        token: CacheHelper.get('token'),
      );
      // Note: We need the categoryId to refresh subcategories
      // This will be handled in the cubit
    } catch (error) {
      print('error in updateSubcategory: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteSubcategory(int id) async {
    try {
      await DioHelper.deleteData('inventory/deleteSubcategory/$id',
          token: CacheHelper.get('token'));
      // Note: We need the categoryId to refresh subcategories
      // This will be handled in the cubit
    } catch (error) {
      print('error in deleteSubcategory: ' + error.toString());
      rethrow;
    }
  }

  // CRUD operations for Items
  @override
  Future<void> addItem(int subcategoryId, Map<String, dynamic> itemData) async {
    try {
      await DioHelper.postData(
        'inventory/additem/$subcategoryId',
        itemData,
        token: CacheHelper.get('token'),
      );
      // Refresh items after adding
      getItems(subcategoryId);
    } catch (error) {
      print('error in addItem: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateItem(int id, Map<String, dynamic> itemData) async {
    try {
      await DioHelper.updateData('inventory/updateitem/$id', itemData,
          token: CacheHelper.get('token'));
      // Note: We need the subcategoryId to refresh items
      // This will be handled in the cubit
    } catch (error) {
      print('error in updateItem: ' + error.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await DioHelper.deleteData('inventory/deleteitem/$id',
          token: CacheHelper.get('token'));
      // Note: We need the subcategoryId to refresh items
      // This will be handled in the cubit
    } catch (error) {
      print('error in deleteItem: ' + error.toString());
      rethrow;
    }
  }

  // Item quantity history
  @override
  Future<void> addItemHistory(
      int itemId, Map<String, dynamic> historyData) async {
    try {
      await DioHelper.postData(
        'inventory/additemhistory/$itemId',
        historyData,
        token: CacheHelper.get('token'),
      );
      // Refresh item history after adding
      getQuantities(itemId);
    } catch (error) {
      print('error in addItemHistory: ' + error.toString());
      rethrow;
    }
  }
}
