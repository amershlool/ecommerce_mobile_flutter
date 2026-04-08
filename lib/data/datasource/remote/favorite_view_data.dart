import 'package:e_commerce/core/class/crud.dart';
import 'package:e_commerce/linkapi.dart';

class FavoriteData {
  Crud crud;

  FavoriteData(this.crud);

  getData(String userId) async {
    var response = await crud.postData(AppLink.viewFavorite, {
      "userId": userId,
    });
    return response.fold((l) => l, (r) => r);
  }
  addFavorite(String favoriteUsersId, String favoriteItemsId) async {
    var response = await crud.postData(AppLink.addFavorite, {
      "favorite_usersid": favoriteUsersId.toString(),

      "favorite_itemsid": favoriteItemsId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  removeFavorite(String favoriteUsersId, String favoriteItemsId) async {
    var response = await crud.postData(AppLink.removeFavorite, {
      "favorite_usersid": favoriteUsersId.toString(),

      "favorite_itemsid": favoriteItemsId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String favoriteId) async {
    var response = await crud.postData(AppLink.deleteFavorite, {
      "favoriteId": favoriteId,
    });
    return response.fold((l) => l, (r) => r);
  }

  getDataSearch(String search, String usersId) async {
    var response = await crud.postData(AppLink.searchFavorite, {
      "search": search,
      "usersId": usersId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
