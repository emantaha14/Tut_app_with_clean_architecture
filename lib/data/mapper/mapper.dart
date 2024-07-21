import 'package:app_with_clean_architecture/app/extensions.dart';
import 'package:app_with_clean_architecture/data/response/responses.dart';

import '../../domain/model/models.dart';
import 'package:app_with_clean_architecture/app/constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse {
  String toDomain() {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse {
  Service toDomain() {
    return Service(
        this.id.orZero(), this.title.orEmpty(), this.image.orEmpty());
  }
}

extension BannerResponseMapper on BannersResponse {
  BannerAd toDomain() {
    return BannerAd(
        id.orZero(), title.orEmpty(), image.orEmpty(), link.orEmpty());
  }
}

extension StoreResponseMapper on StoreResponse {
  Store toDomain() {
    return Store(this.id.orZero(), this.title.orEmpty(), this.image.orEmpty());
  }
}

extension HomeResponseMapper on HomeResponse {
  HomeObject toDomain() {
    List<Service> services = (this
                .data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
        .data
        ?.banners
        ?.map((bannerResponse) => bannerResponse.toDomain()) ??
        const Iterable.empty())
        .cast<BannerAd>()
        .toList();
    List<Store> stores = (this
        .data
        ?.stores
        ?.map((storeResponse) => storeResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}
