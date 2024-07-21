import '../network/error_handler.dart';
import '../response/responses.dart';
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERNAL = 60*1000;



abstract class LocalDataSource{
  Future<HomeResponse> getHomeData();
  Future<void>saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}


class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHomeData() {
    CachedItem ?cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERNAL)){
      // return the response from cache
      return cachedItem.data;
    }
    else{
      // return an error that
      throw ErrorHandler.handle(DataSource.CASHE_ERROR);
    }

  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

}

class CachedItem{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
   bool isValid(int expirationTimeInMillis){
     int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

     bool isValid = currentTimeInMillis - cacheTime < expirationTimeInMillis;

     return isValid;
   }
}