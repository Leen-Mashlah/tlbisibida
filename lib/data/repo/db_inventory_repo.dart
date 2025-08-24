import 'package:lambda_dent_dash/data/models/inventory/db_repeated_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_cats.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_quants_for_items.dart';
import 'package:lambda_dent_dash/data/models/inventory/db_show_subcats.dart';
import 'package:lambda_dent_dash/domain/repo/inv_repo.dart';
import 'package:lambda_dent_dash/services/dio/dio.dart';

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
    return await DioHelper.getData('inventory/categories', token: '')
        .then((value) {
      dbCategoriesResponse = DBCategoriesResponse.fromJson(value?.data);
    }).catchError((error) {
      print('error in getCats: ' + error.toString());
    });
  }

  @override
  Future<void> getItems(int id) async {
    return await DioHelper.getData('inventory/items/$id', token: '')
        .then((value) {
      dbItemsResponse = DBItemsResponse.fromJson(value?.data);
    }).catchError((error) {
      print('error in getItems: ' + error.toString());
    });
  }

  @override
  Future<void> getItemsLog() async {
    return await DioHelper.getData('inventory/Repeated_item_histories',
            token: '')
        .then((value) {
      dbRepeatedItemsResponse = DBRepeatedItemsResponse.fromJson(value?.data);
    }).catchError((error) {
      print('error in getItemsLog: ' + error.toString());
    });
  }

  @override
  Future<void> getQuantities(int id) async {
    return await DioHelper.getData('inventory/itemhistories/$id', token: '')
        .then((value) {
      dbItemQuantityHistoryResponse =
          DBItemQuantityHistoryResponse.fromJson(value?.data);
    }).catchError((error) {
      print('error in getQuantities: ' + error.toString());
    });
  }

  @override
  Future<void> getSubCats(int id) async {
    return await DioHelper.getData('inventory/subcategories/$id', token: '')
        .then((value) {
      dbSubCategoryRepositoriesResponse =
          DBSubCategoryRepositoriesResponse.fromJson(value?.data);
    }).catchError((error) {
      print('error in getSubCats: ' + error.toString());
    });
  }

  // CRUD operations for Categories
  @override
  Future<void> addCategory(String name) async {
    return await DioHelper.postData(
            'inventory/addcategory',
            {
              'name': name,
            },
            token: '')
        .then((value) {
      // Refresh categories after adding
      getCats();
    }).catchError((error) {
      print('error in addCategory: ' + error.toString());
    });
  }

  @override
  Future<void> updateCategory(int id, String name) async {
    return await DioHelper.updateData(
            'inventory/updateCategory/$id?name=$name', {},
            token: '')
        .then((value) {
      // Refresh categories after updating
      getCats();
    }).catchError((error) {
      print('error in updateCategory: ' + error.toString());
    });
  }

  @override
  Future<void> deleteCategory(int id) async {
    return await DioHelper.deleteData('inventory/deletecategory/$id', token: '')
        .then((value) {
      // Refresh categories after deleting
      getCats();
    }).catchError((error) {
      print('error in deleteCategory: ' + error.toString());
    });
  }

  // CRUD operations for Subcategories
  @override
  Future<void> addSubcategory(int categoryId, String name) async {
    return await DioHelper.postData(
            'inventory/addsubcategory/$categoryId',
            {
              'name': name,
            },
            token: '')
        .then((value) {
      // Refresh subcategories after adding
      getSubCats(categoryId);
    }).catchError((error) {
      print('error in addSubcategory: ' + error.toString());
    });
  }

  @override
  Future<void> updateSubcategory(int id, String name) async {
    return await DioHelper.updateData(
            'inventory/updateSubCategory/$id?name=$name', {},
            token: '')
        .then((value) {
      // Note: We need the categoryId to refresh subcategories
      // This will be handled in the cubit
    }).catchError((error) {
      print('error in updateSubcategory: ' + error.toString());
    });
  }

  @override
  Future<void> deleteSubcategory(int id) async {
    return await DioHelper.deleteData('inventory/deleteSubcategory/$id',
            token: '')
        .then((value) {
      // Note: We need the categoryId to refresh subcategories
      // This will be handled in the cubit
    }).catchError((error) {
      print('error in deleteSubcategory: ' + error.toString());
    });
  }

  // CRUD operations for Items
  @override
  Future<void> addItem(int subcategoryId, Map<String, dynamic> itemData) async {
    return await DioHelper.postData(
            'inventory/additem/$subcategoryId', itemData,
            token: '')
        .then((value) {
      // Refresh items after adding
      getItems(subcategoryId);
    }).catchError((error) {
      print('error in addItem: ' + error.toString());
    });
  }

  @override
  Future<void> updateItem(int id, Map<String, dynamic> itemData) async {
    return await DioHelper.updateData('inventory/updateitem/$id', itemData,
            token: '')
        .then((value) {
      // Note: We need the subcategoryId to refresh items
      // This will be handled in the cubit
    }).catchError((error) {
      print('error in updateItem: ' + error.toString());
    });
  }

  @override
  Future<void> deleteItem(int id) async {
    return await DioHelper.deleteData('inventory/deleteitem/$id', token: '')
        .then((value) {
      // Note: We need the subcategoryId to refresh items
      // This will be handled in the cubit
    }).catchError((error) {
      print('error in deleteItem: ' + error.toString());
    });
  }

  // Item quantity history
  @override
  Future<void> addItemHistory(
      int itemId, Map<String, dynamic> historyData) async {
    return await DioHelper.postData(
            'inventory/additemhistory/$itemId', historyData,
            token: '')
        .then((value) {
      // Refresh item history after adding
      getQuantities(itemId);
    }).catchError((error) {
      print('error in addItemHistory: ' + error.toString());
    });
  }
}
